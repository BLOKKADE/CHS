library trg0 initializer init requires RandomShit

    function Trig_Draft_Abilities_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[22]))then
            return false
        endif
        return true
    endfunction


    function Trig_Draft_Abilities_Actions takes nothing returns nothing
        set udg_integers07[19]=(udg_integers07[19]+ 1)
        call DialogDisplayBJ(true,udg_dialog07,GetTriggerPlayer())
    endfunction


    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterDialogEventBJ(trg,udg_dialog03)
        call TriggerAddCondition(trg,Condition(function Trig_Draft_Abilities_Conditions))
        call TriggerAddAction(trg,function Trig_Draft_Abilities_Actions)
        set trg0 = null
    endfunction


endlibrary
