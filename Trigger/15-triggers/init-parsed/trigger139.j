library trigger139 initializer init requires RandomShit

    function Trig_Drop_Prize_Item_Conditions takes nothing returns boolean
        if(not(IsItemOwned(GetManipulatedItem())==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Drop_Prize_Item_Func001C takes nothing returns boolean
        if(not(udg_items01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==GetManipulatedItem()))then
            return false
        endif
        return true
    endfunction


    function Trig_Drop_Prize_Item_Actions takes nothing returns nothing
        if(Trig_Drop_Prize_Item_Func001C())then
            call UnitDropItemPointLoc(GetTriggerUnit(),GetManipulatedItem(),GetUnitLoc(GetTriggerUnit()))
            call UnitAddItemByIdSwapped(GetItemTypeId(GetManipulatedItem()),GetTriggerUnit())
            call RemoveItem(GetManipulatedItem())
        else
            call UnitDropItemPointLoc(GetTriggerUnit(),GetManipulatedItem(),GetUnitLoc(GetTriggerUnit()))
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger139 = CreateTrigger()
        call DisableTrigger(udg_trigger139)
        call TriggerRegisterAnyUnitEventBJ(udg_trigger139,EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddCondition(udg_trigger139,Condition(function Trig_Drop_Prize_Item_Conditions))
        call TriggerAddAction(udg_trigger139,function Trig_Drop_Prize_Item_Actions)
    endfunction


endlibrary
