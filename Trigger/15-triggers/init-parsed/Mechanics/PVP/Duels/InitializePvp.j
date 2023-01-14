library InitializePvp initializer init requires RandomShit, PvpRoundRobin, VotingResults, PvpHelper
    globals
        real pvpWaitDuration = 25
        timer PvpWaitTimer
        timerdialog PvpWaitTimerDialog
        boolean WaitingForPvp = false
    endglobals

    private function StartPvpBattles takes nothing returns nothing
        // Remove any crap in the map before the duels
        call RemoveUnitsInRect(bj_mapInitialPlayableArea)

        // Run the fights
        if (SimultaneousDuelMode == 2) then
            loop
                exitwhen DuelGameListRemaining.size() == 0

                call InitializeDuelGame(GetNextDuel())
            endloop
        else
            call InitializeDuelGame(GetNextDuel())
        endif

        call TriggerSleepAction(0.20) // Copied from initial trigger. Probably to take a small breath before showing betting screens

        call PlaySoundBJ(udg_sound08) // Horn noise!

        call StartDuels()
    endfunction

    function StartPvp takes nothing returns nothing
        set WaitingForPvp = false
        call DestroyTimer(PvpWaitTimer)
        call DestroyTimerDialog(PvpWaitTimerDialog)
        call StartPvpBattles.execute()
    endfunction

    private function InitializePvpActions takes nothing returns nothing
        call TriggerSleepAction(2.00)
        
        // Setup the fights
        call ResetPvpState()
        call UpdatePlayerCount()
        call MoveRoundRobin()
        
        // Message about the fights
        set PvpWaitTimer = CreateTimer()
        set PvpWaitTimerDialog = CreateTimerDialog(PvpWaitTimer)
        call TimerDialogSetTitle(PvpWaitTimerDialog, "PvP Battle...")
        call TimerDialogDisplay(PvpWaitTimerDialog, true)
        call TimerStart(PvpWaitTimer, pvpWaitDuration, false, function StartPvp)
        call DisplayTimedTextToForce(GetPlayersAll(), pvpWaitDuration, "|cff9dff00You can freely use items during PvP. They will be restored when finished.|r \n|cffff5050You will lose any items bought during the duel.")

        if (OddPlayer != -1) then
            call DisplayTimedTextToForce(GetPlayersAll(), pvpWaitDuration, "|cffffcc00There is an odd amount of players. The odd player|r " + GetUnitNamePlayerColour(PlayerHeroes[GetPlayerId(Player(OddPlayer))]) + " |cffffcc00will duel the loser of the first finished duel.|r")
        endif

        set WaitingForPvp = true

        call DisplayNemesisNames()
    endfunction

    private function init takes nothing returns nothing
        set InitializePvpTrigger = CreateTrigger()
        call TriggerAddAction(InitializePvpTrigger,function InitializePvpActions)
    endfunction

endlibrary
