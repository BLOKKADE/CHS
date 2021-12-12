library trigger144 initializer init requires RandomShit

    function Trig_Remove_Power_Ups_Conditions takes nothing returns boolean
        if(not(GetItemType(GetManipulatedItem())==ITEM_TYPE_POWERUP))then
            return false
        endif
        return true
    endfunction


    function Trig_Remove_Power_Ups_Actions takes nothing returns nothing
        call RemoveItem(GetManipulatedItem())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger144 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger144,EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddCondition(udg_trigger144,Condition(function Trig_Remove_Power_Ups_Conditions))
        call TriggerAddAction(udg_trigger144,function Trig_Remove_Power_Ups_Actions)
    endfunction


endlibrary
