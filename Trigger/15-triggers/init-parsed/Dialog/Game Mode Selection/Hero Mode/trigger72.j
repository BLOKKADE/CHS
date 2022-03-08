library trigger72 initializer init requires RandomShit

    function Trig_Doesnt_Matter_Hero_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[17]))then
            return false
        endif
        return true
    endfunction


    function Trig_Doesnt_Matter_Hero_Actions takes nothing returns nothing
        call DialogDisplayBJ(true,GameDurDialog,GetTriggerPlayer())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger72 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger72,HeroModeDialog)
        call TriggerAddCondition(udg_trigger72,Condition(function Trig_Doesnt_Matter_Hero_Conditions))
        call TriggerAddAction(udg_trigger72,function Trig_Doesnt_Matter_Hero_Actions)
    endfunction


endlibrary
