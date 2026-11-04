library TornadoAbility initializer Init

    globals
        // ===================== CONFIG =====================
        private constant integer TORNADO_DUMMY_ID       = 'ntor' // <- "ntor" non-hero dummy unit-type with Tornado model

        private constant real    TORNADO_SPEED          = 200.   // fixed travel speed, cannot be slowed/hasted
        private constant real    TORNADO_SEARCH_RANGE   = 1500.
        private constant real    TORNADO_AOE_RADIUS     = 200.   // damage radius

        // ---- Periodic AoE damage ----
        private constant real    TORNADO_DMG_TICK       = 0.3    // damage interval
        private constant real    TORNADO_DMG_PER_LVL    = 33.    // flat damage per tick, per ability level
        private constant real    TORNADO_DMG_MAXHP_PCT  = 0.04   // bonus % of target's MAX hp per tick

        private constant real    TORNADO_LIFETIME       = 15.    // tornado always lasts exactly this long

        private constant real    INTERVAL               = 0.03125

        private constant boolean DEBUG_MODE = false // set true to re-enable debug prints
        // ====================================================

        private hashtable TornadoHash = InitHashtable() // timer -> TornadoInstance
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
    // Main tornado
    //==================================================================
    private struct TornadoInstance
        unit dummy       // "ntor"
        unit caster      // original casting hero - persistent damage source
        unit target
        player ownerPlayer
        integer level
        real x
        real y
        real age
        real retimer
        real dmgTimer
        group scan
        timer tmr

        //--------------------------------------------------------
        static method FindTarget takes real x, real y, player owner returns unit
            local group g = CreateGroup()
            local unit u
            local unit bestHero = null
            local unit bestUnit = null
            local real bestHeroDist = 999999.
            local real bestUnitDist = 999999.
            local real d

            call GroupEnumUnitsInRange(g, x, y, TORNADO_SEARCH_RANGE, null)
            loop
                set u = FirstOfGroup(g)
                exitwhen u == null
                call GroupRemoveUnit(g, u)
                if IsValidEnemy(u, owner) then
                    set d = DistanceCoords(x, y, GetUnitX(u), GetUnitY(u))
                    if IsUnitType(u, UNIT_TYPE_HERO) then
                        if d < bestHeroDist then
                            set bestHeroDist = d
                            set bestHero = u
                        endif
                    else
                        if d < bestUnitDist then
                            set bestUnitDist = d
                            set bestUnit = u
                        endif
                    endif
                endif
            endloop
            call DestroyGroup(g)
            set g = null

            if bestHero != null then
                return bestHero
            endif
            return bestUnit
        endmethod

        //--------------------------------------------------------
        // Spawns at the CASTER'S current position - no point-target needed
        static method create takes unit caster, integer lvl returns thistype
            local thistype this = thistype.allocate()
            local real startX = GetUnitX(caster)
            local real startY = GetUnitY(caster)

            set .caster      = caster
            set .ownerPlayer = GetOwningPlayer(caster)
            set .level       = lvl
            set .x           = startX
            set .y           = startY
            set .age         = 0.
            set .retimer     = 1.0
            set .dmgTimer    = 0.
            set .target      = null
            set .scan        = CreateGroup()

            set .dummy = CreateUnit(.ownerPlayer, TORNADO_DUMMY_ID, startX, startY, 0)
            call DebugMsg("ntor created | handleId=" + I2S(GetHandleId(.dummy)) + " at (" + R2S(startX) + ", " + R2S(startY) + ")")

            call SetUnitPathing(.dummy, false) // travels freely, ignoring normal pathing/collision
            call SetUnitFlyHeight(.dummy, 0., 0.)

            set .tmr = CreateTimer()
            call SaveInteger(TornadoHash, GetHandleId(.tmr), 0, this)
            call TimerStart(.tmr, INTERVAL, true, function TornadoInstance.onTickCallback)

            return this
        endmethod

        //--------------------------------------------------------
        method onTick takes nothing returns nothing
            local unit u
            local real dx
            local real dy
            local real dist
            local real ang
            local real dmg
            local boolean doDamageThisTick = false

            set .age      = .age + INTERVAL
            set .retimer  = .retimer + INTERVAL
            set .dmgTimer = .dmgTimer + INTERVAL

            if .dmgTimer >= TORNADO_DMG_TICK then
                set .dmgTimer = .dmgTimer - TORNADO_DMG_TICK
                set doDamageThisTick = true
            endif

            // ---- Retarget ----
            if (.target == null) or (GetWidgetLife(.target) < 0.405) or (.retimer >= 0.25) then
                set .retimer = 0.
                set .target = TornadoInstance.FindTarget(.x, .y, .ownerPlayer)
            endif

            // ---- Move toward target at a fixed, unmodifiable speed ----
            if .target != null then
                set dx = GetUnitX(.target) - .x
                set dy = GetUnitY(.target) - .y
                set dist = SquareRoot(dx * dx + dy * dy)
                if dist > 5. then
                    set ang = Atan2(dy, dx)
                    set .x = .x + TORNADO_SPEED * INTERVAL * Cos(ang)
                    set .y = .y + TORNADO_SPEED * INTERVAL * Sin(ang)
                    call SetUnitFacing(.dummy, ang * bj_RADTODEG)
                endif
            endif
            call SetUnitX(.dummy, .x)
            call SetUnitY(.dummy, .y)

            // ---- Periodic AoE damage ----
            if doDamageThisTick then
                call GroupEnumUnitsInRange(.scan, .x, .y, TORNADO_AOE_RADIUS, null)
                loop
                    set u = FirstOfGroup(.scan)
                    exitwhen u == null
                    call GroupRemoveUnit(.scan, u)

                    if IsValidEnemy(u, .ownerPlayer) and (u != .dummy) then
                        set dmg = (TORNADO_DMG_PER_LVL * I2R(.level)) + (GetUnitState(u, UNIT_STATE_MAX_LIFE) * TORNADO_DMG_MAXHP_PCT)
                        call UnitDamageTarget(.caster, u, dmg, false, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                    endif
                endloop
            endif

            // ---- Tornado always lasts its full 15-second duration ----
            if .age >= TORNADO_LIFETIME then
                call DebugMsg("ntor expired at age=" + R2S(.age))
                call .destroy()
            endif
        endmethod

        method onDestroy takes nothing returns nothing
            call DestroyGroup(.scan)

            call FlushChildHashtable(TornadoHash, GetHandleId(.tmr))
            call PauseTimer(.tmr)
            call DestroyTimer(.tmr)

            call KillUnit(.dummy)
            call RemoveUnit(.dummy)
            set .dummy  = null
            set .target = null
            set .caster = null
        endmethod

        static method onTickCallback takes nothing returns nothing
            local timer tmr = GetExpiredTimer()
            local thistype this = LoadInteger(TornadoHash, GetHandleId(tmr), 0)
            call this.onTick()
            set tmr = null
        endmethod
    endstruct

    //==================================================================
    // Public entry point — spawns at the CASTER'S position, no x/y needed
    //==================================================================
    function CastTornado takes unit hero, integer lvl returns nothing
        call TornadoInstance.create(hero, lvl)
    endfunction

    private function Init takes nothing returns nothing
    endfunction

endlibrary