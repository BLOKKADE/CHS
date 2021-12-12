library trigger68 initializer init requires RandomShit

    function Trig_Random_Abilities_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[8]))then
            return false
        endif
        return true
    endfunction


    function Trig_Random_Abilities_Actions takes nothing returns nothing
        set udg_integers07[7]=(udg_integers07[7]+ 1)
        call DialogDisplayBJ(true,udg_dialog07,GetTriggerPlayer())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger68 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger68,udg_dialog03)
        call TriggerAddCondition(udg_trigger68,Condition(function Trig_Random_Abilities_Conditions))
        call TriggerAddAction(udg_trigger68,function Trig_Random_Abilities_Actions)
    endfunction


endlibrary
