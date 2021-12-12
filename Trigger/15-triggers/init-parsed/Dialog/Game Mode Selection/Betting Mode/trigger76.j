library trigger76 initializer init requires RandomShit

    function Trig_Doesnt_Matter_Betting_Menu_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[14]))then
            return false
        endif
        return true
    endfunction


    function Trig_Doesnt_Matter_Betting_Menu_Actions takes nothing returns nothing
        set udg_integers07[12]=(udg_integers07[12]+ 1)
        set udg_integer63 =(udg_integer63 + 1)
        call ConditionalTriggerExecute(udg_trigger77)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger76 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger76,udg_dialog05)
        call TriggerAddCondition(udg_trigger76,Condition(function Trig_Doesnt_Matter_Betting_Menu_Conditions))
        call TriggerAddAction(udg_trigger76,function Trig_Doesnt_Matter_Betting_Menu_Actions)
    endfunction


endlibrary
