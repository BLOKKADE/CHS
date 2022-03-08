library trigger128 initializer init requires RandomShit

    function Trig_Playtime_Command_Func002Func003C takes nothing returns boolean
        if(not(Playtime[1]==1))then
            return false
        endif
        if(not(Playtime[2]==1))then
            return false
        endif
        return true
    endfunction


    function Trig_Playtime_Command_Func002C takes nothing returns boolean
        if(not Trig_Playtime_Command_Func002Func003C())then
            return false
        endif
        return true
    endfunction


    function Trig_Playtime_Command_Func002Func001Func003C takes nothing returns boolean
        if(not(Playtime[1]==1))then
            return false
        endif
        if(not(Playtime[2]!=1))then
            return false
        endif
        return true
    endfunction


    function Trig_Playtime_Command_Func002Func001C takes nothing returns boolean
        if(not Trig_Playtime_Command_Func002Func001Func003C())then
            return false
        endif
        return true
    endfunction


    function Trig_Playtime_Command_Func002Func001Func001Func003C takes nothing returns boolean
        if(not(Playtime[1]!=1))then
            return false
        endif
        if(not(Playtime[2]==1))then
            return false
        endif
        return true
    endfunction


    function Trig_Playtime_Command_Func002Func001Func001C takes nothing returns boolean
        if(not Trig_Playtime_Command_Func002Func001Func001Func003C())then
            return false
        endif
        return true
    endfunction


    function Trig_Playtime_Command_Actions takes nothing returns nothing
        call ForceAddPlayerSimple(GetTriggerPlayer(),bj_FORCE_PLAYER[11])
        if(Trig_Playtime_Command_Func002C())then
            call DisplayTextToForce(bj_FORCE_PLAYER[11],("|c00F08000Current Playtime: " +((I2S(Playtime[1])+(" minute and " +(I2S(Playtime[2])+ " second")))+ "|r")))
        else
            if(Trig_Playtime_Command_Func002Func001C())then
                call DisplayTextToForce(bj_FORCE_PLAYER[11],("|c00F08000Current Playtime: " +((I2S(Playtime[1])+(" minute and " +(I2S(Playtime[2])+ " seconds")))+ "|r")))
            else
                if(Trig_Playtime_Command_Func002Func001Func001C())then
                    call DisplayTextToForce(bj_FORCE_PLAYER[11],("|c00F08000Current Playtime: " +((I2S(Playtime[1])+(" minutes and " +(I2S(Playtime[2])+ " second")))+ "|r")))
                else
                    call DisplayTextToForce(bj_FORCE_PLAYER[11],("|c00F08000Current Playtime: " +((I2S(Playtime[1])+(" minutes and " +(I2S(Playtime[2])+ " seconds")))+ "|r")))
                endif
            endif
        endif
        call ForceRemovePlayerSimple(GetTriggerPlayer(),bj_FORCE_PLAYER[11])
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger128 = CreateTrigger()
        call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(0),"-pt",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(0),"-time",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(1),"-pt",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(1),"-time",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(2),"-pt",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(2),"-time",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(3),"-pt",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(3),"-time",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(4),"-pt",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(4),"-time",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(5),"-pt",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(5),"-time",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(6),"-pt",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(6),"-time",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(7),"-pt",true)
        call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(7),"-time",true)
        call TriggerAddAction(udg_trigger128,function Trig_Playtime_Command_Actions)
    endfunction


endlibrary
