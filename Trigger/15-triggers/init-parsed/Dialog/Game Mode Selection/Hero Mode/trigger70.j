library trigger70 initializer init requires RandomShit

    function Trig_Pick_Hero_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[15]))then
            return false
        endif
        return true
    endfunction


    function Trig_Pick_Hero_Actions takes nothing returns nothing
        set udg_integers07[13]=(udg_integers07[13]+ 1)
        call DialogDisplayBJ(true,udg_dialog01,GetTriggerPlayer())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger70 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger70,udg_dialog07)
        call TriggerAddCondition(udg_trigger70,Condition(function Trig_Pick_Hero_Conditions))
        call TriggerAddAction(udg_trigger70,function Trig_Pick_Hero_Actions)
    endfunction


endlibrary
