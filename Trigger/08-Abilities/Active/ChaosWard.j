library ChaosWard requires ChaosMagic

    globals
        // ===================== CONFIG =====================
        // The ward uses the shared ward dummy. 'hdhw' is written here as a plain rawcode so this library can't clash
        // with however you've named it elsewhere. Swap it for your constant if you prefer.
        private constant integer WARD_DUMMY_ID      = 'hdhw'

        // Hit points and lifetime
        private constant integer WARD_HP             = 15
        private constant real    HP_PER_CAST         = 1.      // hit points lost each time it casts
        private constant real    WARD_LIFETIME       = 45.     // seconds. 0 = until its hit points run out

        // Behaviour
        private constant real    DETECT_RANGE        = 600.    // an enemy this close makes it cast
        private constant real    CAST_INTERVAL       = 2.0     // seconds between casts
        private constant real    SCAN_INTERVAL       = 0.2     // how often it looks for an enemy once it's ready to cast
        private constant boolean CAST_AS_WARD        = true    // true = the ward is the "caster" in CastRandomSpell.
                                                                 // false = your hero is (spells then credit the hero)

        // TEST SWITCHES for hunting the lag spike. Leave both true normally. Turn ONE off at a time and see if the spike goes away.
        private constant boolean DO_VISUALS          = true    // the forked bolt and flash that play on each cast
        private constant boolean DO_SPELL            = true    // the actual CastRandomSpell call

        // Look. A chaos eye: a Sentry Ward whose colours never stop shifting, ringed by five restless orbs
        // that drift in and out and swap direction. Every cast it jolts, and a forked bolt of a random colour hits the target.
        private constant integer WARD_SKIN_ID        = 'oeye'  // the dummy takes on this unit type's model (Sentry Ward, an eye on a post). Swap for any model
        private constant real    WARD_SCALE          = 1.3
        private constant real    COLOR_SPEED         = 2.0     // how fast the ward's colours cycle
        private constant string  ORB_MODEL           = "Abilities\\Weapons\\WaterElementalMissile\\WaterElementalMissile.mdl"
        private constant real    MODEL_NATIVE_WIDTH  = 50.     // rough width of the orb model at scale 1. Tune if the orbs look off
        private constant real    ORB_DIAMETER        = 28.
        private constant string  FLASH_MODEL         = "Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl"            // spawn and cast flashes
        private constant string  BREAK_MODEL         = "Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl"   // when the ward shatters
        private constant string  LINK_LIGHTNING      = "FORK"  // the bolt from the ward to the unit it just cast on
        private constant real    LINK_TIME           = 0.3

        private constant real    INTERVAL            = 0.03125
        // ====================================================

        private integer array Active
        private integer       Count = 0
        private timer         Tick  = CreateTimer()
        private group         Grp   = CreateGroup()
        private location     ZLoc  = Location(0., 0.)
        private location     SpellLoc = Location(0., 0.)     // handed to CastRandomSpell as the spell's point
        private hashtable     LinkHash = InitHashtable()
    endglobals

    //==================================================================
    private function GroundZ takes real x, real y returns real
        call MoveLocation(ZLoc, x, y)
        return GetLocationZ(ZLoc)
    endfunction

    // The ward's shifting colour: three out-of-step waves, one per colour channel
    private function ChaosR takes real phase returns integer
        return R2I(150. + 105. * Sin(phase))
    endfunction

    private function ChaosG takes real phase returns integer
        return R2I(150. + 105. * Sin(phase + 2.094))
    endfunction

    private function ChaosB takes real phase returns integer
        return R2I(150. + 105. * Sin(phase + 4.189))
    endfunction

    // A one-shot flash in a random colour
    private function ChaosFlash takes string model, real x, real y returns nothing
        local effect e
        local real ph = GetRandomReal(0., 6.283)

        if model != "" then
            set e = AddSpecialEffect(model, x, y)
            call BlzSetSpecialEffectColor(e, ChaosR(ph), ChaosG(ph), ChaosB(ph))
            call DestroyEffect(e)
            set e = null
        endif
    endfunction

    // The bolt from the ward to its target goes away after a moment
    private function LinkEnd takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer id = GetHandleId(t)

        call DestroyLightning(LoadLightningHandle(LinkHash, id, 0))
        call FlushChildHashtable(LinkHash, id)
        call DestroyTimer(t)
        set t = null
    endfunction

    // A forked bolt of a random colour from the ward to its target, plus a flash on the target
    private function ShowCast takes unit ward, unit target returns nothing
        local real x1 = GetUnitX(ward)
        local real y1 = GetUnitY(ward)
        local real x2 = GetUnitX(target)
        local real y2 = GetUnitY(target)
        local lightning l = AddLightningEx(LINK_LIGHTNING, false, x1, y1, GroundZ(x1, y1) + 90., x2, y2, GroundZ(x2, y2) + 70.)
        local timer t = CreateTimer()
        local real ph = GetRandomReal(0., 6.283)

        call SetLightningColor(l, I2R(ChaosR(ph)) / 255., I2R(ChaosG(ph)) / 255., I2R(ChaosB(ph)) / 255., 1.)
        call SaveLightningHandle(LinkHash, GetHandleId(t), 0, l)
        call TimerStart(t, LINK_TIME, false, function LinkEnd)

        call ChaosFlash(FLASH_MODEL, x2, y2)

        set l = null
        set t = null
    endfunction

    //==================================================================
    // One ward. Its hit points ARE its life: each cast takes one away.
    //==================================================================
    private struct ChaosWardInstance
        unit ward
        unit hero
        integer level         // the level of the Chaos Ward ability when it was cast: this is the chaos level
        real t
        real cd               // time until it may cast again
        real scan             // time until it next looks for an enemy
        real pulse            // 1 right after a cast, fading to 0: makes the ward jolt
        effect array orb[5]

        //--------------------------------------------------------
        static method create takes unit hero, real x, real y, integer lvl returns thistype
            local thistype this = thistype.allocate()
            local integer i = 0

            set .hero  = hero
            set .level = lvl
            set .t     = 0.
            set .cd    = CAST_INTERVAL
            set .scan  = 0.
            set .pulse = 0.
            set .ward  = CreateUnit(GetOwningPlayer(hero), WARD_DUMMY_ID, x, y, 270.)

            // hit points
            call BlzSetUnitMaxHP(.ward, WARD_HP)
            call SetWidgetLife(.ward, I2R(WARD_HP))
            call BlzSetUnitRealField(.ward, UNIT_RF_HIT_POINTS_REGENERATION_RATE, 0.)
            call BlzSetUnitArmor(.ward, 0.)

            // it stays where it's put
            call SetUnitMoveSpeed(.ward, 0.)

            // the look
            call BlzSetUnitSkin(.ward, WARD_SKIN_ID)
            call SetUnitScale(.ward, WARD_SCALE, WARD_SCALE, WARD_SCALE)

            loop
                exitwhen i >= 5
                set .orb[i] = AddSpecialEffect(ORB_MODEL, x, y)
                call BlzSetSpecialEffectScale(.orb[i], ORB_DIAMETER / MODEL_NATIVE_WIDTH)
                set i = i + 1
            endloop

            call ChaosFlash(FLASH_MODEL, x, y)

            set Active[Count] = this
            set Count = Count + 1
            if Count == 1 then
                call TimerStart(Tick, INTERVAL, true, function thistype.tickAll)
            endif
            return this
        endmethod

        //--------------------------------------------------------
        // The nearest valid enemy within DETECT_RANGE, or null.
        // Only cheap native checks are used here, nothing from your helper libraries.
        method findTarget takes real wx, real wy returns unit
            local unit u
            local unit best = null
            local real bestD = 0.
            local real dx
            local real dy
            local real d
            local player p = GetOwningPlayer(.ward)

            call GroupEnumUnitsInRange(Grp, wx, wy, DETECT_RANGE, null)
            loop
                set u = FirstOfGroup(Grp)
                exitwhen u == null
                call GroupRemoveUnit(Grp, u)

                if u != .ward /*
                    */ and GetWidgetLife(u) > 0.405 /*
                    */ and IsUnitEnemy(u, p) /*
                    */ and not IsUnitType(u, UNIT_TYPE_DEAD) /*
                    */ and not IsUnitType(u, UNIT_TYPE_STRUCTURE) /*
                    */ and GetUnitAbilityLevel(u, 'Aloc') == 0 /*
                    */ and not IsUnitHidden(u) /*
                    */ and not BlzIsUnitInvulnerable(u) then

                    set dx = GetUnitX(u) - wx
                    set dy = GetUnitY(u) - wy
                    set d = dx * dx + dy * dy
                    if best == null or d < bestD then
                        set best = u
                        set bestD = d
                    endif
                endif
            endloop

            set u = null
            set p = null
            return best
        endmethod

        //--------------------------------------------------------
        // One cast: a random chaos spell on the target, at the chaos level of this ward, costing the ward a hit point
        method castAt takes unit target returns nothing
            local unit caster = .ward
            local real life

            if not CAST_AS_WARD and .hero != null and GetWidgetLife(.hero) > 0.405 then
                set caster = .hero
            endif

            if DO_VISUALS then
                call ShowCast(.ward, target)
            endif

            if DO_SPELL then
                // the target's spot is the spell's point, for point-target spells
                call MoveLocation(SpellLoc, GetUnitX(target), GetUnitY(target))
                call CastRandomSpell(caster, CHAOS_WARD_ABILITY_ID, target, SpellLoc, false, .level)
            endif

            // it loses a hit point for casting
            if GetWidgetLife(.ward) > 0.405 then
                set life = GetWidgetLife(.ward) - HP_PER_CAST
                if life < 0.406 then
                    call KillUnit(.ward)
                else
                    call SetWidgetLife(.ward, life)
                endif
            endif

            set .pulse = 1.
            set caster = null
        endmethod

        //--------------------------------------------------------
        // returns true when the ward is gone
        method step takes nothing returns boolean
            local real wx
            local real wy
            local real ph
            local real a
            local real r
            local real x
            local real y
            local real s
            local integer i = 0
            local unit target

            // removed from the game by something else
            if GetUnitTypeId(.ward) == 0 then
                return true
            endif

            set wx = GetUnitX(.ward)
            set wy = GetUnitY(.ward)

            // out of hit points (or out of time): it shatters
            if GetWidgetLife(.ward) < 0.405 then
                call ChaosFlash(BREAK_MODEL, wx, wy)
                call RemoveUnit(.ward)
                return true
            endif

            set .t = .t + INTERVAL
            if WARD_LIFETIME > 0. and .t >= WARD_LIFETIME then
                call KillUnit(.ward)       // it shatters on the next tick
            endif

            // ---------- the look ----------
            // the ward's colours drift, and it jolts bigger right after a cast
            set ph = .t * COLOR_SPEED
            call SetUnitVertexColor(.ward, ChaosR(ph), ChaosG(ph), ChaosB(ph), 255)
            set s = WARD_SCALE * (1. + 0.08 * Sin(.t * 5.) + 0.45 * .pulse)
            call SetUnitScale(.ward, s, s, s)
            if .pulse > 0. then
                set .pulse = .pulse - INTERVAL / 0.4
                if .pulse < 0. then
                    set .pulse = 0.
                endif
            endif

            // five restless orbs: each drifts in and out at its own pace, orbits at its own speed, and they alternate direction
            loop
                exitwhen i >= 5
                if i - (i / 2) * 2 == 0 then
                    set a = (1.5 + 0.4 * I2R(i)) * .t + I2R(i) * 1.2566
                else
                    set a = -(1.5 + 0.4 * I2R(i)) * .t + I2R(i) * 1.2566
                endif
                set r = 80. + 35. * Sin(.t * 1.7 + I2R(i) * 1.3)
                set x = wx + r * Cos(a)
                set y = wy + r * Sin(a)

                call BlzSetSpecialEffectPosition(.orb[i], x, y, GroundZ(x, y) + 90. + 40. * Sin(.t * 2.3 + I2R(i)))
                call BlzSetSpecialEffectColor(.orb[i], ChaosR(ph * 1.5 + I2R(i) * 1.2), ChaosG(ph * 1.5 + I2R(i) * 1.2), ChaosB(ph * 1.5 + I2R(i) * 1.2))
                set i = i + 1
            endloop

            // ---------- the casting ----------
            // once it's ready, it checks for an enemy every SCAN_INTERVAL and casts as soon as one is in range
            set .cd = .cd - INTERVAL
            if .cd <= 0. then
                set .scan = .scan - INTERVAL
                if .scan <= 0. then
                    set .scan = SCAN_INTERVAL
                    set target = .findTarget(wx, wy)
                    if target != null then
                        call .castAt(target)
                        set .cd = CAST_INTERVAL
                    endif
                    set target = null
                endif
            endif

            return false
        endmethod

        //--------------------------------------------------------
        method onDestroy takes nothing returns nothing
            local integer i = 0

            loop
                exitwhen i >= 5
                if .orb[i] != null then
                    call BlzSetSpecialEffectScale(.orb[i], 0.001)
                    call DestroyEffect(.orb[i])
                    set .orb[i] = null
                endif
                set i = i + 1
            endloop

            set .ward = null
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
    // Public entry point, called from your ability dispatcher.
    // lvl is the level of the Chaos Ward ability, and becomes the chaos level of every spell it casts.
    function CastChaosWard takes unit hero, real x, real y, integer lvl returns nothing
        if hero == null then
            return
        endif
        call ChaosWardInstance.create(hero, x, y, lvl)
    endfunction

endlibrary