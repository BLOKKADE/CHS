library DistributeBets initializer init requires RandomShit, PvpRoundRobin

    private function DistributeBetsConditions takes nothing returns boolean
        return BettingEnabled == true
    endfunction

    private function DistributeBetsForPlayer takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local integer currentPlayerId = GetPlayerId(currentPlayer)
        local string winMessage

        if (ResourceBetPercentageGoldReward[currentPlayerId] > 0 or ResourceBetPercentageLumberReward[currentPlayerId] > 0) then
            set winMessage = GetPlayerNameColour(currentPlayer)
            set winMessage = winMessage + " won: "

            call DestroyEffect(AddSpecialEffectTargetUnitBJ("origin", PlayerHeroes[currentPlayerId], "Abilities\\Spells\\Other\\Transmute\\PileofGold.mdl"))
            
            if (PlayerPlacedGoldBet[currentPlayerId] == true) then
                call AdjustPlayerStateBJ((ResourceBetPercentageGoldReward[currentPlayerId] * 2), currentPlayer, PLAYER_STATE_RESOURCE_GOLD)
                call ResourseRefresh(currentPlayer)
                set winMessage = winMessage + I2S((ResourceBetPercentageGoldReward[currentPlayerId] * 2))
                
                if (PlayerPlacedLumberBet[currentPlayerId] == true) then
                    set winMessage = winMessage + " gold and "
                endif
            endif

            if (PlayerPlacedLumberBet[currentPlayerId] == true) then
                call AdjustPlayerStateBJ((ResourceBetPercentageLumberReward[currentPlayerId] * 2), currentPlayer, PLAYER_STATE_RESOURCE_LUMBER)
                call ResourseRefresh(currentPlayer)
                set winMessage = winMessage + I2S((ResourceBetPercentageLumberReward[currentPlayerId] * 2))
                set winMessage = winMessage + " lumber!"
            else
                set winMessage = winMessage + " gold!"
            endif

            call DisplayTimedTextToForce(GetPlayersAll(), 5.00, winMessage)
        endif

        // Wipe all betting values
        set PlayerResourceBetPercentage[currentPlayerId] = 0
        set ResourceBetPercentageGoldReward[currentPlayerId] = 0
        set ResourceBetPercentageLumberReward[currentPlayerId] = 0
        set PlayerPlacedGoldBet[currentPlayerId] = false
        set PlayerPlacedLumberBet[currentPlayerId] = false

        // Cleanup
        set currentPlayer = null
    endfunction

    private function DistributeBetsActions takes nothing returns nothing
        if (CurrentDuelGame.team1Won) then
            call ForForce(Team1BettingForce, function DistributeBetsForPlayer)
        else
            call ForForce(Team2BettingForce, function DistributeBetsForPlayer)
        endif

        // Clear the betting forces
        call ForceClear(Team1BettingForce)
        call ForceClear(Team2BettingForce)
    endfunction

    private function init takes nothing returns nothing
        set DistributeBetsTrigger = CreateTrigger()
        call TriggerAddCondition(DistributeBetsTrigger, Condition(function DistributeBetsConditions))
        call TriggerAddAction(DistributeBetsTrigger, function DistributeBetsActions)
    endfunction

endlibrary
