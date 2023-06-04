library PlayerDiesInBattleRoyale initializer init requires BattleRoyaleHelper, Scoreboard

    private function PlayerDiesInBattleRoyaleConditions takes nothing returns boolean
        return BrStarted == true and IsPlayerHero(GetTriggerUnit())
    endfunction

    private function PlayerDiesInBattleRoyaleActions takes nothing returns nothing
        local unit deadHero = GetTriggerUnit()
        local player deadPlayer = GetOwningPlayer(deadHero)
        local integer deadPlayerId = GetPlayerId(deadPlayer)
        local location randomSpawnLocation

        if (not IsFunBRRound) then
            call PlayerStats.forPlayer(GetOwningPlayer(GetKillingUnit())).addBRPVPKill()
        endif

        call DisplayTimedTextToForce(GetPlayersAll(), 5.00, "|cffffcc00" + GetPlayerNameColour(deadPlayer) + " was defeated by |r" + GetPlayerNameColour(GetOwningPlayer(GetKillingUnit())) + "!")

        // Try to revive the hero if there are BR lives
        if (BRLivesMode == 2) then
            // Increment the player deaths
            set PlayerBRDeaths[deadPlayerId] = PlayerBRDeaths[deadPlayerId] + 1

            // Don't revive the hero if they died too many times
            if (PlayerBRDeaths[deadPlayerId] > MAX_BR_DEATH_COUNT) then
                // Set the status of their death in the BR
                call UpdateScoreboardPlayerDies(deadPlayer, RoundNumber)

                call DisplayTimedTextToForce(GetPlayersAll(), 5.00, "|cffffcc00" + GetPlayerNameColour(deadPlayer) + " has no lives left. Will not respawn.|r")

                // Set the status of their death in the BR
                call UpdateScoreboardPlayerDies(deadPlayer, RoundNumber)
                set PlayerCount = PlayerCount - 1

                // Cleanup
                set deadHero = null
                set deadPlayer = null

                // Try to end the game
                call ConditionalTriggerExecute(EndGameTrigger)
            else
                call DisplayTimedTextToForce(GetPlayersAll(), 5.00, "|cffffcc00" + GetPlayerNameColour(deadPlayer) + " has |r" + I2S(MAX_BR_DEATH_COUNT - PlayerBRDeaths[deadPlayerId]) + " |cffffcc00lives remaining! Respawning in 5 seconds.|r")
                
                call TriggerSleepAction(5)

                // Respawn the hero
                set randomSpawnLocation = GetRandomLocInRect(RectMidArena)
                call ReviveHeroLoc(deadHero, randomSpawnLocation, true)
                call SelectUnitForPlayerSingle(deadHero, deadPlayer)
                call PanCameraToTimedLocForPlayer(deadPlayer, randomSpawnLocation, 0.50)

                set TempUnit = deadHero // Used in HeroRefreshTrigger
                call ConditionalTriggerExecute(HeroRefreshTrigger)

                // Cleanup
                call RemoveLocation(randomSpawnLocation)
                set randomSpawnLocation = null
                set deadHero = null
                set deadPlayer = null
            endif

            return
        endif

        // Set the status of their death in the BR
        call UpdateScoreboardPlayerDies(deadPlayer, RoundNumber)
        call ShowDiscordFrames(deadPlayer, true)
        set PlayerCount = PlayerCount - 1

        // Cleanup
        set deadHero = null
        set deadPlayer = null

        // Try to end the game
        call ConditionalTriggerExecute(EndGameTrigger)
    endfunction

    private function init takes nothing returns nothing
        set PlayerDiesInBattleRoyaleTrigger = CreateTrigger()
        call DisableTrigger(PlayerDiesInBattleRoyaleTrigger)
        call TriggerRegisterAnyUnitEventBJ(PlayerDiesInBattleRoyaleTrigger, EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(PlayerDiesInBattleRoyaleTrigger, Condition(function PlayerDiesInBattleRoyaleConditions))
        call TriggerAddAction(PlayerDiesInBattleRoyaleTrigger, function PlayerDiesInBattleRoyaleActions)
    endfunction

endlibrary
