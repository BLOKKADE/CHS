library trigger38 initializer init requires RandomShit

    function Trig_Acquire_Item_Conditions takes nothing returns boolean
        if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Acquire_Item_Actions takes nothing returns nothing
        call SetItemUserData(GetManipulatedItem(),GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit())))
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger38 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger38,EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddCondition(udg_trigger38,Condition(function Trig_Acquire_Item_Conditions))
        call TriggerAddAction(udg_trigger38,function Trig_Acquire_Item_Actions)
    endfunction


endlibrary
