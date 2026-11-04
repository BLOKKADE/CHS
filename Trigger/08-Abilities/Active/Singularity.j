library Singularity initializer Init

    globals
        // ===================== CONFIG =====================
        // Model path of your purple sphere. This replaces the dummy unit, so no rawcode is needed.
        // Put the same model you used on the dummy here (imported models work too).
        private constant string  SPHERE_MODEL        = "Abilities\\Weapons\\FaerieDragonMissile\\FaerieDragonMissile.mdl"

        private constant integer SPHERE_COUNT        = 12
        private constant real    RING_RADIUS         = 500.

        private constant real    SPAWN_STEP          = 25.
        private constant real    CLIFF_MARGIN        = 60.
        private constant real    MIN_SPAWN_DIST      = 60.

        private constant real    GROW_TIME           = 3.0
        private constant real    START_SCALE         = 1.0   // effect scale is relative to the model's native size
        private constant real    MAX_SCALE           = 5.0

        private constant real    MAX_SPEED           = 1000.
        private constant real    ACCELERATION        = 3000.
        private constant real    MAX_DISTANCE        = 5000.

        private constant real    TRIGGER_RADIUS      = 75.
        private constant real    EXPLODE_RADIUS      = 150.
        private constant real    DMG_PER_LVL         = 500.

        private constant real    FLY_HEIGHT          = 25.  // height above the terrain

        private constant integer TINT_R              = 170
        private constant integer TINT_G              = 60
        private constant integer TINT_B              = 255

        private constant string  SFX_EXPLODE         = "Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBoltImpact.mdl"
        private constant string  SFX_EXPLODE2        = "Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl"
        private constant real    SFX_EXPLODE_SCALE   = 2.0
        private constant string  SFX_DISSIPATE       = "Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBoltImpact.mdl"

        private constant real    INTERVAL            = 0.03125

        private constant boolean DEBUG_MODE = false
        // ====================================================

        private hashtable SphereHash = InitHashtable() // timer -> SphereInstance
        private location ZLoc = Location(0., 0.)       // reused to read terrain height
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

    private function GetZ takes real x, real y returns real
        call MoveLocation(ZLoc, x, y)
        return GetLocationZ(ZLoc)
    endfunction

    // A move is blocked if the destination is unwalkable and on a different cliff level.
    private function IsBlocked takes real fromX, real fromY, real toX, real toY returns boolean
        return IsTerrainPathable(toX, toY, PATHING_TYPE_WALKABILITY) and GetTerrainCliffLevel(toX, toY) != GetTerrainCliffLevel(fromX, fromY)
    endfunction

    private function GetSpawnDist takes real cx, real cy, real angle returns real
        local real d = SPAWN_STEP
        local real x
        local real y
        local real result = RING_RADIUS

        loop
            exitwhen d > RING_RADIUS
            set x = cx + d * Cos(angle)
            set y = cy + d * Sin(angle)
            if IsBlocked(cx, cy, x, y) then
                set result = d - CLIFF_MARGIN
                if result < MIN_SPAWN_DIST then
                    set result = MIN_SPAWN_DIST
                endif
                return result
            endif
            set d = d + SPAWN_STEP
        endloop

        return result
    endfunction

    //==================================================================
    // One sphere, drawn as a special effect. Phase 0 = growing, 1 = flying.
    //==================================================================
    private struct SphereInstance
        effect fx
        unit caster
        player ownerPlayer
        integer level
        real x
        real y
        real dirX
        real dirY
        real t
        real speed
        real traveled
        integer phase
        timer tmr

        method place takes nothing returns nothing
            call BlzSetSpecialEffectPosition(.fx, .x, .y, GetZ(.x, .y) + FLY_HEIGHT)
        endmethod

        static method create takes unit caster, real sx, real sy, real cx, real cy, integer lvl returns thistype
            local thistype this = thistype.allocate()
            local real angle = Atan2(cy - sy, cx - sx)

            set .caster      = caster
            set .ownerPlayer = GetOwningPlayer(caster)
            set .level       = lvl
            set .x           = sx
            set .y           = sy
            set .dirX        = Cos(angle)
            set .dirY        = Sin(angle)
            set .t           = 0.
            set .speed       = 0.
            set .traveled    = 0.
            set .phase       = 0

            set .fx = AddSpecialEffect(SPHERE_MODEL, sx, sy)
            call BlzSetSpecialEffectColor(.fx, TINT_R, TINT_G, TINT_B)
            call BlzSetSpecialEffectScale(.fx, START_SCALE)
            call .place()

            set .tmr = CreateTimer()
            call SaveInteger(SphereHash, GetHandleId(.tmr), 0, this)
            call TimerStart(.tmr, INTERVAL, true, function SphereInstance.onTickCallback)
            return this
        endmethod

        //--------------------------------------------------------
        method explode takes nothing returns nothing
            local group g = CreateGroup()
            local unit u
            local effect e
            local real dmg = DMG_PER_LVL * I2R(.level)

            set e = AddSpecialEffect(SFX_EXPLODE, .x, .y)
            call BlzSetSpecialEffectScale(e, SFX_EXPLODE_SCALE)
            call DestroyEffect(e)
            set e = AddSpecialEffect(SFX_EXPLODE2, .x, .y)
            call BlzSetSpecialEffectScale(e, SFX_EXPLODE_SCALE)
            call DestroyEffect(e)
            set e = null

            call GroupEnumUnitsInRange(g, .x, .y, EXPLODE_RADIUS, null)
            loop
                set u = FirstOfGroup(g)
                exitwhen u == null
                call GroupRemoveUnit(g, u)
                if IsValidEnemy(u, .ownerPlayer) then
                    call UnitDamageTarget(.caster, u, dmg, false, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                endif
            endloop
            call DestroyGroup(g)
            set g = null

            call .destroy()
        endmethod

        //--------------------------------------------------------
        method checkHit takes nothing returns boolean
            local group g = CreateGroup()
            local unit u
            local boolean found = false

            call GroupEnumUnitsInRange(g, .x, .y, TRIGGER_RADIUS, null)
            loop
                set u = FirstOfGroup(g)
                exitwhen u == null
                call GroupRemoveUnit(g, u)
                if IsValidEnemy(u, .ownerPlayer) then
                    set found = true
                endif
            endloop
            call DestroyGroup(g)
            set g = null
            return found
        endmethod

        //--------------------------------------------------------
        method onTick takes nothing returns nothing
            local real ratio
            local real scale
            local real step
            local real nx
            local real ny
            local boolean blockX
            local boolean blockY

            if .phase == 0 then
                set .t = .t + INTERVAL
                set ratio = .t / GROW_TIME
                if ratio > 1. then
                    set ratio = 1.
                endif
                set scale = START_SCALE + (MAX_SCALE - START_SCALE) * ratio
                call BlzSetSpecialEffectScale(.fx, scale)

                if ratio >= 1. then
                    set .phase = 1
                    call DebugMsg("Sphere launching")
                endif
                return
            endif

            // ---- Flying ----
            set .speed = .speed + ACCELERATION * INTERVAL
            if .speed > MAX_SPEED then
                set .speed = MAX_SPEED
            endif
            set step = .speed * INTERVAL
            set nx = .x + .dirX * step
            set ny = .y + .dirY * step

            if IsBlocked(.x, .y, nx, ny) then
                set blockX = IsBlocked(.x, .y, nx, .y)
                set blockY = IsBlocked(.x, .y, .x, ny)
                if blockX and (not blockY) then
                    set .dirX = -.dirX
                elseif blockY and (not blockX) then
                    set .dirY = -.dirY
                else
                    set .dirX = -.dirX
                    set .dirY = -.dirY
                endif
                set nx = .x
                set ny = .y
            else
                set .traveled = .traveled + step
            endif

            set .x = nx
            set .y = ny
            call .place()

            if .checkHit() then
                call .explode()
                return
            endif

            if .traveled >= MAX_DISTANCE then
                call DestroyEffect(AddSpecialEffect(SFX_DISSIPATE, .x, .y))
                call .destroy()
            endif
        endmethod

        //--------------------------------------------------------
        method onDestroy takes nothing returns nothing
            call FlushChildHashtable(SphereHash, GetHandleId(.tmr))
            call PauseTimer(.tmr)
            call DestroyTimer(.tmr)

            call DestroyEffect(.fx)
            set .fx     = null
            set .caster = null
        endmethod

        static method onTickCallback takes nothing returns nothing
            local timer tmr = GetExpiredTimer()
            local thistype this = LoadInteger(SphereHash, GetHandleId(tmr), 0)
            call this.onTick()
            set tmr = null
        endmethod
    endstruct

    //==================================================================
    function CastSingularity takes unit caster, real x, real y, integer lvl returns nothing
        local integer i = 0
        local real angle
        local real dist

        loop
            exitwhen i >= SPHERE_COUNT
            set angle = (2. * bj_PI) * I2R(i) / I2R(SPHERE_COUNT)
            set dist = GetSpawnDist(x, y, angle)
            call SphereInstance.create(caster, x + dist * Cos(angle), y + dist * Sin(angle), x, y, lvl)
            set i = i + 1
        endloop
    endfunction

    private function Init takes nothing returns nothing
    endfunction

endlibrary