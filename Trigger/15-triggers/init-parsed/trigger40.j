library trigger40 initializer init requires RandomShit

    function Trig_Give_Item_Conditions takes nothing returns boolean
        if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Give_Item_Actions takes nothing returns nothing
        call TriggerSleepAction(0.00)
        if(Trig_Give_Item_Func002C())then
            call SetItemUserData(GetManipulatedItem(),0)
        else
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger40 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger40,EVENT_PLAYER_UNIT_DROP_ITEM)
        call TriggerAddCondition(udg_trigger40,Condition(function Trig_Give_Item_Conditions))
        call TriggerAddAction(udg_trigger40,function Trig_Give_Item_Actions)
    endfunction


endlibrary
