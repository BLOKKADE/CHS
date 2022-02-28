library trg2 initializer init requires RandomShit

    function Trig_Individual_Income_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[20]))then
            return false
        endif
        return true
    endfunction


    function Trig_Individual_Income_Actions takes nothing returns nothing
        set ModeVotesCount[16] = ModeVotesCount[16] + 1
        call ConditionalTriggerExecute(udg_trigger62)
    endfunction


    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterDialogEventBJ(trg,IncomeModeDialog)
        call TriggerAddCondition(trg,Condition(function Trig_Individual_Income_Conditions))
        call TriggerAddAction(trg,function Trig_Individual_Income_Actions)
        set trg = null
    endfunction


endlibrary
