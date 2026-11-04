library AstralWard initializer Init

    globals
        // ===================== CONFIG =====================
        private constant integer WARD_UNIT_ID     = 'hdhw'
        private constant integer WARD_SKIN_ID     = 'oeye'   // unit type whose model the ward borrows (Orc Sentry Ward)
        private constant real    WARD_SCALE       = 1.3
        private constant integer WARD_TINT_R      = 180
        private constant integer WARD_TINT_G      = 120
        private constant integer WARD_TINT_B      = 255
        private constant string  WARD_GLOW        = "Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBoltImpact.mdl"

        private constant real    DURATION        = 10.
        private constant real    TRIGGER_RANGE   = 1000.

        private constant real    DMG_PER_LVL     = 300.
        private constant real    BLAST_RADIUS    = 150.
        private constant real    KNOCKDOWN_TIME  = 1.5

        // Blast-away: the target flies the way the meteor was travelling,
        // everyone else is thrown directly away from the impact point. Stops at cliffs.
        private constant real    THROW_DIST      = 400.
        private constant real    THROW_TIME      = 0.4

        // Meteor flight: lands 1 second after the cast
        private constant real    FLIGHT_TIME     = 1.0
        private constant real    PATH_LENGTH     = 900.
        private constant real    ENTRY_CONE      = 90.      // degrees, total cone to the left and right of the target
        private constant real    ELEV_MIN        = 60.      // degrees above the horizon
        private constant real    ELEV_MAX        = 75.

        // Visible bolide (glowing fireball) plus a soft glow around it
        private constant real    BOLIDE_SCALE    = 0.7
        private constant integer BOLIDE_R        = 255
        private constant integer BOLIDE_G        = 190
        private constant integer BOLIDE_B        = 110
        private constant real    BOLIDE_GLOW_SCALE = 2.2
        private constant integer BOLIDE_GLOW_ALPHA = 120    // 0-255

        // Smoke trail (grey/black)
        private constant real    TRAIL_LIFE      = 3.5
        private constant real    TRAIL_SCALE     = 0.33
        private constant real    TRAIL_GROW      = 1.0
        private constant integer TRAIL_PER_TICK  = 1        // 1 puff per tick, since the flight is now longer
        // Tint multiplies the model's own colours, so low values darken it toward black.
        // Raise all three equally (e.g. 90) for a lighter grey.
        private constant integer SMOKE_R         = 35
        private constant integer SMOKE_G         = 35
        private constant integer SMOKE_B         = 35

        // Impact lighting
        private constant real    HEAT_SCALE      = 2.5
        private constant real    HEAT_LIFE       = 0.15
        private constant real    GLOW_SCALE      = 6.0
        private constant real    GLOW_LIFE       = 0.5
        private constant integer SCREEN_FLASH    = 90       // 0-255, 0 = off
        private constant real    SCREEN_FLASH_RANGE = 1800.
        private constant real    SCREEN_FLASH_TIME  = 0.4

        // Unverified paths. Swap for ones you've confirmed render.
        private constant string  METEOR_MODEL    = "Abilities\\Weapons\\FireBallMissile\\FireBallMissile.mdl"
        private constant string  BOLIDE_GLOW_MODEL = "Abilities\\Weapons\\FireBallMissile\\FireBallMissile.mdl"
        private constant string  SMOKE_MODEL     = "Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl"
        private constant string  SFX_EXPLODE     = "Abilities\\Weapons\\MortarMissile\\MortarMissile.mdl"
        private constant string  HEAT_MODEL      = "Abilities\\Weapons\\FireBallMissile\\FireBallMissile.mdl"
        private constant string  GLOW_MODEL      = "Abilities\\Weapons\\FireBallMissile\\FireBallMissile.mdl"
        private constant string  SFX_HIT         = "Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl"   // confirmed working

        private constant real    INTERVAL        = 0.03125
        private constant boolean DEBUG_MODE      = false
        // ====================================================

        private integer array WardList
        private integer       WardCount = 0
        private timer         WardTick  = CreateTimer()

        private integer array MeteorList
        private integer       MeteorCount = 0
        private timer         MeteorTick  = CreateTimer()

        private integer array FadeList
        private integer       FadeCount = 0
        private timer         FadeTick  = CreateTimer()

        private integer array ThrowList
        private integer       ThrowCount = 0
        private timer         ThrowTick  = CreateTimer()

        private hashtable KnockHash  = InitHashtable()
        private hashtable KnockCount = InitHashtable()
        private group     Grp        = CreateGroup()
        private location  ZLoc       = Location(0., 0.)
    endglobals

    //==================================================================
    private function GetZ takes real x, real y returns real
        call MoveLocation(ZLoc, x, y)
        return GetLocationZ(ZLoc)
    endfunction

    private function IsValidEnemy takes unit u, player owner returns boolean
        return GetWidgetLife(u) > 0.405 /*
            */ and IsUnitEnemy(u, owner) /*
            */ and not IsUnitType(u, UNIT_TYPE_DEAD) /*
            */ and not IsUnitType(u, UNIT_TYPE_STRUCTURE) /*
            */ and GetUnitAbilityLevel(u, 'Aloc') == 0
    endfunction

    private function FlashScreen takes real x, real y returns nothing
        local real dx
        local real dy

        if SCREEN_FLASH <= 0 then
            return
        endif
        set dx = GetCameraTargetPositionX() - x
        set dy = GetCameraTargetPositionY() - y
        if dx * dx + dy * dy <= SCREEN_FLASH_RANGE * SCREEN_FLASH_RANGE then
            call SetCineFilterTexture("ReplaceableTextures\\CameraMasks\\White_mask.blp")
            call SetCineFilterBlendMode(BLEND_MODE_ADDITIVE)
            call SetCineFilterTexMapFlags(TEXMAP_FLAG_NONE)
            call SetCineFilterStartUV(0., 0., 1., 1.)
            call SetCineFilterEndUV(0., 0., 1., 1.)
            call SetCineFilterStartColor(255, 255, 255, SCREEN_FLASH)
            call SetCineFilterEndColor(255, 255, 255, 0)
            call SetCineFilterDuration(SCREEN_FLASH_TIME)
            call DisplayCineFilter(true)
        endif
    endfunction

    //==================================================================
    // A short-lived fading effect (smoke puffs, heat spot, glow).
    //==================================================================
    private struct Fader
        effect fx
        real age
        real life
        real baseScale
        real grow

        static method create takes string model, real x, real y, real z, real scale, real life, real grow, integer r, integer g, integer b returns thistype
            local thistype this = thistype.allocate()

            set .age       = 0.
            set .life      = life
            set .baseScale = scale
            set .grow      = grow
            set .fx        = AddSpecialEffect(model, x, y)
            call BlzSetSpecialEffectPosition(.fx, x, y, z)
            call BlzSetSpecialEffectColor(.fx, r, g, b)
            call BlzSetSpecialEffectScale(.fx, scale)

            set FadeList[FadeCount] = this
            set FadeCount = FadeCount + 1
            if FadeCount == 1 then
                call TimerStart(FadeTick, INTERVAL, true, function thistype.tickAll)
            endif
            return this
        endmethod

        method step takes nothing returns boolean
            local real f

            set .age = .age + INTERVAL
            set f = .age / .life
            if f >= 1. then
                return true
            endif
            call BlzSetSpecialEffectAlpha(.fx, R2I(255. * (1. - f * f)))
            call BlzSetSpecialEffectScale(.fx, .baseScale * (1. + .grow * f))
            return false
        endmethod

        method onDestroy takes nothing returns nothing
            call BlzSetSpecialEffectScale(.fx, 0.001)
            call DestroyEffect(.fx)
            set .fx = null
        endmethod

        static method tickAll takes nothing returns nothing
            local integer i = FadeCount - 1
            local thistype this

            loop
                exitwhen i < 0
                set this = FadeList[i]
                if this.step() then
                    call this.destroy()
                    set FadeCount = FadeCount - 1
                    set FadeList[i] = FadeList[FadeCount]
                endif
                set i = i - 1
            endloop

            if FadeCount == 0 then
                call PauseTimer(FadeTick)
            endif
        endmethod
    endstruct

    //==================================================================
    private struct Knockdown
        unit u
        timer tmr

        static method create takes unit target, real duration returns thistype
            local thistype this = thistype.allocate()
            local integer uid = GetHandleId(target)
            local integer count = LoadInteger(KnockCount, uid, 0)

            set .u   = target
            set .tmr = CreateTimer()

            if count == 0 then
                call PauseUnit(target, true)
                call UnitAddType(target, UNIT_TYPE_STUNNED)
            endif
            call SaveInteger(KnockCount, uid, 0, count + 1)

            call SaveInteger(KnockHash, GetHandleId(.tmr), 0, this)
            call TimerStart(.tmr, duration, false, function Knockdown.onExpireCallback)
            return this
        endmethod

        method onExpire takes nothing returns nothing
            local integer uid = GetHandleId(.u)
            local integer count = LoadInteger(KnockCount, uid, 0) - 1

            if count <= 0 then
                call RemoveSavedInteger(KnockCount, uid, 0)
                if GetWidgetLife(.u) > 0.405 then
                    call UnitRemoveType(.u, UNIT_TYPE_STUNNED)
                    call PauseUnit(.u, false)
                endif
            else
                call SaveInteger(KnockCount, uid, 0, count)
            endif

            call FlushChildHashtable(KnockHash, GetHandleId(.tmr))
            call PauseTimer(.tmr)
            call DestroyTimer(.tmr)
            set .u = null
            call .destroy()
        endmethod

        static method onExpireCallback takes nothing returns nothing
            local timer t = GetExpiredTimer()
            local thistype this = LoadInteger(KnockHash, GetHandleId(t), 0)
            call this.onExpire()
            set t = null
        endmethod
    endstruct

    //==================================================================
    // Slides a unit along the ground, stopping at cliffs.
    //==================================================================
    private struct Throw
        unit u
        real dirX
        real dirY
        real t

        static method create takes unit u, real angle returns thistype
            local thistype this = thistype.allocate()

            set .u    = u
            set .dirX = Cos(angle)
            set .dirY = Sin(angle)
            set .t    = 0.

            set ThrowList[ThrowCount] = this
            set ThrowCount = ThrowCount + 1
            if ThrowCount == 1 then
                call TimerStart(ThrowTick, INTERVAL, true, function thistype.tickAll)
            endif
            return this
        endmethod

        method step takes nothing returns boolean
            local real stp = THROW_DIST / THROW_TIME * INTERVAL
            local real nx
            local real ny

            set .t = .t + INTERVAL
            if GetWidgetLife(.u) < 0.405 or .t > THROW_TIME then
                return true
            endif

            set nx = GetUnitX(.u) + .dirX * stp
            set ny = GetUnitY(.u) + .dirY * stp

            if not IsUnitType(.u, UNIT_TYPE_FLYING) and IsTerrainPathable(nx, ny, PATHING_TYPE_WALKABILITY) then
                return true
            endif

            call SetUnitX(.u, nx)
            call SetUnitY(.u, ny)
            return false
        endmethod

        method onDestroy takes nothing returns nothing
            set .u = null
        endmethod

        static method tickAll takes nothing returns nothing
            local integer i = ThrowCount - 1
            local thistype this

            loop
                exitwhen i < 0
                set this = ThrowList[i]
                if this.step() then
                    call this.destroy()
                    set ThrowCount = ThrowCount - 1
                    set ThrowList[i] = ThrowList[ThrowCount]
                endif
                set i = i - 1
            endloop

            if ThrowCount == 0 then
                call PauseTimer(ThrowTick)
            endif
        endmethod
    endstruct

    //==================================================================
    // The meteor: a glowing bolide with a dark smoke trail. It enters
    // from the left or right of the target at a 60-75 degree elevation
    // and lands FLIGHT_TIME seconds after the cast.
    //==================================================================
    private struct MeteorInstance
        effect fx
        effect glow
        unit caster
        player owner
        unit target
        integer level
        real startX
        real startY
        real startH
        real endX
        real endY
        real prevX
        real prevY
        real prevZ
        real t

        static method create takes unit caster, unit target, integer lvl returns thistype
            local thistype this = thistype.allocate()
            local real a
            local real elev

            if GetRandomInt(0, 1) == 0 then
                set a = 0.
            else
                set a = bj_PI
            endif
            set a = a + GetRandomReal(-ENTRY_CONE * 0.5, ENTRY_CONE * 0.5) * bj_DEGTORAD
            set elev = GetRandomReal(ELEV_MIN, ELEV_MAX) * bj_DEGTORAD

            set .caster = caster
            set .owner  = GetOwningPlayer(caster)
            set .target = target
            set .level  = lvl
            set .endX   = GetUnitX(target)
            set .endY   = GetUnitY(target)
            set .startX = .endX + PATH_LENGTH * Cos(elev) * Cos(a)
            set .startY = .endY + PATH_LENGTH * Cos(elev) * Sin(a)
            set .startH = PATH_LENGTH * Sin(elev)
            set .prevX  = .startX
            set .prevY  = .startY
            set .prevZ  = GetZ(.startX, .startY) + .startH
            set .t      = 0.

            // the bolide itself
            set .fx = AddSpecialEffect(METEOR_MODEL, .startX, .startY)
            call BlzSetSpecialEffectScale(.fx, BOLIDE_SCALE)
            call BlzSetSpecialEffectColor(.fx, BOLIDE_R, BOLIDE_G, BOLIDE_B)
            call BlzSetSpecialEffectYaw(.fx, Atan2(.endY - .startY, .endX - .startX))
            call BlzSetSpecialEffectPitch(.fx, elev)
            call BlzSetSpecialEffectPosition(.fx, .startX, .startY, .prevZ)

            // a larger, see-through copy around it for the glow
            set .glow = AddSpecialEffect(BOLIDE_GLOW_MODEL, .startX, .startY)
            call BlzSetSpecialEffectScale(.glow, BOLIDE_GLOW_SCALE)
            call BlzSetSpecialEffectColor(.glow, 255, 140, 60)
            call BlzSetSpecialEffectAlpha(.glow, BOLIDE_GLOW_ALPHA)
            call BlzSetSpecialEffectPosition(.glow, .startX, .startY, .prevZ)

            set MeteorList[MeteorCount] = this
            set MeteorCount = MeteorCount + 1
            if MeteorCount == 1 then
                call TimerStart(MeteorTick, INTERVAL, true, function thistype.tickAll)
            endif
            return this
        endmethod

        method impact takes nothing returns nothing
            local unit u
            local real dmg = DMG_PER_LVL * I2R(.level)
            local real z = GetZ(.endX, .endY)
            local real ang
            local real travel = Atan2(.endY - .startY, .endX - .startX)

            call DestroyEffect(AddSpecialEffect(SFX_EXPLODE, .endX, .endY))
            call DestroyEffect(AddSpecialEffect(SFX_HIT, .endX, .endY))

            call Fader.create(HEAT_MODEL, .endX, .endY, z + 30., HEAT_SCALE, HEAT_LIFE, 0.5, 255, 255, 255)
            call Fader.create(GLOW_MODEL, .endX, .endY, z + 40., GLOW_SCALE, GLOW_LIFE, 0.3, 255, 170, 80)
            call FlashScreen(.endX, .endY)

            call GroupEnumUnitsInRange(Grp, .endX, .endY, BLAST_RADIUS, null)
            loop
                set u = FirstOfGroup(Grp)
                exitwhen u == null
                call GroupRemoveUnit(Grp, u)
                if IsValidEnemy(u, .owner) then
                    call UnitDamageTarget(.caster, u, dmg, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                    if GetWidgetLife(u) > 0.405 then
                        call Knockdown.create(u, KNOCKDOWN_TIME)

                        if u == .target then
                            set ang = travel
                        elseif (GetUnitX(u) - .endX) * (GetUnitX(u) - .endX) + (GetUnitY(u) - .endY) * (GetUnitY(u) - .endY) < 4. then
                            set ang = travel
                        else
                            set ang = Atan2(GetUnitY(u) - .endY, GetUnitX(u) - .endX)
                        endif
                        call Throw.create(u, ang)
                    endif
                endif
            endloop
            set u = null
        endmethod

        // returns true when the meteor has landed
        method step takes nothing returns boolean
            local real ratio
            local real x
            local real y
            local real z
            local real f
            local integer i

            set .t = .t + INTERVAL
            set ratio = .t / FLIGHT_TIME
            if ratio > 1. then
                set ratio = 1.
            endif

            if .target != null and GetWidgetLife(.target) > 0.405 then
                set .endX = GetUnitX(.target)
                set .endY = GetUnitY(.target)
            endif

            set x = .startX + (.endX - .startX) * ratio
            set y = .startY + (.endY - .startY) * ratio
            set z = GetZ(x, y) + .startH * (1. - ratio)
            call BlzSetSpecialEffectPosition(.fx, x, y, z)
            call BlzSetSpecialEffectPosition(.glow, x, y, z)

            set i = 1
            loop
                exitwhen i > TRAIL_PER_TICK
                set f = I2R(i) / I2R(TRAIL_PER_TICK)
                call Fader.create(SMOKE_MODEL, .prevX + (x - .prevX) * f, .prevY + (y - .prevY) * f, .prevZ + (z - .prevZ) * f, TRAIL_SCALE, TRAIL_LIFE, TRAIL_GROW, SMOKE_R, SMOKE_G, SMOKE_B)
                set i = i + 1
            endloop
            set .prevX = x
            set .prevY = y
            set .prevZ = z

            if ratio >= 1. then
                call .impact()
                return true
            endif
            return false
        endmethod

        method onDestroy takes nothing returns nothing
            call BlzSetSpecialEffectScale(.fx, 0.001)
            call DestroyEffect(.fx)
            call BlzSetSpecialEffectScale(.glow, 0.001)
            call DestroyEffect(.glow)
            set .fx     = null
            set .glow   = null
            set .caster = null
            set .target = null
        endmethod

        static method tickAll takes nothing returns nothing
            local integer i = MeteorCount - 1
            local thistype this

            loop
                exitwhen i < 0
                set this = MeteorList[i]
                if this.step() then
                    call this.destroy()
                    set MeteorCount = MeteorCount - 1
                    set MeteorList[i] = MeteorList[MeteorCount]
                endif
                set i = i - 1
            endloop

            if MeteorCount == 0 then
                call PauseTimer(MeteorTick)
            endif
        endmethod
    endstruct

    //==================================================================
    private struct WardInstance
        unit ward
        unit caster
        player owner
        integer level
        real age

        static method create takes unit caster, real x, real y, integer lvl returns thistype
            local thistype this = thistype.allocate()

            set .caster = caster
            set .owner  = GetOwningPlayer(caster)
            set .level  = lvl
            set .age    = 0.
            set .ward   = CreateUnit(.owner, WARD_UNIT_ID, x, y, 270.)

            // borrow the Orc Sentry Ward model
            call BlzSetUnitSkin(.ward, WARD_SKIN_ID)
            call SetUnitScale(.ward, WARD_SCALE, WARD_SCALE, WARD_SCALE)
            call SetUnitVertexColor(.ward, WARD_TINT_R, WARD_TINT_G, WARD_TINT_B, 255)
            call AddSpecialEffectTarget(WARD_GLOW, .ward, "origin")

            set WardList[WardCount] = this
            set WardCount = WardCount + 1
            if WardCount == 1 then
                call TimerStart(WardTick, INTERVAL, true, function thistype.tickAll)
            endif
            return this
        endmethod

        method step takes nothing returns boolean
            set .age = .age + INTERVAL
            return .age >= DURATION or GetWidgetLife(.ward) < 0.405
        endmethod

        method onDestroy takes nothing returns nothing
            if GetWidgetLife(.ward) > 0.405 then
                call KillUnit(.ward)
            endif
            set .ward   = null
            set .caster = null
        endmethod

        static method tickAll takes nothing returns nothing
            local integer i = WardCount - 1
            local thistype this

            loop
                exitwhen i < 0
                set this = WardList[i]
                if this.step() then
                    call this.destroy()
                    set WardCount = WardCount - 1
                    set WardList[i] = WardList[WardCount]
                endif
                set i = i - 1
            endloop

            if WardCount == 0 then
                call PauseTimer(WardTick)
            endif
        endmethod
    endstruct

    //==================================================================
    // Call from your own creep-casting code if the engine event doesn't fire for them.
    //==================================================================
    function AstralWard_OnCast takes unit c returns nothing
        local integer i = 0
        local WardInstance w
        local real dx
        local real dy

        if c == null or GetWidgetLife(c) < 0.405 or GetUnitAbilityLevel(c, 'Aloc') > 0 then
            return
        endif

        loop
            exitwhen i >= WardCount
            set w = WardList[i]
            if IsUnitEnemy(c, w.owner) then
                set dx = GetUnitX(c) - GetUnitX(w.ward)
                set dy = GetUnitY(c) - GetUnitY(w.ward)
                if dx * dx + dy * dy <= TRIGGER_RANGE * TRIGGER_RANGE then
                    call MeteorInstance.create(w.caster, c, w.level)
                endif
            endif
            set i = i + 1
        endloop
    endfunction

    private function OnSpellEffect takes nothing returns boolean
        if DEBUG_MODE then
            call BJDebugMsg("Astral Ward saw a cast by: " + GetUnitName(GetTriggerUnit()))
        endif
        call AstralWard_OnCast(GetTriggerUnit())
        return false
    endfunction

    function CastAstralWard takes unit caster, real x, real y, integer lvl returns nothing
        call WardInstance.create(caster, x, y, lvl)
    endfunction

    private function Init takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer i = 0

        loop
            exitwhen i >= bj_MAX_PLAYER_SLOTS
            call TriggerRegisterPlayerUnitEvent(t, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT, null)
            set i = i + 1
        endloop
        call TriggerRegisterPlayerUnitEvent(t, Player(PLAYER_NEUTRAL_AGGRESSIVE), EVENT_PLAYER_UNIT_SPELL_EFFECT, null)
        call TriggerRegisterPlayerUnitEvent(t, Player(PLAYER_NEUTRAL_PASSIVE), EVENT_PLAYER_UNIT_SPELL_EFFECT, null)

        call TriggerAddCondition(t, Condition(function OnSpellEffect))
        set t = null
    endfunction

endlibrary