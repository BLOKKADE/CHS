library trigger67 initializer init requires RandomShit

    function Trig_Pick_Abilities_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[7]))then
            return false
        endif
        return true
    endfunction


    function Trig_Pick_Abilities_Actions takes nothing returns nothing
        set udg_integers07[6]=(udg_integers07[6]+ 1)
        call DialogDisplayBJ(true,udg_dialog07,GetTriggerPlayer())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger67 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger67,udg_dialog03)
        call TriggerAddCondition(udg_trigger67,Condition(function Trig_Pick_Abilities_Conditions))
        call TriggerAddAction(udg_trigger67,function Trig_Pick_Abilities_Actions)
    endfunction


endlibrary
