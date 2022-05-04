library trigger74 initializer init requires RandomShit

    function Trig_Hide_Betting_Menu_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[12]))then
            return false
        endif
        return true
    endfunction


    function Trig_Hide_Betting_Menu_Actions takes nothing returns nothing
        set ModeVotesCount[10]=(ModeVotesCount[10]+ 1)
        set udg_integer63 =(udg_integer63 + 1)
        call ConditionalTriggerExecute(udg_trigger77)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger74 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger74,BettingModeDialog)
        call TriggerAddCondition(udg_trigger74,Condition(function Trig_Hide_Betting_Menu_Conditions))
        call TriggerAddAction(udg_trigger74,function Trig_Hide_Betting_Menu_Actions)
    endfunction


endlibrary
