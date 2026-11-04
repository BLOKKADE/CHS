library Marine requires CustomState, SpellFormula

    globals
        // ===== Depleted Uranium Shells (Marine) =====
        constant integer DEPLETED_URANIUM_ABILITY_ID  = 'DUBB'   // the passive on the Marine
        constant real    DEPLETED_URANIUM_PCT_PER_HIT = 0.01     // +1% of max HP for each consecutive hit
        constant real    DEPLETED_URANIUM_DURATION    = 7.       // seconds without a hit before the stacks reset
        constant integer DEPLETED_URANIUM_MAX_STACKS  = 0        // 0 = no cap
        constant string  DEPLETED_URANIUM_HIT_FX      = "Abilities\\Spells\\Other\\AcidBomb\\BottleImpact.mdl"

        // ===== Marine =====
        constant real    MARINE_LIFETIME              = 90.      // seconds before the Marine expires

        private constant boolean DEBUG_MODE = false

        private hashtable Data  = InitHashtable()
        private timer     Clock = CreateTimer()
    endglobals

    function DepletedUraniumHit takes unit target returns real
        local integer id = GetHandleId(target)
        local real now = TimerGetElapsed(Clock)
        local integer stacks = LoadInteger(Data, id, 0)
        local real bonus
        local effect fx

        if stacks > 0 and (now - LoadReal(Data, id, 1)) <= DEPLETED_URANIUM_DURATION then
            set stacks = stacks + 1
        else
            set stacks = 1
        endif

        if DEPLETED_URANIUM_MAX_STACKS > 0 and stacks > DEPLETED_URANIUM_MAX_STACKS then
            set stacks = DEPLETED_URANIUM_MAX_STACKS
        endif

        call SaveInteger(Data, id, 0, stacks)
        call SaveReal(Data, id, 1, now)

        set bonus = GetUnitState(target, UNIT_STATE_MAX_LIFE) * DEPLETED_URANIUM_PCT_PER_HIT * I2R(stacks)

        // hit visual, a bit bigger with more stacks
        set fx = AddSpecialEffectTarget(DEPLETED_URANIUM_HIT_FX, target, "chest")
        call BlzSetSpecialEffectScale(fx, RMinBJ(2., 0.8 + 0.1 * I2R(stacks)))
        call DestroyEffect(fx)
        set fx = null

        if DEBUG_MODE then
            call BJDebugMsg("Depleted Uranium: stack " + I2S(stacks) + ", bonus " + R2S(bonus))
        endif

        return bonus
    endfunction

    function MarineStats takes unit u, integer totalLevel returns nothing
        local integer summonLevel = IMaxBJ(totalLevel - 30, 0)
        local integer abilityLevel = IMinBJ(totalLevel, 30)

        call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u,0) + GetSpellValue(0, 12, abilityLevel) + (summonLevel * 150), 0)
        call BlzSetUnitAttackCooldown(u, BlzGetUnitAttackCooldown(u,0) * (8 / (10.1 + (totalLevel / 2))), 0)
        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + totalLevel * 800)
        call BlzSetUnitArmor(u, BlzGetUnitArmor(u) + 5 * totalLevel)

        call UnitAddAbility(u, 'DUBB')

        // timed life
        call UnitApplyTimedLife(u, 'BTLF', MARINE_LIFETIME)
    endfunction

    private function Init takes nothing returns nothing
        call TimerStart(Clock, 1000000., false, null)   // runs as a game clock
    endfunction
endlibrary