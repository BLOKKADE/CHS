library trigger113 initializer init requires RandomShit

    function Trig_Random_Ability_Conditions takes nothing returns boolean
        if(not('I02J'==GetItemTypeId(GetManipulatedItem())))then
            return false
        endif
        return true
    endfunction


    function Trig_Random_Ability_Actions takes nothing returns nothing
        if AbilityMode != 2 then
            set udg_integer37 = 0
            set udg_unit01 = GetTriggerUnit()
            call ConditionalTriggerExecute(udg_trigger114)
        else
            call AdjustPlayerStateBJ(5, GetOwningPlayer(GetTriggerUnit()), PLAYER_STATE_RESOURCE_LUMBER)
            call DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, "Random is unavailable in Draft mode")
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger113 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger113,EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddCondition(udg_trigger113,Condition(function Trig_Random_Ability_Conditions))
        call TriggerAddAction(udg_trigger113,function Trig_Random_Ability_Actions)
    endfunction


endlibrary
