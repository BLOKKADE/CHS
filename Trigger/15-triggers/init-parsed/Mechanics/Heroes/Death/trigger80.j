library trigger80 initializer init requires RandomShit, DebugCommands, AchievementsFrame, PetDeath

    function IsUnitNotHeroOrCreep takes unit u returns boolean
        return IsUnitType(u, UNIT_TYPE_HERO) == false or GetOwningPlayer(u) == Player(8) or GetOwningPlayer(u) == Player(11) or IsUnitInGroup(u, DuelingHeroGroup)
    endfunction

    function RemoveUnitsInArena takes nothing returns boolean
        local unit u = GetFilterUnit()

        if not IsUnitType(u, UNIT_TYPE_HERO) and not DUMMIES.contains(GetUnitTypeId(u)) then
            call DeleteUnit(u)
        endif

        return false
    endfunction

    function EnableDeathTrigger takes nothing returns nothing
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


    function Trig_Hero_Dies_Conditions takes nothing returns boolean
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
    function Trig_Hero_Dies_Func008A takes nothing returns nothing
        call DeleteUnit(GetEnumUnit())
    endfunction


    function Trig_Hero_Dies_Func011C takes nothing returns boolean
        if(not(GetPlayerController(GetOwningPlayer(GetTriggerUnit()))==MAP_CONTROL_USER))then
            return false
        endif
        return true
    endfunction

    function Trig_Hero_Dies_Func016C takes nothing returns boolean
        if(not(BrStarted==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Hero_Dies_Func024Func001C takes nothing returns boolean
        if(not(RectContainsUnit(PlayerArenaRects[udg_integer42],GetTriggerUnit())==true))then
            return false
        endif
        return true
    endfunction

    function Trig_Hero_Dies_Func024Func001Func001001002 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())==Player(11))
    endfunction

    function Trig_Hero_Dies_Func024Func001Func001A takes nothing returns nothing
        call DisableTrigger(udg_trigger107)
        call DeleteUnit(GetEnumUnit())
        call EnableTrigger(udg_trigger107)
    endfunction

    function Trig_Hero_Dies_Actions takes nothing returns nothing
        call StopSoundBJ(udg_sound13,false)
        call PlaySoundBJ(udg_sound13)
        call ForceAddPlayerSimple(GetOwningPlayer(GetTriggerUnit()),DefeatedPlayers)
        set PlayerCount =(PlayerCount - 1)
        call AllowSinglePlayerCommands()
        
        call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(GetOwningPlayer(GetTriggerUnit()))+ "|cffC60000 was defeated!|r")))
        call DisableTrigger(udg_trigger16)
        call ForGroupBJ(GetUnitsOfPlayerAll(GetOwningPlayer(GetTriggerUnit())),function Trig_Hero_Dies_Func008A)
        call EnableTrigger(udg_trigger16)
    
        if(Trig_Hero_Dies_Func011C())then
            call DialogSetMessageBJ(udg_dialog04,"Defeat!")
            call DialogDisplayBJ(true,udg_dialog04,GetOwningPlayer(GetTriggerUnit()))
        else
            call CustomDefeatBJ(GetOwningPlayer(GetTriggerUnit()),"Defeat!")
        endif
    
        if(Trig_Hero_Dies_Func016C())then
            call ConditionalTriggerExecute(EndGameTrigger)
        endif
    
        call ConditionalTriggerExecute(udg_trigger118)
        call TriggerSleepAction(2)
        call StopSoundBJ(udg_sound13,true)
        call StopSoundBJ(udg_sound12,false)
        call PlaySoundBJ(udg_sound12)
    
        set udg_integer42 = 1
        loop
            exitwhen udg_integer42 > 8
            if(Trig_Hero_Dies_Func024Func001C())then
                call ForGroupBJ(GetUnitsInRectMatching(PlayerArenaRects[udg_integer42],Condition(function Trig_Hero_Dies_Func024Func001Func001001002)),function Trig_Hero_Dies_Func024Func001Func001A)
            endif
            set udg_integer42 = udg_integer42 + 1
        endloop
    
        call ConditionalTriggerExecute(udg_trigger108)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger80 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger80,EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(udg_trigger80,Condition(function Trig_Hero_Dies_Conditions))
        call TriggerAddAction(udg_trigger80,function Trig_Hero_Dies_Actions)
    endfunction


endlibrary
