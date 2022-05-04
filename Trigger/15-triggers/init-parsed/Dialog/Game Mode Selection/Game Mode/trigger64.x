library trigger64 initializer init requires RandomShit

    function Trig_Elimination_Mode_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[5]))then
            return false
        endif
        return true
    endfunction


    function Trig_Elimination_Mode_Actions takes nothing returns nothing
        set ModeVotesCount[5]=(ModeVotesCount[5]+ 1)
        call DialogDisplayBJ(true,AbilModeDialog,GetTriggerPlayer())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger64 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger64,GameModeDialog)
        call TriggerAddCondition(udg_trigger64,Condition(function Trig_Elimination_Mode_Conditions))
        call TriggerAddAction(udg_trigger64,function Trig_Elimination_Mode_Actions)
    endfunction


endlibrary
