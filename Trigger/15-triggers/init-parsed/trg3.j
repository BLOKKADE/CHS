library trg3 initializer init requires RandomShit

    function Trig_No_Income_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[21]))then
            return false
        endif
        return true
    endfunction


    function Trig_No_Income_Actions takes nothing returns nothing
        set udg_integers07[17] = udg_integers07[17] + 1
        call ConditionalTriggerExecute(udg_trigger62)
    endfunction


    private function init takes nothing returns nothing
        local trigger trg3 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(trg,IncomeDialog)
        call TriggerAddCondition(trg,Condition(function Trig_No_Income_Conditions))
        call TriggerAddAction(trg,function Trig_No_Income_Actions)
        set trg3 = null
    endfunction


endlibrary
