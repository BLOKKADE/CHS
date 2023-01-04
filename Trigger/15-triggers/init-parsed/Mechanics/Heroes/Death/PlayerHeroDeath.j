library PlayerHeroDeath initializer init requires RandomShit, DebugCommands, AchievementsFrame, PetDeath, Scoreboard

    private function IsUnitNotHeroOrCreep takes unit currentUnit returns boolean
        return (IsUnitType(currentUnit, UNIT_TYPE_HERO) == false) or (GetOwningPlayer(currentUnit) == Player(8)) or (GetOwningPlayer(currentUnit) == Player(11)) or (IsUnitInGroup(currentUnit, DuelingHeroGroup) == true)
    endfunction

    private function RemoveUnitsInArena takes nothing returns boolean
        local unit currentUnit = GetFilterUnit()

        if (not IsUnitType(currentUnit, UNIT_TYPE_HERO) and not DUMMIES.contains(GetUnitTypeId(currentUnit))) then
            call DeleteUnit(currentUnit)
        endif

        // Cleanup
        set currentUnit = null

        return false
    endfunction

    private function EnableDeathTrigger takes nothing returns nothing
        local integer currentPlayerId = GetTimerData(GetExpiredTimer())
        local unit currentUnit = PlayerHeroes[currentPlayerId + 1]
        local player currentPlayer = GetOwningPlayer(currentUnit)
        local location arenaLocation = GetRectCenter(RectMidArena)
        local PlayerStats ps = PlayerStats.forPlayer(currentPlayer)

        call ReviveHeroLoc(currentUnit, arenaLocation, true)
        call AchievementsFrame_TryToSummonPet(ps.getPetIndex(), currentPlayer, false)

        call FixAbominationPassive(currentUnit)

        if (not CamMoveDisabled[currentPlayerId]) then
            call PanCameraToForPlayer(currentPlayer, GetUnitX(currentUnit), GetUnitY(currentUnit))
        endif

        call ReleaseTimer(GetExpiredTimer())

        // Cleanup
        call RemoveLocation(arenaLocation)
        set arenaLocation = null
        set currentUnit = null
        set currentPlayer = null
    endfunction

    private function PlayerHeroDeathConditions takes nothing returns boolean
        local unit currentUnit = GetDyingUnit()
        local player currentPlayer = GetOwningPlayer(currentUnit)
        local integer currentPlayerId = GetPlayerId(currentPlayer)
        local PlayerStats ps = PlayerStats.forPlayer(currentPlayer)
        local location arenaLocation

        //call BJDebugMsg(GetUnitName(currentUnit))
        if IsUnitNotHeroOrCreep(currentUnit) then
            set currentUnit = null
            set currentPlayer = null
            return false
        endif

        call StopRectLeaveDetection(GetHandleId(currentUnit))
        
        //immortal mode
        if ModeNoDeath == true and BrStarted == false and GetPlayerSlotState(currentPlayer) != PLAYER_SLOT_STATE_LEFT then
            set arenaLocation = GetRectCenter(RectMidArena)
            call ReviveHeroLoc(currentUnit, arenaLocation,true)
            call AchievementsFrame_TryToSummonPet(ps.getPetIndex(), currentPlayer, false)

            call FixAbominationPassive(currentUnit)
            if not CamMoveDisabled[currentPlayerId] then
                call PanCameraToForPlayer(currentPlayer, GetUnitX(currentUnit), GetUnitY(currentUnit))
            endif

            call GroupEnumUnitsInRect(ENUM_GROUP, PlayerArenaRects[currentPlayerId + 1], Condition(function RemoveUnitsInArena))
            
            call RemoveLocation(arenaLocation)
            set arenaLocation = null
            set currentUnit = null
            set currentPlayer = null
            return false
        endif
    
        if Lives[GetPlayerId(currentPlayer)] > 0 and BrStarted == false and GetPlayerSlotState(currentPlayer) != PLAYER_SLOT_STATE_LEFT then
            call TimerStart(NewTimerEx(currentPlayerId), 1, false, function EnableDeathTrigger)
            set RoundLiveLost[currentPlayerId] = true
            
            call GroupEnumUnitsInRect(ENUM_GROUP, PlayerArenaRects[currentPlayerId + 1], Condition(function RemoveUnitsInArena))
    
            set Lives[currentPlayerId] = Lives[currentPlayerId] - 1
            call DisplayTextToPlayer(currentPlayer, 0, 0, "You have " + I2S(Lives[currentPlayerId]) + " lives left")
            
            set currentUnit = null
            set currentPlayer = null
            return false
        endif
    
        // Cleanup
        set currentPlayer = null
        set currentUnit = null

        return true
    endfunction

    private function RemovePlayerUnit takes nothing returns nothing
        call DeleteUnit(GetEnumUnit())
    endfunction

    private function FilterCreeps takes nothing returns boolean
        return (GetOwningPlayer(GetFilterUnit()) == Player(11))
    endfunction

    private function DeleteUnitsFromRect takes nothing returns nothing
        call DisableTrigger(PlayerCompleteRoundTrigger)
        call DeleteUnit(GetEnumUnit())
        call EnableTrigger(PlayerCompleteRoundTrigger)
    endfunction

    private function PlayerHeroDeathActions takes nothing returns nothing
        local player currentPlayer = GetOwningPlayer(GetTriggerUnit())
        local group playerUnits = GetUnitsOfPlayerAll(currentPlayer)
        local integer playerArenaIndex = 0
        local group playerArenaUnits

        call StopSoundBJ(udg_sound13,false)
        call PlaySoundBJ(udg_sound13)
        call ForceAddPlayer(DefeatedPlayers, currentPlayer)

        set PlayerCount = PlayerCount - 1
        call AllowSinglePlayerCommands()
        
        // Mark the round the player died on
        call UpdateScoreboardPlayerDies(currentPlayer, RoundNumber)

        call DisplayTimedTextToForce(GetPlayersAll(), 5.00, GetPlayerNameColour(currentPlayer) + "|cffC60000 was defeated!|r")
        call GroupRemoveUnit(OnPeriodGroup, PlayerHeroes[GetPlayerId(currentPlayer) + 1])
        
        call DisableTrigger(FaerieDragonDiesTrigger)
        call ForGroup(playerUnits, function RemovePlayerUnit)

        // Cleanup
        call DestroyGroup(playerUnits)
        set playerUnits = null

        call EnableTrigger(FaerieDragonDiesTrigger)
    
        if (GetPlayerController(currentPlayer) == MAP_CONTROL_USER) then
            call DialogSetMessage(DeathDialog, "Defeat!")
            call DialogDisplay(currentPlayer, DeathDialog, true)
        else
            call CustomDefeatBJ(currentPlayer, "Defeat!")
        endif
    
        // Cleanup
        set currentPlayer = null

        if (BrStarted) then
            call ConditionalTriggerExecute(EndGameTrigger)
        endif
    
        call ConditionalTriggerExecute(AllPlayersDeadTrigger)
        call TriggerSleepAction(2)
        call StopSoundBJ(udg_sound13,true)
        call StopSoundBJ(udg_sound12,false)
        call PlaySoundBJ(udg_sound12)
    
        set playerArenaIndex = 0
        loop
            exitwhen playerArenaIndex == 8

            if (RectContainsUnit(PlayerArenaRects[playerArenaIndex + 1], GetTriggerUnit())) then
                set playerArenaUnits = GetUnitsInRectMatching(PlayerArenaRects[playerArenaIndex + 1], Condition(function FilterCreeps))

                call ForGroup(playerArenaUnits, function DeleteUnitsFromRect)

                // Cleanup
                call DestroyGroup(playerArenaUnits)
                set playerArenaUnits = null
            endif

            set playerArenaIndex = playerArenaIndex + 1
        endloop
    
        call ConditionalTriggerExecute(AllPlayersCompletedRoundTrigger)
    endfunction

    private function init takes nothing returns nothing
        set PlayerHeroDeathTrigger = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(PlayerHeroDeathTrigger, EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(PlayerHeroDeathTrigger, Condition(function PlayerHeroDeathConditions))
        call TriggerAddAction(PlayerHeroDeathTrigger, function PlayerHeroDeathActions)
    endfunction

endlibrary
