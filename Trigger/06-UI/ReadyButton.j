library ReadyButton initializer init requires PlayerTracking
    //button is setup in IconFrames.j
    globals
        boolean array PlayerHasReadied
        integer PlayersNeeded
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
            exitwhen i > 8
        endloop

        return count
    endfunction

    function PlayerReadies takes player p returns nothing
        local integer pid = GetPlayerId(p)

        if not PlayerHasReadied[pid] then
            call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 10, GetPlayerNameColour(p) + " is ready. " + I2S(ReadyPlayerCount()) + "/" + I2S(PlayerCount))
        endif

        set PlayerHasReadied[pid] = true
    endfunction

    private function init takes nothing returns nothing
        
    endfunction
endlibrary
