library trigger153 initializer init requires RandomShit, DebugCommands

    function Trig_Hero_Dies_Elimination_Func039C takes nothing returns boolean
        if(not(udg_boolean03==true))then
            return false
        endif
        if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
            return false
        endif
        if(not(GetOwningPlayer(GetTriggerUnit())!=Player(8)))then
            return false
        endif
        if(not(GetOwningPlayer(GetTriggerUnit())!=Player(11)))then
            return false
        endif
        return true
    endfunction


    function Trig_Hero_Dies_Elimination_Conditions takes nothing returns boolean
        if(not Trig_Hero_Dies_Elimination_Func039C())then
            return false
        endif
        return true
    endfunction


    function Trig_Hero_Dies_Elimination_Func008A takes nothing returns nothing
        local unit u = GetEnumUnit()
    
        if IsUnitType(u, UNIT_TYPE_HERO) then
            call RemoveItem(UnitItemInSlot(u, 0))
            call RemoveItem(UnitItemInSlot(u, 1))
            call RemoveItem(UnitItemInSlot(u, 2))
            call RemoveItem(UnitItemInSlot(u, 3))
            call RemoveItem(UnitItemInSlot(u, 4))
            call RemoveItem(UnitItemInSlot(u, 5))
    
            call RemoveHeroAbilities(u)
        endif
    
        call KillUnit(u)
        set u = null
    endfunction


    function Trig_Hero_Dies_Elimination_Func010001002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
    endfunction


    function Trig_Hero_Dies_Elimination_Func010A takes nothing returns nothing
        call SetUnitInvulnerable(GetEnumUnit(),true)
    endfunction


    function Trig_Hero_Dies_Elimination_Func012C takes nothing returns boolean
        if(not(GetPlayerController(GetOwningPlayer(GetTriggerUnit()))==MAP_CONTROL_USER))then
            return false
        endif
        return true
    endfunction


    function Trig_Hero_Dies_Elimination_Func018Func001001002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(8))
    endfunction
    
    function Trig_Hero_Dies_Elimination_Func018Func001001002002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(11))
    endfunction
    
    function Trig_Hero_Dies_Elimination_Func018Func001001002002002001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_Hero_Dies_Elimination_Func018Func001001002002002002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
    endfunction
    
    function Trig_Hero_Dies_Elimination_Func018Func001001002002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Hero_Dies_Elimination_Func018Func001001002002002001(),Trig_Hero_Dies_Elimination_Func018Func001001002002002002())
    endfunction
    
    function Trig_Hero_Dies_Elimination_Func018Func001001002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Hero_Dies_Elimination_Func018Func001001002002001(),Trig_Hero_Dies_Elimination_Func018Func001001002002002())
    endfunction
    
    function Trig_Hero_Dies_Elimination_Func018Func001001002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Hero_Dies_Elimination_Func018Func001001002001(),Trig_Hero_Dies_Elimination_Func018Func001001002002())
    endfunction


    function Trig_Hero_Dies_Elimination_Func018Func001A takes nothing returns nothing
        call SetPlayerAllianceStateBJ(GetOwningPlayer(GetEnumUnit()),ConvertedPlayer(udg_integer47),bj_ALLIANCE_UNALLIED)
    endfunction


    function Trig_Hero_Dies_Elimination_Func021001 takes nothing returns boolean
        return(udg_integer06==1)
    endfunction

    function Trig_Hero_Dies_Elimination_Func030001002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(8))
    endfunction
    
    function Trig_Hero_Dies_Elimination_Func030001002002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(11))
    endfunction
    
    function Trig_Hero_Dies_Elimination_Func030001002002002001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_Hero_Dies_Elimination_Func030001002002002002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
    endfunction
    
    function Trig_Hero_Dies_Elimination_Func030001002002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Hero_Dies_Elimination_Func030001002002002001(),Trig_Hero_Dies_Elimination_Func030001002002002002())
    endfunction
    
    function Trig_Hero_Dies_Elimination_Func030001002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Hero_Dies_Elimination_Func030001002002001(),Trig_Hero_Dies_Elimination_Func030001002002002())
    endfunction
    
    function Trig_Hero_Dies_Elimination_Func030001002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Hero_Dies_Elimination_Func030001002001(),Trig_Hero_Dies_Elimination_Func030001002002())
    endfunction


    function Trig_Hero_Dies_Elimination_Func030A takes nothing returns nothing
        set udg_unit01 = GetEnumUnit()
        call ConditionalTriggerExecute(udg_trigger82)
        call SetUnitPositionLoc(GetEnumUnit(),GetRectCenter(udg_rect09))
        call SelectUnitForPlayerSingle(GetEnumUnit(),GetOwningPlayer(GetEnumUnit()))
        call PanCameraToTimedLocForPlayer(GetOwningPlayer(GetEnumUnit()),GetUnitLoc(GetEnumUnit()),0.50)
        call SuspendHeroXPBJ(false,GetEnumUnit())
    endfunction


    function Trig_Hero_Dies_Elimination_Func031001002001001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(8))
    endfunction
    
    function Trig_Hero_Dies_Elimination_Func031001002001002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(11))
    endfunction
    
    function Trig_Hero_Dies_Elimination_Func031001002001002002001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_Hero_Dies_Elimination_Func031001002001002002002001 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
    endfunction
    
    function Trig_Hero_Dies_Elimination_Func031001002001002002002002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
    endfunction
    
    function Trig_Hero_Dies_Elimination_Func031001002001002002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Hero_Dies_Elimination_Func031001002001002002002001(),Trig_Hero_Dies_Elimination_Func031001002001002002002002())
    endfunction
    
    function Trig_Hero_Dies_Elimination_Func031001002001002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Hero_Dies_Elimination_Func031001002001002002001(),Trig_Hero_Dies_Elimination_Func031001002001002002002())
    endfunction
    
    function Trig_Hero_Dies_Elimination_Func031001002001002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Hero_Dies_Elimination_Func031001002001002001(),Trig_Hero_Dies_Elimination_Func031001002001002002())
    endfunction
    
    function Trig_Hero_Dies_Elimination_Func031001002001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Hero_Dies_Elimination_Func031001002001001(),Trig_Hero_Dies_Elimination_Func031001002001002())
    endfunction
    
    function Trig_Hero_Dies_Elimination_Func031001002002 takes nothing returns boolean
        return(IsUnitIllusionBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_Hero_Dies_Elimination_Func031001002 takes nothing returns boolean
        return GetBooleanOr(Trig_Hero_Dies_Elimination_Func031001002001(),Trig_Hero_Dies_Elimination_Func031001002002())
    endfunction


    function Trig_Hero_Dies_Elimination_Func031A takes nothing returns nothing
        call KillUnit(GetEnumUnit())
    endfunction


    function Trig_Hero_Dies_Elimination_Func032001002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(8))
    endfunction
    
    function Trig_Hero_Dies_Elimination_Func032001002002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(11))
    endfunction
    
    function Trig_Hero_Dies_Elimination_Func032001002002002001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_Hero_Dies_Elimination_Func032001002002002002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
    endfunction
    
    function Trig_Hero_Dies_Elimination_Func032001002002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Hero_Dies_Elimination_Func032001002002002001(),Trig_Hero_Dies_Elimination_Func032001002002002002())
    endfunction
    
    function Trig_Hero_Dies_Elimination_Func032001002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Hero_Dies_Elimination_Func032001002002001(),Trig_Hero_Dies_Elimination_Func032001002002002())
    endfunction
    
    function Trig_Hero_Dies_Elimination_Func032001002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Hero_Dies_Elimination_Func032001002001(),Trig_Hero_Dies_Elimination_Func032001002002())
    endfunction


    function Trig_Hero_Dies_Elimination_Func032A takes nothing returns nothing
        call SuspendHeroXPBJ(true,GetEnumUnit())
    endfunction


    function Trig_Hero_Dies_Elimination_Actions takes nothing returns nothing
        call DisableTrigger(GetTriggeringTrigger())
        call StopSoundBJ(udg_sound13,false)
        call PlaySoundBJ(udg_sound13)
        call ForceAddPlayerSimple(GetOwningPlayer(GetTriggerUnit()),udg_force02)
        call SetCurrentlyFighting(GetOwningPlayer(GetTriggerUnit()), false)
        set udg_integer06 =(udg_integer06 - 1)
        call AllowSinglePlayerCommands()
        call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(GetOwningPlayer(GetTriggerUnit()))+ "|cffffcc00 was defeated!|r")))
        call DisableTrigger(udg_trigger16)
        call ForGroupBJ(GetUnitsOfPlayerAll(GetOwningPlayer(GetTriggerUnit())),function Trig_Hero_Dies_Elimination_Func008A)
        call EnableTrigger(udg_trigger16)
        call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_Hero_Dies_Elimination_Func010001002)),function Trig_Hero_Dies_Elimination_Func010A)
        if(Trig_Hero_Dies_Elimination_Func012C())then
            call DialogSetMessageBJ(udg_dialog04,"Defeat!")
            call DialogDisplayBJ(true,udg_dialog04,GetOwningPlayer(GetTriggerUnit()))
        else
            call CustomDefeatBJ(GetOwningPlayer(GetTriggerUnit()),"Defeat!")
        endif
        set udg_integer30 = 1
        loop
            exitwhen udg_integer30 > 5
            call AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()),"Objects\\Spawnmodels\\Human\\HumanLargeDeathExplode\\HumanLargeDeathExplode.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
            call AddSpecialEffectTargetUnitBJ("chest",GetTriggerUnit(),"Objects\\Spawnmodels\\Orc\\OrcLargeDeathExplode\\OrcLargeDeathExplode.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
            call TriggerSleepAction(0.10)
            set udg_integer30 = udg_integer30 + 1
        endloop
        call TriggerSleepAction(3.00)
        set udg_boolean03 = false
        set udg_integer47 = 1
        loop
            exitwhen udg_integer47 > 8
            call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_Hero_Dies_Elimination_Func018Func001001002)),function Trig_Hero_Dies_Elimination_Func018Func001A)
            set udg_integer47 = udg_integer47 + 1
        endloop
        call ConditionalTriggerExecute(udg_trigger122)
        if(Trig_Hero_Dies_Elimination_Func021001())then
            return
        else
            call DoNothing()
        endif
        call EnableTrigger(udg_trigger142)
        call EnableTrigger(udg_trigger145)
        call EnableTrigger(udg_trigger80)
        call EnableTrigger(udg_trigger87)
        call EnableTrigger(udg_trigger149)
        call DisableTrigger(udg_trigger153)
        call ConditionalTriggerExecute(udg_trigger148)
        call ShowDraftBuildings(true)
        call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_Hero_Dies_Elimination_Func030001002)),function Trig_Hero_Dies_Elimination_Func030A)
        call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_Hero_Dies_Elimination_Func031001002)),function Trig_Hero_Dies_Elimination_Func031A)
        call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_Hero_Dies_Elimination_Func032001002)),function Trig_Hero_Dies_Elimination_Func032A)
        call ConditionalTriggerExecute(udg_trigger103)
        call SetAllCurrentlyFighting(false)
        call CreateTimerDialogBJ(GetLastCreatedTimerBJ(),"Next Level ...")
        call StartTimerBJ(GetLastCreatedTimerBJ(),false,20.00)
        call TriggerSleepAction(20.00)
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call TriggerExecute(udg_trigger109)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger153 = CreateTrigger()
        call DisableTrigger(udg_trigger153)
        call TriggerRegisterAnyUnitEventBJ(udg_trigger153,EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(udg_trigger153,Condition(function Trig_Hero_Dies_Elimination_Conditions))
        call TriggerAddAction(udg_trigger153,function Trig_Hero_Dies_Elimination_Actions)
    endfunction


endlibrary
