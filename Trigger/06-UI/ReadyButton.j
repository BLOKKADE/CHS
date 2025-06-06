library ReadyButton initializer init requires PlayerTracking, AllPlayersCompletedRound, InitializePvp, BattleRoyaleHelper
    //button is setup in IconFrames.j
    globals
        boolean array PlayerHasReadied
        boolean array PlayerIsAlwaysReady
        boolean array ReadyButtonDisabled
        integer PlayersNeeded

        string ReadyIcon = "Ready"
        string UnreadyIcon = "NotReady"

        private boolean ReadyEventInitiated = false
    endglobals

    function ReadyPlayerCount takes nothing returns integer
        local integer i = 0
        local integer count = 0
        local PlayerStats ps

        loop
            set ps = PlayerStats.forPlayer(Player(i))

            if ps != 0 and ps.isReady() and (not IsPlayerInForce(Player(i), DefeatedPlayers)) then
                set count = count + 1
            endif

            set i = i + 1
            exitwhen i == 8
        endloop

        return count
    endfunction
    
    function UpdatePlayersNeeded takes nothing returns nothing
        set PlayersNeeded = PlayerCount
    endfunction

    private function ReadyTooltip takes nothing returns string
		return "Currently |cfff3fc77" + I2S(ReadyPlayerCount()) + "|r out of |cfffc77db" + I2S(PlayerCount) + "|r players are ready.|n|cffd8fc77Next round|r starts once enough players are ready.|nDoes not work for non-simultaneous pvp rounds.|n"
	endfunction

    function ReadyButtonTooltipTitle takes player p returns string
        local PlayerStats ps = 0
        local string s = ""

        set ps = PlayerStats.forPlayer(p)

        if (IsPlayerInForce(p, DefeatedPlayers)) then
            return "|cffff0000Cannot ready up|r"
        elseif ps.isReady() then
            return "|cfff3fc77Unready yourself|r (|cff77f3fcCtrl+R|r)"
        else
            return "|cff92fc77Ready|r (|cff77f3fcCtrl+R|r)"
        endif
    endfunction

    function ReadyButtonTooltip takes player p, integer pid returns string
        local string s = ReadyTooltip()

        if (IsPlayerInForce(p, DefeatedPlayers)) then
            return "|cffff0000Defeated players cannot ready up|r.|n"
        endif

        if ReadyButtonDisabled[pid] then
            set s = "|cfffc9277Cannot be used during a round|r.|n"
        endif

        if PlayerIsAlwaysReady[pid] then
            set s = s + "Set to |cff7784fcauto-ready|r.|n"
        endif

        return s + "Hold shift while activating this button to always be |cff7784fcready|r."
    endfunction

    function ReadyButtonVisibility takes boolean disable, integer pid, boolean isReady returns nothing
        local string tex
        local string iconPath

        if (IsPlayerInForce(Player(pid), DefeatedPlayers)) then
            set disable = true
            set tex = UnreadyIcon
        elseif isReady then
            set tex = ReadyIcon
        else
            set tex = UnreadyIcon
        endif

        if disable then
            set ReadyButtonDisabled[pid] = true
            set iconPath = GetDisabledIconPath(tex)

            if GetLocalPlayer() == Player(pid) then
                call BlzFrameSetTexture(ButtonId[5], iconPath, 0, true)
                call BlzFrameSetVisible(ButtonIndicatorParentId[5], PlayerIsAlwaysReady[pid])
            endif
        else
            set ReadyButtonDisabled[pid] = false
            set iconPath = GetIconPath(tex)

            if GetLocalPlayer() == Player(pid) then
                call BlzFrameSetTexture(ButtonId[5], iconPath, 0, true)
                call BlzFrameSetVisible(ButtonIndicatorParentId[5], PlayerIsAlwaysReady[pid])
            endif
        endif
    endfunction

    function DisableReadyButtonForAllPlayers takes nothing returns nothing
        local integer i = 0

        loop
            call ReadyButtonVisibility(true, i, false)
            set i = i + 1
            exitwhen i > 8
        endloop
    endfunction

    private function ResetFlags takes nothing returns nothing
        call ReleaseTimer(GetExpiredTimer())

        set ReadyEventInitiated = false
    endfunction

    private function StartRound takes nothing returns nothing
        call ReleaseTimer(GetExpiredTimer())

        if WaitingForBattleRoyal then
            if IsFunBRRound then
                call StartBattleRoyale()
            else
                call FinalizeBattleRoyaleSetup()
            endif
        elseif WaitingForPvp then
            call StartPvp()
        elseif PvpRoundEndWait then
            call PvpStartNextRound.execute()
        else
            call AllPlayersCompletedRound_StartNextRound()
        endif
    endfunction

    function CheckReadyPlayers takes nothing returns nothing
        local real resetFlagTime = 5

        if ReadyPlayerCount() >= PlayersNeeded and (not ReadyEventInitiated) then
            // Flag to make sure the event doesn't get fired off more than once
            set ReadyEventInitiated = true

            if WaitingForBattleRoyal then
                if (IsFunBRRound) then
                    call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 2, "|c00fbff08Everyone is ready!|r Starting the |c003bff34Fun Battle Royal!|r")
                else
                    call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 2, "|c00fbff08Everyone is ready!|r Starting the |c003bff34Battle Royal!|r")
                endif

                set resetFlagTime = 10
            elseif WaitingForPvp then
                call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 2, "|c00fbff08Everyone is ready!|r Starting the |c003bff34Pvp battles!|r")
            else
                call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 2, "|c00fbff08Everyone is ready!|r Starting the |c003bff34Next round!|r")
            endif

            // Reset flags after some time to prevent this function from getting fired off again
            call TimerStart(NewTimer(), resetFlagTime, false, function ResetFlags)

            call TimerStart(NewTimer(), 2., false, function StartRound)
        endif
    endfunction

    function PlayerReadies takes player p, boolean isEndRound returns nothing
        local integer pid = GetPlayerId(p)
        local PlayerStats ps = PlayerStats.forPlayer(p)
        local string message

        if (IsPlayerInForce(p, DefeatedPlayers)) then
            set PlayerIsAlwaysReady[pid] = false
        elseif HoldShift[pid] then
            set PlayerIsAlwaysReady[pid] = not PlayerIsAlwaysReady[pid]
            call ps.setIsReady(PlayerIsAlwaysReady[pid])
            call ReadyButtonVisibility(ReadyButtonDisabled[pid], pid, PlayerIsAlwaysReady[pid])
        endif

        if not ReadyButtonDisabled[pid] then
            if (HoldShift[pid] and PlayerIsAlwaysReady[pid]) then
                call ps.setIsReady(true)
            elseif ((not isEndRound) and (not HoldShift[pid]) and PlayerIsAlwaysReady[pid]) then
                call ps.toggleIsReady()
                set PlayerIsAlwaysReady[pid] = ps.isReady()
            elseif (PlayerIsAlwaysReady[pid]) then
                call ps.setIsReady(true)
            else
                call ps.toggleIsReady()
            endif

            call ReadyButtonVisibility(false, pid, ps.isReady())

            call UpdatePlayersNeeded()

            //only show text to everyone once
            if not PlayerHasReadied[pid] then
                set message = GetPlayerNameColour(p) + " is ready. |c00fcff3b" + I2S(ReadyPlayerCount()) + "|r/|c000bff03" + I2S(PlayerCount) + "|r"

                call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 10, message)
            else
                if ps.isReady() then
                    call DisplayTimedTextToPlayer(p, 0, 0, 10, GetPlayerNameColour(p) + " is ready. |c00fcff3b" + I2S(ReadyPlayerCount()) + "|r/|c000bff03" + I2S(PlayerCount) + "|r")
                else
                    call DisplayTimedTextToPlayer(p, 0, 0, 10, GetPlayerNameColour(p) + " is not ready. |c00fcff3b" + I2S(ReadyPlayerCount()) + "|r/|c000bff03" + I2S(PlayerCount) + "|r")
                endif
            endif

            call CheckReadyPlayers()

            set PlayerHasReadied[pid] = true
        endif
    endfunction

    private function OnRoundStart takes EventInfo eventInfo returns nothing
        local integer pid = GetPlayerId(eventInfo.p)

        if (PlayerIsAlwaysReady[pid]) then
            call ReadyButtonVisibility(true, pid, true)
            call PlayerStats.forPlayer(eventInfo.p).setIsReady(true)
            set PlayerHasReadied[pid] = true
        else
            call ReadyButtonVisibility(true, pid, false)
            call PlayerStats.forPlayer(eventInfo.p).setIsReady(false)
            set PlayerHasReadied[pid] = false
        endif
    endfunction

    private function OnRoundEnd takes EventInfo eventInfo returns nothing
        local integer pid = GetPlayerId(eventInfo.p)
        local PlayerStats ps = PlayerStats.forPlayer(eventInfo.p)

        // Reset the ready button for BR
        if (eventInfo.roundNumber == BattleRoyalRound) then
            call ReadyButtonVisibility(false, pid, false)
            call PlayerStats.forPlayer(eventInfo.p).setIsReady(false)
            set PlayerHasReadied[pid] = false
            set PlayerIsAlwaysReady[pid] = false
        else
            call ReadyButtonVisibility(false, pid, PlayerIsAlwaysReady[pid])
            call PlayerStats.forPlayer(eventInfo.p).setIsReady(PlayerIsAlwaysReady[pid])
            set PlayerHasReadied[pid] = PlayerIsAlwaysReady[pid]
        endif

        if PlayerIsAlwaysReady[pid] then
            //reset when battle royal wait time starts
            if (not (PlayerCount > 1 and ModuloInteger(eventInfo.roundNumber, 5) == 0)) then
                call PlayerReadies(eventInfo.p, true)
            endif
        endif
    endfunction

    private function init takes nothing returns nothing
        call CustomGameEvent_RegisterEventCode(EVENT_PLAYER_ROUND_TELEPORT, CustomEvent.OnRoundStart)
        call CustomGameEvent_RegisterEventCode(EVENT_GAME_ROUND_END, CustomEvent.OnRoundEnd)
        call CustomGameEvent_RegisterEventCode(EVENT_FUN_BR_ROUND_END, CustomEvent.OnRoundEnd)
        call CustomGameEvent_RegisterEventCode(EVENT_FUN_BR_ROUND_START, CustomEvent.OnRoundStart)
    endfunction
endlibrary
