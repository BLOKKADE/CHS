library ReadyButton initializer init requires PlayerTracking, AllPlayersCompletedRound
    //button is setup in IconFrames.j
    globals
        boolean array PlayerHasReadied
        boolean array PlayerIsAlwaysReady
        boolean array ReadyButtonDisabled
        integer PlayersNeeded

        string ReadyIcon = "Ability_parry"
        string UnreadyIcon = "Defend"
    endglobals

    function ReadyPlayerCount takes nothing returns integer
        local integer i = 0
        local integer count = 0
        local PlayerStats ps

        loop
            set ps = PlayerStats.forPlayer(Player(i))

            if ps != 0 and ps.isReady() then
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

    function ReadyTooltip takes nothing returns string
		return " (|cff77f3fcCtrl+R|r)|nCurrently |cfff3fc77" + I2S(ReadyPlayerCount()) + "|r out of |cfffc77db" + I2S(PlayerCount) + "|r players are ready.|n|cffd8fc77Next round|r starts once enough players are ready.|n|nHold shift while activating this button to always be |cff7784fcready|r."
	endfunction

    function ReadyButtonTooltip takes player p, integer pid returns string
        local PlayerStats ps = 0
        local string s = ""

        if not ReadyButtonDisabled[pid] then
            set ps = PlayerStats.forPlayer(p)

            if ps.isReady() then
                set s = "|cfff3fc77Unready yourself|r " + ReadyTooltip()
            else
                set s = "|cff92fc77Ready|r" + ReadyTooltip()
            endif
        else
            set s = "|cfffc9277Cannot be used during a round.|r"
        endif

        if PlayerIsAlwaysReady[pid] then
            set s = s + "\nSet to |cff7784fcauto-ready|r."
        endif

        return s
    endfunction

    function ReadyButtonVisibility takes boolean disable, integer pid, boolean isReady returns nothing
        local string tex = ""

        if isReady then
            set tex = ReadyIcon
        else
            set tex = UnreadyIcon
        endif

        if disable then
            set ReadyButtonDisabled[pid] = true
            call BlzFrameSetTexture(ButtonId[5], GetDisabledIconPath(tex), 0, true)
        else
            set ReadyButtonDisabled[pid] = false
            call BlzFrameSetTexture(ButtonId[5], GetIconPath(tex), 0, true)
        endif
    endfunction

    function ReadyButtonTexture takes boolean isReady returns nothing
        if isReady then
            call BlzFrameSetTexture(ButtonId[5], "ReplaceableTextures\\CommandButtons\\BTNDefend.blp", 0, true)
        else
            call BlzFrameSetTexture(ButtonId[5], "ReplaceableTextures\\CommandButtons\\BTNAbility_parry.blp", 0, true)
        endif
    endfunction
    
    private function StartRound takes nothing returns nothing
        call ReleaseTimer(GetExpiredTimer())
        call AllPlayersCompletedRound_StartNextRound()
    endfunction

    function CheckReadyPlayers takes nothing returns nothing
        if ReadyPlayerCount() >= PlayersNeeded then
            call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 10, "Starting next round...")
            call TimerStart(NewTimer(), 2., false, function StartRound)
        endif
    endfunction

    function PlayerReadies takes player p returns nothing
        local integer pid = GetPlayerId(p)
        local PlayerStats ps = PlayerStats.forPlayer(p)
        call ps.toggleIsReady()
        call ReadyButtonVisibility(false, pid, ps.isReady())

        if HoldShift[pid] then
            set PlayerIsAlwaysReady[pid] = not PlayerIsAlwaysReady[pid]
        endif

        call UpdatePlayersNeeded()

        if not PlayerHasReadied[pid] then
            call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 10, GetPlayerNameColour(p) + " is ready. |c00fbff08" + I2S(ReadyPlayerCount()) + "|r/|c000bff03" + I2S(PlayerCount) + "|r")
        endif

        call CheckReadyPlayers()

        set PlayerHasReadied[pid] = true
    endfunction

    private function OnRoundStart takes EventInfo eventInfo returns nothing
        call ReadyButtonVisibility(true, GetPlayerId(eventInfo.p), false)
    endfunction

    private function OnRoundEnd takes EventInfo eventInfo returns nothing
        local integer pid = GetPlayerId(eventInfo.p)
        call PlayerStats.forPlayer(eventInfo.p).setIsReady(false)
        call ReadyButtonVisibility(false, pid, false)
        set PlayerHasReadied[pid] = false
        if PlayerIsAlwaysReady[pid] then
            call PlayerReadies(eventInfo.p)
        endif
    endfunction

    private function init takes nothing returns nothing
        call CustomGameEvent_RegisterEventCode(EVENT_GAME_ROUND_START, CustomEvent.OnRoundStart)
        call CustomGameEvent_RegisterEventCode(EVENT_GAME_ROUND_END, CustomEvent.OnRoundEnd)
    endfunction
endlibrary
