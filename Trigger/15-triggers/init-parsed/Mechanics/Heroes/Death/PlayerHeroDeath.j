library trigger80 initializer init requires RandomShit, DebugCommands, AchievementsFrame, PetDeath, Scoreboard

    private function IsUnitNotHeroOrCreep takes unit u returns boolean
        return IsUnitType(u, UNIT_TYPE_HERO) == false or GetOwningPlayer(u) == Player(8) or GetOwningPlayer(u) == Player(11) or IsUnitInGroup(u, DuelingHeroGroup)
    endfunction

    private function RemoveUnitsInArena takes nothing returns boolean
        local unit u = GetFilterUnit()

        if (not IsUnitType(u, UNIT_TYPE_HERO) and not DUMMIES.contains(GetUnitTypeId(u))) then
            call DeleteUnit(u)
        endif

        return false
    endfunction

    private function EnableDeathTrigger takes nothing returns nothing
        local integer pid = GetTimerData(GetExpiredTimer())
        local unit u = PlayerHeroes[pid+1]
        local location arenaLocation = GetRectCenter(RectMidArena)
        local PlayerStats ps = PlayerStats.forPlayer(GetOwningPlayer(u))

        call ReviveHeroLoc(u,arenaLocation,true)
        call AchievementsFrame_TryToSummonPet(ps.getPetIndex(), GetOwningPlayer(u), false)

        call FixAbominationPassive(u)
        call PanCameraToForPlayer(GetOwningPlayer(u),GetUnitX(u),GetUnitY(u))
        call ReleaseTimer(GetExpiredTimer())

        call RemoveLocation(arenaLocation)
        set arenaLocation = null
        set u = null
    endfunction

    private function PlayerHeroDeathConditions takes nothing returns boolean
        local unit u = GetDyingUnit()
        local integer pid = GetPlayerId(GetOwningPlayer(u))
        local location arenaLocation
        local PlayerStats ps = PlayerStats.forPlayer(GetOwningPlayer(u))

        //call BJDebugMsg(GetUnitName(u))
        if IsUnitNotHeroOrCreep(u) then
            set u = null
            return false
        endif

        call StopRectLeaveDetection(GetHandleId(u))
        
        //immortal mode
        if ModeNoDeath == true and BrStarted == false and GetPlayerSlotState(GetOwningPlayer(u)) != PLAYER_SLOT_STATE_LEFT then
            set arenaLocation = GetRectCenter(RectMidArena)
            call ReviveHeroLoc(u,arenaLocation,true)
            call AchievementsFrame_TryToSummonPet(ps.getPetIndex(), GetOwningPlayer(u), false)

            call FixAbominationPassive(u)
            call PanCameraToForPlayer(GetOwningPlayer(u),GetUnitX(u),GetUnitY(u))

            call GroupEnumUnitsInRect(ENUM_GROUP, PlayerArenaRects[pid + 1], Condition( function RemoveUnitsInArena))
            
            call RemoveLocation(arenaLocation)
            set arenaLocation = null
            set u = null
            return false
        endif
    
        if Lives[GetPlayerId(GetOwningPlayer(u))] > 0 and BrStarted == false and GetPlayerSlotState(GetOwningPlayer(u)) != PLAYER_SLOT_STATE_LEFT then
            call TimerStart(NewTimerEx(pid), 1, false, function EnableDeathTrigger)
            set RoundLiveLost[pid] = true
            
            call GroupEnumUnitsInRect(ENUM_GROUP, PlayerArenaRects[pid + 1], Condition( function RemoveUnitsInArena))
    
            set Lives[pid] = Lives[pid] - 1
            call DisplayTextToPlayer(GetOwningPlayer(u) ,0,0,"You have " + I2S(Lives[pid]) + " lives left")
            
            set u = null
            return false
        endif
    
        set u = null
        return true
    endfunction

    //removes all of a players units
    private function DeleteUnits takes nothing returns nothing
        call DeleteUnit(GetEnumUnit())
    endfunction

    private function FilterCreeps takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())==Player(11))
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
        
        call DisableTrigger(HeroPassivePetDeathTrigger)
        call ForGroup(playerUnits, function DeleteUnits)

        // Cleanup
        call DestroyGroup(playerUnits)
        set playerUnits = null

        call EnableTrigger(HeroPassivePetDeathTrigger)
    
        if (GetPlayerController(currentPlayer) == MAP_CONTROL_USER) then
            call DialogSetMessage(udg_dialog04, "Defeat!")
            call DialogDisplay(currentPlayer, udg_dialog04, true)
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

            if (RectContainsUnit(PlayerArenaRects[playerArenaIndex], GetTriggerUnit())) then
                set playerArenaUnits = GetUnitsInRectMatching(PlayerArenaRects[playerArenaIndex], Condition(function FilterCreeps))

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
