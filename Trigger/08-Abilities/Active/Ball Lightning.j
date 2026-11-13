library LightningBall initializer Init

    globals
        // ===================== CONFIG =====================
        private constant integer DUMMY_ID           = 'esen'  // needs Locust + Invulnerable (you add these)

        private constant real    BASE_DMG_PER_LVL   = 150.    // damage per ability level on the FIRST hit
        private constant real    BOUNCE_MULTIPLIER  = 1.10    // cumulative multiplier per subsequent hit
        private constant real    BOUNCE_RANGE       = 500.    // search radius for next target, from the unit just hit
        private constant real    BALL_SPEED         = 300.    // units/second
        private constant integer MAX_BOUNCES        = 0       // 0 = unlimited (two units will ping-pong forever)

        // Enforces "up to 3 hits/second between adjacent units"
        private constant real    MIN_BOUNCE_TIME    = 0.3333

        private constant real    INTERVAL           = 0.03125

        // Visuals
        private constant string  BALL_MODEL         = "Abilities\\Spells\\Items\\WandOfNeutralization\\NeutralizationMissile.mdl"
        private constant real    BALL_SCALE         = 1.5
        private constant real    FLY_HEIGHT         = 60.
        private constant boolean USE_BOLT           = true    // lightning trail from last hit point to the ball
        private constant string  LIGHTNING_CODE     = "SPLK"

        private constant boolean DEBUG_MODE         = false
        // ====================================================

        private integer array Active
        private integer       Count = 0
        private timer         Tick  = CreateTimer()
        private group         Grp   = CreateGroup()
        private unit array    Cands
        private location      ZLoc  = Location(0., 0.)
    endglobals

    //==================================================================
    private function DebugMsg takes string s returns nothing
        if DEBUG_MODE then
            call BJDebugMsg(s)
        endif
    endfunction

    private function Dist takes real x1, real y1, real x2, real y2 returns real
        return SquareRoot((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1))
    endfunction

    // Absolute Z (needed by lightning only; the dummy uses fly height)
    private function GetZ takes real x, real y returns real
        call MoveLocation(ZLoc, x, y)
        return GetLocationZ(ZLoc) + FLY_HEIGHT
    endfunction

    private function IsValidEnemy takes unit u, player owner returns boolean
        return GetWidgetLife(u) > 0.405 /*
            */ and IsUnitEnemy(u, owner) /*
            */ and not IsUnitType(u, UNIT_TYPE_DEAD) /*
            */ and GetUnitAbilityLevel(u, 'Aloc') == 0
    endfunction

    private function RandomTarget takes real x, real y, player owner, unit exclude returns unit
        local integer n = 0
        local unit u

        call GroupEnumUnitsInRange(Grp, x, y, BOUNCE_RANGE, null)
        loop
            set u = FirstOfGroup(Grp)
            exitwhen u == null
            call GroupRemoveUnit(Grp, u)
            if u != exclude and IsValidEnemy(u, owner) then
                set Cands[n] = u
                set n = n + 1
            endif
        endloop

        if n == 0 then
            return null
        endif
        return Cands[GetRandomInt(0, n - 1)]
    endfunction

    //==================================================================
    private struct Ball
        unit      caster
        player    owner
        integer   level
        unit      target
        unit      lastHit
        unit      dummy
        effect    fx
        lightning bolt
        real      startX
        real      startY
        real      endX
        real      endY
        real      travelTime
        real      t
        real      mult
        integer   hits

        //--------------------------------------------------------
        static method create takes unit caster, unit firstTarget, integer lvl returns thistype
            local thistype this = thistype.allocate()
            local real cx = GetUnitX(caster)
            local real cy = GetUnitY(caster)
            local real tx = GetUnitX(firstTarget)
            local real ty = GetUnitY(firstTarget)

            set .caster     = caster
            set .owner      = GetOwningPlayer(caster)
            set .level      = lvl
            set .target     = firstTarget
            set .lastHit    = null
            set .startX     = cx
            set .startY     = cy
            set .endX       = tx
            set .endY       = ty
            set .travelTime = RMaxBJ(Dist(cx, cy, tx, ty) / BALL_SPEED, MIN_BOUNCE_TIME)
            set .t          = 0.
            set .mult       = 1.
            set .hits       = 0

            set .dummy = CreateUnit(.owner, DUMMY_ID, cx, cy, bj_RADTODEG * Atan2(ty - cy, tx - cx))
            call UnitAddAbility(.dummy, 'Amrf')      // lets us change fly height
            call UnitRemoveAbility(.dummy, 'Amrf')
            call SetUnitFlyHeight(.dummy, FLY_HEIGHT, 0.)

            set .fx = AddSpecialEffectTarget(BALL_MODEL, .dummy, "origin")
            call BlzSetSpecialEffectScale(.fx, BALL_SCALE)

            if USE_BOLT then
                set .bolt = AddLightningEx(LIGHTNING_CODE, true, cx, cy, GetZ(cx, cy), cx, cy, GetZ(cx, cy))
            endif

            set Active[Count] = this
            set Count = Count + 1
            if Count == 1 then
                call TimerStart(Tick, INTERVAL, true, function thistype.tickAll)
            endif

            call DebugMsg("LightningBall launched")
            return this
        endmethod

        //--------------------------------------------------------
        // returns true when the chain is finished
        method hit takes nothing returns boolean
            local real dmg = BASE_DMG_PER_LVL * I2R(.level) * .mult
            local unit nxt

            call UnitDamageTarget(.caster, .target, dmg, false, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
            call DebugMsg("LightningBall hit for " + R2S(dmg))

            set .hits    = .hits + 1
            set .lastHit = .target

            if MAX_BOUNCES > 0 and .hits > MAX_BOUNCES then
                return true
            endif

            set nxt = RandomTarget(.endX, .endY, .owner, .lastHit)
            if nxt == null then
                call DebugMsg("LightningBall: no further target")
                return true
            endif

            set .startX     = .endX
            set .startY     = .endY
            set .endX       = GetUnitX(nxt)
            set .endY       = GetUnitY(nxt)
            set .travelTime = RMaxBJ(Dist(.startX, .startY, .endX, .endY) / BALL_SPEED, MIN_BOUNCE_TIME)
            set .t          = 0.
            set .target     = nxt
            set .mult       = .mult * BOUNCE_MULTIPLIER

            set nxt = null
            return false
        endmethod

        //--------------------------------------------------------
        // returns true when the chain is finished
        method step takes nothing returns boolean
            local real ratio
            local real curX
            local real curY

            if .target == null or GetWidgetLife(.target) < 0.405 then
                call DebugMsg("LightningBall: target lost")
                return true
            endif

            // follow the target so the ball still lands if it moves
            set .endX = GetUnitX(.target)
            set .endY = GetUnitY(.target)

            set .t = .t + INTERVAL
            set ratio = .t / .travelTime
            if ratio > 1. then
                set ratio = 1.
            endif

            set curX = .startX + (.endX - .startX) * ratio
            set curY = .startY + (.endY - .startY) * ratio

            call SetUnitX(.dummy, curX)
            call SetUnitY(.dummy, curY)
            call SetUnitFacing(.dummy, bj_RADTODEG * Atan2(.endY - .startY, .endX - .startX))

            if .bolt != null then
                call MoveLightningEx(.bolt, true, .startX, .startY, GetZ(.startX, .startY), curX, curY, GetZ(curX, curY))
            endif

            if ratio >= 1. then
                return .hit()
            endif
            return false
        endmethod

        //--------------------------------------------------------
        method onDestroy takes nothing returns nothing
            if .bolt != null then
                call DestroyLightning(.bolt)
                set .bolt = null
            endif

            if .fx != null then
                // shrink first so the model's death animation is invisible
                call BlzSetSpecialEffectScale(.fx, 0.001)
                call DestroyEffect(.fx)
                set .fx = null
            endif

            // RemoveUnit skips the unit's death animation entirely
            call RemoveUnit(.dummy)
            set .dummy   = null
            set .caster  = null
            set .target  = null
            set .lastHit = null
        endmethod

        //--------------------------------------------------------
        static method tickAll takes nothing returns nothing
            local integer i = Count - 1
            local thistype this

            loop
                exitwhen i < 0
                set this = Active[i]
                if this.step() then
                    call this.destroy()
                    set Count = Count - 1
                    set Active[i] = Active[Count]
                endif
                set i = i - 1
            endloop

            if Count == 0 then
                call PauseTimer(Tick)
            endif
        endmethod
    endstruct

    //==================================================================
    function CastLightningBall takes unit caster, unit target, integer lvl returns nothing
        if caster == null or target == null then
            call DebugMsg("CastLightningBall: null caster/target")
            return
        endif
        call Ball.create(caster, target, lvl)
    endfunction

    private function Init takes nothing returns nothing
    endfunction

endlibrary