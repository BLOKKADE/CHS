library trigger60 initializer init requires RandomShit

    function Trig_Dialog_50_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[2]))then
            return false
        endif
        return true
    endfunction


    function Trig_Dialog_50_Actions takes nothing returns nothing
        set udg_integers07[2]=(udg_integers07[2]+ 1)
        call DialogDisplayBJ(true,IncomeDialog,GetTriggerPlayer())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger60 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger60,udg_dialog01)
        call TriggerAddCondition(udg_trigger60,Condition(function Trig_Dialog_50_Conditions))
        call TriggerAddAction(udg_trigger60,function Trig_Dialog_50_Actions)
    endfunction


endlibrary
