library trigger71 initializer init requires RandomShit

    function Trig_Random_Hero_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[16]))then
            return false
        endif
        return true
    endfunction


    function Trig_Random_Hero_Actions takes nothing returns nothing
        set ModeVotesCount[14]=(ModeVotesCount[14]+ 1)
        call DialogDisplayBJ(true,GameDurDialog,GetTriggerPlayer())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger71 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger71,HeroModeDialog)
        call TriggerAddCondition(udg_trigger71,Condition(function Trig_Random_Hero_Conditions))
        call TriggerAddAction(udg_trigger71,function Trig_Random_Hero_Actions)
    endfunction


endlibrary
