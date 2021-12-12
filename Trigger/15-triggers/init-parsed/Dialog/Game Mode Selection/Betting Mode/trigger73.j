library trigger73 initializer init requires RandomShit

    function Trig_Show_Betting_Menu_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[11]))then
            return false
        endif
        return true
    endfunction


    function Trig_Show_Betting_Menu_Actions takes nothing returns nothing
        set udg_integers07[9]=(udg_integers07[9]+ 1)
        set udg_integer63 =(udg_integer63 + 1)
        call ConditionalTriggerExecute(udg_trigger77)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger73 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger73,udg_dialog05)
        call TriggerAddCondition(udg_trigger73,Condition(function Trig_Show_Betting_Menu_Conditions))
        call TriggerAddAction(udg_trigger73,function Trig_Show_Betting_Menu_Actions)
    endfunction


endlibrary
