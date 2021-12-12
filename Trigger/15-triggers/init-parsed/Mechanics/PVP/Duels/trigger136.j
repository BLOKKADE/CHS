library trigger136 initializer init requires RandomShit, StartFunction

    function Trig_PvP_Battle_Func001C takes nothing returns boolean
        if(not(CountUnitsInGroup(udg_group01)>= 1))then
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
        return(IsUnitInGroup(GetFilterUnit(),udg_group01)==true)
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
        if(not(CountUnitsInGroup(udg_group01)>= 1))then
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
        return(IsUnitInGroup(GetFilterUnit(),udg_group01)==true) and GetFilterUnit() != udg_units03[1]
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
        return IsPlayerInForce(GetOwningPlayer(GetFilterUnit()), DuelLosers) and GetFilterUnit() != udg_units03[1]
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
            set debugText = debugText + I2S(GetPlayerId(GetOwningPlayer(BlzGroupUnitAt(udg_group01, i))))
            set i = i - 1
            exitwhen i < 0
        endloop
    
        return debugText
    endfunction


    function GetPvpEnemy takes nothing returns boolean
        return IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO) and UnitAlive(GetFilterUnit()) and GetFilterUnit() != udg_units03[1] and GetOwningPlayer(GetFilterUnit()) != Player(8) and GetOwningPlayer(GetFilterUnit()) != Player(11) 
    endfunction


    function Trig_PvP_Battle_Func001Func017A takes nothing returns nothing
        call PanCameraToTimedLocForPlayer(GetEnumPlayer(),GetRectCenter(udg_rects01[udg_integer14]),0.20)
    endfunction


    function Trig_PvP_Battle_Func001Func018001002001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_PvP_Battle_Func001Func018001002002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
    endfunction
    
    function Trig_PvP_Battle_Func001Func018001002 takes nothing returns boolean
        return GetBooleanAnd(Trig_PvP_Battle_Func001Func018001002001(),Trig_PvP_Battle_Func001Func018001002002())
    endfunction


    function Trig_PvP_Battle_Func001Func018A takes nothing returns nothing
        if(Trig_Start_Level_Func015Func002Func003Func001001(GetEnumUnit()))then
            call DeleteUnit(GetEnumUnit())
        else
            call DoNothing()
        endif
        call ExplodeUnitBJ(GetEnumUnit())
    endfunction


    function RemoveNonHeroUnitFilter takes nothing returns boolean
        return UnitAlive(GetFilterUnit()) and GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') == 0 and (IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == false or IsUnitIllusion(GetFilterUnit())) and GetUnitTypeId(GetFilterUnit()) != 'h00C' and GetUnitTypeId(GetFilterUnit()) != 'h00D' 
    endfunction


    function RemoveNonHeroUnits takes nothing returns nothing
        call DeleteUnit(GetEnumUnit())
    endfunction


    function Trig_PvP_Battle_Func001Func019A takes nothing returns nothing
        call RemoveItem(GetEnumItem())
    endfunction


    function Trig_PvP_Battle_Func001Func031C takes nothing returns boolean
        if(not(udg_boolean13==true))then
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
        return(GetOwningPlayer(udg_units03[1])!=GetFilterPlayer())
    endfunction
    
    function Trig_PvP_Battle_Func001Func031Func006001001002001 takes nothing returns boolean
        return(GetOwningPlayer(udg_units03[2])!=GetFilterPlayer())
    endfunction
    
    function Trig_PvP_Battle_Func001Func031Func006001001002002 takes nothing returns boolean
        return(IsPlayerInForce(GetFilterPlayer(),udg_force02)!=true)
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
            call DialogDisplayBJ(true,udg_dialogs01[1],GetEnumPlayer())
        else
        endif
    endfunction


    function Trig_PvP_Battle_Func001Func041A takes nothing returns nothing
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 3
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            call DialogDisplayBJ(false,udg_dialogs01[GetForLoopIndexA()],GetEnumPlayer())
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
    endfunction


    function Trig_PvP_Battle_Func001Func001001 takes nothing returns boolean
        return(IsTriggerEnabled(udg_trigger119)==false)
    endfunction


    function Trig_PvP_Battle_Actions takes nothing returns nothing
        if(Trig_PvP_Battle_Func001C())then
            set udg_units03[1]= GroupPickRandomUnit(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_PvP_Battle_Func001Func008002001002)))
            call GroupRemoveUnitSimple(udg_units03[1],udg_group01)
            if(Trig_PvP_Battle_Func001Func010C())then
                set udg_units03[2]= GroupPickRandomUnit(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_PvP_Battle_Func001Func010Func003002001002)))
            else
                set udg_units03[2]= GroupPickRandomUnit(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_PvP_Battle_Func001Func010Func001002001002)))
            endif
            //shitty attempt at making sure it doesnt fuck up
            if udg_units03[2] == udg_units03[1] or udg_units03[2] == null then
                call DisplayTimedTextToForce(GetPlayersAll(), 90, "|cfffd2727Duel Error|r: " + GetPlayerName(GetOwningPlayer(udg_units03[1])) + " will fight any random player.\nPlease send this code in the bug-report channel on discord: " + TempDuelDebug() )
                set udg_units03[2] = GroupPickRandomUnit(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function GetPvpEnemy)))
            endif
            call GroupRemoveUnitSimple(udg_units03[2],udg_group01)
            call PlaySoundBJ(udg_sound08)
            call DisplayTextToForce(GetPlayersAll(),("|cffa0966dPvP Battle:|r " +(GetPlayerNameColour(GetOwningPlayer(udg_units03[1]))+(" vs " +(GetPlayerNameColour(GetOwningPlayer(udg_units03[2])))))))
            set udg_integer14 = GetRandomInt(1,8)
            call ForForce(GetPlayersAll(),function Trig_PvP_Battle_Func001Func017A)
            call ForGroupBJ(GetUnitsInRectMatching(udg_rects01[udg_integer14],Condition(function Trig_PvP_Battle_Func001Func018001002)),function Trig_PvP_Battle_Func001Func018A)
            call ForGroupBJ(GetUnitsOfPlayerMatching(GetOwningPlayer(udg_units03[1]) , Condition(function RemoveNonHeroUnitFilter)), function RemoveNonHeroUnits)
            call ForGroupBJ(GetUnitsOfPlayerMatching(GetOwningPlayer(udg_units03[2]) , Condition(function RemoveNonHeroUnitFilter)), function RemoveNonHeroUnits)
            call EnumItemsInRectBJ(udg_rects01[udg_integer14],function Trig_PvP_Battle_Func001Func019A)
            set udg_location01 = OffsetLocation(GetRectCenter(udg_rects01[udg_integer14]),- 40.00,- 50.00)
            call SetUnitPositionLocFacingLocBJ(udg_units03[1],OffsetLocation(GetRectCenter(udg_rects01[udg_integer14]),- 500.00,0),GetRectCenter(udg_rects01[udg_integer14]))
            call SetUnitPositionLocFacingLocBJ(udg_units03[2],OffsetLocation(GetRectCenter(udg_rects01[udg_integer14]),500.00,0),GetRectCenter(udg_rects01[udg_integer14]))
            set bj_forLoopAIndex = 1
            set bj_forLoopAIndexEnd = 2
            loop
                exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                call PauseUnitBJ(true,udg_units03[GetForLoopIndexA()])
                call SelectUnitForPlayerSingle(udg_units03[GetForLoopIndexA()],GetOwningPlayer(udg_units03[GetForLoopIndexA()]))
                set udg_unit01 = udg_units03[GetForLoopIndexA()]
                call ConditionalTriggerExecute(udg_trigger82)
                call GroupAddUnitSimple(udg_units03[GetForLoopIndexA()],udg_group02)
                set bj_forLoopAIndex = bj_forLoopAIndex + 1
            endloop
            call SetPlayerAllianceStateBJ(GetOwningPlayer(udg_units03[1]),GetOwningPlayer(udg_units03[2]),bj_ALLIANCE_UNALLIED)
            call SetPlayerAllianceStateBJ(GetOwningPlayer(udg_units03[2]),GetOwningPlayer(udg_units03[1]),bj_ALLIANCE_UNALLIED)
            set udg_integer33 = 1
            loop
                exitwhen udg_integer33 > 6
                set udg_integers03[udg_integer33]= GetItemTypeId(UnitItemInSlotBJ(udg_units03[1],udg_integer33))
                call SetItemPawnable(UnitItemInSlotBJ(udg_units03[1],udg_integer33), false)
                set udg_integers04[udg_integer33]= GetItemTypeId(UnitItemInSlotBJ(udg_units03[2],udg_integer33))
                call SetItemPawnable(UnitItemInSlotBJ(udg_units03[2],udg_integer33), false)
                set udg_integer33 = udg_integer33 + 1
            endloop
            call TriggerSleepAction(0.20)
            set udg_boolean18 = true
            if(Trig_PvP_Battle_Func001Func031C())then
                call DialogClearBJ(udg_dialogs01[1])
                call DialogSetMessageBJ(udg_dialogs01[1],"Betting Menu")
                set bj_forLoopAIndex = 1
                set bj_forLoopAIndexEnd = 2
                loop
                    exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                    if(Trig_PvP_Battle_Func001Func031Func003Func001C())then
                        call DialogAddButtonBJ(udg_dialogs01[1],("<< " +(GetPlayerNameColour(GetOwningPlayer(udg_units03[GetForLoopIndexA()]))+ "|r   ")))
                    else
                        call DialogAddButtonBJ(udg_dialogs01[1],("   " +(GetPlayerNameColour(GetOwningPlayer(udg_units03[GetForLoopIndexA()]))+ "|r >>")))
                    endif
                    set udg_buttons02[GetForLoopIndexA()]= GetLastCreatedButtonBJ()
                    set bj_forLoopAIndex = bj_forLoopAIndex + 1
                endloop
                call DialogAddButtonBJ(udg_dialogs01[1],"Skip")
                set udg_buttons02[3]= GetLastCreatedButtonBJ()
                call ForForce(GetPlayersMatching(Condition(function Trig_PvP_Battle_Func001Func031Func006001001)),function Trig_PvP_Battle_Func001Func031Func006A)
            endif
            call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
            call CreateTimerDialogBJ(GetLastCreatedTimerBJ(),"Prepare ...")
            call StartTimerBJ(GetLastCreatedTimerBJ(),false,10.00)
            call TriggerSleepAction(4.50)
            set udg_integer19 = 5
            call ConditionalTriggerExecute(udg_trigger117)
            call TriggerSleepAction(5.50)
            set udg_boolean18 = false
            call ForForce(GetPlayersAll(),function Trig_PvP_Battle_Func001Func041A)
            call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
            set udg_integer39 = 0
            set udg_real03 = 0.02
            call EnableTrigger(udg_trigger140)
            call EnableTrigger(udg_trigger141)
            call PvpStartSuddenDeathTimer()
            call SetCurrentlyFighting(GetOwningPlayer(udg_units03[1]), true)
            call SetCurrentlyFighting(GetOwningPlayer(udg_units03[2]), true)
            call PlaySoundBJ(udg_sound15)
            set bj_forLoopAIndex = 1
            set bj_forLoopAIndexEnd = 2
            loop
                exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                call SetUnitInvulnerable(udg_units03[GetForLoopIndexA()],false)
                call StartFunctionSpell(udg_units03[GetForLoopIndexA()],4 ) 
                call PauseUnitBJ(false,udg_units03[GetForLoopIndexA()])
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
