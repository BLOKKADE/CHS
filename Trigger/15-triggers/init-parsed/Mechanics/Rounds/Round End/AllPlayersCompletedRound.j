library AllPlayersCompletedRound initializer init requires RandomShit, EconomyCreepBonus, VotingResults

    globals
        integer BattleRoyalRound = 50
        real RoundTime = 20
        timer RoundWaitTimer
        timerdialog RoundWaitTimerDialog
    endglobals

    public function StartNextRound takes nothing returns nothing
        if (NextRound[RoundNumber + 1]) then
            if (IncomeMode == 3) then
                call SetEconomyCreepBonus()
            endif

            set NextRound[RoundNumber + 1] = false
            call ReleaseTimer(RoundWaitTimer)
            call DestroyTimerDialog(RoundWaitTimerDialog)

            set RoundWaitTimer = null
            call TriggerExecute(StartLevelTrigger)
        endif
    endfunction

    private function IsGameOver takes nothing returns boolean
        return (IsTriggerEnabled(IsGameFinishedTrigger) != true) or (GameComplete != true and IsTriggerEnabled(AllPlayersDeadTrigger) != true and InitialPlayerCount != 1)
    endfunction

    private function IsShortPvpRound takes nothing returns boolean
        return (PlayerCount > 1) and (ElimModeEnabled == false) and (RoundNumber == 5 or RoundNumber == 10 or RoundNumber == 15 or RoundNumber == 20)
    endfunction

    private function IsPvpRound takes nothing returns boolean
        return RoundNumber != 0 and RoundNumber != 50 and ModuloInteger(RoundNumber, 5) == 0
    endfunction

    private function EndroundEventForAllPlayers takes nothing returns nothing
        local integer i = 0
        loop
            call CustomGameEvent_FireEvent(EVENT_GAME_ROUND_END, EventInfo.create(Player(i), 0, RoundNumber))
            set i = i + 1
            exitwhen i == 8
        endloop
    endfunction

    private function AllPlayersCompletedRoundActions takes nothing returns nothing
        if (RoundFinishedCount >= PlayerCount) and RoundWaitTimer == null then
            if (IsGameOver()) then
                return
            endif

            call DisableTrigger(SuddenDeathCreepTimerTrigger)
            call StopSuddenDeathTimer()
            call DisableTrigger(PlayerAntiStuckTrigger)
            call ConditionalTriggerExecute(EndGameTrigger)
            call ConditionalTriggerExecute(IsGameFinishedTrigger)

            call EndroundEventForAllPlayers()
            
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

            set RoundWaitTimer = NewTimer()
            set RoundWaitTimerDialog = CreateTimerDialog(RoundWaitTimer)
            call TimerDialogSetTitle(RoundWaitTimerDialog, "Next Level...")
            call TimerDialogDisplay(RoundWaitTimerDialog, true)

            set NextRound[RoundNumber + 1] = true
            
            call TimerStart(RoundWaitTimer, RoundTime, false, function StartNextRound)
        endif
    endfunction

    private function init takes nothing returns nothing
        set AllPlayersCompletedRoundTrigger = CreateTrigger()
        set RoundWaitTimer = null 
        call TriggerAddAction(AllPlayersCompletedRoundTrigger, function AllPlayersCompletedRoundActions)
    endfunction

endlibrary
