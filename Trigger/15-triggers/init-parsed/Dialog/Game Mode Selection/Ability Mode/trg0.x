library trg0 initializer init requires RandomShit

    function Trig_Draft_Abilities_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons01[22]))then
            return false
        endif
        return true
    endfunction


    function Trig_Draft_Abilities_Actions takes nothing returns nothing
        set ModeVotesCount[19]=(ModeVotesCount[19]+ 1)
        call DialogDisplayBJ(true,HeroModeDialog,GetTriggerPlayer())
    endfunction


    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterDialogEventBJ(trg,AbilModeDialog)
        call TriggerAddCondition(trg,Condition(function Trig_Draft_Abilities_Conditions))
        call TriggerAddAction(trg,function Trig_Draft_Abilities_Actions)
        set trg = null
    endfunction


endlibrary
