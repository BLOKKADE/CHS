library ReadyButton requires PlayerTracking, AllPlayersCompletedRound
    //button is setup in IconFrames.j
    globals
        boolean array PlayerHasReadied
        integer PlayersNeeded
    endglobals

    function ReadyButtonVisibility takes boolean show returns nothing
        if show then
            call BlzFrameSetVisible(ButtonParentId[5], true)
        else
            call BlzFrameSetVisible(ButtonParentId[5], false)
        endif
    endfunction

    function ReadyButtonTexture takes boolean isReady returns nothing
        if isReady then
            call BlzFrameSetTexture(ButtonId[5], "ReplaceableTextures\\CommandButtons\\BTNDefend.blp", 0, true)
        else
            call BlzFrameSetTexture(ButtonId[5], "ReplaceableTextures\\CommandButtons\\BTNAbility_parry.blp", 0, true)
        endif
    endfunction

    function ResetReadyPlayers takes nothing returns nothing
        local integer i = 0
        local PlayerStats ps

        loop
            set ps = PlayerStats.forPlayer(Player(i))
            call ps.setIsReady(false)
            call ReadyButtonTexture(false)
            set PlayerHasReadied[i] = false

            set i = i + 1
            exitwhen i > 8
        endloop
    endfunction

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
            exitwhen i > 8
        endloop

        return count
    endfunction

    
    function UpdatePlayersNeeded takes nothing returns nothing
        set PlayersNeeded = PlayerCount
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
        call ReadyButtonTexture(ps.isReady())

        call UpdatePlayersNeeded()

        if not PlayerHasReadied[pid] then
            call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 10, GetPlayerNameColour(p) + " is ready. |c00fbff08" + I2S(ReadyPlayerCount()) + "|r/|c000bff03" + I2S(PlayerCount) + "|r")
        endif

        call CheckReadyPlayers()

        set PlayerHasReadied[pid] = true
    endfunction
endlibrary
