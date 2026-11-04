library ChargeAbility initializer Init

    globals
        // Tuning
        constant real    CHARGE_WIDTH           = 200.
        constant real    CHARGE_BASE_DIST       = 300.
        constant real    CHARGE_DIST_PER_LVL    = 15.
        constant real    CHARGE_WINDUP          = 0.10
        constant real    CHARGE_SPEED           = 3000.
        constant real    CHARGE_DAMAGE_PER_LVL  = 250.
        constant real    CHARGE_STUN_DURATION   = 2.00
        constant real    CHARGE_KNOCK_HEIGHT    = 300.
        constant real    CHARGE_TICK            = 0.03125

        // Visuals & Sound (change to whatever you like)
        constant string  CHARGE_WINDUP_SFX      = "Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl"
        constant string  CHARGE_TRAIL_SFX       = "Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl"
        constant string  CHARGE_HIT_SFX         = "Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl"
        constant string  CHARGE_LOOP_SOUND      = "Abilities\\Spells\\Orc\\MirrorImage\\MirrorImage.wav"

        private hashtable ChargeHash = InitHashtable() // separate hashtable, local to this library
        private hashtable StunHash   = InitHashtable()
    endglobals

    // ==================================================
    //  Data
    // ==================================================
    private struct ChargeData
        unit    caster
        integer lvl
        real    startX
        real    startY
        real    dist
        real    travelled
        real    speed
        real    angle
        effect  trail
        timer   t
        group   hitGroup
        sound   loopSnd

        static method create takes unit c, integer level returns thistype
            local thistype this = thistype.allocate()
            set this.caster    = c
            set this.lvl       = level
            set this.startX    = GetUnitX(c)
            set this.startY    = GetUnitY(c)
            set this.travelled = 0.
            set this.speed     = CHARGE_SPEED
            set this.angle     = GetUnitFacing(c) * bj_DEGTORAD
            set this.dist      = CHARGE_BASE_DIST + CHARGE_DIST_PER_LVL * level
            set this.hitGroup  = CreateGroup()
            set this.trail     = null
            set this.loopSnd   = null
            set this.t         = null
            return this
        endmethod

        method onDestroy takes nothing returns nothing
            if this.trail != null then
                call DestroyEffect(this.trail)
            endif
            if this.loopSnd != null then
                call StopSound(this.loopSnd, true, false)
                call KillSoundWhenDone(this.loopSnd)
            endif
            if this.t != null then
                call FlushChildHashtable(ChargeHash, GetHandleId(this.t))
                call PauseTimer(this.t)
                call DestroyTimer(this.t)
            endif
            call DestroyGroup(this.hitGroup)
        endmethod
    endstruct

    //==================================================================
    // Stacking-safe stun that also applies STUNNED_BUFF_ID visually.
    //==================================================================
    private struct StunInstance
        unit u
        timer tmr

        static method create takes unit whichUnit, real duration returns thistype
            local thistype this = thistype.allocate()
            set .u = whichUnit
            set .tmr = CreateTimer()

            call PauseUnit(whichUnit, true)
            call UnitAddType(whichUnit, UNIT_TYPE_STUNNED)
            call UnitAddAbility(whichUnit, STUNNED_BUFF_ID)

            call SaveInteger(StunHash, GetHandleId(.tmr), 0, this)
            call TimerStart(.tmr, duration, false, function StunInstance.onExpireCallback)
            return this
        endmethod

        method onExpire takes nothing returns nothing
            if GetWidgetLife(.u) > 0.405 then
                call UnitRemoveAbility(.u, STUNNED_BUFF_ID)
                call UnitRemoveType(.u, UNIT_TYPE_STUNNED)
                call PauseUnit(.u, false)
            endif

            call FlushChildHashtable(StunHash, GetHandleId(.tmr))
            call PauseTimer(.tmr)
            call DestroyTimer(.tmr)
            set .u = null
            call .destroy()
        endmethod

        static method onExpireCallback takes nothing returns nothing
            local timer tmr = GetExpiredTimer()
            local thistype this = LoadInteger(StunHash, GetHandleId(tmr), 0)
            call this.onExpire()
            set tmr = null
        endmethod
    endstruct

    // ==================================================
    //  Helpers
    // ==================================================
    private function IsPathable takes real x, real y returns boolean
        return not IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY)
    endfunction

    private function DamageAndStun takes unit caster, unit target, integer lvl returns nothing
        local real dmg = CHARGE_DAMAGE_PER_LVL * lvl

        // Small upward hurl
        call SetUnitFlyHeight(target, GetUnitFlyHeight(target) + CHARGE_KNOCK_HEIGHT, 0.35)

        // Damage
        call UnitDamageTarget(caster, target, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)

        // Stun + buff
        call StunInstance.create(target, CHARGE_STUN_DURATION)

        // Hit visual
        call DestroyEffect(AddSpecialEffectTarget(CHARGE_HIT_SFX, target, "origin"))
    endfunction

    // ==================================================
    //  Cleanup
    // ==================================================
    private function EndCharge takes ChargeData d returns nothing
        call PauseUnit(d.caster, false)
        call SetUnitPathing(d.caster, true)
        call SetUnitAnimation(d.caster, "stand")
        call d.destroy()
    endfunction

    // ==================================================
    //  Movement loop
    // ==================================================
    private function Periodic takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local ChargeData d = ChargeData(LoadInteger(ChargeHash, GetHandleId(t), 0))
        local real step = d.speed * CHARGE_TICK
        local real nx
        local real ny
        local group g
        local unit u

        if not UnitAlive(d.caster) then
            call EndCharge(d)
            return
        endif

        set d.travelled = d.travelled + step
        set nx = d.startX + Cos(d.angle) * d.travelled
        set ny = d.startY + Sin(d.angle) * d.travelled

        // Stop on cliff / unpathable
        if not IsPathable(nx, ny) then
            call EndCharge(d)
            return
        endif

        call SetUnitX(d.caster, nx)
        call SetUnitY(d.caster, ny)

        // Hit detection
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, nx, ny, CHARGE_WIDTH * 0.5 + 32., null)
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            call GroupRemoveUnit(g, u)

            if u != d.caster and UnitAlive(u) and IsUnitEnemy(u, GetOwningPlayer(d.caster)) then
                if not IsUnitInGroup(u, d.hitGroup) then
                    call GroupAddUnit(d.hitGroup, u)
                    call DamageAndStun(d.caster, u, d.lvl)
                endif
            endif
        endloop
        call DestroyGroup(g)

        if d.travelled >= d.dist then
            call EndCharge(d)
        endif
    endfunction

    // ==================================================
    //  After wind-up → start moving
    // ==================================================
    private function BeginTravel takes nothing returns nothing
        local timer windup = GetExpiredTimer()
        local ChargeData d = ChargeData(LoadInteger(ChargeHash, GetHandleId(windup), 0))

        call FlushChildHashtable(ChargeHash, GetHandleId(windup))
        call PauseTimer(windup)
        call DestroyTimer(windup)

        // Trail effect
        set d.trail = AddSpecialEffectTarget(CHARGE_TRAIL_SFX, d.caster, "origin")

        // Looping sound
        set d.loopSnd = CreateSound(CHARGE_LOOP_SOUND, false, true, true, 10, 10, "DefaultEAXON")
        call SetSoundVolume(d.loopSnd, 100)
        call StartSound(d.loopSnd)
        call AttachSoundToUnit(d.loopSnd, d.caster)

        // Allow passing through units
        call SetUnitPathing(d.caster, false)
        call SetUnitAnimation(d.caster, "walk")

        // Movement timer
        set d.t = CreateTimer()
        call SaveInteger(ChargeHash, GetHandleId(d.t), 0, integer(d))
        call TimerStart(d.t, CHARGE_TICK, true, function Periodic)
    endfunction

    // ==================================================
    //  Public API
    // ==================================================
    function CastCharge takes unit caster, real x, real y, integer lvl returns nothing
        local ChargeData d = ChargeData.create(caster, lvl)
        local timer windup = CreateTimer()

        // Wind-up visual + pause
        call DestroyEffect(AddSpecialEffectTarget(CHARGE_WINDUP_SFX, caster, "origin"))
        call SetUnitAnimation(caster, "spell")
        call PauseUnit(caster, true)

        // Store data on the wind-up timer
        call SaveInteger(ChargeHash, GetHandleId(windup), 0, integer(d))
        call TimerStart(windup, CHARGE_WINDUP, false, function BeginTravel)
    endfunction

    private function Init takes nothing returns nothing
    endfunction

endlibrary