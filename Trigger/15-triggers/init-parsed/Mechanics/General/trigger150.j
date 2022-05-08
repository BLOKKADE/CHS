/*library trigger150 initializer init requires RandomShit

    function Trig_Remove_HintEffect_Conditions takes nothing returns boolean
        if(not(GetTriggerUnit()==udg_unit03))then
            return false
        endif
        return true
    endfunction


    function Trig_Remove_HintEffect_Actions takes nothing returns nothing
        call DeleteUnit(GetTriggerUnit())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger150 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger150,EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(udg_trigger150,Condition(function Trig_Remove_HintEffect_Conditions))
        call TriggerAddAction(udg_trigger150,function Trig_Remove_HintEffect_Actions)
    endfunction


endlibrary
*/