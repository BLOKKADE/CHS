library CancelBetting initializer init requires RandomShit, InitializeBettingDialogs

    private function CancelBettingConditions takes nothing returns boolean
        // These are buttons the 3 different betting dialogs that have a cancel button
        return GetClickedButton() == BettingDialogButtons[3] or GetClickedButton() == BettingDialogButtons[7] or GetClickedButton() == BettingDialogButtons[11]
    endfunction

    private function CancelBettingActions takes nothing returns nothing
        local player currentPlayer = GetTriggerPlayer()
        local integer dialogIndex = 1

        // Remove the player from any betting forces
        call ForceRemovePlayer(Team1BettingForce, currentPlayer)
        call ForceRemovePlayer(Team2BettingForce, currentPlayer)

        // Close any possible dialogs
        loop
            exitwhen dialogIndex > 3
            call DialogDisplay(currentPlayer, BettingDialogs[dialogIndex], false)
            set dialogIndex = dialogIndex + 1
        endloop

        // Cleanup
        set currentPlayer = null
    endfunction

    private function init takes nothing returns nothing
        set CancelBettingTrigger = CreateTrigger()
        call TriggerRegisterDialogEventBJ(CancelBettingTrigger, BettingDialogs[1])
        call TriggerAddCondition(CancelBettingTrigger, Condition(function CancelBettingConditions))
        call TriggerAddAction(CancelBettingTrigger, function CancelBettingActions)
    endfunction

endlibrary
