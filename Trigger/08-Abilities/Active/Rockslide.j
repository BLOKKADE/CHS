library BoulderStampede initializer Init requires GetObjectElement

    globals
        // ===================== CONFIG =====================
        // 6 boulder dummy unit-types (different rock models).
        // One is picked at random for each boulder spawned.
        private constant integer BOULDER_DUMMY_ID_1     = 'ugho'
        private constant integer BOULDER_DUMMY_ID_2     = 'ugho'//'umtw'
        private constant integer BOULDER_DUMMY_ID_3     = 'ugho'//'ucry'
        private constant integer BOULDER_DUMMY_ID_4     = 'ugho'//'ugar'
        private constant integer BOULDER_DUMMY_ID_5     = 'ugho'//'unec'
        private constant integer BOULDER_DUMMY_ID_6     = 'uobs'

        // Visual scale applied to every boulder regardless of which model gets picked.
        // Tune this until the rendered size roughly matches BOULDER_AOE's hit radius.
        private constant real    BOULDER_SCALE          = 0.35
        private constant real    BOULDER_FLY_HEIGHT     = 0.     // 0 = rolls along the ground

        // Lane size: base values, plus a bonus per Earth element on the hero
        private constant real    BASE_LANE_LENGTH       = 800.   // total distance boulders travel
        private constant real    BASE_LANE_WIDTH        = 800.   // total perpendicular spread
        private constant real    LANE_PER_EARTH         = 100.   // +100 length and +100 width per Earth element
                                                                   // boulders spawn half the lane length BEHIND the hero
                                                                   // and finish half the lane length in FRONT of him

        private constant real    WAVE_INTERVAL          = 0.01    // seconds between each line of boulders
        private constant integer BASE_BOULDERS_PER_WAVE = 1
        private constant integer EARTH_PER_EXTRA_BOULDER = 0     // +1 boulder per wave for every this many Earth elements
        private constant real    CAST_DURATION          = 1.0    // waves keep spawning for this long

        private constant real    BOULDER_SPEED          = 600.   // units/second
        private constant real    BOULDER_AOE            = 70.    // per-boulder hit radius
        private constant real    BOULDER_PUSH_DIST      = 400.   // total slide distance, along travel direction
        private constant real    BOULDER_STUN           = 1.0    // also doubles as the slide duration
        private constant real    BOULDER_DMG_PER_LVL    = 200.

        private constant real    INTERVAL               = 0.03125

        private constant boolean DEBUG_MODE = false
        // ====================================================

        private integer array BOULDER_DUMMY_IDS[6]

        private hashtable ControllerHash = InitHashtable() // timer -> BoulderController
        private hashtable BoulderHash    = InitHashtable() // timer -> BoulderInstance
        private hashtable ImpactHash     = InitHashtable() // timer -> BoulderImpactInstance
        private hashtable StunCountHash  = InitHashtable() // unit  -> active stun count (handles overlapping hits safely)
    endglobals

    //==================================================================
    private function DebugMsg takes string s returns nothing
        if DEBUG_MODE then
            call BJDebugMsg(s)
        endif
    endfunction

    private function IsValidEnemy takes unit u, player owner returns boolean
        return GetWidgetLife(u) > 0.405 and IsUnitEnemy(u, owner) and (not IsUnitType(u, UNIT_TYPE_DEAD)) and GetUnitAbilityLevel(u, 'Aloc') == 0
    endfunction

    private function GetRandomBoulderId takes nothing returns integer
        return BOULDER_DUMMY_IDS[GetRandomInt(0, 5)]
    endfunction

    //==================================================================
    // Handles a single hit's aftermath: the unit is stunned AND slides
    // along the ground (gradually, not an instant teleport) for the
    // same duration as the stun. Stacking-safe if hit by multiple
    // boulders - stays stunned until the LAST instance expires.
    //==================================================================
    private struct BoulderImpactInstance
        unit u
        real angle
        real speed      // units/second, computed so the full push distance completes exactly as the stun ends
        real t
        timer tmr

        static method create takes unit whichUnit, real angle, real pushDist, real duration returns thistype
            local thistype this = thistype.allocate()
            local integer uid = GetHandleId(whichUnit)
            local integer count = LoadInteger(StunCountHash, uid, 0)

            set .u     = whichUnit
            set .angle = angle
            set .speed = pushDist / duration
            set .t     = 0.
            set .tmr   = CreateTimer()

            if count == 0 then
                call PauseUnit(whichUnit, true)
                call UnitAddType(whichUnit, UNIT_TYPE_STUNNED)
            endif
            call SaveInteger(StunCountHash, uid, 0, count + 1)

            call SaveInteger(ImpactHash, GetHandleId(.tmr), 0, this)
            call TimerStart(.tmr, INTERVAL, true, function BoulderImpactInstance.onTickCallback)
            return this
        endmethod

        method onTick takes nothing returns nothing
            set .t = .t + INTERVAL

            if (GetWidgetLife(.u) > 0.405) and (.t <= BOULDER_STUN) then
                call SetUnitX(.u, GetUnitX(.u) + .speed * INTERVAL * Cos(.angle))
                call SetUnitY(.u, GetUnitY(.u) + .speed * INTERVAL * Sin(.angle))
            endif

            if .t >= BOULDER_STUN then
                call .onFinish()
            endif
        endmethod

        method onFinish takes nothing returns nothing
            local integer uid = GetHandleId(.u)
            local integer count = LoadInteger(StunCountHash, uid, 0) - 1

            if count <= 0 then
                set count = 0
                call RemoveSavedInteger(StunCountHash, uid, 0)
                if GetWidgetLife(.u) > 0.405 then
                    call UnitRemoveType(.u, UNIT_TYPE_STUNNED)
                    call PauseUnit(.u, false)
                endif
            else
                call SaveInteger(StunCountHash, uid, 0, count)
            endif

            call FlushChildHashtable(ImpactHash, GetHandleId(.tmr))
            call PauseTimer(.tmr)
            call DestroyTimer(.tmr)
            set .u = null
            call .destroy()
        endmethod

        static method onTickCallback takes nothing returns nothing
            local timer tmr = GetExpiredTimer()
            local thistype this = LoadInteger(ImpactHash, GetHandleId(tmr), 0)
            call this.onTick()
            set tmr = null
        endmethod
    endstruct

    //==================================================================
    // A single boulder: travels in a straight line along the cast
    // direction along the ground, spawns as a randomly-chosen rock
    // model, scaled down to a consistent visual size, in a random fixed
    // orientation (no spinning), hits anything within BOULDER_AOE once,
    // and despawns after covering its full lane length. Terrain and
    // cliffs have no effect on it at all.
    //==================================================================
    private struct BoulderInstance
        unit dummy
        unit caster
        player ownerPlayer
        integer level
        real x
        real y
        real angle        // travel direction (fixed for this boulder's whole flight)
        real traveled
        real laneLength   // how far this boulder may travel (scales with Earth elements)
        group hitUnits
        timer tmr

        static method create takes unit caster, real spawnX, real spawnY, real angle, integer lvl, real laneLength returns thistype
            local thistype this = thistype.allocate()
            local real randomFacing = GetRandomReal(0., 360.)
            local integer modelId = GetRandomBoulderId()

            set .caster      = caster
            set .ownerPlayer = GetOwningPlayer(caster)
            set .level       = lvl
            set .x           = spawnX
            set .y           = spawnY
            set .angle       = angle
            set .traveled    = 0.
            set .laneLength  = laneLength
            set .hitUnits    = CreateGroup()

            // Random model + random fixed orientation (no spin) each time
            set .dummy = CreateUnit(.ownerPlayer, modelId, spawnX, spawnY, randomFacing)
            call UnitAddAbility(.dummy, 'Aloc')          // no collision with other units, so boulders never shove each other
            call SetUnitPropWindow(.dummy, 0.)           // can never turn: orientation stays exactly as spawned
            call SetUnitTurnSpeed(.dummy, 0.)
            call SetUnitScale(.dummy, BOULDER_SCALE, BOULDER_SCALE, BOULDER_SCALE)
            call SetUnitPathing(.dummy, false)

            // Amrf trick so ground units accept a fly height, then set it (0 = on the ground)
            call UnitAddAbility(.dummy, 'Amrf')
            call UnitRemoveAbility(.dummy, 'Amrf')
            call SetUnitFlyHeight(.dummy, BOULDER_FLY_HEIGHT, 0.)

            set .tmr = CreateTimer()
            call SaveInteger(BoulderHash, GetHandleId(.tmr), 0, this)
            call TimerStart(.tmr, INTERVAL, true, function BoulderInstance.onTickCallback)
            return this
        endmethod

        method onTick takes nothing returns nothing
            local unit u
            local group g
            local real dmg

            set .x = .x + BOULDER_SPEED * INTERVAL * Cos(.angle)
            set .y = .y + BOULDER_SPEED * INTERVAL * Sin(.angle)
            set .traveled = .traveled + BOULDER_SPEED * INTERVAL

            call SetUnitX(.dummy, .x)
            call SetUnitY(.dummy, .y)

            // ---- Check for hits ----
            set g = CreateGroup()
            call GroupEnumUnitsInRange(g, .x, .y, BOULDER_AOE, null)
            loop
                set u = FirstOfGroup(g)
                exitwhen u == null
                call GroupRemoveUnit(g, u)

                if IsValidEnemy(u, .ownerPlayer) and (not IsUnitInGroup(u, .hitUnits)) then
                    call GroupAddUnit(.hitUnits, u) // never hit the same unit twice with this boulder

                    // Damage (applied the instant the boulder connects)
                    set dmg = BOULDER_DMG_PER_LVL * I2R(.level)
                    call UnitDamageTarget(.caster, u, dmg, false, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)

                    // Stun + gradual slide along the ground
                    call BoulderImpactInstance.create(u, .angle, BOULDER_PUSH_DIST, BOULDER_STUN)
                endif
            endloop
            call DestroyGroup(g)
            set g = null

            // ---- Despawn after covering the full lane length ----
            if .traveled >= .laneLength then
                call .destroy()
            endif
        endmethod

        method onDestroy takes nothing returns nothing
            call FlushChildHashtable(BoulderHash, GetHandleId(.tmr))
            call PauseTimer(.tmr)
            call DestroyTimer(.tmr)
            call DestroyGroup(.hitUnits)

            call KillUnit(.dummy)
            call RemoveUnit(.dummy)
            set .dummy  = null
            set .caster = null
        endmethod

        static method onTickCallback takes nothing returns nothing
            local timer tmr = GetExpiredTimer()
            local thistype this = LoadInteger(BoulderHash, GetHandleId(tmr), 0)
            call this.onTick()
            set tmr = null
        endmethod
    endstruct

    //==================================================================
    // Controller: spawns a wave of boulders every WAVE_INTERVAL seconds,
    // for CAST_DURATION seconds total. The lane direction is taken from
    // the HERO'S FACING at cast time - no point-target needed. Boulders
    // spawn half the lane length BEHIND the hero's cast-time position and
    // travel the full lane length forward, ending half the lane length in
    // FRONT of him.
    //
    // Lane length, lane width and boulders per wave are worked out once,
    // at cast time, from the hero's Earth elements.
    //==================================================================
    private struct BoulderController
        unit caster
        integer level
        real originX
        real originY
        real angle
        real age
        real waveTimer
        real laneLength
        real laneWidth
        integer perWave
        timer tmr

        static method create takes unit caster, integer lvl returns thistype
            local thistype this = thistype.allocate()
            local integer earth = GetUnitElementCount(caster, Element_Earth)

            set .caster    = caster
            set .level     = lvl
            set .originX   = GetUnitX(caster)
            set .originY   = GetUnitY(caster)
            set .angle     = GetUnitFacing(caster) * bj_DEGTORAD // direction hero is facing at cast time
            set .age       = 0.
            set .waveTimer = 0. // forces an immediate first wave

            // Earth element scaling
            set .laneLength = BASE_LANE_LENGTH + LANE_PER_EARTH * I2R(earth)
            set .laneWidth  = BASE_LANE_WIDTH  + LANE_PER_EARTH * I2R(earth)
            set .perWave    = BASE_BOULDERS_PER_WAVE + earth / EARTH_PER_EXTRA_BOULDER

            set .tmr = CreateTimer()
            call SaveInteger(ControllerHash, GetHandleId(.tmr), 0, this)
            call TimerStart(.tmr, INTERVAL, true, function BoulderController.onTickCallback)
            return this
        endmethod

        method SpawnWave takes nothing returns nothing
            local real perpAngle = .angle + bj_PI * 0.5
            local real backX = .originX - (.laneLength * 0.5) * Cos(.angle)
            local real backY = .originY - (.laneLength * 0.5) * Sin(.angle)
            local integer i = 0
            local real offset
            local real spawnX
            local real spawnY

            loop
                exitwhen i >= .perWave
                set offset = GetRandomReal(-.laneWidth * 0.5, .laneWidth * 0.5)
                set spawnX = backX + offset * Cos(perpAngle)
                set spawnY = backY + offset * Sin(perpAngle)

                call BoulderInstance.create(.caster, spawnX, spawnY, .angle, .level, .laneLength)
                set i = i + 1
            endloop

            call DebugMsg("Spawned boulder wave at age=" + R2S(.age))
        endmethod

        method onTick takes nothing returns nothing
            set .age       = .age + INTERVAL
            set .waveTimer = .waveTimer + INTERVAL

            if .waveTimer >= WAVE_INTERVAL then
                set .waveTimer = .waveTimer - WAVE_INTERVAL
                call .SpawnWave()
            endif

            if .age >= CAST_DURATION then
                call .destroy()
            endif
        endmethod

        method onDestroy takes nothing returns nothing
            call FlushChildHashtable(ControllerHash, GetHandleId(.tmr))
            call PauseTimer(.tmr)
            call DestroyTimer(.tmr)
            set .caster = null
        endmethod

        static method onTickCallback takes nothing returns nothing
            local timer tmr = GetExpiredTimer()
            local thistype this = LoadInteger(ControllerHash, GetHandleId(tmr), 0)
            call this.onTick()
            set tmr = null
        endmethod
    endstruct

    //==================================================================
    // Public entry point — no target point needed anymore. Fires in
    // whatever direction the hero is currently facing.
    //==================================================================
    function CastRockslide takes unit hero, integer lvl returns nothing
        call BoulderController.create(hero, lvl)
    endfunction

    private function Init takes nothing returns nothing
        set BOULDER_DUMMY_IDS[0] = BOULDER_DUMMY_ID_1
        set BOULDER_DUMMY_IDS[1] = BOULDER_DUMMY_ID_2
        set BOULDER_DUMMY_IDS[2] = BOULDER_DUMMY_ID_3
        set BOULDER_DUMMY_IDS[3] = BOULDER_DUMMY_ID_4
        set BOULDER_DUMMY_IDS[4] = BOULDER_DUMMY_ID_5
        set BOULDER_DUMMY_IDS[5] = BOULDER_DUMMY_ID_6
    endfunction

endlibrary