library MarineDropIn initializer Init

    globals
        // ===================== CONFIG =====================

        private constant real    DROP_SPAWN_DIST        = 16000.  // spawns this far away, in a random direction
        private constant real    DROP_SPEED             = 4000.   // units/second while flying in

        private constant real    PING_INTERVAL          = 0.5    // minimap ping every N seconds
        private constant real    PING_DURATION          = 1.0    // how long each ping stays visible

        private constant real    INTERVAL               = 0.03125

        // Landing effect - a small "thud"/impact puff, NOT an explosion, just to sell the landing
        private constant string  SFX_LANDING            = "Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl"

        // Optional: a quick drop-pod / sci-fi arrival sound (verify this path before relying on it)
        private constant string  SFX_LAUNCH_SOUND       = "Units\\Orc\\TaurenChieftain\\TaurenChieftainYesAttack1.wav"
        private constant boolean PLAY_LAUNCH_SOUND      = true

        private constant boolean DEBUG_MODE = false
        // ====================================================

        // Travel time is always identical since spawn distance and speed are both fixed constants.
        real DROP_TRAVEL_TIME = 0.

        private hashtable DropHash = InitHashtable() // timer -> MarineDropInstance
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

    private function PingForAllPlayers takes real x, real y, real duration returns nothing
        call PingMinimapForForce(bj_FORCE_ALL_PLAYERS, x, y, duration)
    endfunction

    private function PlaySoundAtPointRaw takes string soundPath, real x, real y returns nothing
        local sound snd = CreateSound(soundPath, false, true, false, 10, 10, "DefaultEAXON")
        call SetSoundPosition(snd, x, y, 0)
        call SetSoundDistanceCutoff(snd, 10000)
        call StartSound(snd)
        call KillSoundWhenDone(snd)
        set snd = null
    endfunction

    //==================================================================
    // The marine: spawns DROP_SPAWN_DIST away in a RANDOM direction,
    // travels in a straight line toward the target at a fixed speed
    // (just like the missile), pings the minimap along the way, but on
    // arrival does NOT explode - instead it becomes a normal, player-
    // controlled unit that can walk around, attack, and act freely.
    //==================================================================
    private struct MarineDropInstance
        unit marine
        player ownerPlayer
        real startX
        real startY
        real targetX
        real targetY
        real totalDist
        real traveled
        real angle
        real pingTimer
        timer tmr

        static method create takes unit caster, real targetX, real targetY returns thistype
            local thistype this = thistype.allocate()
            local real spawnAngle = GetRandomReal(0., 2. * bj_PI)
            local real launchX = targetX + DROP_SPAWN_DIST * Cos(spawnAngle)
            local real launchY = targetY + DROP_SPAWN_DIST * Sin(spawnAngle)

            set .ownerPlayer = GetOwningPlayer(caster)
            set .startX      = launchX
            set .startY      = launchY
            set .targetX     = targetX
            set .targetY     = targetY
            set .totalDist   = DistanceCoords(launchX, launchY, targetX, targetY)
            set .traveled    = 0.
            set .angle       = Atan2(targetY - launchY, targetX - launchX)
            set .pingTimer   = 0.

            // Create the REAL marine unit right away - it IS the "missile" this time,
            // not a dummy that gets destroyed on arrival.
            set .marine = CreateUnit(.ownerPlayer, MARINE_UNIT_ID, launchX, launchY, .angle * bj_RADTODEG)

            // While in flight: no pathing interference, flies in from above, can't act yet.
            // Explicitly force the FLYING unit-type during transit so raw X/Y movement
            // across cliffs doesn't get silently rejected or cause the unit to vanish.
            call SetUnitPathing(.marine, false)
            call UnitAddType(.marine, UNIT_TYPE_FLYING)
            call SetUnitFlyHeight(.marine, 800., 0.) // starts high up, "falling" in
            call PauseUnit(.marine, true)
            call ShowUnit(.marine, true)

            call PingForAllPlayers(launchX, launchY, PING_DURATION)

            if PLAY_LAUNCH_SOUND then
                call PlaySoundAtPointRaw(SFX_LAUNCH_SOUND, launchX, launchY)
            endif

            call DebugMsg("Marine drop launched from (" + R2S(launchX) + ", " + R2S(launchY) + ") -> target (" + R2S(targetX) + ", " + R2S(targetY) + "), travel time=" + R2S(DROP_TRAVEL_TIME))

            set .tmr = CreateTimer()
            call SaveInteger(DropHash, GetHandleId(.tmr), 0, this)
            call TimerStart(.tmr, INTERVAL, true, function MarineDropInstance.onTickCallback)
            return this
        endmethod

        method onTick takes nothing returns nothing
            local real ratio
            local real curX
            local real curY
            local real height

            set .traveled  = .traveled + DROP_SPEED * INTERVAL
            set .pingTimer = .pingTimer + INTERVAL

            if .totalDist <= 0. then
                set ratio = 1.
            else
                set ratio = .traveled / .totalDist
            endif
            if ratio > 1. then
                set ratio = 1.
            endif

            set curX = .startX + (.targetX - .startX) * ratio
            set curY = .startY + (.targetY - .startY) * ratio

            // Cruise much higher for most of the flight (well above any cliff level),
            // only descending sharply in the final 10% of the approach.
            if ratio < 0.9 then
                set height = 2000.
            else
                // Descend from 2000 down to 0 over the last 10% of travel
                set height = 2000. * (1. - ((ratio - 0.9) / 0.1))
            endif

            call SetUnitX(.marine, curX)
            call SetUnitY(.marine, curY)
            call SetUnitFlyHeight(.marine, height, 9999.)

            if .pingTimer >= PING_INTERVAL then
                set .pingTimer = .pingTimer - PING_INTERVAL
                call PingForAllPlayers(curX, curY, PING_DURATION)
            endif

            if ratio >= 1. then
                call .onLand()
            endif
        endmethod

        method onLand takes nothing returns nothing
            // Small landing effect, not an explosion
            call DestroyEffect(AddSpecialEffect(SFX_LANDING, .targetX, .targetY))

            // Settle onto the ground and hand full control back to the player
            call SetUnitFlyHeight(.marine, 0., 9999.)
            call UnitRemoveType(.marine, UNIT_TYPE_FLYING) // back to a normal ground unit
            call SetUnitPathing(.marine, true)
            call PauseUnit(.marine, false)

            call DebugMsg("Marine landed at (" + R2S(.targetX) + ", " + R2S(.targetY) + ") and is now player-controlled")

            call FlushChildHashtable(DropHash, GetHandleId(.tmr))
            call PauseTimer(.tmr)
            call DestroyTimer(.tmr)
            set .marine = null
            call .destroy()
        endmethod

        static method onTickCallback takes nothing returns nothing
            local timer tmr = GetExpiredTimer()
            local thistype this = LoadInteger(DropHash, GetHandleId(tmr), 0)
            call this.onTick()
            set tmr = null
        endmethod
    endstruct

    //==================================================================
    // Public entry point — point-target cast, matches your dispatcher format
    //==================================================================
    function CastMarineDrop takes unit hero, real x, real y returns nothing
        call MarineDropInstance.create(hero, x, y)
    endfunction

    private function Init takes nothing returns nothing
        set DROP_TRAVEL_TIME = DROP_SPAWN_DIST / DROP_SPEED
    endfunction

endlibrary