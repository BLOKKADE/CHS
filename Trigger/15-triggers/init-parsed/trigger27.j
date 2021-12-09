library trigger27 initializer init requires RandomShit

    function Trig_Pulverize_Add_Conditions takes nothing returns boolean
        if(not(IsUnitInGroup(GetTriggerUnit(),udg_group04)!=true))then
            return false
        endif
        if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_GROUND)==true))then
            return false
        endif
        if(not Trig_Pulverize_Add_Func003C())then
            return false
        endif
        return true
    endfunction


    function Trig_Pulverize_Add_Actions takes nothing returns nothing
        call GroupAddUnitSimple(GetTriggerUnit(),udg_group04)
        call TriggerRegisterUnitEvent(udg_trigger26,GetTriggerUnit(),EVENT_UNIT_DAMAGED)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger27 = CreateTrigger()
        call TriggerRegisterEnterRectSimple(udg_trigger27,GetPlayableMapRect())
        call TriggerAddCondition(udg_trigger27,Condition(function Trig_Pulverize_Add_Conditions))
        call TriggerAddAction(udg_trigger27,function Trig_Pulverize_Add_Actions)
    endfunction


endlibrary
