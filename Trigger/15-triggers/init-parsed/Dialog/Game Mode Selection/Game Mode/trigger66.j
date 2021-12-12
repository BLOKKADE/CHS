library trigger66 initializer init requires RandomShit

    function Trig_Doesnt_Matter_Mode_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[6]))then
            return false
        endif
        return true
    endfunction


    function Trig_Doesnt_Matter_Mode_Actions takes nothing returns nothing
        call DialogDisplayBJ(true,udg_dialog03,GetTriggerPlayer())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger66 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger66,udg_dialog02)
        call TriggerAddCondition(udg_trigger66,Condition(function Trig_Doesnt_Matter_Mode_Conditions))
        call TriggerAddAction(udg_trigger66,function Trig_Doesnt_Matter_Mode_Actions)
    endfunction


endlibrary
