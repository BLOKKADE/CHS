library EndGame initializer init requires RandomShit, SaveCommand, Scoreboard, BattleRoyaleHelper

    globals
        private force AwardedPlayers = CreateForce()
    endglobals

    private function IsOnlyOnePlayerRemaining takes nothing returns boolean
        return (IsTriggerEnabled(GetTriggeringTrigger()) == true) and (InitialPlayerCount > 1) and (PlayerCount == 1) and (GameComplete == false)
    endfunction

    private function IsShortGameComplete takes nothing returns boolean
        return (GameModeShort == true) and (RoundNumber == 25) and (ElimModeEnabled == false)
    endfunction

    private function IsLongGameComplete takes nothing returns boolean
        return (GameModeShort == false) and (RoundNumber == 50) and (ElimModeEnabled == false)
    endfunction

    private function IsShortOrLongGameComplete takes nothing returns boolean
        return IsShortGameComplete() or IsLongGameComplete()
    endfunction

    private function IsInitialSoloPlayerGame takes nothing returns boolean
        return (InitialPlayerCount == 1) and (PlayerCount == 1) and IsShortOrLongGameComplete()
    endfunction

    private function EndGameConditions takes nothing returns boolean
        return IsOnlyOnePlayerRemaining() or IsInitialSoloPlayerGame() or (BrStarted and IsBROver())
    endfunction

    private function ShowScoreboardForPlayer takes nothing returns nothing
        call PlayerStats.forPlayer(GetEnumPlayer()).setHasScoreboardOpen(true)
    endfunction

    private function AutoSaveForPlayer takes nothing returns nothing
        if (GetPlayerSlotState(GetEnumPlayer()) == PLAYER_SLOT_STATE_PLAYING and GetPlayerController(GetEnumPlayer()) == MAP_CONTROL_USER) then
            call SaveCommand_SaveCodeForPlayer(GetEnumPlayer(), false)
        endif
    endfunction

    private function MakeWinnerInvulnerable takes nothing returns nothing
        call SetUnitInvulnerable(PlayerHeroes[GetPlayerId(GetEnumPlayer())], true)

        call SetCurrentlyFighting(GetEnumPlayer(), false)

        // Extra cleanup
        call StopRectLeaveDetection(GetHandleId(PlayerHeroes[GetPlayerId(GetEnumPlayer())]))
    endfunction

    private function AddBRWinToPlayer takes nothing returns nothing
        // Update the player's stats that they won a BR
        local PlayerStats ps = PlayerStats.forPlayer(GetEnumPlayer())

        // Ensure a player doesn't get more than one BR win for some reason
        if (not IsPlayerInForce(GetEnumPlayer(), AwardedPlayers)) then
            call ForceAddPlayer(AwardedPlayers, GetEnumPlayer())

            call ps.addBRWin()

            call DisplayTimedTextToForce(GetPlayersAll(), 30, GameDescription)
            call DisplayTimedTextToForce(GetPlayersAll(), 30, GetPlayerNameColour(GetEnumPlayer()) + " |cffffcc00survived longer than all other players with " + ps.getBRPVPKillCount() + " Congratulations!!")
            call DisplayTimedTextToForce(GetPlayersAll(), 30, GetPlayerNameColour(GetEnumPlayer()) + " has |cffc2154f" + I2S(ps.getSeasonBRWins()) + "|r Battle Royale wins this season, |cffc2154f" + I2S(ps.getAllBRWins()) + "|r all time for this game mode")
        endif
    endfunction

    private function EndGameActions takes nothing returns nothing
        local force winningForce

        set GameComplete = true
        call DisableTrigger(AllPlayersDeadTrigger)
        call DisableTrigger(PlayerHeroDeathTrigger)

        call EventHelpers_FireEventForAllPlayers(EVENT_PLAYER_ROUND_COMPLETE, 0, RoundNumber, true)

        if (BrStarted == false) then
            call EnableTrigger(HeroDiesInRoundTrigger)
        endif

        call DestroyTimer(BattleRoyalRemoveLifeTimer)
        call ConditionalTriggerExecute(IsGameFinishedTrigger)

        // Get the winner before the trigger sleep
        set winningForce = GetBRWinningForce()

        if (winningForce != null) then
            call ForForce(winningForce, function MakeWinnerInvulnerable)
        endif

        call TriggerSleepAction(2)

        if (InitialPlayerCount == 1 and PlayerCount == 1) then
            call DisplayTimedTextToForce(GetPlayersAll(), 30, "|cffffcc00You survived all levels! Congratulations!!")
        else
            if (winningForce != null) then
                call UpdateScoreboardBrWinner(winningForce)

                call BlzFrameSetVisible(BRLivesFrameHandle, false)

                if (not IsFunBRRound) then
                    // There should only be one player in this force since there can only be one winner
                    call ForForce(winningForce, function AddBRWinToPlayer)
                else
                    call DisplayTimedTextToForce(GetPlayersAll(), 30, ConvertForceToString(winningForce) + " |cffffcc00survived longer than all other players. Congratulations!!")
                endif

                // Cleanup
                set winningForce = null
            else
                call DisplayTimedTextToForce(GetPlayersAll(), 30, GameDescription)
                call DisplayTimedTextToForce(GetPlayersAll(), 30, "|cffff7b00No winner detected.|r |cffffcc00That sucks bro, the game ends here.")
            endif
        endif

        call PlaySoundBJ(udg_sound05)
        call TriggerSleepAction(2.00)

        // Save everyones codes
        if (not IsFunBRRound) then
            call DisplayTimedTextToForce(GetPlayersAll(), 30.00, "|cffffcc00Thank you for playing|r " + "|cff7bff00" + CurrentGameVersion.getVersionString() + "|r")
            call DisplayTimedTextToForce(GetPlayersAll(), 30.00, "|cffff5a44Upload your save code to the CHS discord leaderboard!!!|r")
            call DisplayTimedTextToForce(GetPlayersAll(), 30.00, "|cff63ff44Stay for the fun BR rounds!!!|r")

            call ForForce(GetPlayersAll(), function AutoSaveForPlayer)
        endif

        // Show the scoreboard to everyone
        call TriggerSleepAction(3.00)
        call ForForce(GetPlayersAll(), function ShowScoreboardForPlayer) 
        call BlzFrameSetVisible(ScoreboardFrameHandle, true)

        set BattleRoyalTimer = CreateTimer()
        set BattleRoyalTimerDialog = CreateTimerDialog(BattleRoyalTimer)

        if (not IsFunBRRound) then
            call TimerDialogSetTitle(BattleRoyalTimerDialog, "Battle Royale Review...")
        else
            call TimerDialogSetTitle(BattleRoyalTimerDialog, "Fun Battle Royale Review...")
        endif

        call TimerDialogDisplay(BattleRoyalTimerDialog, true)

        call TimerStart(BattleRoyalTimer, BattleRoyalReviewWaitTime, false, function InitializeFunBattleRoyale)
    endfunction

    private function init takes nothing returns nothing
        set EndGameTrigger = CreateTrigger()
        call TriggerAddCondition(EndGameTrigger, Condition(function EndGameConditions))
        call TriggerAddAction(EndGameTrigger, function EndGameActions)
    endfunction

endlibrary
