library DistributeBets initializer init requires RandomShit, PvpRoundRobin

    private function DistributeBetsConditions takes nothing returns boolean
        return BettingEnabled == true
    endfunction

    private function DistributeBetsForPlayer takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local integer convertedPlayerId = GetConvertedPlayerId(currentPlayer)
        local string winMessage

        if (ResourceBetPercentageGoldReward[convertedPlayerId] > 0 or ResourceBetPercentageLumberReward[convertedPlayerId] > 0) then
            set winMessage = GetPlayerNameColour(currentPlayer)
            set winMessage = winMessage + " won: "

            call DestroyEffectBJ(AddSpecialEffectTargetUnitBJ("origin", PlayerHeroes[convertedPlayerId], "Abilities\\Spells\\Other\\Transmute\\PileofGold.mdl"))
            
            if (PlayerPlacedGoldBet[convertedPlayerId] == true)then
                call AdjustPlayerStateBJ((ResourceBetPercentageGoldReward[convertedPlayerId] * 2), currentPlayer, PLAYER_STATE_RESOURCE_GOLD)
                call ResourseRefresh(currentPlayer)
                set winMessage = winMessage + I2S((ResourceBetPercentageGoldReward[convertedPlayerId] * 2))
                
                if (PlayerPlacedLumberBet[convertedPlayerId] == true) then
                    set winMessage = winMessage + " gold and "
                endif
            endif

            if (PlayerPlacedLumberBet[convertedPlayerId] == true) then
                call AdjustPlayerStateBJ((ResourceBetPercentageLumberReward[convertedPlayerId]* 2), currentPlayer, PLAYER_STATE_RESOURCE_LUMBER)
                call ResourseRefresh(currentPlayer)
                set winMessage = winMessage + I2S((ResourceBetPercentageLumberReward[convertedPlayerId] * 2))
                set winMessage = winMessage + " lumber!"
            else
                set winMessage = winMessage + " gold!"
            endif

            call DisplayTimedTextToForce(GetPlayersAll(), 5.00, winMessage)
        endif

        // Wipe all betting values
        set PlayerResourceBetPercentage[convertedPlayerId] = 0
        set ResourceBetPercentageGoldReward[convertedPlayerId] = 0
        set ResourceBetPercentageLumberReward[convertedPlayerId] = 0
        set PlayerPlacedGoldBet[convertedPlayerId] = false
        set PlayerPlacedLumberBet[convertedPlayerId] = false

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
        call TriggerAddCondition(DistributeBetsTrigger,Condition(function DistributeBetsConditions))
        call TriggerAddAction(DistributeBetsTrigger,function DistributeBetsActions)
    endfunction

endlibrary
