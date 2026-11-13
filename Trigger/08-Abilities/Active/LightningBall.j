library LightningBall initializer Init

    globals
        // ===================== CONFIG =====================
        private constant integer LIGHTNING_BALL_DUMMY_ID    = 'h006' // <- ball-lightning visual dummy unit-type (Locust=true, Fly, 0 collision)
        private constant integer LIGHTNING_BALL_ABILITY_ID  = 'A007' // <- the real spell id players cast (unit-target)

        private constant real    BASE_DMG_PER_LVL   = 150.   // base damage per ability level on the FIRST hit
        private constant real    BOUNCE_MULTIPLIER  = 1.10   // cumulative multiplier applied to each subsequent hit
        private constant real    BOUNCE_RANGE       = 500.   // search radius for the next target, from the last hit unit
        private constant real    BALL_SPEED         = 800.   // units/second

        // Enforces the stated "up to 3 hits/second between adjacent units" cap: even if the next
        // target is right next to the current one (near-zero travel distance), a bounce can never
        // resolve faster than this floor. 1 / 3 = 0.333s -> exactly 3 hits per second max.
        private constant real    MIN_BOUNCE_TIME    = 0.3333

        private constant real    INTERVAL           = 0.03125

        private constant string  SFX_TRAIL  = "Abilities\\Weapons\\AncientProtectorMissile\\AncientProtectorMissile.mdl" // ball-in-flight visual, swap as desired
        private constant string  SFX_HIT    = "Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl" // impact zap
        private constant string  LIGHTNING_CODE = "FORK" // bolt connecting each bounce, purely cosmetic

        private constant boolean DEBUG_MODE = false
        // ====================================================

        private hashtable BallHash = InitHashtable() // timer -> LightningBallInstance
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
    // Finds a random valid enemy within range of (x,y), excluding one
    // specific unit (the one just hit, so it can't bounce to itself).
    // Returns null if nothing qualifies.
    //==================================================================
    private function GetRandomNextTarget takes real x, real y, real range, player owner, unit exclude returns unit
        local group g = CreateGroup()
        local unit array candidates
        local integer count = 0
        local unit u
        local integer pick

        call GroupEnumUnitsInRange(g, x, y, range, null)
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            call GroupRemoveUnit(g, u)

            if (u != exclude) and IsValidEnemy(u, owner) then
                set candidates[count] = u
                set count = count + 1
            endif
        endloop
        call DestroyGroup(g)
        set g = null

        if count == 0 then
            return null
        endif

        set pick = GetRandomInt(0, count - 1)
        return candidates[pick]
    endfunction

    //==================================================================
    // The lightning ball: travels in a straight line to its current
    // locked target, deals damage on arrival (scaled by a cumulative
    // multiplier that grows 10% with each successive bounce), then
    // searches for a new random target within BOUNCE_RANGE of the unit
    // it just hit. Ends when no further target can be found.
    //==================================================================
    private struct LightningBallInstance
        unit caster
        player ownerPlayer
        integer level
        unit target        // the unit this leg of the journey is flying toward
        unit lastHit        // the unit that was hit last (excluded from the next pick)
        real startX
        real startY
        real endX
        real endY
        real travelTime
        real t
        real cumMultiplier  // multiplier applied to THIS upcoming hit
        unit dummy
        timer tmr

        //--------------------------------------------------------
        static method create takes unit caster, unit firstTarget, integer lvl returns thistype
            local thistype this = thistype.allocate()
            local real cx = GetUnitX(caster)
            local real cy = GetUnitY(caster)
            local real tx = GetUnitX(firstTarget)
            local real ty = GetUnitY(firstTarget)
            local real dist = DistanceCoords(cx, cy, tx, ty)

            set .caster      = caster
            set .ownerPlayer = GetOwningPlayer(caster)
            set .level       = lvl
            set .target      = firstTarget
            set .lastHit     = null
            set .startX      = cx
            set .startY      = cy
            set .endX        = tx
            set .endY        = ty
            set .travelTime  = RMaxBJ(dist / BALL_SPEED, MIN_BOUNCE_TIME)
            set .t           = 0.
            set .cumMultiplier = 1.0

            set .dummy = CreateUnit(.ownerPlayer, LIGHTNING_BALL_DUMMY_ID, cx, cy, Atan2(ty - cy, tx - cx) * bj_RADTODEG)
            call SetUnitPathing(.dummy, false)
            call SetUnitFlyHeight(.dummy, 60., 0.)
            call DestroyEffect(AddSpecialEffectTarget(SFX_TRAIL, .dummy, "origin"))

            set .tmr = CreateTimer()
            call SaveInteger(BallHash, GetHandleId(.tmr), 0, this)
            call TimerStart(.tmr, INTERVAL, true, function LightningBallInstance.onTickCallback)

            call DebugMsg("LightningBall launched, travelTime=" + R2S(.travelTime))
            return this
        endmethod

        //--------------------------------------------------------
        method onTick takes nothing returns nothing
            local real ratio
            local real curX
            local real curY

            // If the current target died mid-flight, the chain ends here.
            if (.target == null) or (GetWidgetLife(.target) < 0.405) then
                call DebugMsg("LightningBall target invalid mid-flight - ending chain")
                call .destroy()
                return
            endif

            set .t = .t + INTERVAL
            set ratio = .t / .travelTime
            if ratio > 1. then
                set ratio = 1.
            endif

            set curX = .startX + (.endX - .startX) * ratio
            set curY = .startY + (.endY - .startY) * ratio

            call SetUnitX(.dummy, curX)
            call SetUnitY(.dummy, curY)

            if ratio >= 1. then
                call .onHit()
            endif
        endmethod

        //--------------------------------------------------------
        method onHit takes nothing returns nothing
            local real dmg = BASE_DMG_PER_LVL * I2R(.level) * .cumMultiplier
            local unit nextTarget
            local real dist

            call DestroyEffect(AddSpecialEffectTarget(SFX_HIT, .target, "origin"))
            call DestroyLightning(AddLightningEx(LIGHTNING_CODE, true, .startX, .startY, 60., .endX, .endY, 60.))

            call UnitDamageTarget(.caster, .target, dmg, false, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
            call DebugMsg("LightningBall hit for " + R2S(dmg) + " (mult=" + R2S(.cumMultiplier) + ")")

            set .lastHit = .target

            // Find the next bounce target, excluding the unit just hit
            set nextTarget = GetRandomNextTarget(.endX, .endY, BOUNCE_RANGE, .ownerPlayer, .lastHit)

            if nextTarget == null then
                call DebugMsg("LightningBall found no further target - ending chain")
                call .destroy()
                return
            endif

            // Set up the next leg of the journey
            set .startX = .endX
            set .startY = .endY
            set .endX   = GetUnitX(nextTarget)
            set .endY   = GetUnitY(nextTarget)
            set dist    = DistanceCoords(.startX, .startY, .endX, .endY)

            set .travelTime = RMaxBJ(dist / BALL_SPEED, MIN_BOUNCE_TIME)
            set .t = 0.
            set .target = nextTarget
            set .cumMultiplier = .cumMultiplier * BOUNCE_MULTIPLIER

            call SetUnitFacing(.dummy, Atan2(.endY - .startY, .endX - .startX) * bj_RADTODEG)
        endmethod

        //--------------------------------------------------------
        method onDestroy takes nothing returns nothing
            call FlushChildHashtable(BallHash, GetHandleId(.tmr))
            call PauseTimer(.tmr)
            call DestroyTimer(.tmr)

            call KillUnit(.dummy)
            call RemoveUnit(.dummy)
            set .dummy  = null
            set .caster = null
            set .target = null
            set .lastHit = null
        endmethod

        static method onTickCallback takes nothing returns nothing
            local timer tmr = GetExpiredTimer()
            local thistype this = LoadInteger(BallHash, GetHandleId(tmr), 0)
            call this.onTick()
            set tmr = null
        endmethod
    endstruct

    //==================================================================
    // Public entry point — unit-target cast, matches the format of
    // other single-unit-target abilities you're using.
    //==================================================================
    function CastLightningBall takes unit caster, unit target, integer lvl returns nothing
        if target == null then
            return
        endif
        call LightningBallInstance.create(caster, target, lvl)
    endfunction

    private function Init takes nothing returns nothing
    endfunction

endlibrary