library trigger127 initializer init requires RandomShit

    function Trig_Movement_Speed_Command_Conditions takes nothing returns boolean
        if(not(IsUnitAliveBJ(PlayerHeroes[GetConvertedPlayerId(GetTriggerPlayer())])==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Movement_Speed_Command_Actions takes nothing returns nothing
        call ForceAddPlayerSimple(GetTriggerPlayer(),bj_FORCE_PLAYER[11])
        call DisplayTextToForce(bj_FORCE_PLAYER[11],("|c00F08000Current Movement Speed: " +(I2S(R2I(GetUnitMoveSpeed(PlayerHeroes[GetConvertedPlayerId(GetTriggerPlayer())])))+ "|r")))
        call ForceRemovePlayerSimple(GetTriggerPlayer(),bj_FORCE_PLAYER[11])
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger127 = CreateTrigger()
        call DisableTrigger(udg_trigger127)
        call TriggerRegisterPlayerChatEvent(udg_trigger127,Player(0),"-ms",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger127,Player(1),"-ms",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger127,Player(2),"-ms",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger127,Player(3),"-ms",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger127,Player(4),"-ms",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger127,Player(5),"-ms",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger127,Player(6),"-ms",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger127,Player(7),"-ms",true)
        call TriggerAddCondition(udg_trigger127,Condition(function Trig_Movement_Speed_Command_Conditions))
        call TriggerAddAction(udg_trigger127,function Trig_Movement_Speed_Command_Actions)
    endfunction


endlibrary
