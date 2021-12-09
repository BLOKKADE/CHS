library trigger69 initializer init requires RandomShit

    function Trig_Doesnt_Matter_Abilities_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[9]))then
            return false
        endif
        return true
    endfunction


    function Trig_Doesnt_Matter_Abilities_Actions takes nothing returns nothing
        call DialogDisplayBJ(true,udg_dialog07,GetTriggerPlayer())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger69 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger69,udg_dialog03)
        call TriggerAddCondition(udg_trigger69,Condition(function Trig_Doesnt_Matter_Abilities_Conditions))
        call TriggerAddAction(udg_trigger69,function Trig_Doesnt_Matter_Abilities_Actions)
    endfunction


endlibrary
