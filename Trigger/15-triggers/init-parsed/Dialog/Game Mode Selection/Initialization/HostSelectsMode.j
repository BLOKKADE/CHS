library HostSelectsMode initializer init requires RandomShit

    private function HostSelectsModeConditions takes nothing returns boolean
        return GetClickedButton() != udg_buttons04[0]
    endfunction

    private function NotHostPlayerFilter takes nothing returns boolean
        return GetFilterPlayer() != HostPlayer
    endfunction

    private function HostSelectsModeActions takes nothing returns nothing
        local force otherPlayersForce

        // Only the admin player votes
        set udg_boolean15 = false
        call ConditionalTriggerExecute(DialogInitializationTrigger)

        // Don't show the message if there is only 1 person in the game
        if (InitialPlayerCount == 1)then
            return
        endif

        // Show the message to everyone except the admin player
        set otherPlayersForce = GetPlayersMatching(Condition(function NotHostPlayerFilter))
        call DisplayTimedTextToForce(otherPlayersForce, 8.00, "|cffffcc00Please wait! The host is choosing a game mode.")
        call PlaySoundBJ(udg_sound25)

        // Cleanup
        call DestroyForce(otherPlayersForce)
        set otherPlayersForce = null
    endfunction

    private function init takes nothing returns nothing
        set HostSelectsModeTrigger = CreateTrigger()
        call TriggerRegisterDialogEventBJ(HostSelectsModeTrigger, udg_dialog06)
        call TriggerAddCondition(HostSelectsModeTrigger, Condition(function HostSelectsModeConditions))
        call TriggerAddAction(HostSelectsModeTrigger, function HostSelectsModeActions)
    endfunction

endlibrary
