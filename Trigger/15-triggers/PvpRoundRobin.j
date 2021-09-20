library PvpRoundRobin

    globals
        private boolean initialised = false
        private integer PlayerCount = 0
        private integer duelPlayers = 0
        private integer currentduel = 0
        private integer replacementPlayer = 0
        private integer randomedPlayer = 0
        private integer array playerEnemy
        private integer array Players
        private integer array PlayersTop
        private integer array PlayersBottom
    endglobals

    function GetPlayerTop takes nothing returns player
        return Player(PlayersTop[currentduel])
    endfunction

    function GetTopEnemy takes nothing returns player
        set currentduel = currentduel + 1
        return Player(PlayersBottom[currentduel - 1])
    endfunction

    function GetPlayerDuelEnemy takes player p returns player
        local integer pid = GetPlayerId(p)
        local integer enemy = 0
        local integer i = 0
        loop
            if PlayersTop[i] == pid then
                set enemy = PlayersBottom[i]
            elseif PlayersBottom[i] == pid then
                set enemy = PlayersTop[i]
            endif
            set i = i + 1
            exitwhen i >= duelPlayers / 2
        endloop

        if enemy == replacementPlayer then
            set i = 0
            if randomedPlayer == -1 then
                loop
                    set randomedPlayer = GetRandomInt(0, PlayerCount)
                    set i = i + 1
                    exitwhen randomedPlayer != pid and randomedPlayer != replacementPlayer or i >= 100
                endloop
            endif
            set enemy = randomedPlayer
        endif

        return Player(enemy)
    endfunction

    function DisplayDuelNemesis takes nothing returns nothing
        local integer i = 0
        loop
            if UnitAlive(udg_units01[i+1]) then
                call DisplayTimedTextToPlayer(Player(i), 0, 0, 20, "You are dueling " + GetPlayerNameColour(GetPlayerDuelEnemy(Player(i))))
            endif
            set i = i + 1
            exitwhen i > 8
        endloop
    endfunction

    function MoveRoundRobin takes nothing returns nothing
        local integer i = 0
        local integer temp = 0
        set randomedPlayer = -1
        loop
            if i != 0 then
                set PlayersBottom[i] = PlayersBottom[i] - 1
            endif
            set PlayersTop[i] = PlayersTop[i] - 1
            if PlayersTop[i] == 0 then
                set PlayersTop[i] = Players[duelPlayers - 1]
            endif
            if PlayersBottom[i] == 0 and i != 0 then
                set PlayersBottom[i] = Players[duelPlayers - 1]
            endif
            call BJDebugMsg("move: " + I2S(PlayersTop[i]) + " vs " + I2S(PlayersBottom[i]))
            set i = i + 1
            exitwhen i >= duelPlayers / 2
        endloop
    endfunction

    
    function UpdatePlayers takes nothing returns nothing
        local integer i = 0
        local integer index = 0
        set PlayerCount = 0

        loop
            if UnitAlive(udg_units01[i+1]) then
                set PlayerCount = PlayerCount + 1
                set Players[index] = i
                set index = index + 1
                call BJDebugMsg("upc: " + I2S(PlayerCount) + ", index: " + I2S(index - 1) + ", pl: " + GetPlayerName(Player(Players[index])))
            endif
            set i = i + 1
            exitwhen i > 7
        endloop

        set duelPlayers = PlayerCount
        if ModuloInteger(PlayerCount, 2) != 0 then
            set Players[PlayerCount] = PlayerCount
            set replacementPlayer = PlayerCount
            set duelPlayers = PlayerCount + 1
            call BJDebugMsg("odd new count: " + I2S(duelPlayers))
        endif
    endfunction

    private function init takes nothing returns nothing
        local integer i = 0
        call UpdatePlayers()
        loop
            set PlayersTop[i] = Players[duelPlayers - 1 - i]
            set PlayersBottom[i] = Players[i]
            call BJDebugMsg("init: " + I2S(PlayersTop[i]) + " vs " + I2S(PlayersBottom[i]))
            set i = i + 1
            exitwhen i >= duelPlayers / 2
        endloop
    endfunction

    function UpdatePlayerCount takes nothing returns nothing
        local integer i = 0
        local integer index = 0
        set PlayerCount = 0

        if initialised == false then
            set initialised = true
            call init()
        else

            call UpdatePlayers()
        endif
    endfunction

endlibrary