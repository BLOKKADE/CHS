library trigger64 initializer init requires RandomShit

    function Trig_Elimination_Mode_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[5]))then
            return false
        endif
        return true
    endfunction


    function Trig_Elimination_Mode_Actions takes nothing returns nothing
        set udg_integers07[5]=(udg_integers07[5]+ 1)
        call DialogDisplayBJ(true,udg_dialog03,GetTriggerPlayer())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger64 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger64,udg_dialog02)
        call TriggerAddCondition(udg_trigger64,Condition(function Trig_Elimination_Mode_Conditions))
        call TriggerAddAction(udg_trigger64,function Trig_Elimination_Mode_Actions)
    endfunction


endlibrary
