library PlayerInitialization initializer init requires RandomShit

    private function ValidPlayerFilter takes nothing returns boolean
        local player currentPlayer = GetFilterPlayer()
        local boolean isHumanPlayer = (currentPlayer != Player(8)) and (currentPlayer != Player(11))
        local boolean isPlayingPlayer = (IsPlayerInForce(currentPlayer, LeaverPlayers) == true) or (GetPlayerSlotState(currentPlayer) == PLAYER_SLOT_STATE_PLAYING)

        // Cleanup
        set currentPlayer = null

        return isHumanPlayer and isPlayingPlayer
    endfunction

    private function AddValidPlayer takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local integer playerIdIndex = 0

        set PlayerCount = PlayerCount + 1
        set InitialPlayerCount = InitialPlayerCount + 1

        loop
            exitwhen playerIdIndex == 8
            call SetPlayerAllianceStateBJ(currentPlayer, Player(playerIdIndex), bj_ALLIANCE_UNALLIED)
            set playerIdIndex = playerIdIndex + 1
        endloop

        call SetPlayerStateBJ(currentPlayer, PLAYER_STATE_RESOURCE_FOOD_USED, 0)
        call ResourseRefresh(currentPlayer) 
        call CreateFogModifierRectBJ(true, currentPlayer, FOG_OF_WAR_VISIBLE, GetPlayableMapRect())

        // Cleanup
        set currentPlayer = null
    endfunction

    private function SetPlayerAlliances takes nothing returns nothing
        call SetPlayerAllianceStateBJ(GetEnumPlayer(), Player(8), bj_ALLIANCE_ALLIED_VISION)
        call SetPlayerAllianceStateBJ(Player(PLAYER_NEUTRAL_PASSIVE), GetEnumPlayer(), bj_ALLIANCE_ALLIED_ADVUNITS)
    endfunction

    private function PlayerInitializationActions takes nothing returns nothing
        // Find valid players
        local force validPlayerForce = GetPlayersMatching(Condition(function ValidPlayerFilter))

        call SetMapFlag(MAP_ALLIANCE_CHANGES_HIDDEN, true)
        call SetMapFlag(MAP_LOCK_RESOURCE_TRADING, true)
        call SetTimeOfDay(12)
        
        // Add the valid player to the game
        call ForForce(validPlayerForce, function AddValidPlayer)

        // Single player mode
        if (PlayerCount == 1) then
            call DisableTrigger(AllPlayersDeadTrigger)
            call DisableTrigger(PlayerHeroDeathTrigger)
            call EnableTrigger(HeroDiesInRoundTrigger)
        endif

        // No idea why we have this. Maybe alliances aren't setup yet on map init for the next call?
        call TriggerSleepAction(0.00)

        call ForForce(validPlayerForce, function SetPlayerAlliances)

        // Cleanup
        call DestroyForce(validPlayerForce)
        set validPlayerForce = null
    endfunction

    private function init takes nothing returns nothing
        set PlayerInitializationTrigger = CreateTrigger()
        call TriggerAddAction(PlayerInitializationTrigger, function PlayerInitializationActions)
    endfunction

endlibrary
