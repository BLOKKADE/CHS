library trigger124 initializer init requires RandomShit

    function Trig_Clear_Command_Func001001001 takes nothing returns boolean
        return(GetFilterPlayer()==GetTriggerPlayer())
    endfunction


    function Trig_Clear_Command_Actions takes nothing returns nothing
        call ClearTextMessagesBJ(GetPlayersMatching(Condition(function Trig_Clear_Command_Func001001001)))
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger124 = CreateTrigger()
        call TriggerRegisterPlayerChatEvent(udg_trigger124,Player(0),"-clear",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger124,Player(1),"-clear",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger124,Player(2),"-clear",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger124,Player(3),"-clear",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger124,Player(4),"-clear",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger124,Player(5),"-clear",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger124,Player(6),"-clear",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger124,Player(7),"-clear",true)
        call TriggerAddAction(udg_trigger124,function Trig_Clear_Command_Actions)
        /*
    endfunction


endlibrary
