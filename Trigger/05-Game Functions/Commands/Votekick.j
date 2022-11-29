library VoteKick initializer Votekick_Init requires TimerUtils, MathRound

    globals
        boolean voteKickStarted = false
        integer voteKickVotes
        string array playerColours
        integer voteKickPlayer
        integer votesNeeded
        boolean array voteKickPlayerVoted
        boolean array voteKickAllow
    endglobals

    function GetVotesNeeded takes nothing returns integer
        if PlayerCount == 4 or PlayerCount == 6 or PlayerCount == 8 then
            return R2I(PlayerCount / 2) + 1
        elseif PlayerCount == 5 then
            return 3
        elseif PlayerCount == 7 then
            return 4
        else
            return 3
        endif
    endfunction

    function CanPlayerVote takes player p returns boolean
        return IsPlayerInForce(p, DefeatedPlayers) == false
    endfunction

    function KickPlayer takes player p returns nothing
        set udg_boolean17 = true
        call PlaySoundBJ(udg_sound04)
        call ForceAddPlayerSimple(p,udg_force07)
        call CustomDefeatBJ(p,"Kicked!")
        call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(p)+ "|cffffcc00 was kicked out of the game!|r")))
    endfunction

    function VoteKickReset takes nothing returns nothing
        local integer i = 0
        loop
            exitwhen i > 11
            set voteKickPlayerVoted[i] = false
            set i = i + 1
        endloop
        
        set voteKickVotes = 0
        set voteKickPlayer = - 1
        set votesNeeded = 0
        set voteKickStarted = false
    endfunction
    
    function voteKickPlayerAllow takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer p = GetTimerData(t)
        set voteKickAllow[p] = false
        call DisplayTextToPlayer(Player(p),0,0,"|cff97FF38You can now vote again.|r")
        call ReleaseTimer(t)
        set t = null
    endfunction

    function VoteKickEnd takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer i = 0
        call ReleaseTimer(t)

        if voteKickVotes >= votesNeeded then
            call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "Kicking " + GetPlayerNameColour(Player(voteKickPlayer)))
            call KickPlayer(Player(voteKickPlayer))
        else
            call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "|cffFFCD38Not enough votes|r in favour of kicking " + GetPlayerNameColour(Player(voteKickPlayer)))
        endif
        set t = null
        call VoteKickReset()
    endfunction
    
    function VoteKickVote takes boolean vote, player p returns nothing
        local integer playerId = GetPlayerId(p)
        if voteKickStarted == true and playerId != voteKickPlayer and voteKickPlayerVoted[playerId] != true then
            set voteKickPlayerVoted[playerId] = true
            
            if vote then
                set voteKickVotes = voteKickVotes + 1
                call DisplayTextToPlayer(p, 0, 0, "|cffFFCD38You voted to kick|r " + GetPlayerNameColour(Player(voteKickPlayer)))
            endif
            
            if (voteKickVotes > 1) then
                call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "|cffFFF645" + I2S(voteKickVotes) + " votes|r have been cast")
            elseif (voteKickVotes == 1) then
                call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "|cffFFF645" + I2S(voteKickVotes) + " vote|r has been cast")
            endif
        endif
    endfunction

    function VoteKickYes takes nothing returns nothing
        if CanPlayerVote(GetTriggerPlayer()) then
            call VoteKickVote(true, GetTriggerPlayer())
        endif
    endfunction

    function VoteKickNo takes nothing returns nothing
        //call VoteKickVote(false, GetTriggerPlayer())
    endfunction

    function VoteKickGetPlayer takes string playerName, integer playerNumber, string playerColour returns integer
        local integer i = 0
        local boolean found = false
        local integer foundPlayer = 12
        if playerName != null or playerNumber != null or playerColour != null then
            loop
                exitwhen i > 8
                if GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING then
                    if playerName == SubString(GetPlayerName(Player(i)), 0, StringLength(playerName)) or playerNumber - 1 == i or playerColour == playerColours[i] then
                        if foundPlayer != 12 then
                            set found = true
                        else
                            set foundPlayer = i
                        endif
                    endif
                endif
                set i = i + 1
            endloop
        endif
        
        if found == true then
            return 20
        endif
        
        return foundPlayer
    endfunction

    function VoteKickStart takes nothing returns nothing
        local string playerName
        local string playerColour
        local integer playerNumber
        local integer pickedPlayer
        local timer t = NewTimer()
        local timer t2 = NewTimerEx(GetPlayerId(GetTriggerPlayer()))
        local string input
        if CanPlayerVote(GetTriggerPlayer()) then
            if voteKickStarted == false then
                if voteKickAllow[GetPlayerId(GetTriggerPlayer())] == false then
                    call VoteKickReset()
                    if SubString(GetEventPlayerChatString(),0,3) == "-vk" then
                        set playerName = SubString(GetEventPlayerChatString(),4,40)
                        set playerNumber = S2I(SubString(GetEventPlayerChatString(),4,6))
                        set playerColour = SubString(GetEventPlayerChatString(), 4, 46)
                        set pickedPlayer = VoteKickGetPlayer(playerName, playerNumber, playerColour)
                    elseif SubString(GetEventPlayerChatString(),0,9) == "-votekick" then
                        set playerName = SubString(GetEventPlayerChatString(),10,46)
                        set playerNumber = S2I(SubString(GetEventPlayerChatString(),10,12))
                        set playerColour = SubString(GetEventPlayerChatString(), 4, 46)
                        set pickedPlayer = VoteKickGetPlayer(playerName, playerNumber, playerColour)
                    endif
                    if pickedPlayer == 20 then
                        call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"|cffFFCD38Found multiple players with that name, either use their player number or be more specific.|r ")
                        call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "|cffFFCD38You can use a playernumber to kick, type \"-pn\" to find each number|r ")
                    elseif pickedPlayer == 12 then
                        call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"|cffFFCD38Can't find player:|r " + playerName)
                    else
                        if pickedPlayer != GetPlayerId(GetTriggerPlayer()) then
                            if PlayerCount > 3 then
                                set voteKickStarted = true
                                set voteKickPlayer = pickedPlayer
                                set voteKickAllow[GetPlayerId(GetTriggerPlayer())] = true

                                call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 30, "|cffC8E833Votekick|r has been initiated against " + GetPlayerNameColour(Player(voteKickPlayer)))
                                call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 30, "Votes will be counted in 30 seconds")
                                call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 30, "Type \"|cff97FF38-yes|r\" or \"|cff97FF38-y|r\" to vote. (Votes are private)")
                                set votesNeeded = GetVotesNeeded()
                                call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 30, "|cffFFF645" + I2S(votesNeeded) + "|r |cff97FF38yes votes|r are needed")

                                call TimerStart(t, 30., false, function VoteKickEnd)
                                call TimerStart(t2, 60., false, function voteKickPlayerAllow)
                            else
                                call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"|cffFFCD38Not enough players to do a votekick.|r ")
                            endif
                        else
                            call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"|cffFFCD38You can't start a votekick against yourself.|r ")
                        endif
                    endif
                else
                    call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"|cffFFCD38You can't start a votekick more than once every 60 seconds.|r")
                endif
            else
                call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"|cffFFCD38You can't start a votekick when another votekick is active.|r")
            endif
        else
            call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"|cffFFCD38You can't start a votekick if you're dead.|r")
        endif
        set t = null
        set t2 = null
    endfunction

    function voteKickPlayerNumbers takes nothing returns nothing
        local integer i = 0
        loop
            exitwhen i > 11
            if GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING then
                call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "#" + I2S(i + 1) + " " + playerColours[i] + " " + GetPlayerNameColour(Player(i)))
            endif
            set i = i + 1
        endloop
    endfunction

    //===========================================================================
    function Votekick_Init takes nothing returns nothing
        local trigger trgVotekick = CreateTrigger()
        local trigger trgYes = CreateTrigger()
        local trigger trgNo = CreateTrigger()
        local trigger trgPn = CreateTrigger()
        local integer i = 0

        set playerColours[0] = "red"
        set playerColours[1] = "blue"
        set playerColours[2] = "teal"
        set playerColours[3] = "purple"
        set playerColours[4] = "yellow"
        set playerColours[5] = "orange"
        set playerColours[6] = "green"
        set playerColours[7] = "pink"

        loop
            exitwhen i > 8
            call TriggerRegisterPlayerChatEvent(trgVotekick,Player(i),"-votekick",false)
            call TriggerRegisterPlayerChatEvent(trgVotekick,Player(i),"-vk",false)
            call TriggerRegisterPlayerChatEvent(trgYes,Player(i),"-yes",true)
            call TriggerRegisterPlayerChatEvent(trgYes,Player(i),"-y",true)
            call TriggerRegisterPlayerChatEvent(trgNo,Player(i),"-no",true)
            call TriggerRegisterPlayerChatEvent(trgNo,Player(i),"-n",true)
            call TriggerRegisterPlayerChatEvent(trgPn,Player(i),"-playernumbers",true)
            call TriggerRegisterPlayerChatEvent(trgPn,Player(i),"-pn",true)
            set i = i + 1
        endloop
        call TriggerAddAction(trgVotekick,function VoteKickStart)
        call TriggerAddAction(trgYes,function VoteKickYes)
        call TriggerAddAction(trgNo,function VoteKickNo)
        call TriggerAddAction(trgPn,function voteKickPlayerNumbers)
        
        set trgVotekick = null
        set trgYes = null
        set trgNo = null
        set trgPn = null
    endfunction
endlibrary