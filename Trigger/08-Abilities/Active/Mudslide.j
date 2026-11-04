library MudSlide initializer Init

    globals
        // true = this library listens for the spell itself. Set false if you call CastMudSlide from your own trigger.
        private constant boolean AUTO_REGISTER         = true

        // Timeline
        private constant real    WINDUP_TIME           = 2.0     // the Y-shaped streams flow and converge for this long
        private constant real    JET_SPEED             = 500.    // blast speed
        private constant real    JET_DISTANCE          = 1500.   // blast distance (blast lasts JET_DISTANCE / JET_SPEED = 3s)
        private constant real    DISSIPATE_TIME        = 0.5     // the whole jet shrinks away over the last bit

        // Jet shape
        private constant real    JET_WIDTH             = 400.
        private constant real    EDGE_WIDTH            = 100.    // outer band on EACH side (so the middle section is 200 wide)
        private constant real    JET_LENGTH            = 450.    // how far back the body of the jet stretches behind its front edge

        // Damage / forces
        private constant real    DMG_PER_LEVEL         = 300.    // x ability level
        private constant real    EDGE_PUSH_DIST        = 300.    // outer band: diagonal sideways push
        private constant real    EDGE_PUSH_TIME        = 0.4
        private constant real    EDGE_PUSH_ANGLE       = 0.7853982 // 45 degrees off the forward direction, outward
        private constant real    CAUGHT_DMG_INTERVAL   = 0.5     // middle section: damage this often while caught
        private constant real    END_PUSH_DIST         = 500.    // caught units are thrown forward this far when the wave ends
        private constant real    END_PUSH_TIME         = 0.5
        private constant integer MAX_CAUGHT            = 24      // most units one cast can hold at once

        // Y shape (all measured from the hero's cast-time position, along / across his cast direction)
        private constant real    CONVERGE_DIST         = 250.    // the streams meet this far IN FRONT of the hero
        private constant real    ARM_BACK              = 350.    // streams start this far BEHIND him...
        private constant real    ARM_SIDE              = 450.    // ...and this far out to each side
        private constant real    ARM_CTRL_FORWARD      = 100.    // curve control point (bends the stream inwards)
        private constant real    ARM_CTRL_SIDE         = 420.
        private constant real    ARM_FLOW              = 0.5     // how fast mud flows along each stream (laps per second)
        private constant real    ARM_WOBBLE            = 40.

        // Particles (effects). Total must stay at or under 120.
        private constant integer ARM_PARTICLES         = 22      // per stream
        private constant integer BLOB_PARTICLES        = 14      // swirling mass where the streams meet
        private constant integer JET_PARTICLES         = 56      // the blast itself
        private constant integer ROCK_EVERY            = 4       // every Nth particle is a rock instead of mud
        private constant real    BLOB_RADIUS_MIN       = 40.
        private constant real    BLOB_RADIUS_MAX       = 130.
        private constant real    BLOB_SPIN             = 6.
        private constant real    JET_FLOW              = 0.8     // how fast mud churns through the jet (laps per second)
        private constant real    PARTICLE_HEIGHT       = 30.

        // Models: swap these for whatever mud / rock models you like. They are tinted below.
        private constant string  MUD_MODEL             = "Abilities\\Weapons\\WaterElementalMissile\\WaterElementalMissile.mdl"
        private constant string  ROCK_MODEL            = "Abilities\\Weapons\\Catapult\\CatapultMissile.mdl"
        private constant integer MUD_RED               = 150
        private constant integer MUD_GREEN             = 105
        private constant integer MUD_BLUE              = 60
        private constant integer ROCK_RED              = 130
        private constant integer ROCK_GREEN            = 120
        private constant integer ROCK_BLUE             = 105
        private constant real    MUD_SCALE_MIN         = 1.6
        private constant real    MUD_SCALE_MAX         = 2.6
        private constant real    ROCK_SCALE_MIN        = 0.8
        private constant real    ROCK_SCALE_MAX        = 1.4

        private constant real    INTERVAL              = 0.03125
        // ====================================================

        private integer array Active
        private integer       Count = 0
        private timer         Tick  = CreateTimer()
        private group         Grp   = CreateGroup()
        private location     ZLoc  = Location(0., 0.)
        private hashtable     HoldHash = InitHashtable()  // unit -> number of things holding it still
        private hashtable     PushHash = InitHashtable()  // timer -> MudPushInstance
    endglobals

    //==================================================================
    private function GroundZ takes real x, real y returns real
        call MoveLocation(ZLoc, x, y)
        return GetLocationZ(ZLoc)
    endfunction

    private function IsValidTarget takes unit u, unit caster, player owner returns boolean
        return u != caster /*
            */ and GetWidgetLife(u) > 0.405 /*
            */ and IsUnitEnemy(u, owner) /*
            */ and not IsUnitType(u, UNIT_TYPE_DEAD) /*
            */ and not IsUnitType(u, UNIT_TYPE_STRUCTURE) /*
            */ and GetUnitAbilityLevel(u, 'Aloc') == 0
    endfunction

    // Freezes a unit in place. Stacking-safe: it stays frozen until EVERY hold on it is released.
    private function MudHold takes unit u returns nothing
        local integer id = GetHandleId(u)
        local integer c = LoadInteger(HoldHash, id, 0)

        if c == 0 then
            call PauseUnit(u, true)
            call UnitAddType(u, UNIT_TYPE_STUNNED)
        endif
        call SaveInteger(HoldHash, id, 0, c + 1)
    endfunction

    private function MudRelease takes unit u returns nothing
        local integer id = GetHandleId(u)
        local integer c = LoadInteger(HoldHash, id, 0) - 1

        if c <= 0 then
            call RemoveSavedInteger(HoldHash, id, 0)
            call UnitRemoveType(u, UNIT_TYPE_STUNNED)
            if GetWidgetLife(u) > 0.405 then
                call PauseUnit(u, false)
            endif
        else
            call SaveInteger(HoldHash, id, 0, c)
        endif
    endfunction

    //==================================================================
    // A unit being shoved along the ground over a short time. It stops
    // dead the instant it would cross onto a different cliff level, so
    // nobody is ever pushed up, down or over a cliff.
    //==================================================================
    private struct MudPushInstance
        unit u
        real angle
        real speed
        real t
        real duration
        integer level
        timer tmr

        static method create takes unit whichUnit, real angle, real dist, real duration returns thistype
            local thistype this = thistype.allocate()

            set .u        = whichUnit
            set .angle    = angle
            set .duration = duration
            set .speed    = dist / duration
            set .t        = 0.
            set .level    = GetTerrainCliffLevel(GetUnitX(whichUnit), GetUnitY(whichUnit))
            set .tmr      = CreateTimer()

            call MudHold(whichUnit)

            call SaveInteger(PushHash, GetHandleId(.tmr), 0, this)
            call TimerStart(.tmr, INTERVAL, true, function MudPushInstance.onTickCallback)
            return this
        endmethod

        method onTick takes nothing returns nothing
            local real nx
            local real ny

            set .t = .t + INTERVAL

            if GetWidgetLife(.u) > 0.405 and .t <= .duration then
                set nx = GetUnitX(.u) + .speed * INTERVAL * Cos(.angle)
                set ny = GetUnitY(.u) + .speed * INTERVAL * Sin(.angle)

                if GetTerrainCliffLevel(nx, ny) == .level then
                    call SetUnitX(.u, nx)
                    call SetUnitY(.u, ny)
                else
                    set .t = .duration   // hit a cliff: the push is over
                endif
            endif

            if .t >= .duration then
                call .onFinish()
            endif
        endmethod

        method onFinish takes nothing returns nothing
            call MudRelease(.u)
            call FlushChildHashtable(PushHash, GetHandleId(.tmr))
            call PauseTimer(.tmr)
            call DestroyTimer(.tmr)
            set .u = null
            call .destroy()
        endmethod

        static method onTickCallback takes nothing returns nothing
            local timer tmr = GetExpiredTimer()
            local thistype this = LoadInteger(PushHash, GetHandleId(tmr), 0)
            call this.onTick()
            set tmr = null
        endmethod
    endstruct

    //==================================================================
    // The whole spell.
    //
    //   Phase 1 (WINDUP_TIME): two streams of mud and rocks flow along
    //   curved paths from behind and beside the hero (a Y shape) and
    //   converge in a swirling mass just in front of him.
    //
    //   Phase 2 (JET_DISTANCE / JET_SPEED): the jet blasts forward from the
    //   convergence point, then dissipates.
    //     - outer EDGE_WIDTH on each side: damage + diagonal sideways push
    //     - middle section: unit is frozen, carried forward with the jet,
    //       damaged every CAUGHT_DMG_INTERVAL, and thrown forward at the end
    //     - the jet's front halts at a cliff but keeps churning, and units
    //       caught in it stay held and keep taking damage until it ends
    //==================================================================
    private struct MudSlideInstance
        unit caster
        player owner
        integer level
        real hx
        real hy
        real angle
        real cosA
        real sinA
        real cx           // convergence point = start of the jet
        real cy
        real t
        real front        // how far the jet's front edge has travelled from the convergence point
        integer jetLevel  // cliff level the jet runs on

        group handled     // units already hit by this cast (each is only dealt with once)

        unit array cu[24]     // caught units
        real array ct[24]     // their damage timers
        integer array cl[24]  // the cliff level each is held at
        integer cn

        effect array fx[120]
        real array pv[120]
        real array pp[120]
        real array ps[120]
        boolean array rk[120]

        //--------------------------------------------------------
        static method create takes unit caster, real tx, real ty, integer lvl returns thistype
            local thistype this = thistype.allocate()
            local real x = GetUnitX(caster)
            local real y = GetUnitY(caster)
            local integer blobStart = ARM_PARTICLES * 2
            local integer jetStart  = blobStart + BLOB_PARTICLES
            local integer total     = jetStart + JET_PARTICLES
            local integer k = 0
            local integer i
            local boolean rock

            set .caster  = caster
            set .owner   = GetOwningPlayer(caster)
            set .level   = lvl
            set .hx      = x
            set .hy      = y
            if tx == x and ty == y then
                set .angle = GetUnitFacing(caster) * bj_DEGTORAD
            else
                set .angle = Atan2(ty - y, tx - x)
            endif
            set .cosA    = Cos(.angle)
            set .sinA    = Sin(.angle)
            set .cx      = x + CONVERGE_DIST * .cosA
            set .cy      = y + CONVERGE_DIST * .sinA
            set .t       = 0.
            set .front   = 0.
            set .jetLevel = GetTerrainCliffLevel(.cx, .cy)
            set .handled = CreateGroup()
            set .cn      = 0

            // build all the particles up front, hidden until they're needed
            loop
                exitwhen k >= total

                if k < blobStart then
                    set i = k - (k / ARM_PARTICLES) * ARM_PARTICLES
                    set rock = (i - (i / ROCK_EVERY) * ROCK_EVERY) == 0
                    set .pv[k] = GetRandomReal(-ARM_WOBBLE, ARM_WOBBLE)
                    set .pp[k] = GetRandomReal(0., 2. * bj_PI)
                elseif k < jetStart then
                    set rock = false
                    set .pv[k] = GetRandomReal(0., 1.)
                    set .pp[k] = GetRandomReal(0., 2. * bj_PI)
                else
                    set i = k - jetStart
                    set rock = (i - (i / ROCK_EVERY) * ROCK_EVERY) == 0
                    set .pv[k] = GetRandomReal(-(JET_WIDTH * 0.5 - 20.), JET_WIDTH * 0.5 - 20.)
                    set .pp[k] = GetRandomReal(0., 1.)
                endif

                set .rk[k] = rock
                if rock then
                    set .fx[k] = AddSpecialEffect(ROCK_MODEL, x, y)
                    call BlzSetSpecialEffectColor(.fx[k], ROCK_RED, ROCK_GREEN, ROCK_BLUE)
                    set .ps[k] = GetRandomReal(ROCK_SCALE_MIN, ROCK_SCALE_MAX)
                else
                    set .fx[k] = AddSpecialEffect(MUD_MODEL, x, y)
                    call BlzSetSpecialEffectColor(.fx[k], MUD_RED, MUD_GREEN, MUD_BLUE)
                    set .ps[k] = GetRandomReal(MUD_SCALE_MIN, MUD_SCALE_MAX)
                endif
                call BlzSetSpecialEffectScale(.fx[k], 0.001)

                set k = k + 1
            endloop

            set Active[Count] = this
            set Count = Count + 1
            if Count == 1 then
                call TimerStart(Tick, INTERVAL, true, function thistype.tickAll)
            endif
            return this
        endmethod

        //--------------------------------------------------------
        // Lets go of a caught unit (swap-removes it from the list)
        method removeCaught takes integer i returns nothing
            call MudRelease(.cu[i])
            set .cn = .cn - 1
            set .cu[i] = .cu[.cn]
            set .ct[i] = .ct[.cn]
            set .cl[i] = .cl[.cn]
            set .cu[.cn] = null
        endmethod

        //--------------------------------------------------------
        // Places and scales every particle for this tick
        method updateVisuals takes real fade, boolean blasting, real tb returns nothing
            local integer blobStart = ARM_PARTICLES * 2
            local integer jetStart  = blobStart + BLOB_PARTICLES
            local integer total     = jetStart + JET_PARTICLES
            local integer k = 0
            local integer arm
            local integer i
            local real side
            local real s
            local real inv
            local real a
            local real b
            local real x
            local real y
            local real z
            local real ramp
            local real sc
            local real r
            local real ang
            local real progress
            local real w
            local real u
            local real v
            local real yaw

            loop
                exitwhen k >= total

                if k < blobStart then
                    // ---------- the two streams: flow along a curve from behind/beside the hero to the convergence point ----------
                    set arm = k / ARM_PARTICLES
                    set i = k - arm * ARM_PARTICLES
                    if arm == 0 then
                        set side = 1.
                    else
                        set side = -1.
                    endif

                    set s = I2R(i) / I2R(ARM_PARTICLES) + .t * ARM_FLOW + I2R(arm) * 0.5 / I2R(ARM_PARTICLES)
                    set s = s - I2R(R2I(s))
                    set inv = 1. - s

                    set a = inv * inv * (-ARM_BACK) + 2. * inv * s * ARM_CTRL_FORWARD + s * s * CONVERGE_DIST
                    set b = side * (inv * inv * ARM_SIDE + 2. * inv * s * ARM_CTRL_SIDE) + .pv[k] * Sin(.pp[k] + .t * 4.)

                    set x = .hx + a * .cosA - b * .sinA
                    set y = .hy + a * .sinA + b * .cosA
                    set z = GroundZ(x, y) + PARTICLE_HEIGHT + 20. * Sin(.pp[k] * 2. + .t * 6.)

                    set ramp = s * 10.
                    if (1. - s) * 10. < ramp then
                        set ramp = (1. - s) * 10.
                    endif
                    if ramp > 1. then
                        set ramp = 1.
                    endif
                    set sc = .ps[k] * ramp * fade

                elseif k < jetStart then
                    // ---------- the swirling mass where the streams meet ----------
                    set progress = .t / WINDUP_TIME
                    if progress > 1. then
                        set progress = 1.
                    endif

                    set ang = .pp[k] + .t * BLOB_SPIN
                    set r = (BLOB_RADIUS_MIN + (BLOB_RADIUS_MAX - BLOB_RADIUS_MIN) * progress) * (0.6 + 0.4 * .pv[k])

                    set x = .cx + r * Cos(ang)
                    set y = .cy + r * Sin(ang)
                    set z = GroundZ(x, y) + PARTICLE_HEIGHT + 30. * Sin(.t * 5. + .pp[k])

                    set ramp = .t / (WINDUP_TIME * 0.5)
                    if ramp > 1. then
                        set ramp = 1.
                    endif
                    set sc = .ps[k] * ramp * fade

                else
                    // ---------- the jet: mud churns backwards through a body that rides on the advancing front ----------
                    if blasting then
                        set w = .pp[k] + tb * JET_FLOW
                        set w = w - I2R(R2I(w))
                        set u = .front - w * JET_LENGTH
                        set v = .pv[k] + 14. * Sin(tb * 6. + .pp[k] * 20.)

                        set x = .cx + u * .cosA - v * .sinA
                        set y = .cy + u * .sinA + v * .cosA
                        set z = GroundZ(x, y) + PARTICLE_HEIGHT + 25. * Sin(u * 0.02 + tb * 8.)

                        if u < 0. then
                            set sc = 0.001      // not out of the convergence point yet
                        else
                            set sc = .ps[k] * (1.1 - 0.5 * w) * fade
                        endif
                    else
                        set x = .cx
                        set y = .cy
                        set z = GroundZ(x, y)
                        set sc = 0.001
                    endif
                endif

                if sc < 0.001 then
                    set sc = 0.001
                endif

                if .rk[k] then
                    set yaw = .pp[k] + .t * 2.      // rocks tumble
                else
                    set yaw = .angle
                endif

                call BlzSetSpecialEffectScale(.fx[k], sc)
                call BlzSetSpecialEffectPosition(.fx[k], x, y, z)
                call BlzSetSpecialEffectYaw(.fx[k], yaw)

                set k = k + 1
            endloop
        endmethod

        //--------------------------------------------------------
        // returns true when the spell is finished
        method step takes nothing returns boolean
            local boolean blasting = false
            local boolean finished = false
            local real tb = 0.
            local real fade = 1.
            local real blastTime = JET_DISTANCE / JET_SPEED
            local real stp
            local real moved = 0.
            local real nx
            local real ny
            local real lo
            local real hi
            local real halfLen
            local real mx
            local real my
            local real rad
            local real dx
            local real dy
            local real uu
            local real vv
            local real ang
            local real dmg
            local real midHalf = JET_WIDTH * 0.5 - EDGE_WIDTH
            local integer i
            local unit u

            set .t = .t + INTERVAL
            if .t >= WINDUP_TIME then
                set blasting = true
                set tb = .t - WINDUP_TIME
            endif

            if blasting then
                set dmg = DMG_PER_LEVEL * I2R(.level)

                // ---------- advance the front (it halts at a cliff but the spell keeps running) ----------
                set stp = JET_SPEED * INTERVAL
                if .front + stp > JET_DISTANCE then
                    set stp = JET_DISTANCE - .front
                endif
                if stp < 0. then
                    set stp = 0.
                endif
                if stp > 0. then
                    set nx = .cx + (.front + stp) * .cosA
                    set ny = .cy + (.front + stp) * .sinA
                    if GetTerrainCliffLevel(nx, ny) != .jetLevel then
                        set stp = 0.
                    endif
                endif
                set .front = .front + stp
                set moved = stp

                // ---------- find units touching the jet ----------
                set hi = .front
                set lo = .front - JET_LENGTH
                if lo < 0. then
                    set lo = 0.
                endif
                set halfLen = (hi - lo) * 0.5
                set mx = .cx + (lo + halfLen) * .cosA
                set my = .cy + (lo + halfLen) * .sinA
                set rad = SquareRoot(halfLen * halfLen + (JET_WIDTH * 0.5) * (JET_WIDTH * 0.5)) + 64.

                call GroupEnumUnitsInRange(Grp, mx, my, rad, null)
                loop
                    set u = FirstOfGroup(Grp)
                    exitwhen u == null
                    call GroupRemoveUnit(Grp, u)

                    if not IsUnitInGroup(u, .handled) and IsValidTarget(u, .caster, .owner) then
                        set dx = GetUnitX(u) - .cx
                        set dy = GetUnitY(u) - .cy
                        set uu = dx * .cosA + dx * 0. + dy * .sinA
                        set vv = -dx * .sinA + dy * .cosA

                        if uu >= lo and uu <= hi and vv <= JET_WIDTH * 0.5 and vv >= -JET_WIDTH * 0.5 then
                            if vv <= midHalf and vv >= -midHalf then
                                // middle section: caught up in the jet
                                if .cn < MAX_CAUGHT then
                                    call GroupAddUnit(.handled, u)
                                    set .cu[.cn] = u
                                    set .ct[.cn] = CAUGHT_DMG_INTERVAL   // so the first damage lands right away
                                    set .cl[.cn] = GetTerrainCliffLevel(GetUnitX(u), GetUnitY(u))
                                    set .cn = .cn + 1
                                    call MudHold(u)
                                endif
                            else
                                // outer band: damaged and shoved diagonally outward
                                call GroupAddUnit(.handled, u)
                                call UnitDamageTarget(.caster, u, dmg, false, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)

                                if GetWidgetLife(u) > 0.405 then
                                    if vv > 0. then
                                        set ang = .angle + EDGE_PUSH_ANGLE
                                    else
                                        set ang = .angle - EDGE_PUSH_ANGLE
                                    endif
                                    call MudPushInstance.create(u, ang, EDGE_PUSH_DIST, EDGE_PUSH_TIME)
                                endif
                            endif
                        endif
                    endif
                endloop
                set u = null

                // ---------- carry and damage everything caught ----------
                set i = .cn - 1
                loop
                    exitwhen i < 0
                    set u = .cu[i]

                    if GetWidgetLife(u) < 0.405 then
                        call .removeCaught(i)
                    else
                        // carried along with the jet, but never over a cliff
                        if moved > 0. then
                            set nx = GetUnitX(u) + moved * .cosA
                            set ny = GetUnitY(u) + moved * .sinA
                            if GetTerrainCliffLevel(nx, ny) == .cl[i] then
                                call SetUnitX(u, nx)
                                call SetUnitY(u, ny)
                            endif
                        endif

                        // damage keeps ticking whether or not the unit can still move (e.g. pinned against a cliff)
                        set .ct[i] = .ct[i] + INTERVAL
                        if .ct[i] >= CAUGHT_DMG_INTERVAL then
                            set .ct[i] = .ct[i] - CAUGHT_DMG_INTERVAL
                            if GetWidgetLife(u) <= dmg then
                                call .removeCaught(i)     // freed first so a lethal hit can play its death
                            endif
                            call UnitDamageTarget(.caster, u, dmg, false, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                        endif
                    endif

                    set i = i - 1
                endloop
                set u = null

                // ---------- end of the wave ----------
                if tb >= blastTime then
                    set i = .cn - 1
                    loop
                        exitwhen i < 0
                        set u = .cu[i]
                        if GetWidgetLife(u) > 0.405 then
                            call MudPushInstance.create(u, .angle, END_PUSH_DIST, END_PUSH_TIME)   // takes its own hold first...
                        endif
                        call .removeCaught(i)                                                       // ...then the catch hold is let go
                        set i = i - 1
                    endloop
                    set u = null
                    set finished = true
                endif

                // everything shrinks away over the last moments
                if blastTime - tb < DISSIPATE_TIME then
                    set fade = (blastTime - tb) / DISSIPATE_TIME
                    if fade < 0. then
                        set fade = 0.
                    endif
                endif
            endif

            call .updateVisuals(fade, blasting, tb)
            return finished
        endmethod

        //--------------------------------------------------------
        method onDestroy takes nothing returns nothing
            local integer k = 0
            local integer total = ARM_PARTICLES * 2 + BLOB_PARTICLES + JET_PARTICLES

            // safety: never leave anyone frozen
            loop
                exitwhen .cn <= 0
                call .removeCaught(.cn - 1)
            endloop

            loop
                exitwhen k >= total
                call BlzSetSpecialEffectScale(.fx[k], 0.001)   // hides the death animation
                call DestroyEffect(.fx[k])
                set .fx[k] = null
                set k = k + 1
            endloop

            call DestroyGroup(.handled)
            set .handled = null
            set .caster = null
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
    // Public entry point. Fires toward the target point (or the hero's facing if the point is on him).
    function CastMudSlide takes unit hero, real x, real y, integer lvl returns nothing
        if hero == null then
            return
        endif
        call MudSlideInstance.create(hero, x, y, lvl)
    endfunction

    private function OnCast takes nothing returns boolean
        local unit c

        if GetSpellAbilityId() == MUD_SLIDE_ABILITY_ID then
            set c = GetTriggerUnit()
            call CastMudSlide(c, GetSpellTargetX(), GetSpellTargetY(), GetUnitAbilityLevel(c, MUD_SLIDE_ABILITY_ID))
            set c = null
        endif
        return false
    endfunction

    private function Init takes nothing returns nothing
        local trigger t

        if AUTO_REGISTER then
            set t = CreateTrigger()
            call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_EFFECT)
            call TriggerAddCondition(t, Condition(function OnCast))
            set t = null
        endif
    endfunction

endlibrary