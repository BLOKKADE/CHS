library AllPlayersCompletedRound initializer init requires RandomShit, EconomyCreepBonus, VotingResults

    globals
        integer BattleRoyalRound = 50
    endglobals

    private function IsGameOver takes nothing returns boolean
        return (IsTriggerEnabled(IsGameFinishedTrigger) != true) or (GameComplete != true and IsTriggerEnabled(AllPlayersDeadTrigger) != true and InitialPlayerCount != 1)
    endfunction

    private function IsShortPvpRound takes nothing returns boolean
        return (PlayerCount > 1) and (ElimModeEnabled == false) and (RoundNumber == 5 or RoundNumber == 10 or RoundNumber == 15 or RoundNumber == 20)
    endfunction

    private function IsPvpRound takes nothing returns boolean
        if (RoundNumber == 5) then
            return true
        endif
        if (RoundNumber == 10) then
            return true
        endif
        if (RoundNumber == 15) then
            return true
        endif
        if (RoundNumber == 20) then
            return true
        endif
        if (RoundNumber == 25) then
            return true
        endif
        if (RoundNumber == 30) then
            return true
        endif	
        if (RoundNumber == 35) then
            return true
        endif	
        if (RoundNumber == 40) then
            return true
        endif	
        if (RoundNumber == 45) then
            return true
        endif	
    
        return false
    endfunction

    private function AllPlayersCompletedRoundActions takes nothing returns nothing
        local integer round = RoundNumber + 1

        if (RoundFinishedCount >= PlayerCount) then
            if (IsGameOver()) then
                return
            endif

            call DisableTrigger(SuddenDeathCreepTimerTrigger)
            call StopSuddenDeathTimer()
            call DisableTrigger(PlayerAntiStuckTrigger)
            call ConditionalTriggerExecute(EndGameTrigger)
            call ConditionalTriggerExecute(IsGameFinishedTrigger)
            
            set RoundFinishedCount = 0
            call PlaySoundBJ(udg_sound02)

            // Check if a PVP round should start
            if (GameModeShort == true and ElimModeEnabled == false) then
                if (IsShortPvpRound()) then
                    call ConditionalTriggerExecute(InitializePvpTrigger)
                    return
                endif
            else
                if (IsPvpRound() and (PlayerCount > 1) and (ElimModeEnabled == false)) then
                    call ConditionalTriggerExecute(InitializePvpTrigger)
                    return
                endif
            endif

            if (GameModeShort == true and ElimModeEnabled == false) then
                if (RoundNumber == BattleRoyalRound and ElimModeEnabled == false) then
                    if (PlayerCount == 1) then
                        //end game
                        call ConditionalTriggerExecute(IsGameFinishedTrigger)
                    else
                        //battle royal
                        call ConditionalTriggerExecute(InitializeBattleRoyaleTrigger)
                    endif
                    return
                endif
            else
                if (RoundNumber == BattleRoyalRound and ElimModeEnabled == false) then
                    if (PlayerCount == 1) then
                        //end game
                        call ConditionalTriggerExecute(IsGameFinishedTrigger)
                    else
                        //battle royal
                        call ConditionalTriggerExecute(InitializeBattleRoyaleTrigger)
                    endif
                    return
                endif
            endif

            call ConditionalTriggerExecute(GenerateNextCreepLevelTrigger)
            call CreateTimerDialogBJ(GetLastCreatedTimerBJ(), "Next Level ...")
            set NextRound[round] = true
            
            if (RoundNumber <= 3) then
                call StartTimerBJ(GetLastCreatedTimerBJ(), false, RoundTime)
                call TriggerSleepAction(RoundTime)
            else
                call StartTimerBJ(GetLastCreatedTimerBJ(), false, RoundTime * 0.75)
                call TriggerSleepAction(RoundTime * 0.75)
            endif

            if (IncomeMode == 3) then
                call SetEconomyCreepBonus()
            endif
    
            if (NextRound[round]) then
                call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
                call TriggerExecute(StartLevelTrigger)
            endif
        endif
    endfunction

    private function init takes nothing returns nothing
        set AllPlayersCompletedRoundTrigger = CreateTrigger()
        call TriggerAddAction(AllPlayersCompletedRoundTrigger, function AllPlayersCompletedRoundActions)
    endfunction

endlibrary
