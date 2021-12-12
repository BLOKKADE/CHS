library trigger58 initializer init requires RandomShit

    function Trig_Everyone_Votes_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons04[0]))then
            return false
        endif
        return true
    endfunction


    function Trig_Everyone_Votes_Actions takes nothing returns nothing
        set udg_boolean15 = true
        call ConditionalTriggerExecute(udg_trigger55)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger58 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger58,udg_dialog06)
        call TriggerAddCondition(udg_trigger58,Condition(function Trig_Everyone_Votes_Conditions))
        call TriggerAddAction(udg_trigger58,function Trig_Everyone_Votes_Actions)
    endfunction


endlibrary
