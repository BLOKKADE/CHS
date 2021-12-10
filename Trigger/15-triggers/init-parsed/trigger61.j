library trigger61 initializer init requires RandomShit

    function Trig_Doesnt_Matter_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[3]))then
            return false
        endif
        return true
    endfunction


    function Trig_Doesnt_Matter_Actions takes nothing returns nothing
        set udg_integers07[3]=(udg_integers07[3]+ 1)
        call DialogDisplayBJ(true,IncomeDialog,GetTriggerPlayer())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger61 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger61,udg_dialog01)
        call TriggerAddCondition(udg_trigger61,Condition(function Trig_Doesnt_Matter_Conditions))
        call TriggerAddAction(udg_trigger61,function Trig_Doesnt_Matter_Actions)
    endfunction


endlibrary
