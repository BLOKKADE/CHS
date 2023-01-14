library DialogInitialization initializer init requires RandomShit, VotingScreen

    private function ShowVotingDialogToPlayer takes nothing returns nothing
        if (InitialPlayerCount > 1) then
            if (udg_boolean15 == true) then // If everyone should vote
                if GetLocalPlayer() == GetEnumPlayer() then
                    call BlzFrameSetVisible(MainVotingFrameHandle, true)
                endif
            else
                if GetLocalPlayer() == HostPlayer then
                    call BlzFrameSetVisible(MainVotingFrameHandle, true)
                endif
            endif
        else
            if GetLocalPlayer() == GetEnumPlayer() then
                call BlzFrameSetVisible(MainVotingFrameHandle, true)
            endif
        endif
    endfunction

    private function DialogInitializationActions takes nothing returns nothing
        call EnableTrigger(GetTriggeringTrigger())

        call ForForce(GetPlayersAll(), function ShowVotingDialogToPlayer)

        if (IsTriggerEnabled(GameModeQuestSetupTrigger) != true) then
            return
        endif

        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call CreateTimerDialogBJ(GetLastCreatedTimerBJ(), "Mode Selection")
        call StartTimerBJ(GetLastCreatedTimerBJ(), false, 25.00)
        call TriggerSleepAction(25.00)

        if (IsTriggerEnabled(GameModeQuestSetupTrigger) != true) then
            return
        endif

        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call BlzFrameSetVisible(MainVotingFrameHandle, false)

        if (IsTriggerEnabled(GameModeQuestSetupTrigger) == true) then
            call TriggerExecute(GameModeQuestSetupTrigger)
        endif
    endfunction

    private function init takes nothing returns nothing
        set DialogInitializationTrigger = CreateTrigger()
        call DisableTrigger(DialogInitializationTrigger)
        call TriggerAddAction(DialogInitializationTrigger, function DialogInitializationActions)
    endfunction

endlibrary
