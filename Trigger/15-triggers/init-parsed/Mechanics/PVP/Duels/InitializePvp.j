library InitializePvp initializer init requires RandomShit, PvpRoundRobin, VotingResults, PvpHelper

    private function InitializePvpActions takes nothing returns nothing
        call TriggerSleepAction(2.00)
        
        call GroupClear(DuelingHeroes) // DuelingHeroes keeps track of all heroes that are fighting
        call GroupClear(DuelWinners) // DuelWinners keeps track of all heroes that won
        call GroupClear(DuelWinnerDisabled) // DuelWinnerDisabled keeps track of all heroes that won and is used to prevent them from casting spells in other libraries
        call ForceClear(DuelLosers) // Players that lost the current duels
        
        // Setup the fights
        call UpdatePlayerCount()
        call MoveRoundRobin()
        
        // Message about the fights
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call CreateTimerDialogBJ(GetLastCreatedTimerBJ(), "PvP Battle")
        call StartTimerBJ(GetLastCreatedTimerBJ(), false, 25.00)
        call DisplayTimedTextToForce(GetPlayersAll(), 25, "|cff9dff00You can freely use items during PvP. They will be restored when finished.|r \n|cffff5050You will lose any items bought during the duel.\n|r|cffffcc00If there is an odd amount of players, losing a duel might mean you could duel again vs the last player.|r")
        call DisplayNemesisNames()
        call TriggerSleepAction(25.00)
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

        call StartDuels()
    endfunction

    private function init takes nothing returns nothing
        set InitializePvpTrigger = CreateTrigger()
        call TriggerAddAction(InitializePvpTrigger,function InitializePvpActions)
    endfunction

endlibrary
