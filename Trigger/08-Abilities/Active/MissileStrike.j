library MissileStrike initializer Init

    globals
        // ===================== CONFIG =====================
        private constant integer MISSILE_DUMMY_ID         = 'uban' // large missile dummy unit-type (Locust = FALSE, needs sight radius, non-hero base)

        private constant real    MISSILE_SPAWN_DIST     = 5000.  // spawns this far away, in a random direction
        private constant real    MISSILE_SPEED          = 750.   // units/second, fixed

        private constant real    IMPACT_RADIUS          = 300.
        private constant real    IMPACT_DMG_PER_LVL     = 3000.

        private constant real    PING_INTERVAL          = 1.0    // minimap ping every N seconds
        private constant real    PING_DURATION          = 1.0    // how long each ping stays visible

        private constant real    INTERVAL               = 0.03125

        // Impact effect - swap this once we find one that actually renders
        private constant string  SFX_IMPACT             = "Abilities\\Spells\\Human\\FlameStrike\\FlameStrikeTarget.mdl"

        // ---- DIAGNOSTIC MODE ----
        // Set true to spawn copies of SFX_IMPACT at different heights (below/level/above
        // ground), plus a plain control case, instead of the normal single impact effect.
        // Set back to false once you've confirmed what works.
        private constant boolean TEST_THREE_HEIGHTS = true

        // ---- Launch sound ----
        // Placeholder - replace with a verified sound path from the Object Editor
        // (check a hero's Sound - Attack / Sound - What fields for the exact file path).
        private constant string  SFX_LAUNCH_SOUND       = "Units\\Orc\\TaurenChieftain\\TaurenChieftainYesAttack1.wav"
        private constant boolean PLAY_LAUNCH_SOUND      = true

        private constant boolean DEBUG_MODE = true
        // ====================================================

        // Travel time is always identical since spawn distance and speed are both fixed constants.
        real MISSILE_TRAVEL_TIME = 0.

        private hashtable MissileHash   = InitHashtable() // timer -> MissileInstance
        private hashtable ExplosionHash = InitHashtable() // timer -> ExplosionInstance
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
    // Diagnostic: spawns copies of SFX_IMPACT at different heights
    // (below ground, ground level, above ground), plus one plain
    // AddSpecialEffect control case, side by side, so you can see
    // which one(s) actually render. Each lingers briefly then cleans up.
    //==================================================================
    private function TestThreeHeights takes real x, real y returns nothing
        local unit lowDummy
        local unit midDummy
        local unit highDummy
        local effect fx

        call DebugMsg("Running height diagnostic test at (" + R2S(x) + ", " + R2S(y) + ")")

        // Below ground level
        set lowDummy = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), MISSILE_DUMMY_ID, x - 200., y, 0)
        call SetUnitFlyHeight(lowDummy, -100., 0.)
        call ShowUnit(lowDummy, false)
        set fx = AddSpecialEffectTarget(SFX_IMPACT, lowDummy, "origin")
        call DestroyEffect(fx)

        // Ground level (normal)
        set midDummy = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), MISSILE_DUMMY_ID, x, y, 0)
        call SetUnitFlyHeight(midDummy, 0., 0.)
        call ShowUnit(midDummy, false)
        set fx = AddSpecialEffectTarget(SFX_IMPACT, midDummy, "origin")
        call DestroyEffect(fx)

        // Above ground level
        set highDummy = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), MISSILE_DUMMY_ID, x + 200., y, 0)
        call SetUnitFlyHeight(highDummy, 200., 0.)
        call ShowUnit(highDummy, false)
        set fx = AddSpecialEffectTarget(SFX_IMPACT, highDummy, "origin")
        call DestroyEffect(fx)

        // Plain AddSpecialEffect at ground level, no dummy involved - simplest control case
        call DestroyEffect(AddSpecialEffect(SFX_IMPACT, x - 400., y))

        call RemoveUnit(lowDummy)
        call RemoveUnit(midDummy)
        call RemoveUnit(highDummy)

        set lowDummy = null
        set midDummy = null
        set highDummy = null
    endfunction

    //==================================================================
    // Separate, independently-timed explosion effect. Scheduled once
    // at cast time for exactly MISSILE_TRAVEL_TIME seconds later.
    //==================================================================
    private struct ExplosionInstance
        unit caster
        player ownerPlayer
        integer level
        real targetX
        real targetY
        timer tmr

        static method create takes unit caster, real targetX, real targetY, integer lvl returns thistype
            local thistype this = thistype.allocate()

            set .caster      = caster
            set .ownerPlayer = GetOwningPlayer(caster)
            set .level       = lvl
            set .targetX     = targetX
            set .targetY     = targetY

            set .tmr = CreateTimer()
            call SaveInteger(ExplosionHash, GetHandleId(.tmr), 0, this)
            call TimerStart(.tmr, MISSILE_TRAVEL_TIME, false, function ExplosionInstance.onExpireCallback)
            return this
        endmethod

        method onExpire takes nothing returns nothing
            local group g = CreateGroup()
            local unit u
            local real dmg = IMPACT_DMG_PER_LVL * I2R(.level)

            call DebugMsg("ExplosionInstance.onExpire fired at (" + R2S(.targetX) + ", " + R2S(.targetY) + ")")

            if TEST_THREE_HEIGHTS then
                call TestThreeHeights(.targetX, .targetY)
            else
                call DestroyEffect(AddSpecialEffect(SFX_IMPACT, .targetX, .targetY))
            endif

            call GroupEnumUnitsInRange(g, .targetX, .targetY, IMPACT_RADIUS, null)
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

            call FlushChildHashtable(ExplosionHash, GetHandleId(.tmr))
            call PauseTimer(.tmr)
            call DestroyTimer(.tmr)
            set .caster = null
            call .destroy()
        endmethod

        static method onExpireCallback takes nothing returns nothing
            local timer tmr = GetExpiredTimer()
            local thistype this = LoadInteger(ExplosionHash, GetHandleId(tmr), 0)
            call this.onExpire()
            set tmr = null
        endmethod
    endstruct

    //==================================================================
    // The missile: purely visual/positional. Spawns MISSILE_SPAWN_DIST
    // away in a RANDOM direction, travels in a straight line toward the
    // target at a fixed speed, stays visible on everyone's minimap the
    // whole flight, and pings the minimap every PING_INTERVAL seconds.
    //==================================================================
    private struct MissileInstance
        unit dummy
        real startX
        real startY
        real targetX
        real targetY
        real totalDist
        real traveled
        real angle
        real pingTimer
        timer tmr

        static method create takes unit caster, real targetX, real targetY, integer lvl returns thistype
            local thistype this = thistype.allocate()
            local real spawnAngle = GetRandomReal(0., 2. * bj_PI)
            local real launchX = targetX + MISSILE_SPAWN_DIST * Cos(spawnAngle)
            local real launchY = targetY + MISSILE_SPAWN_DIST * Sin(spawnAngle)

            set .startX      = launchX
            set .startY      = launchY
            set .targetX     = targetX
            set .targetY     = targetY
            set .totalDist   = DistanceCoords(launchX, launchY, targetX, targetY)
            set .traveled    = 0.
            set .angle       = Atan2(targetY - launchY, targetX - launchX)
            set .pingTimer   = 0.

            set .dummy = CreateUnit(GetOwningPlayer(caster), MISSILE_DUMMY_ID, launchX, launchY, .angle * bj_RADTODEG)
            call SetUnitPathing(.dummy, false)
            call SetUnitFlyHeight(.dummy, 0., 0.)

            call PingForAllPlayers(launchX, launchY, PING_DURATION)

            // Launch sound - plays once, right as the missile is fired
            if PLAY_LAUNCH_SOUND then
                call PlaySoundAtPointRaw(SFX_LAUNCH_SOUND, GetUnitX(caster), GetUnitY(caster))
            endif

            call ExplosionInstance.create(caster, targetX, targetY, lvl)

            call DebugMsg("Missile spawned at (" + R2S(launchX) + ", " + R2S(launchY) + ") -> target (" + R2S(targetX) + ", " + R2S(targetY) + "), travel time=" + R2S(MISSILE_TRAVEL_TIME))

            set .tmr = CreateTimer()
            call SaveInteger(MissileHash, GetHandleId(.tmr), 0, this)
            call TimerStart(.tmr, INTERVAL, true, function MissileInstance.onTickCallback)
            return this
        endmethod

        method onTick takes nothing returns nothing
            local real ratio
            local real curX
            local real curY

            set .traveled  = .traveled + MISSILE_SPEED * INTERVAL
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

            call SetUnitX(.dummy, curX)
            call SetUnitY(.dummy, curY)

            if .pingTimer >= PING_INTERVAL then
                set .pingTimer = .pingTimer - PING_INTERVAL
                call PingForAllPlayers(curX, curY, PING_DURATION)
            endif

            if ratio >= 1. then
                call .destroy()
            endif
        endmethod

        method onDestroy takes nothing returns nothing
            call FlushChildHashtable(MissileHash, GetHandleId(.tmr))
            call PauseTimer(.tmr)
            call DestroyTimer(.tmr)

            call KillUnit(.dummy)
            call RemoveUnit(.dummy)
            set .dummy = null
        endmethod

        static method onTickCallback takes nothing returns nothing
            local timer tmr = GetExpiredTimer()
            local thistype this = LoadInteger(MissileHash, GetHandleId(tmr), 0)
            call this.onTick()
            set tmr = null
        endmethod
    endstruct

    //==================================================================
    // Public entry point
    //==================================================================
    function CastMissileStrike takes unit hero, real x, real y, integer lvl returns nothing
        call MissileInstance.create(hero, x, y, lvl)
    endfunction

    private function Init takes nothing returns nothing
        set MISSILE_TRAVEL_TIME = MISSILE_SPAWN_DIST / MISSILE_SPEED
    endfunction

endlibrary