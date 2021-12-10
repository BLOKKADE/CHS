library trigger65 initializer init requires RandomShit

    function Trig_Death_Match_Mode_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[10]))then
            return false
        endif
        return true
    endfunction


    function Trig_Death_Match_Mode_Actions takes nothing returns nothing
        set udg_integers07[8]=(udg_integers07[8]+ 1)
        call DialogDisplayBJ(true,udg_dialog03,GetTriggerPlayer())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger65 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger65,udg_dialog02)
        call TriggerAddCondition(udg_trigger65,Condition(function Trig_Death_Match_Mode_Conditions))
        call TriggerAddAction(udg_trigger65,function Trig_Death_Match_Mode_Actions)
    endfunction


endlibrary
