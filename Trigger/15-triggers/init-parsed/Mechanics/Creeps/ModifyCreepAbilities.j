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
            call UnitAddAbility(creep, 'AOcr')
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
            call UnitAddAbility(creep, 'A08F')
            call SetUnitAbilityLevel(creep, 'A08F', IMinBJ(R2I(RoundNumber * 0.4), 30))
        endif

        // --- Remove Abilities
        // Shockwave
        if (RoundCreepChanceShockwave != 1) then
            call UnitRemoveAbility(creep, 'A00U')
        endif

        // Mana burn
        if (RoundCreepChanceManaBurn != 1) then
            call UnitRemoveAbility(creep, 'A00V')
        endif

        // Hurl boulder
        if (RoundCreepChanceHurlBoulder != 1) then
            call UnitRemoveAbility(creep, 'A00W')
        endif

        // Rejuvination
        if (RoundCreepChanceRejuv != 1) then
            call UnitRemoveAbility(creep, 'A00X')
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
            call UnitRemoveAbility(creep, 'A016')
        endif

        // Blink
        if (RoundCreepChanceBlink != 1) then
            call UnitRemoveAbility(creep, 'A01A')
        endif

        // Thunder clap
        if (RoundCreepChanceThunderClap != 1) then
            call UnitRemoveAbility(creep, 'A01B')
        endif

        // Cleanup
        set creep = null
    endfunction

    private function init takes nothing returns nothing
        set ModifyCreepAbilitiesTrigger = CreateTrigger()
        call TriggerAddAction(ModifyCreepAbilitiesTrigger, function ModifyCreepAbilitiesActions)
    endfunction

endlibrary
