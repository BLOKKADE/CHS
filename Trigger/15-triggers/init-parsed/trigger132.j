library trigger132 initializer init requires RandomShit

    function Trig_Kick_Player_Command_Conditions takes nothing returns boolean
        if(not(GetTriggerPlayer()==udg_player03))then
            return false
        endif
        return true
    endfunction


    function KickPlayer takes player p returns nothing
        set udg_boolean17 = true
        call PlaySoundBJ(udg_sound04)
        call ForceAddPlayerSimple(p,udg_force07)
        call CustomDefeatBJ(p,"Kicked!")
        call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(p)+ "|cffffcc00 was kicked out of the game!|r")))
    endfunction


    function KickPlayer takes player p returns nothing
        set udg_boolean17 = true
        call PlaySoundBJ(udg_sound04)
        call ForceAddPlayerSimple(p,udg_force07)
        call CustomDefeatBJ(p,"Kicked!")
        call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(p)+ "|cffffcc00 was kicked out of the game!|r")))
    endfunction


    function KickPlayer takes player p returns nothing
        set udg_boolean17 = true
        call PlaySoundBJ(udg_sound04)
        call ForceAddPlayerSimple(p,udg_force07)
        call CustomDefeatBJ(p,"Kicked!")
        call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(p)+ "|cffffcc00 was kicked out of the game!|r")))
    endfunction


    function KickPlayer takes player p returns nothing
        set udg_boolean17 = true
        call PlaySoundBJ(udg_sound04)
        call ForceAddPlayerSimple(p,udg_force07)
        call CustomDefeatBJ(p,"Kicked!")
        call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(p)+ "|cffffcc00 was kicked out of the game!|r")))
    endfunction


    function KickPlayer takes player p returns nothing
        set udg_boolean17 = true
        call PlaySoundBJ(udg_sound04)
        call ForceAddPlayerSimple(p,udg_force07)
        call CustomDefeatBJ(p,"Kicked!")
        call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(p)+ "|cffffcc00 was kicked out of the game!|r")))
    endfunction


    function KickPlayer takes player p returns nothing
        set udg_boolean17 = true
        call PlaySoundBJ(udg_sound04)
        call ForceAddPlayerSimple(p,udg_force07)
        call CustomDefeatBJ(p,"Kicked!")
        call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(p)+ "|cffffcc00 was kicked out of the game!|r")))
    endfunction


    function KickPlayer takes player p returns nothing
        set udg_boolean17 = true
        call PlaySoundBJ(udg_sound04)
        call ForceAddPlayerSimple(p,udg_force07)
        call CustomDefeatBJ(p,"Kicked!")
        call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(p)+ "|cffffcc00 was kicked out of the game!|r")))
    endfunction


    function KickPlayer takes player p returns nothing
        set udg_boolean17 = true
        call PlaySoundBJ(udg_sound04)
        call ForceAddPlayerSimple(p,udg_force07)
        call CustomDefeatBJ(p,"Kicked!")
        call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(p)+ "|cffffcc00 was kicked out of the game!|r")))
    endfunction


    function Trig_Kick_Player_Command_Func002001001001001 takes nothing returns boolean
        return(IsPlayerInForce(GetFilterPlayer(),udg_force07)!=true)
    endfunction


    function Trig_Kick_Player_Command_Func002A takes nothing returns nothing
        set udg_boolean17 = true
        call PlaySoundBJ(udg_sound04)
        call ForceAddPlayerSimple(GetEnumPlayer(),udg_force07)
        call CustomDefeatBJ(GetEnumPlayer(),"Kicked!")
        call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(GetEnumPlayer())+ "|cffffcc00 was kicked out of the game!|r")))
    endfunction


    function Trig_Kick_Player_Command_Func003001 takes nothing returns boolean
        return(udg_boolean17==true)
    endfunction


    function Trig_Kick_Player_Command_Func004001001 takes nothing returns boolean
        return(GetFilterPlayer()==GetTriggerPlayer())
    endfunction


    function Trig_Kick_Player_Command_Actions takes nothing returns nothing
        local string command = SubStringBJ(GetEventPlayerChatString(),7,StringLength(GetEventPlayerChatString()))
        set udg_boolean17 = false
        if command == "red" then
            call KickPlayer(Player(0))
        elseif command == "blue" then
            call KickPlayer(Player(1))
        elseif command == "teal" then
            call KickPlayer(Player(2))
        elseif command == "purple" then
            call KickPlayer(Player(3))
        elseif command == "yellow" then
            call KickPlayer(Player(4))
        elseif command == "orange" then
            call KickPlayer(Player(5))
        elseif command == "green" then
            call KickPlayer(Player(6))
        elseif command == "pink" then
            call KickPlayer(Player(7))
        else
            call ForForce(GetPlayersMatching(Condition(function Trig_Kick_Player_Command_Func002001001)),function Trig_Kick_Player_Command_Func002A)
            if(Trig_Kick_Player_Command_Func003001())then
                return
            else
                call DoNothing()
            endif
            call DisplayTimedTextToForce(GetPlayersMatching(Condition(function Trig_Kick_Player_Command_Func004001001)),5.00,("|cffffcc00" +("Couldn't kick player \"" +(SubStringBJ(GetEventPlayerChatString(),7,StringLength(GetEventPlayerChatString()))+ "\"|r"))))
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger132 = CreateTrigger()
        call DisableTrigger(udg_trigger132)
        call TriggerRegisterPlayerChatEvent(udg_trigger132,Player(0),"-kick",false)
        call TriggerRegisterPlayerChatEvent(udg_trigger132,Player(1),"-kick",false)
        call TriggerRegisterPlayerChatEvent(udg_trigger132,Player(2),"-kick",false)
        call TriggerRegisterPlayerChatEvent(udg_trigger132,Player(3),"-kick",false)
        call TriggerRegisterPlayerChatEvent(udg_trigger132,Player(4),"-kick",false)
        call TriggerRegisterPlayerChatEvent(udg_trigger132,Player(5),"-kick",false)
        call TriggerRegisterPlayerChatEvent(udg_trigger132,Player(6),"-kick",false)
        call TriggerRegisterPlayerChatEvent(udg_trigger132,Player(7),"-kick",false)
        call TriggerAddCondition(udg_trigger132,Condition(function Trig_Kick_Player_Command_Conditions))
        call TriggerAddAction(udg_trigger132,function Trig_Kick_Player_Command_Actions)*/
    endfunction


endlibrary
