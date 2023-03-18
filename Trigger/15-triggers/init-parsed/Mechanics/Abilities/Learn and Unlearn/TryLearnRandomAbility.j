library TryLearnRandomAbility initializer init requires RandomShit

    private function TryLearnRandomAbilityConditions takes nothing returns boolean
        return GetItemTypeId(GetManipulatedItem()) == 'I02J'
    endfunction

    private function TryLearnRandomAbilityActions takes nothing returns nothing
        if (AbilityMode != 2) then
            set TryLearnRandomAbilityAttempts = 0
            set TempUnit = GetTriggerUnit()
            call ConditionalTriggerExecute(LearnRandomAbilityTrigger)
        else
            call AdjustPlayerStateBJ(5 * 30, GetOwningPlayer(GetTriggerUnit()), PLAYER_STATE_RESOURCE_GOLD)
            call DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, "Random is unavailable in Draft mode")
        endif
    endfunction

    private function init takes nothing returns nothing
        set TryLearnRandomAbilityTrigger = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(TryLearnRandomAbilityTrigger,EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddCondition(TryLearnRandomAbilityTrigger,Condition(function TryLearnRandomAbilityConditions))
        call TriggerAddAction(TryLearnRandomAbilityTrigger,function TryLearnRandomAbilityActions)
    endfunction

endlibrary
