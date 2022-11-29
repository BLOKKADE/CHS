library trigger67 initializer init requires RandomShit

    function Trig_Pick_Abilities_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[7]))then
            return false
        endif
        return true
    endfunction


    function Trig_Pick_Abilities_Actions takes nothing returns nothing
        set ModeVotesCount[6]=(ModeVotesCount[6]+ 1)
        call DialogDisplayBJ(true,HeroModeDialog,GetTriggerPlayer())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger67 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger67,AbilModeDialog)
        call TriggerAddCondition(udg_trigger67,Condition(function Trig_Pick_Abilities_Conditions))
        call TriggerAddAction(udg_trigger67,function Trig_Pick_Abilities_Actions)
    endfunction


endlibrary
