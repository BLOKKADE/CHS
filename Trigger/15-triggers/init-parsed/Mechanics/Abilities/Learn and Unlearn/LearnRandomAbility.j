library LearnRandomAbility initializer init requires RandomShit

    private function LearnRandomAbilityActions takes nothing returns nothing
        local integer playerId = GetPlayerId(GetOwningPlayer(TempUnit))
        local integer unitAbilityLevel

        set RoundCreepAbilCastChance = GetItemFromAbility(GetRandomAbility())

        set unitAbilityLevel = GetUnitAbilityLevel(TempUnit, GetAbilityFromItem(RoundCreepAbilCastChance))

        // Hero doesn't have ability, ability is valid, hero has less than 10 abilities
        if ((unitAbilityLevel == 0) and (RoundCreepAbilCastChance != GetItemTypeId(null)) and (HeroAbilityCount[playerId + 1] < 10)) then
            if (ArNotLearningAbil == true) then
                set ArNotLearningAbil = false
                set ARLearningAbil = true
                call UnitAddItemByIdSwapped(RoundCreepAbilCastChance, PlayerHeroes[playerId + 1])
                set ARLearningAbil = false
                set ArNotLearningAbil = true
            else
                call UnitAddItemByIdSwapped(RoundCreepAbilCastChance, PlayerHeroes[playerId + 1])
            endif
        // Hero has 10 or more abilities, hero has ability, upgrade it?
        elseif ((HeroAbilityCount[playerId + 1] >= 10) and (unitAbilityLevel > 0) and (unitAbilityLevel < 30) and (TryLearnRandomAbilityAttempts <= 500)) then
            if (ArNotLearningAbil == true) then
                set ArNotLearningAbil = false
                set ARLearningAbil = true
                call UnitAddItemByIdSwapped(RoundCreepAbilCastChance, PlayerHeroes[playerId + 1])
                set ARLearningAbil = false
                set ArNotLearningAbil = true
            else
                call AdjustPlayerStateBJ(5, GetOwningPlayer(TempUnit), PLAYER_STATE_RESOURCE_LUMBER)
                call ResourseRefresh(GetOwningPlayer(TempUnit))
                call DisplayTimedTextToPlayer(GetOwningPlayer(TempUnit), 0, 0, 2.00, "|cffffcc00Failed to learn!")
                return
            endif
        // Reached max attempts trying to get a random ability
        elseif (TryLearnRandomAbilityAttempts > 500) then
            call AdjustPlayerStateBJ(5, GetOwningPlayer(TempUnit), PLAYER_STATE_RESOURCE_LUMBER)
            call ResourseRefresh(GetOwningPlayer(TempUnit))
            call DisplayTimedTextToPlayer(GetOwningPlayer(TempUnit), 0, 0, 2.00, "|cffffcc00Failed to learn!")
            return
        // Try again
        else
            set TryLearnRandomAbilityAttempts = TryLearnRandomAbilityAttempts + 1
            call ConditionalTriggerExecute(GetTriggeringTrigger())
        endif
    endfunction

    private function init takes nothing returns nothing
        set LearnRandomAbilityTrigger = CreateTrigger()
        call TriggerAddAction(LearnRandomAbilityTrigger,function LearnRandomAbilityActions)
    endfunction

endlibrary
