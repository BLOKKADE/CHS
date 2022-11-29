library trigger60 initializer init requires RandomShit

    function Trig_Dialog_50_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[2]))then
            return false
        endif
        return true
    endfunction


    function Trig_Dialog_50_Actions takes nothing returns nothing
        set ModeVotesCount[2]=(ModeVotesCount[2]+ 1)
        call DialogDisplayBJ(true,IncomeModeDialog,GetTriggerPlayer())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger60 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger60,GameDurDialog)
        call TriggerAddCondition(udg_trigger60,Condition(function Trig_Dialog_50_Conditions))
        call TriggerAddAction(udg_trigger60,function Trig_Dialog_50_Actions)
    endfunction


endlibrary
