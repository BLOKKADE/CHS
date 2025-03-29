library ModifyCreepAbilities initializer init requires RandomShit

    private function ModifyCreepAbilitiesActions takes nothing returns nothing
        local unit creep = GetLastCreatedUnit()

        // --- Add abilities
        // Bash
        if (RoundCreepChanceBash == 1) then
            call UnitAddAbility(creep, 'ACbh')
        endif

        // Crit Strike
        if (RoundCreepChanceCritStrike == 1) then
            call UnitAddAbility(creep, CRITICAL_STRIKE_ABILITY_ID)
        endif

        // Evasion
        if (RoundCreepChanceEvasion == 1) then
            call AddUnitCustomState(creep, BONUS_EVASION, 20)
        endif

        // Cleave
        if (RoundCreepChanceCleave == 1) then
            call UnitAddAbility(creep, 'ACce')
        endif

        // Lifesteal
        if (RoundCreepChanceLifesteal == 1) then
            call UnitAddAbility(creep, 'SCva')
        endif

        // Thorns
        if (RoundCreepChanceThorns == 1) then
            call UnitAddAbility(creep, THORNS_AURA_ABILITY_ID)
            call SetUnitAbilityLevel(creep, THORNS_AURA_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.4), 30))
        endif

        // --- Remove Abilities
        // Shockwave
        if (RoundCreepChanceShockwave != 1) then
            call UnitRemoveAbility(creep, SHOCKWAVE_CREEP_ABILITY_ID)
        endif

        // Mana burn
        if (RoundCreepChanceManaBurn != 1) then
            call UnitRemoveAbility(creep, MANA_BURN_CREEP_ABILITY_ID)
        endif

        // Hurl boulder
        if (RoundCreepChanceHurlBoulder != 1) then
            call UnitRemoveAbility(creep, HURL_BOULDER_CREEP_ABILITY_ID)
        endif

        // Rejuvination
        if (RoundCreepChanceRejuv != 1) then
            call UnitRemoveAbility(creep, REJUVENATION_CREEP_ABILITY_ID)
        endif

        // Slow
        if (RoundCreepChanceSlow != 1) then
            call UnitRemoveAbility(creep, 'A013')
        endif

        // Big bad v?
        if (RoundCreepChanceBigBadV != 1) then
            call UnitRemoveAbility(creep, 'A018')
        endif

        // Faerie fire
        if (RoundCreepChanceFaerieFire != 1) then
            call UnitRemoveAbility(creep, FAERIE_FIRE_CREEP_ABILITY_ID)
        endif

        // Blink
        if (RoundCreepChanceBlink != 1) then
            call UnitRemoveAbility(creep, 'A01A')
        endif

        // Thunder clap
        if (RoundCreepChanceThunderClap != 1) then
            call UnitRemoveAbility(creep, THUNDER_CLAP_CREEP_ABILITY_ID)
        endif

        // Cleanup
        set creep = null
    endfunction

    private function init takes nothing returns nothing
        set ModifyCreepAbilitiesTrigger = CreateTrigger()
        call TriggerAddAction(ModifyCreepAbilitiesTrigger, function ModifyCreepAbilitiesActions)
    endfunction

endlibrary
