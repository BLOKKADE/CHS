library trigger142 initializer init requires RandomShit

    function Trig_Enter_Center_Conditions takes nothing returns boolean
        if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Enter_Center_Actions takes nothing returns nothing
        call SetUnitInvulnerable(GetTriggerUnit(),true)
        call SetUnitLifePercentBJ(GetTriggerUnit(),100)
        call SetUnitManaPercentBJ(GetTriggerUnit(),100)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger142 = CreateTrigger()
        call TriggerRegisterEnterRectSimple(udg_trigger142,RectMidArena)
        call TriggerAddCondition(udg_trigger142,Condition(function Trig_Enter_Center_Conditions))
        call TriggerAddAction(udg_trigger142,function Trig_Enter_Center_Actions)
    endfunction


endlibrary
