library PlayerLeavesGameBeforeHeroSelection initializer init requires PlayerHeroSelected

    private function PlayerLeavesGameActions takes nothing returns nothing
        if (AllPlayerHeroesSpawned == false) then
            // Check if we are actually ready to start the game
            if (RoundNumber == 1 and SpawnedHeroCount >= GetValidPlayerForceCount()) then
                call PlayerHeroSelected_AllPlayersHaveHeroesActions()
            endif
        else
            // Stop this trigger if heroes have been spawned
            call DisableTrigger(GetTriggeringTrigger())
        endif
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