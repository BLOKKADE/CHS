library PlayerLeavesGame initializer init requires Scoreboard

    private function PlayerLeavesGameActions takes nothing returns nothing
        call UpdateScoreboardPlayerLeaves(GetTriggerPlayer())
    endfunction

    private function init takes nothing returns nothing
        local trigger playerLeavesGameTrigger = CreateTrigger()

        // Register the player event leaves for every player
        local integer playerId = 0
        loop    
            exitwhen playerId == 8
            call TriggerRegisterPlayerEvent(playerLeavesGameTrigger, Player(playerId), EVENT_PLAYER_LEAVE)
            set playerId = playerId + 1
        endloop
    
        call TriggerAddAction(playerLeavesGameTrigger, function PlayerLeavesGameActions)

        set playerLeavesGameTrigger = null
    endfunction

endlibrary