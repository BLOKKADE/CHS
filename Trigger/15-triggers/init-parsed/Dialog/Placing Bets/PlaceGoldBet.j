library PlaceGoldBet initializer init requires RandomShit, InitializeBettingDialogs

    private function PlaceGoldBetConditions takes nothing returns boolean
        return GetClickedButton() == BettingDialogButtons[5]
    endfunction

    private function PlaceGoldBetActions takes nothing returns nothing
        local player currentPlayer = GetTriggerPlayer()
        local integer playerId = GetPlayerId(currentPlayer)

        // Check the player actually has any gold
        if (GetPlayerState(currentPlayer, PLAYER_STATE_RESOURCE_GOLD) > 0) then
            call DialogSetMessage(BettingDialogs[3], "Betting Menu")
            call DialogDisplay(currentPlayer, BettingDialogs[3], true)
            set PlayerPlacedGoldBet[playerId] = true
            set PlayerPlacedLumberBet[playerId] = false
        else
            // Check if they took too long trying to bet
            if (AllowBetSelection == true) then
                // Go to the next dialog
                call DialogDisplay(currentPlayer, BettingDialogs[2], true)
            endif
        endif

        // Cleanup
        set currentPlayer = null
    endfunction

    private function init takes nothing returns nothing
        set PlaceGoldBetTrigger = CreateTrigger()
        call TriggerRegisterDialogEventBJ(PlaceGoldBetTrigger, BettingDialogs[2])
        call TriggerAddCondition(PlaceGoldBetTrigger, Condition(function PlaceGoldBetConditions))
        call TriggerAddAction(PlaceGoldBetTrigger, function PlaceGoldBetActions)
    endfunction

endlibrary
