library trigger59 initializer init requires RandomShit

    function Trig_Dialog_25_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[1]))then
            return false
        endif
        return true
    endfunction


    function Trig_Dialog_25_Actions takes nothing returns nothing
        set udg_integers07[1]=(udg_integers07[1]+ 1)
        call DialogDisplayBJ(true,IncomeDialog,GetTriggerPlayer())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger59 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger59,udg_dialog01)
        call TriggerAddCondition(udg_trigger59,Condition(function Trig_Dialog_25_Conditions))
        call TriggerAddAction(udg_trigger59,function Trig_Dialog_25_Actions)
    endfunction


endlibrary
