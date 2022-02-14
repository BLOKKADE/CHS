library trg4 initializer init requires RandomShit

    function Trig_Economy_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[10]))then
            return false
        endif
        return true
    endfunction


    function Trig_Economy_Actions takes nothing returns nothing
        set udg_integers07[20] = udg_integers07[20] + 1
        call ConditionalTriggerExecute(udg_trigger62)
    endfunction


    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterDialogEventBJ(trg,IncomeDialog)
        call TriggerAddCondition(trg,Condition(function Trig_Economy_Conditions))
        call TriggerAddAction(trg,function Trig_Economy_Actions)
        set trg = null
    endfunction


endlibrary
