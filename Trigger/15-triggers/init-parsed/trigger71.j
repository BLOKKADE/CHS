library trigger71 initializer init requires RandomShit

    function Trig_Random_Hero_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[16]))then
            return false
        endif
        return true
    endfunction


    function Trig_Random_Hero_Actions takes nothing returns nothing
        set udg_integers07[14]=(udg_integers07[14]+ 1)
        call DialogDisplayBJ(true,udg_dialog01,GetTriggerPlayer())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger71 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger71,udg_dialog07)
        call TriggerAddCondition(udg_trigger71,Condition(function Trig_Random_Hero_Conditions))
        call TriggerAddAction(udg_trigger71,function Trig_Random_Hero_Actions)
    endfunction


endlibrary
