library TimeDilation initializer Init requires GetObjectElement, DummySpell, RandomShit

    globals
        // ===== IDs: replace the rawcodes (delete these two lines if you declare them elsewhere) =====
        constant integer TIME_DILATION_BUFF_ID         = 'BTDB'   // the buff shown on affected units
        constant integer TIME_DILATION_BUFF_APPLIER_ID = 'A0TD'   // dummy ability that places that buff

        // ===================== CONFIG =====================
        private constant integer DUMMY_ID         = 'esen'        // Locust + Invulnerable, no model
        private constant string  BUFF_ORDER       = "channel"   // order string of the applier's base ability

        // Size
        private constant real    BASE_AOE         = 200.          // radius with 0 arcane
        private constant real    AOE_PER_ARCANE   = 50.           // extra radius per arcane element count

        // Effect
        private constant real    DURATION         = 10.           // how long the sphere lasts
        private constant real    CD_INTERVAL      = 1.            // every X seconds...
        private constant real    CD_REDUCTION     = 2.            // ...cooldowns are reduced by this many seconds

        // Visuals
        private constant string  SPHERE_MODEL       = "Abilities\\Spells\\Undead\\AntiMagicShell\\AntiMagicShell.mdl"
        private constant real    SPHERE_BASE_RADIUS = 100.        // approx native radius of the model; tune this
        private constant real    SPHERE_Z           = 0.          // extra height offset for the sphere
        private constant boolean SHOW_RING          = true        // exact-size ring on the ground
        private constant string  RING_LIGHTNING     = "SPLK"
        private constant real    RING_HEIGHT        = 30.

        private constant real    TICK             = 0.25          // how often units entering/leaving are checked
        // ====================================================

        private integer array Active
        private integer       Count = 0
        private timer         Clock = CreateTimer()
        private group         Tmp   = CreateGroup()
        private location     ZLoc  = Location(0., 0.)
    endglobals

    //==================================================================
    private function GroundZ takes real x, real y returns real
        call MoveLocation(ZLoc, x, y)
        return GetLocationZ(ZLoc)
    endfunction

    // Reduces every resettable spell cooldown (and its dummy spell's cooldown) by 'amount' seconds.
    // Same logic as RuneOfMagic.
    private function ReduceCooldowns takes unit u, real amount returns nothing
        local integer i = 0
        local integer spellId
        local integer dummySpell
        local real remaining
        local real dummyRemaining

        loop
            exitwhen i > 10
            set spellId = GetHeroSpellAtPosition(u, i)

            if spellId != 0 and IsSpellResettable(spellId) then
                set dummySpell = GetDummySpell(u, spellId)
                set remaining  = BlzGetUnitAbilityCooldownRemaining(u, spellId)

                if remaining <= amount then
                    call BlzEndUnitAbilityCooldown(u, spellId)
                    if dummySpell != 0 then
                        call BlzEndUnitAbilityCooldown(u, dummySpell)
                    endif
                else
                    call BlzStartUnitAbilityCooldown(u, spellId, remaining - amount)
                    if dummySpell != 0 then
                        set dummyRemaining = BlzGetUnitAbilityCooldownRemaining(u, dummySpell)
                        if dummyRemaining <= amount then
                            call BlzEndUnitAbilityCooldown(u, dummySpell)
                        else
                            call BlzStartUnitAbilityCooldown(u, dummySpell, dummyRemaining - amount)
                        endif
                    endif
                endif
            endif

            set i = i + 1
        endloop
    endfunction

    // Every living unit counts: friend, foe, neutral, structures. Only dead units and
    // Locust dummies (the system's own helper units) are skipped.
    private function IsAffected takes unit u returns boolean
        return GetWidgetLife(u) > 0.405 /*
            */ and not IsUnitType(u, UNIT_TYPE_DEAD) /*
            */ and GetUnitAbilityLevel(u, 'Aloc') == 0
    endfunction

    // A dummy casts the buff-placing ability on the unit, then times out
    private function ApplyBuff takes player owner, unit target, real x, real y returns nothing
        local unit d = CreateUnit(owner, DUMMY_ID, x, y, 0.)
        call UnitAddAbility(d, TIME_DILATION_BUFF_APPLIER_ID)
        call UnitApplyTimedLife(d, 'BTLF', 1.)
        call IssueTargetOrder(d, BUFF_ORDER, target)
        set d = null
    endfunction

    //==================================================================
    private struct TimeDilationInstance
        player owner
        real   x
        real   y
        real   radius
        real   elapsed
        real   cdT
        effect sphere
        lightning array ring[32]
        group  affected
        group  now

        //--------------------------------------------------------
        static method create takes unit caster returns thistype
            local thistype this = thistype.allocate()
            local integer i
            local real a1
            local real a2
            local real x1
            local real y1
            local real x2
            local real y2

            set .owner    = GetOwningPlayer(caster)
            set .x        = GetUnitX(caster)      // fixed at cast time, never updated again
            set .y        = GetUnitY(caster)
            set .elapsed  = 0.
            set .cdT      = CD_INTERVAL           // first cooldown reduction happens right away
            set .affected = CreateGroup()
            set .now      = CreateGroup()

            // radius = 200 + 50 per arcane element count of the caster (read once at cast)
            set .radius = BASE_AOE + AOE_PER_ARCANE * GetUnitElementCount(caster, Element_Arcane)

            // sphere visual scaled to the radius
            set .sphere = AddSpecialEffect(SPHERE_MODEL, .x, .y)
            call BlzSetSpecialEffectScale(.sphere, .radius / SPHERE_BASE_RADIUS)
            call BlzSetSpecialEffectPosition(.sphere, .x, .y, GroundZ(.x, .y) + SPHERE_Z)

            // exact-size ring
            if SHOW_RING then
                set i = 0
                loop
                    exitwhen i >= 32
                    set a1 = 2. * bj_PI * I2R(i) / 32.
                    set a2 = 2. * bj_PI * I2R(i + 1) / 32.
                    set x1 = .x + .radius * Cos(a1)
                    set y1 = .y + .radius * Sin(a1)
                    set x2 = .x + .radius * Cos(a2)
                    set y2 = .y + .radius * Sin(a2)
                    set .ring[i] = AddLightningEx(RING_LIGHTNING, true, x1, y1, GroundZ(x1, y1) + RING_HEIGHT, x2, y2, GroundZ(x2, y2) + RING_HEIGHT)
                    call SetLightningColor(.ring[i], 0.6, 0.35, 1., 1.)
                    set i = i + 1
                endloop
            endif

            set Active[Count] = this
            set Count = Count + 1
            if Count == 1 then
                call TimerStart(Clock, TICK, true, function thistype.tickAll)
            endif
            return this
        endmethod

        //--------------------------------------------------------
        // returns true when the sphere has expired
        method tick takes nothing returns boolean
            local unit u
            local boolean doCd = false

            set .elapsed = .elapsed + TICK
            if .elapsed >= DURATION then
                return true
            endif

            set .cdT = .cdT + TICK
            if .cdT >= CD_INTERVAL then
                set .cdT = .cdT - CD_INTERVAL
                set doCd = true
            endif

            // 1. who is inside right now (all units)
            call GroupClear(.now)
            call GroupEnumUnitsInRange(Tmp, .x, .y, .radius, null)
            loop
                set u = FirstOfGroup(Tmp)
                exitwhen u == null
                call GroupRemoveUnit(Tmp, u)
                if IsAffected(u) then
                    call GroupAddUnit(.now, u)
                endif
            endloop

            // 2. units that left lose the buff
            call GroupAddGroup(.affected, Tmp)
            loop
                set u = FirstOfGroup(Tmp)
                exitwhen u == null
                call GroupRemoveUnit(Tmp, u)
                if not IsUnitInGroup(u, .now) then
                    call UnitRemoveAbility(u, TIME_DILATION_BUFF_ID)
                    call GroupRemoveUnit(.affected, u)
                endif
            endloop

            // 3. units inside get the buff, and cooldown reduction once per second
            call GroupAddGroup(.now, Tmp)
            loop
                set u = FirstOfGroup(Tmp)
                exitwhen u == null
                call GroupRemoveUnit(Tmp, u)
                call GroupAddUnit(.affected, u)

                if GetUnitAbilityLevel(u, TIME_DILATION_BUFF_ID) == 0 then
                    call ApplyBuff(.owner, u, .x, .y)
                endif
                if doCd then
                    call ReduceCooldowns(u, CD_REDUCTION)
                endif
            endloop

            set u = null
            return false
        endmethod

        //--------------------------------------------------------
        method onDestroy takes nothing returns nothing
            local unit u
            local integer i = 0

            // strip the buff from everyone still inside
            call GroupAddGroup(.affected, Tmp)
            loop
                set u = FirstOfGroup(Tmp)
                exitwhen u == null
                call GroupRemoveUnit(Tmp, u)
                call UnitRemoveAbility(u, TIME_DILATION_BUFF_ID)
            endloop
            set u = null

            call DestroyGroup(.affected)
            call DestroyGroup(.now)
            set .affected = null
            set .now      = null

            if SHOW_RING then
                loop
                    exitwhen i >= 32
                    call DestroyLightning(.ring[i])
                    set .ring[i] = null
                    set i = i + 1
                endloop
            endif

            call BlzSetSpecialEffectScale(.sphere, 0.001)   // hide death animation
            call DestroyEffect(.sphere)
            set .sphere = null
        endmethod

        //--------------------------------------------------------
        static method tickAll takes nothing returns nothing
            local integer i = Count - 1
            local thistype this

            loop
                exitwhen i < 0
                set this = Active[i]
                if this.tick() then
                    call this.destroy()
                    set Count = Count - 1
                    set Active[i] = Active[Count]
                endif
                set i = i - 1
            endloop

            if Count == 0 then
                call PauseTimer(Clock)
            endif
        endmethod
    endstruct

    //==================================================================
    function CastTimeDilation takes unit hero returns nothing
        if hero == null then
            return
        endif
        call TimeDilationInstance.create(hero)
    endfunction

    private function Init takes nothing returns nothing
    endfunction

endlibrary