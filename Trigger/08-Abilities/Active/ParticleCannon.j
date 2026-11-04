library ChargedBeam

    globals
        // ===================== CONFIG =====================
        // Timeline (seconds since the cast)
        private constant real    ARCS_START_TIME    = 0.5     // the 8 spheres start firing arcs at the hero
        private constant real    CHARGE_END_TIME    = 4.0     // charging stops: the 8 spheres have shrunk to nothing, all sound cuts out
        private constant real    FIRE_DELAY         = 1.5     // silence/tension gap between charging stopping and the beam firing
                                                                 // (so the beam fires at CHARGE_END_TIME + FIRE_DELAY = 5.5s)
        private constant real    BEAM_DURATION      = 5.0

        // Beam
        private constant real    BEAM_RANGE         = 10000.
        private constant real    BEAM_SPEED         = 7000.   // how fast the beam's tip travels out from the hero
        private constant real    BEAM_WIDTH         = 150.
        private constant real    BEAM_HEIGHT        = 90.     // beam height above the ground
        private constant real    BEAM_SPACING       = 100.    // distance between the glowing orbs that make up the beam
                                                                 // (keep BEAM_RANGE / BEAM_SPACING + 2 at or under 108)
        private constant real    BEAM_FADE_TIME     = 0.25    // the beam fades out over its last moments
        private constant real    RAY_STEP           = 48.     // how finely the beam looks for cliffs along its path

        // Mana and damage
        private constant real    MANA_PERCENT       = 0.15    // drained every DAMAGE_INTERVAL
        private constant boolean PERCENT_OF_MAX_MANA = true   // true = 15% of MAX mana, false = 15% of CURRENT mana
        private constant real    DMG_FACTOR_PER_LEVEL = 0.2   // damage = mana spent x (level x this)
        private constant real    DAMAGE_INTERVAL    = 1.0
        private constant boolean END_WHEN_OUT_OF_MANA = true  // the beam ends early if the hero has no mana left to spend

        // The spheres
        private constant integer SPHERE_COUNT       = 8       // (the arrays below are sized for 8)
        private constant real    SPHERE_RING_RADIUS = 300.
        private constant real    SPHERE_SPIN        = 0.6     // radians per second the ring slowly turns. 0 = still
        private constant real    SPHERE_HEIGHT      = 110.
        private constant real    OUTER_DIAMETER     = 180.    // size of each of the 8 spheres when they appear
        private constant real    OUTER_APPEAR_TIME  = 0.25
        private constant real    CENTER_DIAMETER_START = 30.  // the sphere on the hero starts here...
        private constant real    CENTER_DIAMETER_MAX   = 300. // ...grows to this by CHARGE_END_TIME, then shrinks away as the beam fires

        // The arcs from the spheres to the hero. The bolts are rebuilt this often so they can never die off
        // while charging (they stay on screen for the entire charge-up).
        private constant real    ARC_REFRESH_TIME   = 0.15

        // Look. Everything shares one blue so the spheres, arcs and beam all match.
        private constant string  SPHERE_MODEL       = "Abilities\\Weapons\\WaterElementalMissile\\WaterElementalMissile.mdl"
        private constant real    MODEL_NATIVE_WIDTH = 50.     // rough width of that model at scale 1. Tune this if sizes look off
        private constant string  ARC_LIGHTNING      = "CLPB"  // electric arcs from the spheres to the hero (and the beam's core)
        private constant integer BLUE_RED           = 100
        private constant integer BLUE_GREEN         = 170
        private constant integer BLUE_BLUE          = 255
        private constant real    BLUE_RED_F         = 0.40    // the same blue, as 0-1 values for lightning
        private constant real    BLUE_GREEN_F       = 0.67
        private constant real    BLUE_BLUE_F        = 1.00

        // ---------- Sound ----------
        // IMPORTANT: I can't verify which stock sound files your game has, so these paths are best guesses.
        // If you hear nothing, replace them with sounds you've imported (e.g. "war3mapImported\\ChargeLoop.wav").
        // What each should be:
        //   CHARGE_SOUND  - a LOOPING low hum / rumble. The crescendo is built by raising its volume and pitch.
        //   BEAM_SOUND    - a LOOPING roaring, energy-pouring sound
        //   CRACKLE_SOUND - a short one-shot snap / crackle / sizzle (played at random spots along the beam)
        private constant boolean SOUNDS_ENABLED     = true
        private constant string  CHARGE_SOUND       = "Abilities\\Spells\\Human\\ManaShield\\ManaShieldLoop.wav"
        private constant string  BEAM_SOUND         = "Abilities\\Spells\\Orc\\LightningShield\\LightningShieldLoop.wav"
        private constant string  CRACKLE_SOUND      = "Abilities\\Spells\\Orc\\LightningBolt\\LightningBolt.wav"
        private constant real    CHARGE_VOLUME_MIN  = 20.     // 0-127. Quiet at the start of the charge...
        private constant real    CHARGE_VOLUME_MAX  = 127.    // ...swelling to full by the moment charging stops
        private constant real    CHARGE_PITCH_MIN   = 0.6     // pitch also rises through the charge
        private constant real    CHARGE_PITCH_MAX   = 1.6
        private constant real    BEAM_VOLUME        = 127.
        private constant real    BEAM_SOUND_FADE_IN = 0.4     // seconds for the beam's sound to swell in when it fires
        private constant real    CRACKLE_VOLUME     = 110.
        private constant real    CRACKLE_MIN_GAP    = 0.12    // a new crackle every random time between these (seconds)
        private constant real    CRACKLE_MAX_GAP    = 0.35
        private constant real    SOUND_MIN_DIST     = 1000.   // full volume within this distance of the hero
        private constant real    SOUND_MAX_DIST     = 6000.   // fading out toward this
        private constant real    SOUND_CUTOFF_DIST  = 8000.   // silent beyond this

        // ---------- Map lighting ----------
        // Warcraft has no direct "ambient light" control, so the map is dimmed by pushing the time of day toward
        // dusk while the beam fires. It affects EVERY player and is restored (smoothly) afterwards. Units' and effects'
        // own brightness is unaffected, so the beam stays vivid against a darker world.
        // Tune DIM_TIME_OF_DAY to taste: for a map at midday, a higher value (up to about 18.5) is darker.
        private constant boolean DIM_ENABLED        = true
        private constant real    DIM_TIME_OF_DAY    = 18.3
        private constant real    LIGHT_FADE_IN      = 0.4     // seconds to dim down once the beam fires
        private constant real    LIGHT_FADE_OUT     = 0.8     // seconds to return to normal after it ends
        private constant real    NORMAL_TIME_OF_DAY_SCALE = 1. // the day/night speed to restore (set 0 if your map keeps time frozen)

        private constant real    INTERVAL           = 0.03125
        // ====================================================

        private integer array Active
        private integer       Count = 0
        private timer         Tick  = CreateTimer()
        private group         Grp   = CreateGroup()
        private location     ZLoc  = Location(0., 0.)

        // map lighting state (shared by every active cast)
        private integer       LightUsers   = 0
        private timer         LightTick    = CreateTimer()
        private real          LightLevel   = 0.      // 0 = normal, 1 = fully dimmed
        private real          LightBase    = 12.     // time of day before dimming
        private real          LightDim     = 12.     // time of day at full dimming
        private boolean       LightRunning = false

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

    private function IsValidTarget takes unit u, unit caster, player owner returns boolean
        return u != caster /*
            */ and GetWidgetLife(u) > 0.405 /*
            */ and IsUnitEnemy(u, owner) /*
            */ and not IsUnitType(u, UNIT_TYPE_DEAD) /*
            */ and not IsUnitType(u, UNIT_TYPE_STRUCTURE) /*
            */ and GetUnitAbilityLevel(u, 'Aloc') == 0
    endfunction

    // How far a beam from (ox, oy) in direction ang can reach (up to maxDist) before it meets a cliff
    // (any change of cliff level from the one the hero stands on) or the edge of the map.
    private function BeamLimit takes real ox, real oy, real ang, real maxDist returns real
        local real c = Cos(ang)
        local real s = Sin(ang)
        local integer lvl = GetTerrainCliffLevel(ox, oy)
        local real prev = 0.
        local real d
        local real lo
        local real hi
        local real mid
        local integer i

        loop
            exitwhen prev >= maxDist

            set d = prev + RAY_STEP
            if d > maxDist then
                set d = maxDist
            endif

            if IsOutOfBounds(ox + d * c, oy + d * s) or GetTerrainCliffLevel(ox + d * c, oy + d * s) != lvl then
                // somewhere between prev and d: narrow it down
                set lo = prev
                set hi = d
                set i = 0
                loop
                    exitwhen i >= 5
                    set mid = (lo + hi) * 0.5
                    if IsOutOfBounds(ox + mid * c, oy + mid * s) or GetTerrainCliffLevel(ox + mid * c, oy + mid * s) != lvl then
                        set hi = mid
                    else
                        set lo = mid
                    endif
                    set i = i + 1
                endloop
                return lo
            endif

            set prev = d
        endloop

        return maxDist
    endfunction

    //==================================================================
    // Sound helper: a positional sound, not yet started
    private function NewSound takes string path, boolean looping returns sound
        local sound s = CreateSound(path, looping, true, false, 10, 10, "DefaultEAXON")
        call SetSoundDistances(s, SOUND_MIN_DIST, SOUND_MAX_DIST)
        call SetSoundDistanceCutoff(s, SOUND_CUTOFF_DIST)
        return s
    endfunction

    //==================================================================
    // Map lighting. Shared and reference-counted, so overlapping casts never fight over it.
    private function LightStep takes nothing returns nothing
        if LightUsers > 0 then
            set LightLevel = LightLevel + INTERVAL / LIGHT_FADE_IN
            if LightLevel > 1. then
                set LightLevel = 1.
            endif
        else
            set LightLevel = LightLevel - INTERVAL / LIGHT_FADE_OUT
            if LightLevel <= 0. then
                // fully back to normal: put the clock back exactly as it was and let it run again
                set LightLevel = 0.
                call SetFloatGameState(GAME_STATE_TIME_OF_DAY, LightBase)
                call SetTimeOfDayScale(NORMAL_TIME_OF_DAY_SCALE)
                call PauseTimer(LightTick)
                set LightRunning = false
                return
            endif
        endif

        call SetFloatGameState(GAME_STATE_TIME_OF_DAY, LightBase + (LightDim - LightBase) * LightLevel)
    endfunction

    private function LightAcquire takes nothing returns nothing
        if not DIM_ENABLED then
            return
        endif

        set LightUsers = LightUsers + 1

        if not LightRunning then
            set LightBase = GetFloatGameState(GAME_STATE_TIME_OF_DAY)

            // only dim if it's daytime and brighter than the dimmed setting; at night leave it alone
            if LightBase >= 6. and LightBase < DIM_TIME_OF_DAY then
                set LightDim = DIM_TIME_OF_DAY
            else
                set LightDim = LightBase
            endif

            call SetTimeOfDayScale(0.)      // hold the clock still while dimmed
            set LightRunning = true
            call TimerStart(LightTick, INTERVAL, true, function LightStep)
        endif
    endfunction

    private function LightRelease takes nothing returns nothing
        if not DIM_ENABLED then
            return
        endif

        if LightUsers > 0 then
            set LightUsers = LightUsers - 1
        endif
    endfunction

    //==================================================================
    // The whole spell.
    //
    //   0.0s  8 large blue spheres appear in a ring around the hero; a small
    //         sphere appears on the hero and starts growing. A rising hum begins.
    //   0.5s  each ring sphere fires an electric arc at the hero's sphere,
    //         and keeps firing it for the entire charge. The ring spheres shrink
    //         while the hero's sphere grows, and the hum builds to a crescendo.
    //   4.0s  charging stops: the ring spheres are gone and ALL sound cuts out.
    //   5.5s  (1.5s of silence later) the beam fires from the hero toward (and past)
    //         the anchor point, growing out at BEAM_SPEED up to BEAM_RANGE, or
    //         stopping at a cliff. Its roaring, crackling sound swells in and the
    //         map dims.
    //   +5s   it lasts BEAM_DURATION. The hero can move around; the beam always
    //         runs from him toward the anchor point. Every second it burns a
    //         share of his mana and damages every enemy it passes through.
    //==================================================================
    private struct ChargedBeamInstance
        unit caster
        player owner
        integer level
        real ax              // the anchor point
        real ay
        real angle           // current beam direction (hero toward anchor)
        real t
        real len             // current beam length
        real dmgTimer

        boolean outerAlive
        boolean arcsMade
        boolean dimActive
        real arcRefresh
        real coreRefresh

        effect center
        effect array outer[8]
        lightning array arc[8]
        lightning core
        effect array beam[110]
        integer beamMade

        sound chargeSnd
        sound beamSnd
        real crackleTimer
        real crackleNext

        //--------------------------------------------------------
        static method create takes unit caster, real tx, real ty, integer lvl returns thistype
            local thistype this = thistype.allocate()
            local real x = GetUnitX(caster)
            local real y = GetUnitY(caster)
            local integer i = 0

            set .caster  = caster
            set .owner   = GetOwningPlayer(caster)
            set .level   = lvl
            set .ax      = tx
            set .ay      = ty
            if tx == x and ty == y then
                set .angle = GetUnitFacing(caster) * bj_DEGTORAD
            else
                set .angle = Atan2(ty - y, tx - x)
            endif
            set .t         = 0.
            set .len       = 0.
            set .dmgTimer  = 0.
            set .outerAlive = true
            set .arcsMade  = false
            set .dimActive = false
            set .arcRefresh  = 0.
            set .coreRefresh = 0.
            set .core      = null
            set .beamMade  = 0
            set .chargeSnd = null
            set .beamSnd   = null
            set .crackleTimer = 0.
            set .crackleNext  = GetRandomReal(CRACKLE_MIN_GAP, CRACKLE_MAX_GAP)

            // the sphere on the hero
            set .center = AddSpecialEffect(SPHERE_MODEL, x, y)
            call BlzSetSpecialEffectColor(.center, BLUE_RED, BLUE_GREEN, BLUE_BLUE)
            call BlzSetSpecialEffectScale(.center, 0.001)

            // the ring of 8
            loop
                exitwhen i >= SPHERE_COUNT
                set .outer[i] = AddSpecialEffect(SPHERE_MODEL, x, y)
                call BlzSetSpecialEffectColor(.outer[i], BLUE_RED, BLUE_GREEN, BLUE_BLUE)
                call BlzSetSpecialEffectScale(.outer[i], 0.001)
                set .arc[i] = null
                set i = i + 1
            endloop

            // the charging hum begins (volume and pitch are raised every tick for the crescendo)
            if SOUNDS_ENABLED and CHARGE_SOUND != "" then
                set .chargeSnd = NewSound(CHARGE_SOUND, true)
                call SetSoundPosition(.chargeSnd, x, y, GroundZ(x, y) + SPHERE_HEIGHT)
                call SetSoundVolume(.chargeSnd, R2I(CHARGE_VOLUME_MIN))
                call SetSoundPitch(.chargeSnd, CHARGE_PITCH_MIN)
                call StartSound(.chargeSnd)
            endif

            set Active[Count] = this
            set Count = Count + 1
            if Count == 1 then
                call TimerStart(Tick, INTERVAL, true, function thistype.tickAll)
            endif
            return this
        endmethod

        //--------------------------------------------------------
        // (Re)builds the 8 arcs from scratch, replacing any that exist
        method buildArcs takes real hx, real hy, real cz returns nothing
            local integer i = 0

            loop
                exitwhen i >= SPHERE_COUNT
                if .arc[i] != null then
                    call DestroyLightning(.arc[i])
                endif
                set .arc[i] = AddLightningEx(ARC_LIGHTNING, false, hx, hy, cz, hx, hy, cz)
                call SetLightningColor(.arc[i], BLUE_RED_F, BLUE_GREEN_F, BLUE_BLUE_F, 1.)
                set i = i + 1
            endloop
        endmethod

        //--------------------------------------------------------
        // Removes the ring spheres and their arcs
        method clearOuter takes nothing returns nothing
            local integer i = 0

            loop
                exitwhen i >= SPHERE_COUNT
                if .outer[i] != null then
                    call BlzSetSpecialEffectScale(.outer[i], 0.001)
                    call DestroyEffect(.outer[i])
                    set .outer[i] = null
                endif
                if .arc[i] != null then
                    call DestroyLightning(.arc[i])
                    set .arc[i] = null
                endif
                set i = i + 1
            endloop

            set .outerAlive = false
        endmethod

        //--------------------------------------------------------
        // One damage pulse: spends mana and hurts every enemy currently inside the beam.
        // Returns false if the hero had nothing left to spend.
        method strike takes real hx, real hy returns boolean
            local real mana = GetUnitState(.caster, UNIT_STATE_MANA)
            local real spend
            local real dmg
            local real c = Cos(.angle)
            local real s = Sin(.angle)
            local real mx
            local real my
            local real dx
            local real dy
            local real uu
            local real vv
            local unit u

            if PERCENT_OF_MAX_MANA then
                set spend = GetUnitState(.caster, UNIT_STATE_MAX_MANA) * MANA_PERCENT
            else
                set spend = mana * MANA_PERCENT
            endif
            if spend > mana then
                set spend = mana
            endif
            if spend <= 0. then
                return false
            endif

            call SetUnitState(.caster, UNIT_STATE_MANA, mana - spend)
            set dmg = spend * (I2R(.level) * DMG_FACTOR_PER_LEVEL)

            // everything within a circle that covers the beam, then test each unit against the real beam shape
            set mx = hx + .len * 0.5 * c
            set my = hy + .len * 0.5 * s
            call GroupEnumUnitsInRange(Grp, mx, my, .len * 0.5 + BEAM_WIDTH, null)
            loop
                set u = FirstOfGroup(Grp)
                exitwhen u == null
                call GroupRemoveUnit(Grp, u)

                if IsValidTarget(u, .caster, .owner) then
                    set dx = GetUnitX(u) - hx
                    set dy = GetUnitY(u) - hy
                    set uu = dx * c + dy * s
                    set vv = -dx * s + dy * c

                    if uu >= 0. and uu <= .len and vv <= BEAM_WIDTH * 0.5 and vv >= -BEAM_WIDTH * 0.5 then
                        call UnitDamageTarget(.caster, u, dmg, false, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                    endif
                endif
            endloop
            set u = null

            return true
        endmethod

        //--------------------------------------------------------
        // returns true when the spell is finished
        method step takes nothing returns boolean
            local real hx = GetUnitX(.caster)
            local real hy = GetUnitY(.caster)
            local real fireTime = CHARGE_END_TIME + FIRE_DELAY
            local real dx
            local real dy
            local real cz
            local real sc
            local real p
            local real bt = 0.
            local real px
            local real py
            local real pz
            local real a
            local real d
            local real c
            local real s
            local real want
            local real beamFade = 1.
            local real vol
            local sound snd
            local integer i
            local integer n
            local boolean finished = false

            if GetWidgetLife(.caster) < 0.405 or IsUnitType(.caster, UNIT_TYPE_DEAD) then
                return true
            endif

            set .t = .t + INTERVAL

            // the beam always runs from the hero toward the anchor, so moving the hero re-aims it
            set dx = .ax - hx
            set dy = .ay - hy
            if dx * dx + dy * dy > 1. then
                set .angle = Atan2(dy, dx)
            endif
            set c = Cos(.angle)
            set s = Sin(.angle)
            set cz = GroundZ(hx, hy) + SPHERE_HEIGHT

            // ---------- the sphere on the hero ----------
            if .t < CHARGE_END_TIME then
                set p = .t / CHARGE_END_TIME
                set sc = (CENTER_DIAMETER_START + (CENTER_DIAMETER_MAX - CENTER_DIAMETER_START) * p) / MODEL_NATIVE_WIDTH
            elseif .t < fireTime then
                set sc = (CENTER_DIAMETER_MAX / MODEL_NATIVE_WIDTH) * (1. + 0.08 * Sin(.t * 20.))    // trembling, fully charged
            else
                set p = (.t - fireTime) / BEAM_DURATION
                if p > 1. then
                    set p = 1.
                endif
                set sc = (CENTER_DIAMETER_MAX / MODEL_NATIVE_WIDTH) * (1. - p)
            endif
            if sc < 0.001 then
                set sc = 0.001
            endif
            call BlzSetSpecialEffectScale(.center, sc)
            call BlzSetSpecialEffectPosition(.center, hx, hy, cz)

            // ---------- the charging hum: a crescendo, then dead silence the instant charging stops ----------
            if .chargeSnd != null then
                if .t >= CHARGE_END_TIME then
                    call StopSound(.chargeSnd, true, false)     // cut off immediately, no fade
                    set .chargeSnd = null
                else
                    set p = .t / CHARGE_END_TIME
                    set vol = CHARGE_VOLUME_MIN + (CHARGE_VOLUME_MAX - CHARGE_VOLUME_MIN) * p * p
                    call SetSoundVolume(.chargeSnd, R2I(vol))
                    call SetSoundPitch(.chargeSnd, CHARGE_PITCH_MIN + (CHARGE_PITCH_MAX - CHARGE_PITCH_MIN) * p)
                    call SetSoundPosition(.chargeSnd, hx, hy, cz)
                endif
            endif

            // ---------- the ring of 8 spheres and their arcs ----------
            if .outerAlive then
                if .t >= CHARGE_END_TIME then
                    call .clearOuter()
                else
                    // arcs: made at 0.5s, then rebuilt every ARC_REFRESH_TIME so they last the whole charge
                    if .t >= ARCS_START_TIME then
                        if not .arcsMade then
                            set .arcsMade = true
                            set .arcRefresh = 0.
                            call .buildArcs(hx, hy, cz)
                        else
                            set .arcRefresh = .arcRefresh + INTERVAL
                            if .arcRefresh >= ARC_REFRESH_TIME then
                                set .arcRefresh = 0.
                                call .buildArcs(hx, hy, cz)
                            endif
                        endif
                    endif

                    if .t < ARCS_START_TIME then
                        set sc = (OUTER_DIAMETER / MODEL_NATIVE_WIDTH) * (.t / OUTER_APPEAR_TIME)
                        if sc > OUTER_DIAMETER / MODEL_NATIVE_WIDTH then
                            set sc = OUTER_DIAMETER / MODEL_NATIVE_WIDTH
                        endif
                    else
                        set sc = (OUTER_DIAMETER / MODEL_NATIVE_WIDTH) * (1. - (.t - ARCS_START_TIME) / (CHARGE_END_TIME - ARCS_START_TIME))
                    endif
                    if sc < 0.001 then
                        set sc = 0.001
                    endif

                    set i = 0
                    loop
                        exitwhen i >= SPHERE_COUNT
                        set a = 2. * bj_PI * I2R(i) / I2R(SPHERE_COUNT) + SPHERE_SPIN * .t
                        set px = hx + SPHERE_RING_RADIUS * Cos(a)
                        set py = hy + SPHERE_RING_RADIUS * Sin(a)
                        set pz = GroundZ(px, py) + SPHERE_HEIGHT

                        call BlzSetSpecialEffectScale(.outer[i], sc)
                        call BlzSetSpecialEffectPosition(.outer[i], px, py, pz)

                        if .arc[i] != null then
                            call MoveLightningEx(.arc[i], false, px, py, pz, hx + GetRandomReal(-15., 15.), hy + GetRandomReal(-15., 15.), cz + GetRandomReal(-15., 15.))
                        endif
                        set i = i + 1
                    endloop
                endif
            endif

            // ---------- the beam ----------
            if .t >= fireTime then
                set bt = .t - fireTime

                // the map dims for as long as the beam is firing
                if not .dimActive then
                    set .dimActive = true
                    call LightAcquire()
                endif

                // the tip travels outward at BEAM_SPEED, but never past a cliff or the max range.
                // (Re-checked every tick, so turning the beam into a wall shortens it at once.)
                set want = .len + BEAM_SPEED * INTERVAL
                if want > BEAM_RANGE then
                    set want = BEAM_RANGE
                endif
                set .len = BeamLimit(hx, hy, .angle, want)

                // a thin bright bolt down the middle (rebuilt periodically, like the arcs, so it can't die off)
                set .coreRefresh = .coreRefresh + INTERVAL
                if .core != null and .coreRefresh >= ARC_REFRESH_TIME then
                    call DestroyLightning(.core)
                    set .core = null
                endif
                if .core == null then
                    set .coreRefresh = 0.
                    set .core = AddLightningEx(ARC_LIGHTNING, false, hx, hy, cz, hx, hy, cz)
                    call SetLightningColor(.core, BLUE_RED_F, BLUE_GREEN_F, BLUE_BLUE_F, 1.)
                endif
                set px = hx + .len * c
                set py = hy + .len * s
                call MoveLightningEx(.core, false, hx, hy, cz, px, py, GroundZ(px, py) + BEAM_HEIGHT)

                // the body: a line of glowing orbs the width of the beam
                if BEAM_DURATION - bt < BEAM_FADE_TIME then
                    set beamFade = (BEAM_DURATION - bt) / BEAM_FADE_TIME
                    if beamFade < 0. then
                        set beamFade = 0.
                    endif
                endif

                if .len < 1. then
                    set n = 0
                else
                    set n = R2I(.len / BEAM_SPACING) + 2
                endif
                if n > 108 then
                    set n = 108
                endif

                loop
                    exitwhen .beamMade >= n
                    set .beam[.beamMade] = AddSpecialEffect(SPHERE_MODEL, hx, hy)
                    call BlzSetSpecialEffectColor(.beam[.beamMade], BLUE_RED, BLUE_GREEN, BLUE_BLUE)
                    set .beamMade = .beamMade + 1
                endloop

                set i = 0
                loop
                    exitwhen i >= .beamMade
                    if i < n then
                        set d = I2R(i) * BEAM_SPACING
                        if d > .len then
                            set d = .len
                        endif
                        set px = hx + d * c
                        set py = hy + d * s
                        set pz = GroundZ(px, py) + BEAM_HEIGHT
                        set sc = (BEAM_WIDTH / MODEL_NATIVE_WIDTH) * (0.9 + 0.2 * Sin(bt * 30. + I2R(i))) * beamFade
                        if sc < 0.001 then
                            set sc = 0.001
                        endif
                        call BlzSetSpecialEffectPosition(.beam[i], px, py, pz)
                        call BlzSetSpecialEffectScale(.beam[i], sc)
                    else
                        call BlzSetSpecialEffectScale(.beam[i], 0.001)
                    endif
                    set i = i + 1
                endloop

                // ---------- the sound of the beam pouring out its energy, with air snapping and crackling ----------
                if SOUNDS_ENABLED then
                    if .beamSnd == null and BEAM_SOUND != "" then
                        set .beamSnd = NewSound(BEAM_SOUND, true)
                        call SetSoundPosition(.beamSnd, hx, hy, cz)
                        call SetSoundVolume(.beamSnd, 0)
                        call StartSound(.beamSnd)
                    endif

                    if .beamSnd != null then
                        set p = bt / BEAM_SOUND_FADE_IN
                        if p > 1. then
                            set p = 1.
                        endif
                        call SetSoundVolume(.beamSnd, R2I(BEAM_VOLUME * p * beamFade))
                        call SetSoundPosition(.beamSnd, hx, hy, cz)
                    endif

                    if CRACKLE_SOUND != "" then
                        set .crackleTimer = .crackleTimer + INTERVAL
                        if .crackleTimer >= .crackleNext then
                            set .crackleTimer = 0.
                            set .crackleNext = GetRandomReal(CRACKLE_MIN_GAP, CRACKLE_MAX_GAP)

                            // a snap somewhere along the beam (kept near the hero so it's actually heard)
                            set d = GetRandomReal(0., .len)
                            if d > SOUND_MAX_DIST then
                                set d = GetRandomReal(0., SOUND_MAX_DIST)
                            endif
                            set px = hx + d * c
                            set py = hy + d * s

                            set snd = NewSound(CRACKLE_SOUND, false)
                            call SetSoundPosition(snd, px, py, GroundZ(px, py) + BEAM_HEIGHT)
                            call SetSoundVolume(snd, R2I(CRACKLE_VOLUME * beamFade))
                            call SetSoundPitch(snd, GetRandomReal(0.8, 1.3))
                            call StartSound(snd)
                            call KillSoundWhenDone(snd)
                            set snd = null
                        endif
                    endif
                endif

                // ---------- damage pulses ----------
                set .dmgTimer = .dmgTimer + INTERVAL
                if .dmgTimer >= DAMAGE_INTERVAL then
                    set .dmgTimer = .dmgTimer - DAMAGE_INTERVAL
                    if not .strike(hx, hy) and END_WHEN_OUT_OF_MANA then
                        set finished = true
                    endif
                endif

                if bt >= BEAM_DURATION then
                    set finished = true
                endif
            endif

            return finished
        endmethod

        //--------------------------------------------------------
        method onDestroy takes nothing returns nothing
            local integer i = 0

            call .clearOuter()

            if .center != null then
                call BlzSetSpecialEffectScale(.center, 0.001)
                call DestroyEffect(.center)
                set .center = null
            endif

            if .core != null then
                call DestroyLightning(.core)
                set .core = null
            endif

            loop
                exitwhen i >= .beamMade
                call BlzSetSpecialEffectScale(.beam[i], 0.001)
                call DestroyEffect(.beam[i])
                set .beam[i] = null
                set i = i + 1
            endloop

            // sounds: never leave anything playing
            if .chargeSnd != null then
                call StopSound(.chargeSnd, true, false)
                set .chargeSnd = null
            endif
            if .beamSnd != null then
                call StopSound(.beamSnd, true, true)
                set .beamSnd = null
            endif

            // the lights come back up
            if .dimActive then
                set .dimActive = false
                call LightRelease()
            endif

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
    // Public entry point, called from your ability dispatcher.
    // (x, y) is the anchor point the beam is aimed at.
    function CastChargedBeam takes unit hero, real x, real y, integer lvl returns nothing
        if hero == null then
            return
        endif
        call ChargedBeamInstance.create(hero, x, y, lvl)
    endfunction

endlibrary