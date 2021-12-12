library trigger13 initializer init requires RandomShit

    function Trig_Devastating_Blow_Add_Conditions takes nothing returns boolean
        if(not(IsUnitInGroup(GetTriggerUnit(),udg_group06)!=true))then
            return false
        endif
        return true
    endfunction


    function Trig_Devastating_Blow_Add_Actions takes nothing returns nothing
        call GroupAddUnitSimple(GetTriggerUnit(),udg_group06)
        call TriggerRegisterUnitEvent(udg_trigger11,GetTriggerUnit(),EVENT_UNIT_DAMAGED)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger13 = CreateTrigger()
        call TriggerRegisterEnterRectSimple(udg_trigger13,GetPlayableMapRect())
        call TriggerAddCondition(udg_trigger13,Condition(function Trig_Devastating_Blow_Add_Conditions))
        call TriggerAddAction(udg_trigger13,function Trig_Devastating_Blow_Add_Actions)
    endfunction


endlibrary
