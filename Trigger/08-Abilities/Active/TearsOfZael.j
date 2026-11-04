library TearsOfZael

    globals
        // ===================== CONFIG =====================
        // Models (all built in to Warcraft III, nothing to import)
        private constant string GATE_MODEL    = "Abilities\\Weapons\\FarseerMissile\\FarseerMissile.mdl"
        private constant string MISSILE_MODEL = "Abilities\\Weapons\\FarseerMissile\\FarseerMissile.mdl"

        // Size (built-in models have different native sizes, so tune these by eye)
        private constant real BLAST_SCALE = 1.0     // projectile size
        private constant real GATE_SCALE  = 3.0     // gates are the same model, bigger, so they read as portals

        // Gate colour (red, green, blue, 0-255)
        private constant integer GATE_RED   = 150
        private constant integer GATE_GREEN = 80
        private constant integer GATE_BLUE  = 255

        // Colour
        private constant boolean RANDOM_COLORS = true   // every missile gets its own random colour (and its impact burst matches)

        // Damage
        private constant real    DMG_PER_LEVEL     = 400.    // damage per projectile = this x ability level
        private constant real    IMPACT_RADIUS     = 250.    // everything within this range of where a projectile lands is damaged
        private constant boolean DAMAGE_STRUCTURES = false
        // Units caught by several projectiles take damage from each one.

        // Targeting: any enemy within this radius around the hero's CURRENT position when each projectile fires
        private constant real    TARGET_RADIUS       = 600.
        private constant boolean TARGET_STRUCTURES   = false
        private constant boolean FIRE_WITHOUT_TARGET = true   // no enemy in range: fire at a random spot around the hero instead

        // Barrage timeline (seconds)
        private constant integer PROJECTILES   = 10      // max 16
        private constant real    BUILDUP_TIME  = 5.      // total length of the prelude
        private constant real    FIRE_WINDOW   = 1.      // every projectile fires at a random moment in the LAST this-many seconds of the buildup
        private constant real    GATE_INTERVAL = 0.5     // one prelude gate appears every this many seconds
        private constant integer GATE_COUNT    = 10      // = BUILDUP_TIME / GATE_INTERVAL (max 16)

        // Spawn area: a plane behind the hero's position AT THE MOMENT OF THE CAST
        private constant real BEHIND_DIST     = 600.    // the plane is this far behind the cast position
        private constant real GATE_WIDTH      = 1000.   // gates are scattered randomly along this width (centered behind the hero)
        private constant real START_HEIGHT    = 120.    // gate height above the ground
        private constant real HEIGHT_VARIANCE = 60.     // gate height is randomised by up to this much
        private constant real TARGET_HEIGHT   = 60.     // height the projectile aims at above the ground

        // Gate timing
        private constant real GATE_BIRTH           = 0.70   // a gate can start firing projectiles this long after it appears
        private constant real GATE_HOLD_AFTER_FIRE = 0.35   // gates close this long after the buildup ends

        // Flight
        private constant real SPEED          = 1800.
        private constant real SPEED_VARIANCE = 0.25     // each projectile's speed is randomised by up to +/- 25%
        private constant real MAX_FLIGHT     = 6.       // safety: a projectile explodes after this many seconds

        // Impact visual (leave "" for none)
        private constant string IMPACT_MODEL = "Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl"
        private constant real   IMPACT_SCALE = 1.5

        private constant real PERIOD = 0.03125
        // ====================================================

        private integer array MActive
        private integer       MCount = 0
        private timer         MTick  = CreateTimer()

        private integer array BActive
        private integer       BCount = 0
        private timer         BTick  = CreateTimer()

        private group         Grp   = CreateGroup()
        private unit array    Cand
        private location      ZLoc  = Location(0., 0.)
    endglobals

    //==================================================================
    private function GroundZ takes real x, real y returns real
        call MoveLocation(ZLoc, x, y)
        return GetLocationZ(ZLoc)
    endfunction

    // Picks one random living enemy within TARGET_RADIUS of the hero, or null
    private function PickTarget takes unit hero, player owner returns unit
        local unit u
        local unit result = null
        local integer n = 0
        local integer i

        call GroupEnumUnitsInRange(Grp, GetUnitX(hero), GetUnitY(hero), TARGET_RADIUS, null)
        loop
            set u = FirstOfGroup(Grp)
            exitwhen u == null
            call GroupRemoveUnit(Grp, u)

            if n < 256 and u != hero and GetWidgetLife(u) > 0.405 /*
                */ and IsUnitEnemy(u, owner) /*
                */ and not IsUnitType(u, UNIT_TYPE_DEAD) /*
                */ and GetUnitAbilityLevel(u, 'Aloc') == 0 /*
                */ and (TARGET_STRUCTURES or not IsUnitType(u, UNIT_TYPE_STRUCTURE)) then
                set Cand[n] = u
                set n = n + 1
            endif
        endloop

        if n > 0 then
            set result = Cand[GetRandomInt(0, n - 1)]
        endif

        set i = 0
        loop
            exitwhen i >= n
            set Cand[i] = null
            set i = i + 1
        endloop

        set u = null
        return result
    endfunction

    //==================================================================
    // One flying projectile. It homes in on its target and explodes on arrival.
    private struct Missile
        unit    caster
        player  owner
        integer level
        unit    target
        real    x
        real    y
        real    z
        real    tx
        real    ty
        real    tz
        real    speed
        real    age
        integer red
        integer green
        integer blue
        effect  fx

        //--------------------------------------------------------
        static method create takes unit caster, integer level, real x, real y, real z, unit target, real px, real py returns thistype
            local thistype this = thistype.allocate()
            local integer mid = GetRandomInt(0, 255)
            local integer k   = GetRandomInt(0, 5)

            set .caster = caster
            set .owner  = GetOwningPlayer(caster)
            set .level  = level
            set .target = target
            set .x      = x
            set .y      = y
            set .z      = z
            set .age    = 0.
            set .speed  = SPEED * (1. + GetRandomReal(-SPEED_VARIANCE, SPEED_VARIANCE))

            // random vivid colour: one channel full, one off, one random, in a random order
            set .red   = 255
            set .green = 255
            set .blue  = 255
            if RANDOM_COLORS then
                if k == 0 then
                    set .red = 255
                    set .green = mid
                    set .blue = 0
                elseif k == 1 then
                    set .red = 255
                    set .green = 0
                    set .blue = mid
                elseif k == 2 then
                    set .red = mid
                    set .green = 255
                    set .blue = 0
                elseif k == 3 then
                    set .red = 0
                    set .green = 255
                    set .blue = mid
                elseif k == 4 then
                    set .red = mid
                    set .green = 0
                    set .blue = 255
                else
                    set .red = 0
                    set .green = mid
                    set .blue = 255
                endif
            endif

            if target != null then
                set .tx = GetUnitX(target)
                set .ty = GetUnitY(target)
            else
                set .tx = px
                set .ty = py
            endif
            set .tz = GroundZ(.tx, .ty) + TARGET_HEIGHT

            set .fx = AddSpecialEffect(MISSILE_MODEL, x, y)
            call BlzSetSpecialEffectScale(.fx, BLAST_SCALE)
            call BlzSetSpecialEffectPosition(.fx, x, y, z)
            if RANDOM_COLORS then
                call BlzSetSpecialEffectColor(.fx, .red, .green, .blue)
            endif
            call .aim()

            set MActive[MCount] = this
            set MCount = MCount + 1
            if MCount == 1 then
                call TimerStart(MTick, PERIOD, true, function thistype.tickAll)
            endif
            return this
        endmethod

        //--------------------------------------------------------
        method aim takes nothing returns nothing
            local real dx = .tx - .x
            local real dy = .ty - .y
            local real dz = .tz - .z
            local real h  = SquareRoot(dx * dx + dy * dy)

            if h >= 1. then
                call BlzSetSpecialEffectOrientation(.fx, Atan2(dy, dx), -Atan2(dz, h), 0.)
            endif
        endmethod

        //--------------------------------------------------------
        // damages every enemy within IMPACT_RADIUS of (ix, iy)
        method impact takes real ix, real iy returns nothing
            local unit u
            local effect e

            if IMPACT_MODEL != "" then
                set e = AddSpecialEffect(IMPACT_MODEL, ix, iy)
                call BlzSetSpecialEffectScale(e, IMPACT_SCALE)
                if RANDOM_COLORS then
                    call BlzSetSpecialEffectColor(e, .red, .green, .blue)
                endif
                call DestroyEffect(e)
                set e = null
            endif

            call GroupEnumUnitsInRange(Grp, ix, iy, IMPACT_RADIUS, null)
            loop
                set u = FirstOfGroup(Grp)
                exitwhen u == null
                call GroupRemoveUnit(Grp, u)

                if GetWidgetLife(u) > 0.405 /*
                    */ and IsUnitEnemy(u, .owner) /*
                    */ and not IsUnitType(u, UNIT_TYPE_DEAD) /*
                    */ and GetUnitAbilityLevel(u, 'Aloc') == 0 /*
                    */ and (DAMAGE_STRUCTURES or not IsUnitType(u, UNIT_TYPE_STRUCTURE)) then
                    call UnitDamageTarget(.caster, u, DMG_PER_LEVEL * I2R(.level), false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                endif
            endloop
            set u = null
        endmethod

        //--------------------------------------------------------
        // returns true when the projectile has landed
        method step takes nothing returns boolean
            local real dx
            local real dy
            local real dz
            local real d
            local real stp = .speed * PERIOD

            set .age = .age + PERIOD

            // follow the target; if it died or vanished, keep flying to its last position
            if .target != null then
                if GetUnitTypeId(.target) == 0 or GetWidgetLife(.target) <= 0.405 then
                    set .target = null
                else
                    set .tx = GetUnitX(.target)
                    set .ty = GetUnitY(.target)
                    set .tz = GroundZ(.tx, .ty) + TARGET_HEIGHT
                endif
            endif

            set dx = .tx - .x
            set dy = .ty - .y
            set dz = .tz - .z
            set d  = SquareRoot(dx * dx + dy * dy + dz * dz)

            if d <= stp then
                call .impact(.tx, .ty)
                return true
            endif
            if .age >= MAX_FLIGHT then
                call .impact(.x, .y)
                return true
            endif

            set .x = .x + dx / d * stp
            set .y = .y + dy / d * stp
            set .z = .z + dz / d * stp
            call BlzSetSpecialEffectPosition(.fx, .x, .y, .z)
            call .aim()
            return false
        endmethod

        //--------------------------------------------------------
        method onDestroy takes nothing returns nothing
            if .fx != null then
                call DestroyEffect(.fx)
                set .fx = null
            endif
            set .caster = null
            set .target = null
        endmethod

        //--------------------------------------------------------
        static method tickAll takes nothing returns nothing
            local integer i = MCount - 1
            local thistype this

            loop
                exitwhen i < 0
                set this = MActive[i]
                if this.step() then
                    call this.destroy()
                    set MCount = MCount - 1
                    set MActive[i] = MActive[MCount]
                endif
                set i = i - 1
            endloop

            if MCount == 0 then
                call PauseTimer(MTick)
            endif
        endmethod
    endstruct

    //==================================================================
    // One cast: runs the 5 second prelude (gates behind the cast position) and launches the projectiles
    private struct Barrage
        unit    caster
        integer level
        real    t
        integer spawned
        integer firedN

        // where the hero stood and which way it faced when the ability was cast
        real    ax
        real    ay
        real    yaw

        effect  array gate[16]
        real    array gx[16]
        real    array gy[16]
        real    array gz[16]
        real    array gBorn[16]

        real    array fireAt[16]
        boolean array fired[16]

        //--------------------------------------------------------
        static method create takes unit caster, integer level returns thistype
            local thistype this = thistype.allocate()
            local integer i = 0

            set .caster  = caster
            set .level   = level
            set .t       = 0.
            set .spawned = 0
            set .firedN  = 0
            set .ax      = GetUnitX(caster)
            set .ay      = GetUnitY(caster)
            set .yaw     = GetUnitFacing(caster) * bj_DEGTORAD

            loop
                exitwhen i >= 16
                set .gate[i]   = null
                set .fired[i]  = false
                set .fireAt[i] = BUILDUP_TIME - FIRE_WINDOW + GetRandomReal(0., FIRE_WINDOW)
                set i = i + 1
            endloop

            set BActive[BCount] = this
            set BCount = BCount + 1
            if BCount == 1 then
                call TimerStart(BTick, PERIOD, true, function thistype.tickAll)
            endif
            return this
        endmethod

        //--------------------------------------------------------
        // opens one prelude gate on the plane BEHIND_DIST behind the cast position,
        // at a random point along its GATE_WIDTH
        method spawnGate takes nothing returns nothing
            local integer i = .spawned
            local real side = GetRandomReal(-GATE_WIDTH * 0.5, GATE_WIDTH * 0.5)
            local real px   = .ax - BEHIND_DIST * Cos(.yaw) - side * Sin(.yaw)
            local real py   = .ay - BEHIND_DIST * Sin(.yaw) + side * Cos(.yaw)

            set .gx[i]    = px
            set .gy[i]    = py
            set .gz[i]    = GroundZ(px, py) + START_HEIGHT + GetRandomReal(-HEIGHT_VARIANCE, HEIGHT_VARIANCE)
            set .gBorn[i] = .t

            set .gate[i] = AddSpecialEffect(GATE_MODEL, px, py)
            call BlzSetSpecialEffectScale(.gate[i], GATE_SCALE)
            call BlzSetSpecialEffectColor(.gate[i], GATE_RED, GATE_GREEN, GATE_BLUE)
            call BlzSetSpecialEffectPosition(.gate[i], px, py, .gz[i])
            call BlzSetSpecialEffectOrientation(.gate[i], .yaw, 0., 0.)

            set .spawned = i + 1
        endmethod

        //--------------------------------------------------------
        // launches projectile number m from a random gate that has finished opening,
        // at a random enemy within TARGET_RADIUS of the hero
        method fire takes integer m returns nothing
            local integer open = 0
            local integer pick
            local integer j = 0
            local real sx
            local real sy
            local real sz
            local real a
            local real d
            local real side
            local unit target

            loop
                exitwhen j >= .spawned
                if .t - .gBorn[j] >= GATE_BIRTH then
                    set open = open + 1
                endif
                set j = j + 1
            endloop

            if open > 0 then
                set pick = GetRandomInt(1, open)
                set j = 0
                loop
                    exitwhen j >= .spawned
                    if .t - .gBorn[j] >= GATE_BIRTH then
                        set pick = pick - 1
                        if pick == 0 then
                            set sx = .gx[j]
                            set sy = .gy[j]
                            set sz = .gz[j]
                        endif
                    endif
                    set j = j + 1
                endloop
            else
                // no gate is open yet (only with unusual settings): spawn on the same plane
                set side = GetRandomReal(-GATE_WIDTH * 0.5, GATE_WIDTH * 0.5)
                set sx = .ax - BEHIND_DIST * Cos(.yaw) - side * Sin(.yaw)
                set sy = .ay - BEHIND_DIST * Sin(.yaw) + side * Cos(.yaw)
                set sz = GroundZ(sx, sy) + START_HEIGHT
            endif

            set target = PickTarget(.caster, GetOwningPlayer(.caster))

            if target != null then
                call Missile.create(.caster, .level, sx, sy, sz, target, 0., 0.)
            elseif FIRE_WITHOUT_TARGET then
                set a = GetRandomReal(0., 2. * bj_PI)
                set d = GetRandomReal(TARGET_RADIUS * 0.2, TARGET_RADIUS)
                call Missile.create(.caster, .level, sx, sy, sz, null, GetUnitX(.caster) + d * Cos(a), GetUnitY(.caster) + d * Sin(a))
            endif

            set target = null
        endmethod

        //--------------------------------------------------------
        // returns true when the whole cast is over
        method step takes nothing returns boolean
            local integer i

            // caster removed or dead: the cast is cancelled
            if GetUnitTypeId(.caster) == 0 or IsUnitType(.caster, UNIT_TYPE_DEAD) then
                return true
            endif

            set .t = .t + PERIOD

            // one gate every GATE_INTERVAL seconds
            loop
                exitwhen .spawned >= GATE_COUNT or .t < I2R(.spawned) * GATE_INTERVAL
                call .spawnGate()
            endloop

            // projectiles fire at their random moment inside the last FIRE_WINDOW seconds
            set i = 0
            loop
                exitwhen i >= PROJECTILES
                if not .fired[i] and .t >= .fireAt[i] then
                    set .fired[i] = true
                    set .firedN = .firedN + 1
                    call .fire(i)
                endif
                set i = i + 1
            endloop

            return .firedN >= PROJECTILES and .t >= BUILDUP_TIME + GATE_HOLD_AFTER_FIRE
        endmethod

        //--------------------------------------------------------
        method onDestroy takes nothing returns nothing
            local integer i = 0

            loop
                exitwhen i >= 16
                if .gate[i] != null then
                    call DestroyEffect(.gate[i])
                    set .gate[i] = null
                endif
                set i = i + 1
            endloop
            set .caster = null
        endmethod

        //--------------------------------------------------------
        static method tickAll takes nothing returns nothing
            local integer i = BCount - 1
            local thistype this

            loop
                exitwhen i < 0
                set this = BActive[i]
                if this.step() then
                    call this.destroy()
                    set BCount = BCount - 1
                    set BActive[i] = BActive[BCount]
                endif
                set i = i - 1
            endloop

            if BCount == 0 then
                call PauseTimer(BTick)
            endif
        endmethod
    endstruct

    //==================================================================
    // x, y are kept so your dispatcher call doesn't change; gates are placed
    // from the hero's position and facing at the moment of the cast.
    function CastTearsOfZael takes unit hero, real x, real y, integer lvl returns nothing
        if hero == null then
            return
        endif
        if lvl < 1 then
            set lvl = 1
        endif
        call Barrage.create(hero, lvl)
    endfunction

endlibrary