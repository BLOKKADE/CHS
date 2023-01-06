library InitializePvp initializer init requires RandomShit, PvpRoundRobin, VotingResults, PvpHelper
    globals
        real pvpWaitDuration = 25
    endglobals

    private function InitializePvpActions takes nothing returns nothing
        call TriggerSleepAction(2.00)
        
        // Setup the fights
        call ResetPvpState()
        call UpdatePlayerCount()
        call MoveRoundRobin()
        
        // Message about the fights
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call CreateTimerDialogBJ(GetLastCreatedTimerBJ(), "PvP Battle")
        call StartTimerBJ(GetLastCreatedTimerBJ(), false, pvpWaitDuration)
        call DisplayTimedTextToForce(GetPlayersAll(), pvpWaitDuration, "|cff9dff00You can freely use items during PvP. They will be restored when finished.|r \n|cffff5050You will lose any items bought during the duel.")

        if (OddPlayer != -1) then
            call DisplayTimedTextToForce(GetPlayersAll(), pvpWaitDuration, "|cffffcc00There is an odd amount of players. The odd player|r " + GetUnitNamePlayerColour(PlayerHeroes[GetPlayerId(Player(OddPlayer)) + 1]) + " |cffffcc00will duel the loser of the first finished duel.|r")
        endif

        call DisplayNemesisNames()
        call TriggerSleepAction(pvpWaitDuration)
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())

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

    private function init takes nothing returns nothing
        set InitializePvpTrigger = CreateTrigger()
        call TriggerAddAction(InitializePvpTrigger,function InitializePvpActions)
    endfunction

endlibrary
