library trigger125 initializer init requires RandomShit

    function Trig_Hint_Command_Func001Func004001001 takes nothing returns boolean
        return(GetFilterPlayer()==GetTriggerPlayer())
    endfunction


    function Trig_Hint_Command_Func001Func002001001 takes nothing returns boolean
        return(GetFilterPlayer()==GetTriggerPlayer())
    endfunction


    function Trig_Hint_Command_Actions takes nothing returns nothing
        if(Trig_Hint_Command_Func001C())then
            call ForceRemovePlayerSimple(GetTriggerPlayer(),udg_force06)
            call DisplayTimedTextToForce(GetPlayersMatching(Condition(function Trig_Hint_Command_Func001Func004001001)),3.00,"|cff959697Display Hints: ON|r")
        else
            call ForceAddPlayerSimple(GetTriggerPlayer(),udg_force06)
            call DisplayTimedTextToForce(GetPlayersMatching(Condition(function Trig_Hint_Command_Func001Func002001001)),3.00,"|cff959697Display Hints: OFF|r")
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger125 = CreateTrigger()
        call TriggerRegisterPlayerChatEvent(udg_trigger125,Player(0),"-hint",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger125,Player(1),"-hint",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger125,Player(2),"-hint",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger125,Player(3),"-hint",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger125,Player(4),"-hint",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger125,Player(5),"-hint",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger125,Player(6),"-hint",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger125,Player(7),"-hint",true)
        call TriggerAddAction(udg_trigger125,function Trig_Hint_Command_Actions)*/
    endfunction


endlibrary
