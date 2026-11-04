library TeleportSlam initializer Init requires AbilityCooldown

    globals
        // ===================== CONFIG =====================
        private constant real    ABILITY_COOLDOWN   = 10.

        private constant real    MAX_RANGE          = 1000.
        private constant real    CHARGE_TIME        = 0.6
        private constant string  CHARGE_ANIM        = "spell"

        private constant real    RISE_TIME          = 0.2
        private constant real    HIDDEN_TIME        = 0.5
        private constant real    FALL_TIME          = 0.2
        private constant real    FLIGHT_HEIGHT      = 1800.

        private constant real    LANDING_RADIUS     = 250.
        private constant real    LANDING_STUN       = 2.0
        private constant real    LANDING_DMG_PER_LVL = 350.

        private constant real    INTERVAL           = 0.03125

        private constant string  SFX_CHARGE         = "Abilities\\Spells\\Other\\Levelup\\LevelupVisualEffect.mdl"
        private constant string  SFX_LAND           = "Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl"

        private constant string  LIGHTNING_CODE     = "FORK"
        private constant real    LIGHTNING_LINGER   = 0.3

        private constant boolean DEBUG_MODE = true
        // ====================================================

        private hashtable ChargeHash    = InitHashtable()
        private hashtable FlightHash    = InitHashtable()
        private hashtable LightningHash = InitHashtable()
    endglobals

    //==================================================================
    private function DebugMsg takes string s returns nothing
        if DEBUG_MODE then
            call BJDebugMsg(s)
        endif
    endfunction

    private function DistanceCoords takes real x1, real y1, real x2, real y2 returns real
        return SquareRoot((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1))
    endfunction

    private function IsValidEnemy takes unit u, player owner returns boolean
        return GetWidgetLife(u) > 0.405 and IsUnitEnemy(u, owner) and (not IsUnitType(u, UNIT_TYPE_DEAD))
    endfunction

    //==================================================================
    private struct LightningFadeInstance
        lightning bolt
        timer tmr

        static method create takes real x, real y, real groundHeight, real skyHeight returns thistype
            local thistype this = thistype.allocate()

            set .bolt = AddLightningEx(LIGHTNING_CODE, true, x, y, groundHeight, x, y, skyHeight)
            set .tmr  = CreateTimer()

            call SaveInteger(LightningHash, GetHandleId(.tmr), 0, this)
            call TimerStart(.tmr, LIGHTNING_LINGER, false, function LightningFadeInstance.onExpireCallback)
            return this
        endmethod

        method onExpire takes nothing returns nothing
            call DestroyLightning(.bolt)
            set .bolt = null

            call FlushChildHashtable(LightningHash, GetHandleId(.tmr))
            call PauseTimer(.tmr)
            call DestroyTimer(.tmr)
            call .destroy()
        endmethod

        static method onExpireCallback takes nothing returns nothing
            local timer tmr = GetExpiredTimer()
            local thistype this = LoadInteger(LightningHash, GetHandleId(tmr), 0)
            call this.onExpire()
            set tmr = null
        endmethod
    endstruct

    //==================================================================
    private struct FlightInstance
        unit hero
        player ownerPlayer
        real startX
        real startY
        real targetX
        real targetY
        real t
        integer phase
        timer tmr

        static method create takes unit hero, real targetX, real targetY returns thistype
            local thistype this = thistype.allocate()

            set .hero        = hero
            set .ownerPlayer = GetOwningPlayer(hero)
            set .startX      = GetUnitX(hero)
            set .startY      = GetUnitY(hero)
            set .targetX     = targetX
            set .targetY     = targetY
            set .t           = 0.
            set .phase       = 0

            call SetUnitPathing(hero, false)
            call UnitAddType(hero, UNIT_TYPE_FLYING)

            call LightningFadeInstance.create(.startX, .startY, 0., FLIGHT_HEIGHT)

            set .tmr = CreateTimer()
            call SaveInteger(FlightHash, GetHandleId(.tmr), 0, this)
            call TimerStart(.tmr, INTERVAL, true, function FlightInstance.onTickCallback)
            return this
        endmethod

        method onTick takes nothing returns nothing
            local real ratio
            local real height

            set .t = .t + INTERVAL

            if .phase == 0 then
                set ratio = .t / RISE_TIME
                if ratio >= 1. then
                    set ratio = 1.
                endif
                set height = FLIGHT_HEIGHT * ratio
                call SetUnitFlyHeight(.hero, height, 9999.)

                if ratio >= 1. then
                    call ShowUnit(.hero, false)
                    call SetUnitX(.hero, .targetX)
                    call SetUnitY(.hero, .targetY)
                    set .phase = 1
                    set .t = 0.
                endif

            elseif .phase == 1 then
                if .t >= HIDDEN_TIME then
                    call ShowUnit(.hero, true)
                    if GetLocalPlayer() == .ownerPlayer then
                        call SelectUnitForPlayerSingle(.hero, .ownerPlayer)
                    endif
                    call SetUnitFlyHeight(.hero, FLIGHT_HEIGHT, 0.)
                    call LightningFadeInstance.create(.targetX, .targetY, FLIGHT_HEIGHT, 0.)

                    set .phase = 2
                    set .t = 0.
                endif

            else
                set ratio = .t / FALL_TIME
                if ratio >= 1. then
                    set ratio = 1.
                endif
                set height = FLIGHT_HEIGHT * (1. - ratio)
                call SetUnitFlyHeight(.hero, height, 9999.)

                if ratio >= 1. then
                    call .onLand()
                endif
            endif
        endmethod

        method onLand takes nothing returns nothing
            local group g = CreateGroup()
            local unit u
            local real dmg

            call SetUnitFlyHeight(.hero, 0., 9999.)
            call UnitRemoveType(.hero, UNIT_TYPE_FLYING)
            call SetUnitPathing(.hero, true)

            call DestroyEffect(AddSpecialEffect(SFX_LAND, .targetX, .targetY))

            call GroupEnumUnitsInRange(g, .targetX, .targetY, LANDING_RADIUS, null)
            loop
                set u = FirstOfGroup(g)
                exitwhen u == null
                call GroupRemoveUnit(g, u)

                if (u != .hero) and IsValidEnemy(u, .ownerPlayer) then
                    set dmg = LANDING_DMG_PER_LVL * I2R(GetUnitAbilityLevel(.hero, THUNDER_SLAM_ABILITY_ID))
                    call UnitDamageTarget(.hero, u, dmg, false, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)

                    call UnitAddType(u, UNIT_TYPE_STUNNED)
                    call PauseUnit(u, true)
                    call UnitApplyTimedLife(u, STUNNED_BUFF_ID, LANDING_STUN) // see note below if this isn't the right call for your buff system
                endif
            endloop
            call DestroyGroup(g)
            set g = null

            call DebugMsg("Thunderslam landed at (" + R2S(.targetX) + ", " + R2S(.targetY) + ")")

            call FlushChildHashtable(FlightHash, GetHandleId(.tmr))
            call PauseTimer(.tmr)
            call DestroyTimer(.tmr)
            set .hero = null
            call .destroy()
        endmethod

        static method onTickCallback takes nothing returns nothing
            local timer tmr = GetExpiredTimer()
            local thistype this = LoadInteger(FlightHash, GetHandleId(tmr), 0)
            call this.onTick()
            set tmr = null
        endmethod
    endstruct

    //==================================================================
    private struct ChargeInstance
        unit hero
        real targetX
        real targetY
        real t
        timer tmr

        static method create takes unit hero, real targetX, real targetY returns thistype
            local thistype this = thistype.allocate()

            set .hero    = hero
            set .targetX = targetX
            set .targetY = targetY
            set .t       = 0.
            set .tmr     = CreateTimer()

            call PauseUnit(hero, true)
            call SetUnitAnimation(hero, CHARGE_ANIM)
            call DestroyEffect(AddSpecialEffectTarget(SFX_CHARGE, hero, "origin"))

            call SaveInteger(ChargeHash, GetHandleId(.tmr), 0, this)
            call TimerStart(.tmr, INTERVAL, true, function ChargeInstance.onTickCallback)
            return this
        endmethod

        method onTick takes nothing returns nothing
            set .t = .t + INTERVAL

            if .t >= CHARGE_TIME then
                call .onChargeComplete()
            endif
        endmethod

        method onChargeComplete takes nothing returns nothing
            call PauseUnit(.hero, false)
            call FlightInstance.create(.hero, .targetX, .targetY)

            call FlushChildHashtable(ChargeHash, GetHandleId(.tmr))
            call PauseTimer(.tmr)
            call DestroyTimer(.tmr)
            set .hero = null
            call .destroy()
        endmethod

        static method onTickCallback takes nothing returns nothing
            local timer tmr = GetExpiredTimer()
            local thistype this = LoadInteger(ChargeHash, GetHandleId(tmr), 0)
            call this.onTick()
            set tmr = null
        endmethod
    endstruct

    //==================================================================
    // Public entry point — point-target cast, matches your dispatcher format.
    // Clamps the target point to MAX_RANGE from the caster if it's farther.
    // Applies the ability's cooldown via AbilStartCD since the ability's
    // own native cooldown is set to 0 in the Object Editor.
    //==================================================================
    function CastThunderSlam takes unit hero, real x, real y returns nothing
        local real cx = GetUnitX(hero)
        local real cy = GetUnitY(hero)
        local real dist = DistanceCoords(cx, cy, x, y)
        local real finalX = x
        local real finalY = y
        local real angle
        local player owner = GetOwningPlayer(hero)

        call DebugMsg("CastThunderSlam called!")

        call AbilStartCD(hero, THUNDER_SLAM_ABILITY_ID, ABILITY_COOLDOWN)

        if GetLocalPlayer() == owner then
            call SelectUnitForPlayerSingle(hero, owner)
        endif

        if dist > MAX_RANGE then
            set angle = Atan2(y - cy, x - cx)
            set finalX = cx + MAX_RANGE * Cos(angle)
            set finalY = cy + MAX_RANGE * Sin(angle)
        endif

        call ChargeInstance.create(hero, finalX, finalY)
    endfunction

    private function Init takes nothing returns nothing
    endfunction

endlibrary