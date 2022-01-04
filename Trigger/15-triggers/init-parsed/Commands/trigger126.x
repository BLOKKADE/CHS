library trigger126 initializer init requires RandomShit

    function Trig_Level_Command_Actions takes nothing returns nothing
        call ForceAddPlayerSimple(GetTriggerPlayer(),bj_FORCE_PLAYER[11])
        call DisplayTextToForce(bj_FORCE_PLAYER[11],("|c00F08000Level " +(I2S(udg_integer02)+ "|r")))
        call ForceRemovePlayerSimple(GetTriggerPlayer(),bj_FORCE_PLAYER[11])
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger126 = CreateTrigger()
        call DisableTrigger(udg_trigger126)
        call TriggerRegisterPlayerChatEvent(udg_trigger126,Player(0),"-level",true)
        call TriggerAddAction(udg_trigger126,function Trig_Level_Command_Actions)
    endfunction


endlibrary
