library trigger59 initializer init requires RandomShit

    function Trig_Dialog_25_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[1]))then
            return false
        endif
        return true
    endfunction


    function Trig_Dialog_25_Actions takes nothing returns nothing
        set ModeVotesCount[1]=(ModeVotesCount[1]+ 1)
        call DialogDisplayBJ(true,IncomeModeDialog,GetTriggerPlayer())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger59 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger59,GameDurDialog)
        call TriggerAddCondition(udg_trigger59,Condition(function Trig_Dialog_25_Conditions))
        call TriggerAddAction(udg_trigger59,function Trig_Dialog_25_Actions)
    endfunction


endlibrary
