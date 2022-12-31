library trigger122 initializer init requires RandomShit, SaveCommand, Scoreboard

    private function Trig_Victory_Func001Func001C takes nothing returns boolean
        if (not(IsTriggerEnabled(GetTriggeringTrigger())==true)) then
            return false
        endif
        if (not(InitialPlayerCount > 1)) then
            return false
        endif
        if (not(PlayerCount==1)) then
            return false
        endif
        if (not(GameComplete==false)) then
            return false
        endif
        return true
    endfunction

    private function Trig_Victory_Func001Func002Func003Func001C takes nothing returns boolean
        if (not(GameModeShort==true)) then
            return false
        endif
        if (not(RoundNumber==25)) then
            return false
        endif
        if (not(ElimModeEnabled==false)) then
            return false
        endif
        return true
    endfunction

    private function Trig_Victory_Func001Func002Func003Func002C takes nothing returns boolean
        if (not(GameModeShort==false)) then
            return false
        endif
        if (not(RoundNumber==50)) then
            return false
        endif
        if (not(ElimModeEnabled==false)) then
            return false
        endif
        return true
    endfunction

    private function Trig_Victory_Func001Func002Func003C takes nothing returns boolean
        if (Trig_Victory_Func001Func002Func003Func001C()) then
            return true
        endif
        if (Trig_Victory_Func001Func002Func003Func002C()) then
            return true
        endif
        return false
    endfunction

    private function Trig_Victory_Func001Func002C takes nothing returns boolean
        if (not(InitialPlayerCount==1)) then
            return false
        endif
        if (not(PlayerCount==1)) then
            return false
        endif
        if (not Trig_Victory_Func001Func002Func003C()) then
            return false
        endif
        return true
    endfunction

    private function Trig_Victory_Func001C takes nothing returns boolean
        if (Trig_Victory_Func001Func001C()) then
            return true
        endif
        if (Trig_Victory_Func001Func002C()) then
            return true
        endif
        return false
    endfunction

    private function EndGameConditions takes nothing returns boolean
        if (not Trig_Victory_Func001C()) then
            return false
        endif
        return true
    endfunction

    private function AutoSaveForPlayer takes nothing returns nothing
        if (GetPlayerSlotState(GetEnumPlayer()) == PLAYER_SLOT_STATE_PLAYING) then
            call SaveCommand_SaveCodeForPlayer(GetEnumPlayer(), false)
        endif
    endfunction

    private function GetWinner takes nothing returns nothing
        local integer i = 0

        set WinningPlayer = Player(PLAYER_NEUTRAL_PASSIVE)

        loop
            if UnitAlive(PlayerHeroes[i + 1]) then
                // call BJDebugMsg(GetPlayerName(Player(i)) + ", hero alive: " + GetUnitName(PlayerHeroes[i+1]))
                set WinningPlayer = Player(i)
            endif

            set i = i + 1
            exitwhen i > 8
        endloop
    endfunction

    private function EndGameActions takes nothing returns nothing
        local PlayerStats ps

        set GameComplete = true
        call DisableTrigger(AllPlayersDeadTrigger)
        call DisableTrigger(PlayerHeroDeathTrigger)

        if (BrStarted == false) then
            call EnableTrigger(HeroDiesInRoundTrigger)
        endif

        call ConditionalTriggerExecute(IsGameFinishedTrigger)

        // Get the winner before the trigger sleep
        call GetWinner()
        call TriggerSleepAction(2)

        if (InitialPlayerCount == 1 and PlayerCount == 1) then
            call DisplayTimedTextToForce(GetPlayersAll(), 30, "|cffffcc00You survived all levels! Congratulations!!")
        else
            if WinningPlayer != Player(PLAYER_NEUTRAL_PASSIVE) then
                call DisplayTimedTextToForce(GetPlayersAll(), 30, GameDescription)
                call DisplayTimedTextToForce(GetPlayersAll(), 30, GetPlayerNameColour(WinningPlayer) + " |cffffcc00survived longer than all other players! Congratulations!!")

                call UpdateScoreboardBrWinner(WinningPlayer)

                if BrStarted and (CountPlayersInForceBJ(FORCE_PLAYING) > 1) then
                    // Update the player's stats that they won a BR
                    set ps = PlayerStats.forPlayer(WinningPlayer)
                    call ps.addBRWin()

                    call DisplayTimedTextToForce(GetPlayersAll(), 30, GetPlayerNameColour(WinningPlayer) + " has |cffc2154f" + I2S(ps.getSeasonBRWins()) + "|r Battle Royale wins this season, |cffc2154f" + I2S(ps.getAllBRWins()) + "|r all time for this game mode")
                    call DisplayTimedTextToForce(GetPlayersAll(), 30, "|cffff0000Patch 1.33 broke saving/loading.|r\n|cff00ff15Restart Warcraft after every game to make sure your stats are properly saved!|r")
                endif
            else
                call DisplayTimedTextToForce(GetPlayersAll(), 30, GameDescription)
                call DisplayTimedTextToForce(GetPlayersAll(), 30, "|cffff7b00No winner detected.|r |cffffcc00That sucks bro, the game ends here.")
            endif
        endif

        call EndThematicMusicBJ()
        call SetMusicVolumeBJ(0.00)
        call PlaySoundBJ(udg_sound05)
        call DisableTrigger(udg_trigger87)
        call TriggerSleepAction(2.00)
        call DisplayTimedTextToForce(GetPlayersAll(), 30.00, "|cffffcc00Thank you for playing|r " + "|cff7bff00" + CurrentGameVersion.getVersionString() + "|r")

        // Save everyones codes
        call ForForce(GetPlayersAll(), function AutoSaveForPlayer)
    endfunction

    private function init takes nothing returns nothing
        set EndGameTrigger = CreateTrigger()
        call TriggerAddCondition(EndGameTrigger, Condition(function EndGameConditions))
        call TriggerAddAction(EndGameTrigger, function EndGameActions)
    endfunction

endlibrary
