/*library trigger24 initializer init requires RandomShit

    function Trig_Plague_Remove_Conditions takes nothing returns boolean
        if(not(GetUnitTypeId(GetTriggerUnit())=='n01L'))then
            return false
        endif
        return true
    endfunction


    function Trig_Plague_Remove_Actions takes nothing returns nothing
        call TriggerSleepAction(0.94)
        call DeleteUnit(GetTriggerUnit())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger24 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger24,EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(udg_trigger24,Condition(function Trig_Plague_Remove_Conditions))
        call TriggerAddAction(udg_trigger24,function Trig_Plague_Remove_Actions)
    endfunction


endlibrary
*/