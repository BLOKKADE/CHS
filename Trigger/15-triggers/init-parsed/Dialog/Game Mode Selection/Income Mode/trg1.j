library trg1 initializer init requires RandomShit

    function Trig_Income_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[19]))then
            return false
        endif
        return true
    endfunction


    function Trig_Income_Actions takes nothing returns nothing
        set ModeVotesCount[15] = ModeVotesCount[15] + 1
        call ConditionalTriggerExecute(udg_trigger62)
    endfunction


    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterDialogEventBJ(trg,IncomeModeDialog)
        call TriggerAddCondition(trg,Condition(function Trig_Income_Conditions))
        call TriggerAddAction(trg,function Trig_Income_Actions)
        set trg = null
    endfunction


endlibrary
