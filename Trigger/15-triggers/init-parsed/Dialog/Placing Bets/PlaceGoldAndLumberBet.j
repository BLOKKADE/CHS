library PlaceGoldAndLumberBet initializer init requires RandomShit

    private function PlaceGoldAndLumberBetConditions takes nothing returns boolean
        return GetClickedButton() == DialogButtons[6]
    endfunction

    private function PlaceGoldAndLumberBetActions takes nothing returns nothing
        local player currentPlayer = GetTriggerPlayer()
        local integer playerId = GetConvertedPlayerId(currentPlayer)

        // Check the player actually has any gold and lumber
        if (GetPlayerState(currentPlayer, PLAYER_STATE_RESOURCE_GOLD) > 0 and GetPlayerState(currentPlayer, PLAYER_STATE_RESOURCE_LUMBER) > 0) then
            call DialogSetMessage(Dialogs[3], "Betting Menu")
            call DialogDisplay(currentPlayer, Dialogs[3], true)
            set PlayerPlacedGoldBet[playerId] = true
            set PlayerPlacedLumberBet[playerId] = true
        else
            // Check if they took too long trying to bet
            if (AllowBetSelection == true) then
                // Go to the next dialog
                call DialogDisplay(currentPlayer, Dialogs[2], true)
            endif
        endif

        // Cleanup
        set currentPlayer = null
    endfunction

    private function init takes nothing returns nothing
        set PlaceGoldAndLumberBetTrigger = CreateTrigger()
        call TriggerRegisterDialogEventBJ(PlaceGoldAndLumberBetTrigger, Dialogs[2])
        call TriggerAddCondition(PlaceGoldAndLumberBetTrigger, Condition(function PlaceGoldAndLumberBetConditions))
        call TriggerAddAction(PlaceGoldAndLumberBetTrigger, function PlaceGoldAndLumberBetActions)
    endfunction

endlibrary
