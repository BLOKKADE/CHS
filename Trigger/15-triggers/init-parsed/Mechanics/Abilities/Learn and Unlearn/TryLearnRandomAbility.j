library TryLearnRandomAbility initializer init requires RandomShit

    function Trig_Random_Ability_Conditions takes nothing returns boolean
        if(not('I02J'==GetItemTypeId(GetManipulatedItem())))then
            return false
        endif
        return true
    endfunction

    function Trig_Random_Ability_Actions takes nothing returns nothing
        if AbilityMode != 2 then
            set UnknownInteger02 = 0
            set TempUnit = GetTriggerUnit()
            call ConditionalTriggerExecute(LearnRandomAbilityTrigger)
        else
            call AdjustPlayerStateBJ(5, GetOwningPlayer(GetTriggerUnit()), PLAYER_STATE_RESOURCE_LUMBER)
            call DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, "Random is unavailable in Draft mode")
        endif
    endfunction

    private function init takes nothing returns nothing
        set TryLearnRandomAbilityTrigger = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(TryLearnRandomAbilityTrigger,EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddCondition(TryLearnRandomAbilityTrigger,Condition(function Trig_Random_Ability_Conditions))
        call TriggerAddAction(TryLearnRandomAbilityTrigger,function Trig_Random_Ability_Actions)
    endfunction

endlibrary
