library trigger65 initializer init requires RandomShit

    function Trig_Immortal_Mode_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[18]))then
            return false
        endif
        return true
    endfunction


    function Trig_Immortal_Mode_Actions takes nothing returns nothing
        set ModeVotesCount[8]=(ModeVotesCount[8]+ 1)
        call DialogDisplayBJ(true,AbilModeDialog,GetTriggerPlayer())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger65 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger65,GameModeDialog)
        call TriggerAddCondition(udg_trigger65,Condition(function Trig_Immortal_Mode_Conditions))
        call TriggerAddAction(udg_trigger65,function Trig_Immortal_Mode_Actions)
    endfunction


endlibrary
