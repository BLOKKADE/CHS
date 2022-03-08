library trigger46 initializer init requires RandomShit

    function Trig_Place_Bet_PvP2_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==DialogButtons[2]))then
            return false
        endif
        return true
    endfunction


    function Trig_Place_Bet_PvP2_Actions takes nothing returns nothing
        call DialogSetMessageBJ(Dialogs[2],"Betting Menu")
        call DialogDisplayBJ(true,Dialogs[2],GetTriggerPlayer())
        call ForceAddPlayerSimple(GetTriggerPlayer(),udg_force05)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger46 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger46,Dialogs[1])
        call TriggerAddCondition(udg_trigger46,Condition(function Trig_Place_Bet_PvP2_Conditions))
        call TriggerAddAction(udg_trigger46,function Trig_Place_Bet_PvP2_Actions)
    endfunction


endlibrary
