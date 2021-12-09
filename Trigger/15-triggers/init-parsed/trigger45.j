library trigger45 initializer init requires RandomShit

    function Trig_Place_Bet_PvP1_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons02[1]))then
            return false
        endif
        return true
    endfunction


    function Trig_Place_Bet_PvP1_Actions takes nothing returns nothing
        call DialogSetMessageBJ(udg_dialogs01[2],"Betting Menu")
        call DialogDisplayBJ(true,udg_dialogs01[2],GetTriggerPlayer())
        call ForceAddPlayerSimple(GetTriggerPlayer(),udg_force04)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger45 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger45,udg_dialogs01[1])
        call TriggerAddCondition(udg_trigger45,Condition(function Trig_Place_Bet_PvP1_Conditions))
        call TriggerAddAction(udg_trigger45,function Trig_Place_Bet_PvP1_Actions)
    endfunction


endlibrary
