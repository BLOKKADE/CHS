library ScoreboardManager

    globals
        // Column indexes
        constant integer PLAYER_STATS_INDEX                     = 0
        constant integer PLAYER_HERO_INDEX                      = 1
        constant integer PLAYER_READY_STATUS_INDEX              = 2
        constant integer PLAYER_ELEMENT_COUNT_INDEX             = 3
        constant integer PLAYER_NAME_INDEX                      = 4
        constant integer PLAYER_HERO_LEVEL_INDEX                = 5
        constant integer PLAYER_STATUS_INDEX                    = 6
        constant integer PLAYER_DUELS_INDEX                     = 7
        constant integer PLAYER_ITEMS_START_INDEX               = 8
        constant integer PLAYER_ABILITIES_START_INDEX           = 14

        constant integer CACHING_BUFFER = 50 // Used as a separator in the caching arrays so we can use a single array for all players. This value just needs to be bigger than the amount of columns in the scoreboard
        string array CachedPlayerStrings // Strings for each player column. NOTE: Not the most useful caching, but it could help with performance to not have to update a framehandle

        framehandle array CachedPlayerParentFramehandles

        boolean array PlayerLeftGame // If the player left the game
        boolean array PlayerDiedInBR // If the player died in the BR. e.g. They died on round 25 or 50
        integer array PlayerBRDeathOrder // The order of which players died in the BR
        integer array PlayerDeathRound // The round the player died for good
        force WinnerPlayerForce = null

        integer CurrentDeadHeroCount = 0
    endglobals
    
    function ResetScoreboardBrWinner takes nothing returns nothing
        set WinnerPlayerForce = null
    endfunction

    function UpdateScoreboardBrWinner takes force winningForce returns nothing
        if (winningForce != null and WinnerPlayerForce == null) then
            set WinnerPlayerForce = winningForce
        endif
    endfunction

    function UpdateScoreboardPlayerDies takes player currentPlayer, integer deathRound returns nothing
        local integer playerId = GetPlayerId(currentPlayer)

        // Don't overwrite a value if it already exists
        if (PlayerDeathRound[playerId] == 0) then
            // Mark the player has died. Will be reflected in the update interval
            set PlayerDeathRound[playerId] = deathRound
            set PlayerDiedInBR[playerId] = BrStarted

            if (BrStarted) then
                set CurrentDeadHeroCount = CurrentDeadHeroCount + 1
                set PlayerBRDeathOrder[playerId] = CurrentDeadHeroCount
            endif
        endif
    endfunction

    function UpdateScoreboardPlayerLeaves takes player currentPlayer returns nothing
        local integer playerId = GetPlayerId(currentPlayer)

        // Mark the player left the game. Will be reflected in the update interval
        set PlayerLeftGame[playerId] = true

        // Set the wave the player left
        if (PlayerHeroes[playerId] == null) then
            call UpdateScoreboardPlayerDies(currentPlayer, -1)
        else
            call UpdateScoreboardPlayerDies(currentPlayer, RoundNumber)
        endif
    endfunction

    function ResetPlayerBRProperties takes player currentPlayer returns nothing
        local integer playerId = GetPlayerId(currentPlayer)
        local framehandle playerNameTextFrameHandle = CachedPlayerParentFramehandles[(playerId * CACHING_BUFFER) + PLAYER_STATUS_INDEX]

        set PlayerDeathRound[playerId] = 0
        set PlayerDiedInBR[playerId] = false
        set PlayerBRDeathOrder[playerId] = 0

        set CachedPlayerStrings[(playerId * CACHING_BUFFER) + PLAYER_STATUS_INDEX] = ""
        call BlzFrameSetText(playerNameTextFrameHandle, "") 

        // Cleanup
        set playerNameTextFrameHandle = null
    endfunction

endlibrary
