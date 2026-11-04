library Whirlpool requires GetObjectElement, CastSpellOnTarget, RandomShit

    globals
        // ===================== CONFIG =====================
        // WHIRLPOOL_ABILITY_ID must already exist as a global constant.

        // Timeline
        private constant real    WHIRLPOOL_TIME     = 15.     // the whirlpool at full strength; the rain falls for this long
        private constant real    SHRINK_TIME        = 5.      // then it shrinks away over this long
        private constant real    RAIN_RADIUS        = 700.    // minimum size of the rainy area (it's made bigger if the whirlpool will outgrow it)
        private constant integer RAIN_WEATHER_ID    = 'RLhr'  // heavy rain weather effect. ('RAhr' is the Ashenvale one)

        // Size and growth: it starts small and grows GROWTH_PER_SECOND every second for a number of seconds
        private constant real    START_RADIUS       = 50.
        private constant real    GROWTH_PER_SECOND  = 50.
        private constant real    BASE_GROW_SECONDS  = 5.      // it always grows for this many seconds...
        private constant real    GROW_SECONDS_PER_WATER = 1.  // ...plus this many more for each Water element the hero has (read when it's cast)
        private constant real    MAX_RADIUS         = 0.      // 0 = no limit

        // What it does to units
        private constant real    PULL_SPEED         = 100.    // units per second toward the centre
        private constant real    SPIRAL_SPEED       = 3.      // radians per second the caught units swirl around the centre (a full circle is about 6.3)
        private constant real    BREAKAWAY_DIST     = 350.    // a caught unit that gets moved this far off its path by something else (blink, knockback) is let go
        private constant real    CENTER_RADIUS      = 30.     // a unit this close to the centre has "arrived" and is ejected
        private constant real    EJECT_MIN          = 1000.   // ejected a random distance between these...
        private constant real    EJECT_MAX          = 2000.
        private constant real    EJECT_SPEED        = 2000.   // ...at this speed, in a random direction, stopping at cliffs
        private constant real    DMG_PER_LEVEL      = 2000.   // damage to enemies ONLY when they hit a wall/cliff, x ability level

        // Keeping everything on the whirlpool's own level of ground (never up or down a cliff)
        private constant real    WALL_MARGIN        = 96.     // a flung unit stops this far SHORT of a cliff, so it can never end up on one
        private constant real    FLIGHT_SUBSTEP     = 24.     // a flight is checked every this many units, so a thin wall can't be skipped
        private constant real    DRAG_MARGIN        = 30.     // a unit being dragged in stops this far short of a cliff

        // Look
        private constant string  ORB_MODEL          = "Abilities\\Weapons\\WaterElementalMissile\\WaterElementalMissile.mdl"
        private constant real    MODEL_NATIVE_WIDTH = 50.     // rough width of the orb model at scale 1. Tune if sizes look off
        private constant integer WHIRL_ARMS         = 4       // spiral arms (arms x orbs per arm must be at most 56)
        private constant integer WHIRL_PER_ARM      = 14
        private constant real    SPIN               = 2.      // radians per second the arms turn
        private constant real    TWIST              = 2.4     // how tightly the arms curl
        private constant real    BUBBLE_DIAMETER    = 130.    // the water bubble around a flung unit
        private constant string  SPLASH_MODEL       = "Abilities\\Spells\\Other\\CrushingWave\\CrushingWaveDamage.mdl"  // where a unit is flung from and where it lands
        private constant string  WALL_MODEL         = "Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl"            // when a flung unit slams into a wall
        private constant integer WATER_RED          = 70
        private constant integer WATER_GREEN        = 160
        private constant integer WATER_BLUE         = 255

        private constant real    INTERVAL           = 0.03125
        // ====================================================

        private integer array Active
        private integer       Count = 0
        private timer         Tick  = CreateTimer()
        private group         Grp   = CreateGroup()
        private location     ZLoc  = Location(0., 0.)
        private hashtable     HoldHash = InitHashtable()   // unit -> how many things are holding it still

        // playable map bounds (filled on first use)
        private boolean BoundsReady = false
        private real    MinX = 0.
        private real    MaxX = 0.
        private real    MinY = 0.
        private real    MaxY = 0.
    endglobals

    //==================================================================
    private function GroundZ takes real x, real y returns real
        call MoveLocation(ZLoc, x, y)
        return GetLocationZ(ZLoc)
    endfunction

    private function IsOutOfBounds takes real x, real y returns boolean
        if not BoundsReady then
            set MinX = GetRectMinX(bj_mapInitialPlayableArea)
            set MaxX = GetRectMaxX(bj_mapInitialPlayableArea)
            set MinY = GetRectMinY(bj_mapInitialPlayableArea)
            set MaxY = GetRectMaxY(bj_mapInitialPlayableArea)
            set BoundsReady = true
        endif

        return x <= MinX or x >= MaxX or y <= MinY or y >= MaxY
    endfunction

    // Is this spot somewhere the whirlpool must not take a unit? That is: off the map, on a different level of
    // ground than the whirlpool (up or down a cliff), or (for ground units) ground a unit can't stand on.
    private function IsBlocked takes real x, real y, integer lvl, boolean needWalkable returns boolean
        if IsOutOfBounds(x, y) then
            return true
        endif
        if GetTerrainCliffLevel(x, y) != lvl then
            return true
        endif
        if needWalkable and IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY) then
            return true
        endif
        return false
    endfunction

    // Anyone can be caught: heroes, allies, enemies, neutrals. Buildings can't be moved.
    private function CanCapture takes unit u returns boolean
        return GetWidgetLife(u) > 0.405 /*
            */ and not IsUnitType(u, UNIT_TYPE_DEAD) /*
            */ and not IsUnitType(u, UNIT_TYPE_STRUCTURE) /*
            */ and GetUnitAbilityLevel(u, 'Aloc') == 0 /*
            */ and not IsUnitHidden(u)
    endfunction

    //==================================================================
    // "Cannot move" without stopping a unit from attacking or casting. Its movement speed is set to zero while
    // it is held (and the whirlpool also overwrites its position every tick, so nothing it does can move it).
    // Stacking-safe: if two things hold the same unit, it stays still until both let go.
    private function Freeze takes unit u returns nothing
        local integer id = GetHandleId(u)
        local integer c = LoadInteger(HoldHash, id, 0)

        if c == 0 then
            call SaveReal(HoldHash, id, 1, GetUnitMoveSpeed(u))
            call SetUnitMoveSpeed(u, 0.)
        endif
        call SaveInteger(HoldHash, id, 0, c + 1)
    endfunction

    private function Thaw takes unit u returns nothing
        local integer id = GetHandleId(u)
        local integer c = LoadInteger(HoldHash, id, 0) - 1

        if c <= 0 then
            // gives back exactly the speed that was taken, on top of whatever speed it has now
            call SetUnitMoveSpeed(u, GetUnitMoveSpeed(u) + LoadReal(HoldHash, id, 1))
            call FlushChildHashtable(HoldHash, id)
        else
            call SaveInteger(HoldHash, id, 0, c)
        endif
    endfunction

    //==================================================================
    // One whirlpool.
    //
    //   0s        It appears at once, tiny, under heavy rain. From then on it grows GROWTH_PER_SECOND every
    //             second, for (BASE_GROW_SECONDS + one per Water element the hero had) seconds.
    //             Everyone ON ITS OWN LEVEL OF GROUND inside it can't move, and spirals in toward the centre at
    //             PULL_SPEED while swirling around it. Attacking and casting still work. Units are never pulled
    //             up or down a cliff: the whirlpool, and everything it does, stays on one level of ground.
    //   centre    A unit that arrives is flung out in a random direction, a random 1000-2000 distance, at 2000
    //             speed. It stops short of any cliff. It is only hurt (if it's an enemy) if it slams into a
    //             cliff or the edge of the map, and only at that moment. It can be caught again.
    //   15s       The rain stops, and the whirlpool shrinks away over the next 5 seconds.
    //   20s       Gone.
    //==================================================================
    private struct WhirlpoolInstance
        unit hero
        player owner
        integer level
        real cx
        real cy
        integer cliffLvl      // the level of ground the whirlpool sits on: nothing it touches ever leaves it
        real t
        real radius
        real peak             // the biggest it will get
        real growSecs         // how many seconds it grows for
        boolean over
        boolean rainOn
        weathereffect rain
        rect rainRect

        group caughtG
        group flyG
        integer cn
        unit array cu[64]     // units being dragged in
        real array cpx[64]    // where the whirlpool last put each of them: its position is overwritten from this every tick
        real array cpy[64]
        boolean array cw[64]  // true if this is a ground unit standing on walkable ground (it must never be dragged onto unwalkable ground)
        integer fn
        unit array fu[64]     // units that have been flung and are still flying
        real array fx[64]
        real array fy[64]
        real array fdx[64]
        real array fdy[64]
        real array frem[64]
        boolean array fw[64]
        effect array fxe[64]

        effect array orb[56]

        //--------------------------------------------------------
        static method create takes unit hero, real x, real y, integer lvl returns thistype
            local thistype this = thistype.allocate()
            local integer total = WHIRL_ARMS * WHIRL_PER_ARM
            local integer water = GetUnitElementCount(hero, Element_Water)
            local real grown
            local real half
            local integer i = 0

            set .hero    = hero
            set .owner   = GetOwningPlayer(hero)
            set .level   = lvl
            set .cx      = x
            set .cy      = y
            set .cliffLvl = GetTerrainCliffLevel(x, y)
            set .t       = 0.
            set .over    = false
            set .cn      = 0
            set .fn      = 0
            set .caughtG = CreateGroup()
            set .flyG    = CreateGroup()

            // how long it grows, and so how big it gets
            set .growSecs = BASE_GROW_SECONDS + GROW_SECONDS_PER_WATER * I2R(water)
            set grown = .growSecs
            if grown > WHIRLPOOL_TIME then
                set grown = WHIRLPOOL_TIME
            endif
            set .peak = START_RADIUS + GROWTH_PER_SECOND * grown
            if MAX_RADIUS > 0. and .peak > MAX_RADIUS then
                set .peak = MAX_RADIUS
            endif
            set .radius = START_RADIUS

            // heavy rain over the area, big enough to cover the whole whirlpool
            set half = RAIN_RADIUS
            if .peak + 300. > half then
                set half = .peak + 300.
            endif
            set .rainRect = Rect(x - half, y - half, x + half, y + half)
            set .rain = AddWeatherEffect(.rainRect, RAIN_WEATHER_ID)
            call EnableWeatherEffect(.rain, true)
            set .rainOn = true

            // the water orbs (hidden until positioned)
            loop
                exitwhen i >= total
                set .orb[i] = AddSpecialEffect(ORB_MODEL, x, y)
                call BlzSetSpecialEffectColor(.orb[i], WATER_RED, WATER_GREEN, WATER_BLUE)
                call BlzSetSpecialEffectScale(.orb[i], 0.001)
                set i = i + 1
            endloop

            set Active[Count] = this
            set Count = Count + 1
            if Count == 1 then
                call TimerStart(Tick, INTERVAL, true, function thistype.tickAll)
            endif
            return this
        endmethod

        //--------------------------------------------------------
        // Spiral arms of water that always reach the current radius, and fade away as the radius shrinks to nothing.
        // Any water that would fall on a different level of ground (up a cliff, or down one) is simply not shown,
        // so the arms stop at the cliffs instead of climbing them.
        method drawVisuals takes nothing returns nothing
            local integer total = WHIRL_ARMS * WHIRL_PER_ARM
            local integer k = 0
            local integer arm
            local integer j
            local real frac
            local real rr
            local real ang
            local real x
            local real y
            local real sc
            local real fade = .radius / START_RADIUS

            if fade > 1. then
                set fade = 1.
            endif

            loop
                exitwhen k >= total

                set arm = k / WHIRL_PER_ARM
                set j = k - arm * WHIRL_PER_ARM
                set frac = I2R(j + 1) / I2R(WHIRL_PER_ARM)
                set rr = .radius * frac

                // arms curl inward and spin faster near the centre
                set ang = 2. * bj_PI * I2R(arm) / I2R(WHIRL_ARMS) + SPIN * .t * (1.6 - frac) - frac * TWIST
                set x = .cx + rr * Cos(ang)
                set y = .cy + rr * Sin(ang)

                if IsBlocked(x, y, .cliffLvl, false) then
                    // this bit of water would be on a cliff or off the map: hide it
                    call BlzSetSpecialEffectScale(.orb[k], 0.001)
                else
                    // the orbs get bigger as the whirlpool does, so it never looks sparse
                    set sc = ((40. + .radius * 0.08 * (0.5 + frac)) / MODEL_NATIVE_WIDTH) * fade
                    if sc < 0.001 then
                        set sc = 0.001
                    endif

                    call BlzSetSpecialEffectScale(.orb[k], sc)
                    call BlzSetSpecialEffectPosition(.orb[k], x, y, GroundZ(x, y) + 30. + 15. * Sin(.t * 3. + I2R(k)))
                endif

                set k = k + 1
            endloop
        endmethod

        //--------------------------------------------------------
        // Lets go of a unit that is being dragged (swap-removes it from the list)
        method releaseCaught takes integer i returns nothing
            local unit u = .cu[i]

            call Thaw(u)
            call GroupRemoveUnit(.caughtG, u)

            set .cn = .cn - 1
            set .cu[i]  = .cu[.cn]
            set .cpx[i] = .cpx[.cn]
            set .cpy[i] = .cpy[.cn]
            set .cw[i]  = .cw[.cn]
            set .cu[.cn] = null
            set u = null
        endmethod

        //--------------------------------------------------------
        // The whirlpool is gone: everyone still being dragged is let go, and the water vanishes
        method finish takes nothing returns nothing
            local integer total = WHIRL_ARMS * WHIRL_PER_ARM
            local integer i = .cn - 1
            local integer k = 0

            loop
                exitwhen i < 0
                call .releaseCaught(i)
                set i = i - 1
            endloop

            loop
                exitwhen k >= total
                if .orb[k] != null then
                    call BlzSetSpecialEffectScale(.orb[k], 0.001)
                    call DestroyEffect(.orb[k])
                    set .orb[k] = null
                endif
                set k = k + 1
            endloop

            set .over = true
        endmethod

        //--------------------------------------------------------
        // A unit has reached the centre: it is flung out in a random direction. (No damage yet: that only
        // happens if it slams into a wall.)
        method launch takes unit u, integer i returns nothing
            local real a = GetRandomReal(0., 2. * bj_PI)
            local real dist = GetRandomReal(EJECT_MIN, EJECT_MAX)
            local boolean walk = .cw[i]
            local integer f

            // out of the list of units being dragged
            call GroupRemoveUnit(.caughtG, u)
            set .cn = .cn - 1
            set .cu[i]  = .cu[.cn]
            set .cpx[i] = .cpx[.cn]
            set .cpy[i] = .cpy[.cn]
            set .cw[i]  = .cw[.cn]
            set .cu[.cn] = null

            // it starts from the exact centre
            call SetUnitX(u, .cx)
            call SetUnitY(u, .cy)
            call DestroyEffect(AddSpecialEffect(SPLASH_MODEL, .cx, .cy))

            // no room to track another flight: it's simply let go
            if .fn >= 64 then
                call Thaw(u)
                return
            endif

            set f = .fn
            set .fn = .fn + 1
            set .fu[f]   = u
            set .fx[f]   = .cx
            set .fy[f]   = .cy
            set .fdx[f]  = Cos(a)
            set .fdy[f]  = Sin(a)
            set .frem[f] = dist
            set .fw[f]   = walk

            // a bubble of water around it for the flight
            set .fxe[f] = AddSpecialEffectTarget(ORB_MODEL, u, "chest")
            call BlzSetSpecialEffectColor(.fxe[f], WATER_RED, WATER_GREEN, WATER_BLUE)
            call BlzSetSpecialEffectScale(.fxe[f], BUBBLE_DIAMETER / MODEL_NATIVE_WIDTH)

            call GroupAddUnit(.flyG, u)
        endmethod

        //--------------------------------------------------------
        // A flung unit lands (swap-removes it from the list of flights). It can be caught again.
        method land takes integer i returns nothing
            local unit u = .fu[i]
            local integer last = .fn - 1

            call DestroyEffect(AddSpecialEffect(SPLASH_MODEL, GetUnitX(u), GetUnitY(u)))
            if .fxe[i] != null then
                call BlzSetSpecialEffectScale(.fxe[i], 0.001)
                call DestroyEffect(.fxe[i])
            endif
            call GroupRemoveUnit(.flyG, u)
            call Thaw(u)

            set .fu[i]   = .fu[last]
            set .fx[i]   = .fx[last]
            set .fy[i]   = .fy[last]
            set .fdx[i]  = .fdx[last]
            set .fdy[i]  = .fdy[last]
            set .frem[i] = .frem[last]
            set .fw[i]   = .fw[last]
            set .fxe[i]  = .fxe[last]
            set .fu[last]  = null
            set .fxe[last] = null
            set .fn = last
            set u = null
        endmethod

        //--------------------------------------------------------
        // A flung unit slams into a cliff or the edge of the map: it stops, and an enemy takes the damage
        method hitWall takes integer i returns nothing
            local unit u = .fu[i]
            local real x = GetUnitX(u)
            local real y = GetUnitY(u)

            call .land(i)       // let go first, so the damage happens with everything tidy
            call DestroyEffect(AddSpecialEffect(WALL_MODEL, x, y))

            if IsUnitEnemy(u, .owner) and GetWidgetLife(u) > 0.405 then
                set udg_NextDamageAbilitySource = WHIRLPOOL_ABILITY_ID
                call Damage.applyMagic(.hero, u, DMG_PER_LEVEL * I2R(.level), false, DAMAGE_TYPE_MAGIC)
            endif

            set u = null
        endmethod

        //--------------------------------------------------------
        // Moves every flung unit along its line. It lands at the end of its flight (no damage), or
        // stops WALL_MARGIN short of the first cliff or map edge (damage, if it's an enemy).
        // Each tick's movement is walked in small pieces, each one looking ahead, so a unit can't skip over a thin wall.
        method stepFlights takes nothing returns nothing
            local integer i = .fn - 1
            local integer k
            local integer pieces
            local real stp
            local real sub
            local real nx
            local real ny
            local boolean hit
            local unit u

            loop
                exitwhen i < 0
                set u = .fu[i]

                if GetUnitTypeId(u) == 0 or GetWidgetLife(u) < 0.405 then
                    call .land(i)
                else
                    set stp = EJECT_SPEED * INTERVAL
                    if stp > .frem[i] then
                        set stp = .frem[i]
                    endif
                    set pieces = R2I(stp / FLIGHT_SUBSTEP) + 1
                    set sub = stp / I2R(pieces)
                    set hit = false
                    set k = 0

                    loop
                        exitwhen k >= pieces or hit
                        set nx = .fx[i] + .fdx[i] * sub
                        set ny = .fy[i] + .fdy[i] * sub

                        // look WALL_MARGIN ahead of where it's about to be
                        if IsBlocked(nx + .fdx[i] * WALL_MARGIN, ny + .fdy[i] * WALL_MARGIN, .cliffLvl, .fw[i]) then
                            set hit = true
                        else
                            set .fx[i] = nx
                            set .fy[i] = ny
                            set .frem[i] = .frem[i] - sub
                        endif
                        set k = k + 1
                    endloop

                    call SetUnitX(u, .fx[i])
                    call SetUnitY(u, .fy[i])

                    if hit then
                        call .hitWall(i)
                    elseif .frem[i] <= 0.01 then
                        call .land(i)           // the flight ran its course without hitting anything
                    endif
                endif

                set i = i - 1
            endloop

            set u = null
        endmethod

        //--------------------------------------------------------
        // Can caught unit i step to (nx, ny)? Not if that would take it onto another level of ground (up or down a cliff),
        // or off walkable ground, or right up against such a place (it stops DRAG_MARGIN short).
        method canStep takes integer i, real nx, real ny returns boolean
            local real mx = nx - .cpx[i]
            local real my = ny - .cpy[i]
            local real len = SquareRoot(mx * mx + my * my)

            if len > 0.001 then
                return not IsBlocked(nx + mx / len * DRAG_MARGIN, ny + my / len * DRAG_MARGIN, .cliffLvl, .cw[i])
            endif
            return not IsBlocked(nx, ny, .cliffLvl, .cw[i])
        endmethod

        //--------------------------------------------------------
        // returns true when the whole thing is finished
        method step takes nothing returns boolean
            local real g
            local real dx
            local real dy
            local real ax
            local real ay
            local real nx
            local real ny
            local real ux
            local real uy
            local real d
            local real stp
            local real th
            local integer i
            local unit u

            set .t = .t + INTERVAL

            if not .over then

                // ---------- the rain stops once the whirlpool's full time is up ----------
                if .rainOn and .t >= WHIRLPOOL_TIME then
                    call EnableWeatherEffect(.rain, false)      // fades out
                    set .rainOn = false
                endif

                // ---------- its size: grows, holds, then shrinks away ----------
                if .t <= WHIRLPOOL_TIME then
                    set g = .t
                    if g > .growSecs then
                        set g = .growSecs
                    endif
                    set .radius = START_RADIUS + GROWTH_PER_SECOND * g
                    if MAX_RADIUS > 0. and .radius > MAX_RADIUS then
                        set .radius = MAX_RADIUS
                    endif
                else
                    set .radius = .peak * (1. - (.t - WHIRLPOOL_TIME) / SHRINK_TIME)
                endif

                if .t >= WHIRLPOOL_TIME + SHRINK_TIME or .radius <= 0. then
                    call .finish()
                else
                    // ---------- anyone newly inside is caught ----------
                    // Only units standing on the whirlpool's own level of ground count, so nobody is ever pulled up or down a cliff.
                    // (A unit that is being flung can't be re-caught until it lands.)
                    call GroupEnumUnitsInRange(Grp, .cx, .cy, .radius + 50., null)
                    loop
                        set u = FirstOfGroup(Grp)
                        exitwhen u == null
                        call GroupRemoveUnit(Grp, u)

                        if .cn < 64 and not IsUnitInGroup(u, .caughtG) and not IsUnitInGroup(u, .flyG) and CanCapture(u) then
                            set ux = GetUnitX(u)
                            set uy = GetUnitY(u)
                            set dx = ux - .cx
                            set dy = uy - .cy
                            if SquareRoot(dx * dx + dy * dy) <= .radius and GetTerrainCliffLevel(ux, uy) == .cliffLvl then
                                call GroupAddUnit(.caughtG, u)
                                set .cu[.cn]  = u
                                set .cpx[.cn] = ux
                                set .cpy[.cn] = uy
                                // a ground unit on walkable ground must stay on walkable ground (never be pulled into deep water or a wall)
                                set .cw[.cn]  = not IsUnitType(u, UNIT_TYPE_FLYING) and not IsTerrainPathable(ux, uy, PATHING_TYPE_WALKABILITY)
                                set .cn = .cn + 1
                                call Freeze(u)
                            endif
                        endif
                    endloop

                    // ---------- everyone caught spirals toward the centre ----------
                    // The position comes from where the whirlpool last put the unit, NOT from where the unit is now,
                    // so whatever the unit tries to do on its own is simply overwritten every tick. It has no say in where it goes.
                    // If the spiral's next step would go onto a cliff, it tries straight inward; if that is blocked too,
                    // the unit is simply held where it is until the whirlpool lets go.
                    set stp = PULL_SPEED * INTERVAL
                    set i = .cn - 1
                    loop
                        exitwhen i < 0
                        set u = .cu[i]

                        if GetUnitTypeId(u) == 0 or GetWidgetLife(u) < 0.405 then
                            call .releaseCaught(i)
                        else
                            // moved a long way off by something else (a blink, a knockback): it's free
                            set ax = GetUnitX(u) - .cpx[i]
                            set ay = GetUnitY(u) - .cpy[i]

                            set dx = .cpx[i] - .cx
                            set dy = .cpy[i] - .cy
                            set d = SquareRoot(dx * dx + dy * dy)

                            if ax * ax + ay * ay > BREAKAWAY_DIST * BREAKAWAY_DIST then
                                call .releaseCaught(i)
                            elseif d > .radius + 20. then
                                call .releaseCaught(i)          // the shrinking whirlpool has let it go
                            elseif d <= stp + CENTER_RADIUS then
                                call .launch(u, i)
                            else
                                // one step inward, and one step around the centre
                                set th = Atan2(dy, dx) + SPIRAL_SPEED * INTERVAL
                                set nx = .cx + (d - stp) * Cos(th)
                                set ny = .cy + (d - stp) * Sin(th)

                                if not .canStep(i, nx, ny) then
                                    // straight inward instead
                                    set nx = .cpx[i] - dx / d * stp
                                    set ny = .cpy[i] - dy / d * stp
                                    if not .canStep(i, nx, ny) then
                                        set nx = .cpx[i]
                                        set ny = .cpy[i]
                                    endif
                                endif

                                set .cpx[i] = nx
                                set .cpy[i] = ny
                                call SetUnitX(u, nx)
                                call SetUnitY(u, ny)
                            endif
                        endif

                        set i = i - 1
                    endloop

                    call .drawVisuals()
                endif
            endif

            // units that were flung keep flying even after the whirlpool has gone
            call .stepFlights()

            set u = null
            return .over and .fn == 0
        endmethod

        //--------------------------------------------------------
        method onDestroy takes nothing returns nothing
            local integer total = WHIRL_ARMS * WHIRL_PER_ARM
            local integer i = .cn - 1
            local integer k = 0

            // never leave anyone held still
            loop
                exitwhen i < 0
                call .releaseCaught(i)
                set i = i - 1
            endloop
            loop
                exitwhen .fn <= 0
                call .land(.fn - 1)
            endloop

            loop
                exitwhen k >= total
                if .orb[k] != null then
                    call BlzSetSpecialEffectScale(.orb[k], 0.001)
                    call DestroyEffect(.orb[k])
                    set .orb[k] = null
                endif
                set k = k + 1
            endloop

            call RemoveWeatherEffect(.rain)
            call RemoveRect(.rainRect)
            set .rain = null
            set .rainRect = null

            call DestroyGroup(.caughtG)
            call DestroyGroup(.flyG)
            set .caughtG = null
            set .flyG = null
            set .hero = null
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
    // Public entry point, called from your ability dispatcher. (x, y) is the centre of the whirlpool.
    function CastWhirlpool takes unit hero, real x, real y, integer lvl returns nothing
        if hero == null then
            return
        endif
        call WhirlpoolInstance.create(hero, x, y, lvl)
    endfunction

endlibrary