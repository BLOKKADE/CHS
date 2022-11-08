library trigger136 initializer init requires RandomShit, StartFunction, DebugCode

    globals
        integer array ItemStacksP1
        integer array ItemStacksP2
        integer duelRectId
    endglobals

    function Trig_PvP_Battle_Func001C takes nothing returns boolean
        if(not(CountUnitsInGroup(PotentialDuelHeroes)>= 1))then
            return false
        endif
        return true
    endfunction


    function Trig_PvP_Battle_Func001Func008002001002001 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
    endfunction
    
    function Trig_PvP_Battle_Func001Func008002001002002001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_PvP_Battle_Func001Func008002001002002002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(8))
    endfunction
    
    function Trig_PvP_Battle_Func001Func008002001002002002002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(11))
    endfunction
    
    function Trig_PvP_Battle_Func001Func008002001002002002002002 takes nothing returns boolean
        return(IsUnitInGroup(GetFilterUnit(),PotentialDuelHeroes)==true)
    endfunction
    
    function Trig_PvP_Battle_Func001Func008002001002002002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_PvP_Battle_Func001Func008002001002002002002001(),Trig_PvP_Battle_Func001Func008002001002002002002002())
    endfunction
    
    function Trig_PvP_Battle_Func001Func008002001002002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_PvP_Battle_Func001Func008002001002002002001(),Trig_PvP_Battle_Func001Func008002001002002002002())
    endfunction
    
    function Trig_PvP_Battle_Func001Func008002001002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_PvP_Battle_Func001Func008002001002002001(),Trig_PvP_Battle_Func001Func008002001002002002())
    endfunction
    
    function Trig_PvP_Battle_Func001Func008002001002 takes nothing returns boolean
        return GetBooleanAnd(Trig_PvP_Battle_Func001Func008002001002001(),Trig_PvP_Battle_Func001Func008002001002002())
    endfunction


    function Trig_PvP_Battle_Func001Func010C takes nothing returns boolean
        if(not(CountUnitsInGroup(PotentialDuelHeroes)>= 1))then
            return false
        endif
        return true
    endfunction


    function Trig_PvP_Battle_Func001Func010Func003002001002001 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
    endfunction
    
    function Trig_PvP_Battle_Func001Func010Func003002001002002001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_PvP_Battle_Func001Func010Func003002001002002002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(8))
    endfunction
    
    function Trig_PvP_Battle_Func001Func010Func003002001002002002002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(11))
    endfunction
    
    function Trig_PvP_Battle_Func001Func010Func003002001002002002002002 takes nothing returns boolean
        return(IsUnitInGroup(GetFilterUnit(),PotentialDuelHeroes)==true) and GetFilterUnit() != DuelingHeroes[1]
    endfunction
    
    function Trig_PvP_Battle_Func001Func010Func003002001002002002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_PvP_Battle_Func001Func010Func003002001002002002002001(),Trig_PvP_Battle_Func001Func010Func003002001002002002002002())
    endfunction
    
    function Trig_PvP_Battle_Func001Func010Func003002001002002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_PvP_Battle_Func001Func010Func003002001002002002001(),Trig_PvP_Battle_Func001Func010Func003002001002002002002())
    endfunction
    
    function Trig_PvP_Battle_Func001Func010Func003002001002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_PvP_Battle_Func001Func010Func003002001002002001(),Trig_PvP_Battle_Func001Func010Func003002001002002002())
    endfunction
    
    function Trig_PvP_Battle_Func001Func010Func003002001002 takes nothing returns boolean
        return GetBooleanAnd(Trig_PvP_Battle_Func001Func010Func003002001002001(),Trig_PvP_Battle_Func001Func010Func003002001002002())
    endfunction


    function Trig_PvP_Battle_Func001Func010Func001002001002001 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
    endfunction
    
    function Trig_PvP_Battle_Func001Func010Func001002001002002001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_PvP_Battle_Func001Func010Func001002001002002002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(8))
    endfunction
    
    function Trig_PvP_Battle_Func001Func010Func001002001002002002002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(11))
    endfunction
    
    function Trig_PvP_Battle_Func001Func010Func001002001002002002002002 takes nothing returns boolean
        return IsPlayerInForce(GetOwningPlayer(GetFilterUnit()), DuelLosers) and GetFilterUnit() != DuelingHeroes[1]
    endfunction
    
    function Trig_PvP_Battle_Func001Func010Func001002001002002002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_PvP_Battle_Func001Func010Func001002001002002002002001(),Trig_PvP_Battle_Func001Func010Func001002001002002002002002())
    endfunction
    
    function Trig_PvP_Battle_Func001Func010Func001002001002002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_PvP_Battle_Func001Func010Func001002001002002002001(),Trig_PvP_Battle_Func001Func010Func001002001002002002002())
    endfunction
    
    function Trig_PvP_Battle_Func001Func010Func001002001002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_PvP_Battle_Func001Func010Func001002001002002001(),Trig_PvP_Battle_Func001Func010Func001002001002002002())
    endfunction
    
    function Trig_PvP_Battle_Func001Func010Func001002001002 takes nothing returns boolean
        return GetBooleanAnd(Trig_PvP_Battle_Func001Func010Func001002001002001(),Trig_PvP_Battle_Func001Func010Func001002001002002())
    endfunction


    function TempDuelDebug takes nothing returns string
        local integer i = 0
        local string debugText = "DL"
        loop
            if BlzForceHasPlayer(DuelLosers, Player(i)) then
                set debugText = debugText + I2S(i)
            endif
            set i = i + 1
            exitwhen i >= 8
        endloop
    
        set debugText = debugText + " GP"
        loop
            set debugText = debugText + I2S(GetPlayerId(GetOwningPlayer(BlzGroupUnitAt(PotentialDuelHeroes, i))))
            set i = i - 1
            exitwhen i < 0
        endloop
    
        return debugText
    endfunction


    function GetPvpEnemy takes nothing returns boolean
        return IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO) and UnitAlive(GetFilterUnit()) and GetFilterUnit() != DuelingHeroes[1] and GetOwningPlayer(GetFilterUnit()) != Player(8) and GetOwningPlayer(GetFilterUnit()) != Player(11) 
    endfunction


    function Trig_PvP_Battle_Func001Func017A takes nothing returns nothing
        call PanCameraToTimedLocForPlayer(GetEnumPlayer(),GetRectCenter(PlayerArenaRects[duelRectId]),0.20)
    endfunction

    function Trig_PvP_Battle_Func001Func019A takes nothing returns nothing
        call RemoveItem(GetEnumItem())
    endfunction


    function Trig_PvP_Battle_Func001Func031C takes nothing returns boolean
        if(not(BettingEnabled==true))then
            return false
        endif
        return true
    endfunction


    function Trig_PvP_Battle_Func001Func031Func003Func001C takes nothing returns boolean
        if(not(GetForLoopIndexA()==1))then
            return false
        endif
        return true
    endfunction


    function Trig_PvP_Battle_Func001Func031Func006001001001 takes nothing returns boolean
        return(GetOwningPlayer(DuelingHeroes[1])!=GetFilterPlayer())
    endfunction
    
    function Trig_PvP_Battle_Func001Func031Func006001001002001 takes nothing returns boolean
        return(GetOwningPlayer(DuelingHeroes[2])!=GetFilterPlayer())
    endfunction
    
    function Trig_PvP_Battle_Func001Func031Func006001001002002 takes nothing returns boolean
        return(IsPlayerInForce(GetFilterPlayer(),DefeatedPlayers)!=true)
    endfunction
    
    function Trig_PvP_Battle_Func001Func031Func006001001002 takes nothing returns boolean
        return GetBooleanAnd(Trig_PvP_Battle_Func001Func031Func006001001002001(),Trig_PvP_Battle_Func001Func031Func006001001002002())
    endfunction
    
    function Trig_PvP_Battle_Func001Func031Func006001001 takes nothing returns boolean
        return GetBooleanAnd(Trig_PvP_Battle_Func001Func031Func006001001001(),Trig_PvP_Battle_Func001Func031Func006001001002())
    endfunction


    function Trig_PvP_Battle_Func001Func031Func006Func001Func001C takes nothing returns boolean
        if((GetPlayerState(GetEnumPlayer(),PLAYER_STATE_RESOURCE_GOLD)> 0))then
            return true
        endif
        if((GetPlayerState(GetEnumPlayer(),PLAYER_STATE_RESOURCE_LUMBER)> 0))then
            return true
        endif
        return false
    endfunction


    function Trig_PvP_Battle_Func001Func031Func006Func001C takes nothing returns boolean
        if(not Trig_PvP_Battle_Func001Func031Func006Func001Func001C())then
            return false
        endif
        return true
    endfunction


    function Trig_PvP_Battle_Func001Func031Func006A takes nothing returns nothing
        if(Trig_PvP_Battle_Func001Func031Func006Func001C())then
            call DialogDisplayBJ(true,Dialogs[1],GetEnumPlayer())
        else
        endif
    endfunction


    function Trig_PvP_Battle_Func001Func041A takes nothing returns nothing
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 3
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            call DialogDisplayBJ(false,Dialogs[GetForLoopIndexA()],GetEnumPlayer())
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
    endfunction


    function Trig_PvP_Battle_Func001Func001001 takes nothing returns boolean
        return(IsTriggerEnabled(udg_trigger119)==false)
    endfunction


    function Trig_PvP_Battle_Actions takes nothing returns nothing
        local PlayerStats ps

        if(Trig_PvP_Battle_Func001C())then
            set DuelingHeroes[1]= GroupPickRandomUnit(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_PvP_Battle_Func001Func008002001002)))
            call GroupRemoveUnitSimple(DuelingHeroes[1],PotentialDuelHeroes)
            if(Trig_PvP_Battle_Func001Func010C())then
                set DuelingHeroes[2]= GroupPickRandomUnit(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_PvP_Battle_Func001Func010Func003002001002)))
            else
                set DuelingHeroes[2]= GroupPickRandomUnit(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_PvP_Battle_Func001Func010Func001002001002)))
            endif
            //shitty attempt at making sure it doesnt fuck up
            if DuelingHeroes[2] == DuelingHeroes[1] or DuelingHeroes[2] == null then
                call DisplayTimedTextToForce(GetPlayersAll(), 90, "|cfffd2727Duel Error|r: " + GetPlayerName(GetOwningPlayer(DuelingHeroes[1])) + " will fight any random player.\nPlease send this code in the bug-report channel on discord: " + TempDuelDebug() )
                set DuelingHeroes[2] = GroupPickRandomUnit(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function GetPvpEnemy)))
            endif

            // Save debug logs for each player before the fight
            call DebugCode_SavePlayerDebug(GetOwningPlayer(DuelingHeroes[1]))
            call DebugCode_SavePlayerDebug(GetOwningPlayer(DuelingHeroes[2]))

            call GroupRemoveUnitSimple(DuelingHeroes[2],PotentialDuelHeroes)
            call PlaySoundBJ(udg_sound08)
            call DisplayTextToForce(GetPlayersAll(),("|cffa0966dPvP Battle:|r " +(GetPlayerNameColour(GetOwningPlayer(DuelingHeroes[1]))+(" vs " +(GetPlayerNameColour(GetOwningPlayer(DuelingHeroes[2])))))))
            set duelRectId = GetRandomInt(1,8)
            call RemoveUnitsInRect(bj_mapInitialPlayableArea)

            call ForForce(GetPlayersAll(),function Trig_PvP_Battle_Func001Func017A)
            call EnumItemsInRectBJ(PlayerArenaRects[duelRectId],function Trig_PvP_Battle_Func001Func019A)
            set udg_location01 = OffsetLocation(GetRectCenter(PlayerArenaRects[duelRectId]),- 40.00,- 50.00)
            call SetUnitPositionLocFacingLocBJ(DuelingHeroes[1],OffsetLocation(GetRectCenter(PlayerArenaRects[duelRectId]),- 500.00,0),GetRectCenter(PlayerArenaRects[duelRectId]))
            call SetUnitPositionLocFacingLocBJ(DuelingHeroes[2],OffsetLocation(GetRectCenter(PlayerArenaRects[duelRectId]),500.00,0),GetRectCenter(PlayerArenaRects[duelRectId]))
            
            set ps = PlayerStats.forPlayer(GetOwningPlayer(DuelingHeroes[1]))

            if (ps.getPet() != null) then
                call SetUnitPositionLocFacingLocBJ(ps.getPet(),OffsetLocation(GetRectCenter(PlayerArenaRects[duelRectId]),- 500.00,0),GetRectCenter(PlayerArenaRects[duelRectId]))
            endif

            set ps = PlayerStats.forPlayer(GetOwningPlayer(DuelingHeroes[2]))

            if (ps.getPet() != null) then
                call SetUnitPositionLocFacingLocBJ(ps.getPet(),OffsetLocation(GetRectCenter(PlayerArenaRects[duelRectId]),500.00,0),GetRectCenter(PlayerArenaRects[duelRectId]))
            endif

            set bj_forLoopAIndex = 1
            set bj_forLoopAIndexEnd = 2
            loop
                exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                call PauseUnitBJ(true,DuelingHeroes[GetForLoopIndexA()])
                call SelectUnitForPlayerSingle(DuelingHeroes[GetForLoopIndexA()],GetOwningPlayer(DuelingHeroes[GetForLoopIndexA()]))
                set udg_unit01 = DuelingHeroes[GetForLoopIndexA()]
                call ConditionalTriggerExecute(udg_trigger82)
                call GroupAddUnitSimple(DuelingHeroes[GetForLoopIndexA()],DuelingHeroGroup)
                set bj_forLoopAIndex = bj_forLoopAIndex + 1
            endloop
            call SetPlayerAllianceStateBJ(GetOwningPlayer(DuelingHeroes[1]),GetOwningPlayer(DuelingHeroes[2]),bj_ALLIANCE_UNALLIED)
            call SetPlayerAllianceStateBJ(GetOwningPlayer(DuelingHeroes[2]),GetOwningPlayer(DuelingHeroes[1]),bj_ALLIANCE_UNALLIED)
            set PvpStartIndex = 1
            loop
                exitwhen PvpStartIndex > 6
                set DuelHeroItemIds1[PvpStartIndex]= GetItemTypeId(UnitItemInSlotBJ(DuelingHeroes[1],PvpStartIndex))
                set ItemStacksP1[PvpStartIndex] = GetItemCharges(UnitItemInSlotBJ(DuelingHeroes[1],PvpStartIndex))
                call SetItemPawnable(UnitItemInSlotBJ(DuelingHeroes[1],PvpStartIndex), false)
                set DuelHeroItemIds2[PvpStartIndex]= GetItemTypeId(UnitItemInSlotBJ(DuelingHeroes[2],PvpStartIndex))
                set ItemStacksP2[PvpStartIndex] = GetItemCharges(UnitItemInSlotBJ(DuelingHeroes[2],PvpStartIndex))
                call SetItemPawnable(UnitItemInSlotBJ(DuelingHeroes[2],PvpStartIndex), false)
                set PvpStartIndex = PvpStartIndex + 1
            endloop
            call TriggerSleepAction(0.20)
            set udg_boolean18 = true
            if(Trig_PvP_Battle_Func001Func031C())then
                call DialogClearBJ(Dialogs[1])
                call DialogSetMessageBJ(Dialogs[1],"Betting Menu")
                set bj_forLoopAIndex = 1
                set bj_forLoopAIndexEnd = 2
                loop
                    exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                    if(Trig_PvP_Battle_Func001Func031Func003Func001C())then
                        call DialogAddButtonBJ(Dialogs[1],("<< " +(GetPlayerNameColour(GetOwningPlayer(DuelingHeroes[GetForLoopIndexA()]))+ "|r   ")))
                    else
                        call DialogAddButtonBJ(Dialogs[1],("   " +(GetPlayerNameColour(GetOwningPlayer(DuelingHeroes[GetForLoopIndexA()]))+ "|r >>")))
                    endif
                    set DialogButtons[GetForLoopIndexA()]= GetLastCreatedButtonBJ()
                    set bj_forLoopAIndex = bj_forLoopAIndex + 1
                endloop
                call DialogAddButtonBJ(Dialogs[1],"Skip")
                set DialogButtons[3]= GetLastCreatedButtonBJ()
                call ForForce(GetPlayersMatching(Condition(function Trig_PvP_Battle_Func001Func031Func006001001)),function Trig_PvP_Battle_Func001Func031Func006A)
            endif
            call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
            call CreateTimerDialogBJ(GetLastCreatedTimerBJ(),"Prepare ...")
            call StartTimerBJ(GetLastCreatedTimerBJ(),false,10.00)
            call TriggerSleepAction(4.50)
            set CountdownCount = 5
            call ConditionalTriggerExecute(udg_trigger117)
            call TriggerSleepAction(5.50)
            set udg_boolean18 = false
            call ForForce(GetPlayersAll(),function Trig_PvP_Battle_Func001Func041A)
            call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
            set SuddenDeathTick = 0
            set udg_real03 = 0.02
            call EnableTrigger(udg_trigger140)
            call EnableTrigger(udg_trigger141)
            call EnableTrigger(udg_trigger135)
            call PvpStartSuddenDeathTimer()
            call SetCurrentlyFighting(GetOwningPlayer(DuelingHeroes[1]), true)
            call SetCurrentlyFighting(GetOwningPlayer(DuelingHeroes[2]), true)
            call PlaySoundBJ(udg_sound15)
            set bj_forLoopAIndex = 1
            set bj_forLoopAIndexEnd = 2
            loop
                exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                call SetUnitInvulnerable(DuelingHeroes[GetForLoopIndexA()],false)
                call StartFunctionSpell(DuelingHeroes[GetForLoopIndexA()],4 ) 
                call PauseUnitBJ(false,DuelingHeroes[GetForLoopIndexA()])
                call RectLeaveDetection.create(DuelingHeroes[GetForLoopIndexA()], PlayerArenaRects[duelRectId])
                set bj_forLoopAIndex = bj_forLoopAIndex + 1
            endloop
        else
            if(Trig_PvP_Battle_Func001Func001001())then
                return
            else
                call DoNothing()
            endif
            call ConditionalTriggerExecute(udg_trigger103)
            call CreateTimerDialogBJ(GetLastCreatedTimerBJ(),"Next Level ...")
            call StartTimerBJ(GetLastCreatedTimerBJ(),false,30)
            call TriggerSleepAction(30.00)
            call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
            call TriggerExecute(udg_trigger109)
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger136 = CreateTrigger()
        call TriggerAddAction(udg_trigger136,function Trig_PvP_Battle_Actions)
    endfunction


endlibrary
