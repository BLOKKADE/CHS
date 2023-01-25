library PlacePercentageBet initializer init requires RandomShit, PvpRoundRobin, InitializeBettingDialogs

    private function PlacePercentageBetConditions takes nothing returns boolean
        return GetClickedButton() == BettingDialogButtons[8] or GetClickedButton() == BettingDialogButtons[9] or GetClickedButton() == BettingDialogButtons[10]
    endfunction

    private function PlacePercentageBetActions takes nothing returns nothing
        local player currentPlayer = GetTriggerPlayer()
        local integer playerId = GetPlayerId(currentPlayer)

        // 25% resource bet
        if (GetClickedButton() == BettingDialogButtons[8]) then
            set PlayerResourceBetPercentage[playerId] = 25
         // 50% resource bet
        elseif (GetClickedButton() == BettingDialogButtons[9]) then
            set PlayerResourceBetPercentage[playerId] = 50
         // 100% resource bet
        elseif (GetClickedButton() == BettingDialogButtons[10]) then
            set PlayerResourceBetPercentage[playerId] = 100
        endif

        // Compute the gold resources
        if (PlayerPlacedGoldBet[playerId] == true) then
            set ResourceBetPercentageCalculation = ResourceBetPercentageGoldReward[playerId]
            set ResourceBetPercentageCalculation = R2I(((I2R(GetPlayerState(currentPlayer, PLAYER_STATE_RESOURCE_GOLD)) / 100.00) * I2R(PlayerResourceBetPercentage[playerId])))
            call AdjustPlayerStateBJ((- 1 * ResourceBetPercentageCalculation), currentPlayer, PLAYER_STATE_RESOURCE_GOLD)
            call ResourseRefresh(currentPlayer)
            set ResourceBetPercentageGoldReward[playerId] = ResourceBetPercentageCalculation
        endif

        // We don't support betting for simultaneous duels, so there should only be one duel with two forces
        if (IsPlayerInForce(currentPlayer, Team1BettingForce) == true) then
            call DisplayTimedTextToForce(GetPlayersAll(), 2.00, "|c00F08000" + GetPlayerNameColour(currentPlayer) + " placed a bet on " + ConvertForceToUnitString(CurrentDuelGame.team1) + "!")
        else
            call DisplayTimedTextToForce(GetPlayersAll(), 2.00, "|c00F08000" + GetPlayerNameColour(currentPlayer) + " placed a bet on " + ConvertForceToUnitString(CurrentDuelGame.team2) + "!")
        endif
    endfunction

    private function init takes nothing returns nothing
        set PlacePercentageBetTrigger = CreateTrigger()
        call TriggerRegisterDialogEventBJ(PlacePercentageBetTrigger, BettingDialogs[3])
        call TriggerAddCondition(PlacePercentageBetTrigger, Condition(function PlacePercentageBetConditions))
        call TriggerAddAction(PlacePercentageBetTrigger, function PlacePercentageBetActions)
    endfunction

endlibrary
