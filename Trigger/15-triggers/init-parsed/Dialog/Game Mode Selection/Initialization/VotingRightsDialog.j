library VotingRightsDialog initializer init requires RandomShit

    private function VotingRightsDialogActions takes nothing returns nothing
        call ConditionalTriggerExecute(SetHostPlayerTrigger) // Determine who decides the game mode. Saved as HostPlayer
        
        // Don't bother showing the Voting rights if there is just one player in the game
        if (InitialPlayerCount == 1) then
            call TriggerExecute(HostSelectsModeTrigger)
            return
        endif

        call DialogSetMessageBJ(udg_dialog06, "Voting Rights")
        call DialogAddButtonBJ(udg_dialog06, GetPlayerNameColour(HostPlayer))

        // Everyone can vote option
        call DialogAddButtonBJ(udg_dialog06, "Everyone")
        set udg_buttons04[0] = GetLastCreatedButtonBJ()
        call DialogDisplayBJ(true, udg_dialog06, HostPlayer)
        call CreateTimerDialogBJ(GetLastCreatedTimerBJ(), "Please wait!")
        call StartTimerBJ(GetLastCreatedTimerBJ(), false, 15.00)
        call TriggerSleepAction(15.00)

        // If the player doesn't select anything, default to everyone voting
        if (IsTriggerEnabled(DialogInitializationTrigger) != true) then
            call DialogDisplayBJ(false, udg_dialog06, HostPlayer)
            call TriggerExecute(EveryoneVotesTrigger)
        endif
    endfunction

    private function init takes nothing returns nothing
        set VotingRightsDialogTrigger = CreateTrigger()
        call TriggerRegisterTimerEventSingle(VotingRightsDialogTrigger, 0.00)
        call TriggerAddAction(VotingRightsDialogTrigger, function VotingRightsDialogActions)
    endfunction

endlibrary
