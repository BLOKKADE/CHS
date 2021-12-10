library trigger152 initializer init requires RandomShit, StartFunction

    function Trig_Elimination_Func018Func001001002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(8))
    endfunction
    
    function Trig_Elimination_Func018Func001001002002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(11))
    endfunction
    
    function Trig_Elimination_Func018Func001001002002002001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_Elimination_Func018Func001001002002002002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
    endfunction
    
    function Trig_Elimination_Func018Func001001002002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Elimination_Func018Func001001002002002001(),Trig_Elimination_Func018Func001001002002002002())
    endfunction
    
    function Trig_Elimination_Func018Func001001002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Elimination_Func018Func001001002002001(),Trig_Elimination_Func018Func001001002002002())
    endfunction
    
    function Trig_Elimination_Func018Func001001002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Elimination_Func018Func001001002001(),Trig_Elimination_Func018Func001001002002())
    endfunction


    function Trig_Elimination_Func018Func001A takes nothing returns nothing
        call SetPlayerAllianceStateBJ(GetOwningPlayer(GetEnumUnit()),ConvertedPlayer(udg_integer46),bj_ALLIANCE_UNALLIED)
    endfunction


    function Trig_Elimination_Func020001002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(8))
    endfunction
    
    function Trig_Elimination_Func020001002002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(11))
    endfunction
    
    function Trig_Elimination_Func020001002002002001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_Elimination_Func020001002002002002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
    endfunction
    
    function Trig_Elimination_Func020001002002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Elimination_Func020001002002002001(),Trig_Elimination_Func020001002002002002())
    endfunction
    
    function Trig_Elimination_Func020001002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Elimination_Func020001002002001(),Trig_Elimination_Func020001002002002())
    endfunction
    
    function Trig_Elimination_Func020001002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Elimination_Func020001002001(),Trig_Elimination_Func020001002002())
    endfunction


    function Trig_Elimination_Func020A takes nothing returns nothing
        set udg_integer29 =(udg_integer29 + 1)
        set udg_unit01 = GetEnumUnit()
        call ConditionalTriggerExecute(udg_trigger82)
        call SetUnitPositionLocFacingLocBJ(GetEnumUnit(),PolarProjectionBJ(GetRectCenter(GetPlayableMapRect()),750.00,(((I2R(GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit())))- 1)*- 45.00)- 225.00)),GetRectCenter(udg_rect09))
        call SelectUnitForPlayerSingle(GetEnumUnit(),GetOwningPlayer(GetEnumUnit()))
        call PanCameraToTimedLocForPlayer(GetOwningPlayer(GetEnumUnit()),GetUnitLoc(GetEnumUnit()),0.50)
    endfunction


    function Trig_Elimination_Func021A takes nothing returns nothing
        call RemoveItem(GetEnumItem())
    endfunction


    function Trig_Elimination_Func036001002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(8))
    endfunction
    
    function Trig_Elimination_Func036001002002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(11))
    endfunction
    
    function Trig_Elimination_Func036001002002002001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_Elimination_Func036001002002002002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
    endfunction
    
    function Trig_Elimination_Func036001002002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Elimination_Func036001002002002001(),Trig_Elimination_Func036001002002002002())
    endfunction
    
    function Trig_Elimination_Func036001002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Elimination_Func036001002002001(),Trig_Elimination_Func036001002002002())
    endfunction
    
    function Trig_Elimination_Func036001002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Elimination_Func036001002001(),Trig_Elimination_Func036001002002())
    endfunction


    function Trig_Elimination_Func036A takes nothing returns nothing
        call SetUnitInvulnerable(GetEnumUnit(),false)
    
        call StartFunctionSpell(GetEnumUnit() ,5) 
    endfunction


    function Trig_Elimination_Func037C takes nothing returns boolean
        if(not(udg_integer29==1))then
            return false
        endif
        return true
    endfunction


    function Trig_Elimination_Actions takes nothing returns nothing
        call DisableTrigger(udg_trigger149)
        call KillUnit(udg_unit03)
        call TriggerSleepAction(5.00)
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call CreateTimerDialogBJ(GetLastCreatedTimerBJ(),"Elimination")
        call StartTimerBJ(GetLastCreatedTimerBJ(),false,20.00)
        call StopMusicBJ(true)
        call TriggerSleepAction(2.00)
        call PlaySoundBJ(udg_sound16)
        call TriggerSleepAction(12.50)
        set udg_boolean03 = true
        call DisplayTextToForce(GetPlayersAll(),"|cffffcc00Elimination - Survive to advance to the next level!")
        call PauseAllUnitsBJ(true)
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call ConditionalTriggerExecute(udg_trigger147)
        call ShowDraftBuildings(false)
        set udg_integer46 = 1
        loop
            exitwhen udg_integer46 > 8
            call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_Elimination_Func018Func001001002)),function Trig_Elimination_Func018Func001A)
            set udg_integer46 = udg_integer46 + 1
        endloop
        set udg_integer29 = 0
        call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_Elimination_Func020001002)),function Trig_Elimination_Func020A)
        call EnumItemsInRectBJ(GetPlayableMapRect(),function Trig_Elimination_Func021A)
        call DisableTrigger(udg_trigger142)
        call DisableTrigger(udg_trigger145)
        call DisableTrigger(udg_trigger87)
        call DisableTrigger(udg_trigger80)
        call DisableTrigger(udg_trigger43)
        call EnableTrigger(udg_trigger153)
        call TriggerSleepAction(2)
        set udg_location01 = OffsetLocation(GetRectCenter(GetPlayableMapRect()),- 40.00,- 50.00)
        set udg_integer19 = 5
        call ConditionalTriggerExecute(udg_trigger117)
        call TriggerSleepAction(5.00)
        call ResumeMusicBJ()
        call PlaySoundBJ(udg_sound15)
        call DisplayTimedTextToForce(GetPlayersAll(),1.00,"|cffffcc00GO!!!|r")
        call SetAllCurrentlyFighting(true)
        call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_Elimination_Func036001002)),function Trig_Elimination_Func036A)
        if(Trig_Elimination_Func037C())then
            set udg_integer06 = 1
            call ConditionalTriggerExecute(udg_trigger122)
        else
        endif
        call PauseAllUnitsBJ(false)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger152 = CreateTrigger()
        call TriggerAddAction(udg_trigger152,function Trig_Elimination_Actions)
    endfunction


endlibrary
