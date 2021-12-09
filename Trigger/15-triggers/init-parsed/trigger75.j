library trigger75 initializer init requires RandomShit

    function Trig_Disable_Betting_Menu_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[13]))then
            return false
        endif
        return true
    endfunction


    function Trig_Disable_Betting_Menu_Actions takes nothing returns nothing
        set udg_integers07[11]=(udg_integers07[11]+ 1)
        set udg_integer63 =(udg_integer63 + 1)
        call ConditionalTriggerExecute(udg_trigger77)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger75 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger75,udg_dialog05)
        call TriggerAddCondition(udg_trigger75,Condition(function Trig_Disable_Betting_Menu_Conditions))
        call TriggerAddAction(udg_trigger75,function Trig_Disable_Betting_Menu_Actions)
    endfunction


endlibrary
