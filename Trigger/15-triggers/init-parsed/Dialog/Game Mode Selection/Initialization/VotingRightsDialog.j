library VotingRightsDialog initializer init requires RandomShit

    private function VotingRightsDialogActions takes nothing returns nothing
        call ConditionalTriggerExecute(SetHostPlayerTrigger) // Determine who decides the game mode. Saved as HostPlayer

        // Don't bother showing the Voting rights if there is just one player in the game
        if (PlayerCount == 1) then
            call TriggerExecute(HostSelectsModeTrigger)
            return
        endif

        call DialogSetMessage(VotingRightsDialog, "Voting Rights")
        call DialogAddButtonBJ(VotingRightsDialog, GetPlayerNameColour(HostPlayer))

        // Everyone can vote option
        call DialogAddButtonBJ(VotingRightsDialog, "Everyone")
        set VotingRightButtons[0] = GetLastCreatedButtonBJ()
        call DialogDisplayBJ(true, VotingRightsDialog, HostPlayer)
        call CreateTimerDialogBJ(GetLastCreatedTimerBJ(), "Please wait!")
        call StartTimerBJ(GetLastCreatedTimerBJ(), false, 15.00)
        call TriggerSleepAction(15.00)

        // If the player doesn't select anything, default to everyone voting
        if (IsTriggerEnabled(DialogInitializationTrigger) != true) then
            call DialogDisplayBJ(false, VotingRightsDialog, HostPlayer)
            call TriggerExecute(EveryoneVotesTrigger)
        endif
    endfunction

    private function init takes nothing returns nothing
        set VotingRightsDialogTrigger = CreateTrigger()
        call TriggerAddAction(VotingRightsDialogTrigger, function VotingRightsDialogActions)
    endfunction

endlibrary
