library trigger63 initializer init requires RandomShit

    function Trig_Normal_Mode_Conditions takes nothing returns boolean
        if (GetClickedButtonBJ()==udg_buttons01[4])  then
    
            
            return true
        endif
    
    
        return false
    endfunction


    function Trig_Normal_Mode_Actions takes nothing returns nothing
        set udg_integers07[4]=(udg_integers07[4]+ 1)
        call DialogDisplayBJ(true,udg_dialog03,GetTriggerPlayer())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger63 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger63,udg_dialog02)
        call TriggerAddCondition(udg_trigger63,Condition(function Trig_Normal_Mode_Conditions))
        call TriggerAddAction(udg_trigger63,function Trig_Normal_Mode_Actions)
    endfunction


endlibrary
