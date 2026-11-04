library PhoenixFury initializer Init

    globals
        // ===================== CONFIG =====================
        private constant integer PHOENIX_DUMMY_ID        = 'hphx' // phoenix dummy unit-type (Locust=true, Fly, Collision 0, non-hero)

        private constant real    LINE_LENGTH       = 1500.  // distance from the hero to the end point
        private constant real    LINE_WIDTH        = 250.   // total width of the damage line
        private constant real    PHOENIX_SPEED     = 1100.   // units/second
        private constant real    DMG_PER_LVL       = 400.
        private constant real    PHOENIX_SCALE     = 1.8
        private constant real    FLY_HEIGHT        = 1.    // slightly above the ground

        private constant integer MAX_SEGMENTS      = 50     // safety cap on total legs

        private constant string  SFX_HIT           = "Abilities\\Spells\\Human\\FlameStrike\\FlameStrikeDamageTarget.mdl"

        private constant real    INTERVAL          = 0.03125

        private constant boolean DEBUG_MODE = false
        // ====================================================

        private hashtable PhoenixHash = InitHashtable() // timer -> PhoenixInstance
    endglobals

    //==================================================================
    private function DebugMsg takes string s returns nothing
        if DEBUG_MODE then
            call BJDebugMsg(s)
        endif
    endfunction

    private function IsValidEnemy takes unit u, player owner returns boolean
        return GetWidgetLife(u) > 0.405 and IsUnitEnemy(u, owner) and (not IsUnitType(u, UNIT_TYPE_DEAD))
    endfunction

    //==================================================================
    // Each leg spawns a fresh dummy facing the leg's initial direction.
    // The model's facing is never changed mid-leg, and its animation is
    // frozen so the wings don't flap.
    //
    // The return leg homes in on the hero's LIVE position every tick.
    // Because the facing is fixed, if the hero moves, the phoenix curves
    // toward him while still pointing the way it started.
    //==================================================================
    private struct PhoenixInstance
        unit dummy
        unit caster
        player ownerPlayer
        integer level
        integer startCliff
        real curX
        real curY
        real endX
        real endY
        real legX            // target of the current leg (outbound: fixed; return: updated every tick)
        real legY
        integer phase        // 0 = outbound to the end point, 1 = returning to the hero
        boolean hitThisCycle
        integer segments
        group hitGroup
        timer tmr

        static method create takes unit caster, real tx, real ty, integer lvl returns thistype
            local thistype this = thistype.allocate()
            local real cx = GetUnitX(caster)
            local real cy = GetUnitY(caster)
            local real angle = Atan2(ty - cy, tx - cx)

            set .caster       = caster
            set .ownerPlayer  = GetOwningPlayer(caster)
            set .level        = lvl
            set .startCliff   = GetTerrainCliffLevel(cx, cy)
            set .curX         = cx
            set .curY         = cy
            set .endX         = cx + LINE_LENGTH * Cos(angle)
            set .endY         = cy + LINE_LENGTH * Sin(angle)
            set .legX         = .endX
            set .legY         = .endY
            set .phase        = 0
            set .hitThisCycle = false
            set .segments     = 1
            set .hitGroup     = CreateGroup()
            set .dummy        = null

            call .startLeg()

            set .tmr = CreateTimer()
            call SaveInteger(PhoenixHash, GetHandleId(.tmr), 0, this)
            call TimerStart(.tmr, INTERVAL, true, function PhoenixInstance.onTickCallback)
            return this
        endmethod

        //--------------------------------------------------------
        // Removes the old dummy and spawns a fresh one at the current
        // position, facing the leg's direction, with animation frozen.
        //--------------------------------------------------------
        method startLeg takes nothing returns nothing
            local real angle = Atan2(.legY - .curY, .legX - .curX)

            if .dummy != null then
                call KillUnit(.dummy)
                call RemoveUnit(.dummy)
            endif

            set .dummy = CreateUnit(.ownerPlayer, PHOENIX_DUMMY_ID, .curX, .curY, angle * bj_RADTODEG)
            call UnitAddAbility(.dummy, 'Aloc')              // Locust: no auto-acquire
            call SetUnitAcquireRange(.dummy, 0.)             // never look for targets
            call SetUnitPathing(.dummy, false)
            call SetUnitScale(.dummy, PHOENIX_SCALE, PHOENIX_SCALE, PHOENIX_SCALE)
            call SetUnitFlyHeight(.dummy, FLY_HEIGHT, 0.)
            call SetUnitTimeScale(.dummy, 0.)                // frozen animation
            call BlzSetUnitFacingEx(.dummy, angle * bj_RADTODEG) // make sure the facing is set instantly
            call PauseUnit(.dummy, true)                     // no acquiring, no turning
            call GroupClear(.hitGroup)
        endmethod

        //--------------------------------------------------------
        method isCliff takes real x, real y returns boolean
            return IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY) and GetTerrainCliffLevel(x, y) != .startCliff
        endmethod

        //--------------------------------------------------------
        method hitUnits takes nothing returns nothing
            local group g = CreateGroup()
            local unit u
            local real dmg = DMG_PER_LVL * I2R(.level)

            call GroupEnumUnitsInRange(g, .curX, .curY, LINE_WIDTH * 0.5, null)
            loop
                set u = FirstOfGroup(g)
                exitwhen u == null
                call GroupRemoveUnit(g, u)

                if IsValidEnemy(u, .ownerPlayer) and (not IsUnitInGroup(u, .hitGroup)) then
                    call GroupAddUnit(.hitGroup, u)
                    set .hitThisCycle = true
                    call UnitDamageTarget(.caster, u, dmg, false, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                    call DestroyEffect(AddSpecialEffectTarget(SFX_HIT, u, "chest"))
                endif
            endloop
            call DestroyGroup(g)
            set g = null
        endmethod

        //--------------------------------------------------------
        method onTick takes nothing returns nothing
            local real dx
            local real dy
            local real dist
            local real step = PHOENIX_SPEED * INTERVAL
            local real nextX
            local real nextY
            local boolean arrived = false

            // Return leg: re-aim at the hero's live position every tick
            if .phase == 1 then
                if GetWidgetLife(.caster) < 0.405 then
                    call DebugMsg("Hero died - phoenix ends")
                    call .destroy()
                    return
                endif
                set .legX = GetUnitX(.caster)
                set .legY = GetUnitY(.caster)
            endif

            set dx = .legX - .curX
            set dy = .legY - .curY
            set dist = SquareRoot(dx * dx + dy * dy)

            if dist <= step then
                set nextX = .legX
                set nextY = .legY
                set arrived = true
            else
                set nextX = .curX + dx / dist * step
                set nextY = .curY + dy / dist * step
            endif

            if .isCliff(nextX, nextY) then
                set arrived = true
                call DebugMsg("Phoenix hit a cliff at (" + R2S(.curX) + ", " + R2S(.curY) + ")")
            else
                set .curX = nextX
                set .curY = nextY
                call SetUnitX(.dummy, .curX)
                call SetUnitY(.dummy, .curY)
            endif

            call .hitUnits()

            if arrived then
                call .onArrive()
            endif
        endmethod

        //--------------------------------------------------------
        method onArrive takes nothing returns nothing
            if .phase == 0 then
                // End of the outbound leg (or a cliff): this spot is the anchor from now on
                set .endX = .curX
                set .endY = .curY

                if GetWidgetLife(.caster) < 0.405 then
                    call DebugMsg("Hero died - phoenix ends")
                    call .destroy()
                    return
                endif

                set .phase = 1
                set .legX = GetUnitX(.caster)
                set .legY = GetUnitY(.caster)
                set .segments = .segments + 1
                call .startLeg()
                return
            endif

            // Reached the hero: needs at least one hit during the round trip to go again
            if (not .hitThisCycle) or (.segments >= MAX_SEGMENTS) then
                call DebugMsg("Phoenix hit nothing this round trip (or hit the cap) - ending")
                call .destroy()
                return
            endif

            set .phase = 0
            set .hitThisCycle = false
            set .legX = .endX
            set .legY = .endY
            set .segments = .segments + 1
            call .startLeg()
        endmethod

        //--------------------------------------------------------
        method onDestroy takes nothing returns nothing
            call FlushChildHashtable(PhoenixHash, GetHandleId(.tmr))
            call PauseTimer(.tmr)
            call DestroyTimer(.tmr)
            call DestroyGroup(.hitGroup)

            if .dummy != null then
                call KillUnit(.dummy)
                call RemoveUnit(.dummy)
            endif
            set .hitGroup = null
            set .dummy    = null
            set .caster   = null
        endmethod

        static method onTickCallback takes nothing returns nothing
            local timer tmr = GetExpiredTimer()
            local thistype this = LoadInteger(PhoenixHash, GetHandleId(tmr), 0)
            call this.onTick()
            set tmr = null
        endmethod
    endstruct

    //==================================================================
    function CastPhoenixFury takes unit caster, real x, real y, integer lvl returns nothing
        call PhoenixInstance.create(caster, x, y, lvl)
    endfunction

    private function Init takes nothing returns nothing
    endfunction

endlibrary