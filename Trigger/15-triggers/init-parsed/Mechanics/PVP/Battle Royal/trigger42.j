library trigger42 initializer init requires RandomShit, StartFunction, DebugCode

    function Trig_Battle_Royal_Func015001002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)==true)
    endfunction


    function Trig_Battle_Royal_Func015A takes nothing returns nothing
        call DeleteUnit(GetEnumUnit())
    endfunction


    function Trig_Battle_Royal_Func016Func001001002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(8))
    endfunction
    
    function Trig_Battle_Royal_Func016Func001001002002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(11))
    endfunction
    
    function Trig_Battle_Royal_Func016Func001001002002002001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_Battle_Royal_Func016Func001001002002002002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
    endfunction
    
    function Trig_Battle_Royal_Func016Func001001002002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Battle_Royal_Func016Func001001002002002001(),Trig_Battle_Royal_Func016Func001001002002002002())
    endfunction
    
    function Trig_Battle_Royal_Func016Func001001002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Battle_Royal_Func016Func001001002002001(),Trig_Battle_Royal_Func016Func001001002002002())
    endfunction
    
    function Trig_Battle_Royal_Func016Func001001002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Battle_Royal_Func016Func001001002001(),Trig_Battle_Royal_Func016Func001001002002())
    endfunction


    function Trig_Battle_Royal_Func016Func001A takes nothing returns nothing
        set BrPlayerCount =(BrPlayerCount + 1)
        call SetPlayerAllianceStateBJ(GetOwningPlayer(GetEnumUnit()),ConvertedPlayer(GetForLoopIndexA()),bj_ALLIANCE_UNALLIED)
    endfunction


    function Trig_Battle_Royal_Func017001002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(8))
    endfunction
    
    function Trig_Battle_Royal_Func017001002002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(11))
    endfunction
    
    function Trig_Battle_Royal_Func017001002002002001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_Battle_Royal_Func017001002002002002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
    endfunction
    
    function Trig_Battle_Royal_Func017001002002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Battle_Royal_Func017001002002002001(),Trig_Battle_Royal_Func017001002002002002())
    endfunction
    
    function Trig_Battle_Royal_Func017001002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Battle_Royal_Func017001002002001(),Trig_Battle_Royal_Func017001002002002())
    endfunction
    
    function Trig_Battle_Royal_Func017001002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Battle_Royal_Func017001002001(),Trig_Battle_Royal_Func017001002002())
    endfunction


    function Trig_Battle_Royal_Func017A takes nothing returns nothing
        local PlayerStats ps = PlayerStats.forPlayer(GetOwningPlayer(GetEnumUnit()))

        set udg_unit01 = GetEnumUnit()
        call PauseUnit(udg_unit01, true)
        call ConditionalTriggerExecute(udg_trigger82)
        call SetUnitPositionLocFacingLocBJ(GetEnumUnit(),PolarProjectionBJ(GetRectCenter(GetPlayableMapRect()),1200,(((I2R(GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit())))- 1)*- 45.00)- 225.00)),GetRectCenter(udg_rect09))

        if (ps.getPet() != null) then
            call SetUnitPositionLocFacingLocBJ(ps.getPet(),PolarProjectionBJ(GetRectCenter(GetPlayableMapRect()),1200,(((I2R(GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit())))- 1)*- 45.00)- 225.00)),GetRectCenter(udg_rect09))
        endif

        call SelectUnitForPlayerSingle(GetEnumUnit(),GetOwningPlayer(GetEnumUnit()))
        call PanCameraToTimedLocForPlayer(GetOwningPlayer(GetEnumUnit()),GetUnitLoc(GetEnumUnit()),0.50)
    endfunction


    function Trig_Battle_Royal_Func018002 takes nothing returns nothing
        call DeleteUnit(GetEnumUnit())
    endfunction


    function Trig_Battle_Royal_Func019002 takes nothing returns nothing
        call DeleteUnit(GetEnumUnit())
    endfunction


    function Trig_Battle_Royal_Func020A takes nothing returns nothing
        call RemoveItem(GetEnumItem())
    endfunction


    function Trig_Battle_Royal_Func033001002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(8))
    endfunction
    
    function Trig_Battle_Royal_Func033001002002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(11))
    endfunction
    
    function Trig_Battle_Royal_Func033001002002002001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_Battle_Royal_Func033001002002002002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
    endfunction
    
    function Trig_Battle_Royal_Func033001002002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Battle_Royal_Func033001002002002001(),Trig_Battle_Royal_Func033001002002002002())
    endfunction
    
    function Trig_Battle_Royal_Func033001002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Battle_Royal_Func033001002002001(),Trig_Battle_Royal_Func033001002002002())
    endfunction
    
    function Trig_Battle_Royal_Func033001002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Battle_Royal_Func033001002001(),Trig_Battle_Royal_Func033001002002())
    endfunction


    function Trig_Battle_Royal_Func033A takes nothing returns nothing
        call PauseUnit(GetEnumUnit(), false)
        call SetUnitInvulnerable(GetEnumUnit(),false)
        call StartFunctionSpell(GetEnumUnit(),1)
    endfunction


    function Trig_Battle_Royal_Func034C takes nothing returns boolean
        if(not(BrPlayerCount==1))then
            return false
        endif
        return true
    endfunction

    function ShowDraftBuildings takes boolean b returns nothing
        local integer i = 0
        if AbilityMode != 0 then
            loop
                if AbilityMode == 2 then
                    call ShowUnit(circle1, b)
                    call ShowUnit(udg_Draft_DraftBuildings[i], b)
                    call SetTextTagVisibility(FloatingTextBuy, b)
                endif
                
                call ShowUnit(circle2, b)
                call ShowUnit(udg_Draft_UpgradeBuildings[i], b)
                call SetTextTagVisibility(FloatingTextUpgrade, b)
                set i = i + 1
                exitwhen i > 9
            endloop
        endif
    endfunction


    function Trig_Battle_Royal_Actions takes nothing returns nothing
        call KillUnit(udg_unit03)
        call TriggerSleepAction(5.00)
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call CreateTimerDialogBJ(GetLastCreatedTimerBJ(),"Battle Royal")
        call StartTimerBJ(GetLastCreatedTimerBJ(),false,60.00)
        call DisplayTextToForce(GetPlayersAll(),"Hold |cffffcc00SHIFT|r while buying |cff7bff00glory buffs|r or |cff00ff37tomes|r to buy |cff00fff21000|r of them at once, provided you have the gold.")
        call TriggerSleepAction(60.00)
        set BrStarted = true
        call SetVersion()
        call PlaySoundBJ(udg_sound10)
        call DisplayTextToForce(GetPlayersAll(),"|cffffcc00FINAL BATTLE - THE WINNER TAKES IT ALL")
        //call PauseAllUnitsBJ(true)
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call ShowDraftBuildings(false)
        call RemoveUnitsInRect(bj_mapInitialPlayableArea)
        call ForGroupBJ(GetUnitsOfPlayerMatching(Player(PLAYER_NEUTRAL_PASSIVE),Condition(function Trig_Battle_Royal_Func015001002)),function Trig_Battle_Royal_Func015A)
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 8
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_Battle_Royal_Func016Func001001002)),function Trig_Battle_Royal_Func016Func001A)
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
        call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_Battle_Royal_Func017001002)),function Trig_Battle_Royal_Func017A)

        call EnumItemsInRectBJ(GetPlayableMapRect(),function Trig_Battle_Royal_Func020A)
        call DisableTrigger(udg_trigger142)
        call DisableTrigger(udg_trigger145)
        call DisableTrigger(udg_trigger80)
        call DisableTrigger(udg_trigger81)
        call EnableTrigger(udg_trigger43)
        call TriggerSleepAction(2)
        set udg_location01 = OffsetLocation(GetRectCenter(GetPlayableMapRect()),- 40.00,- 50.00)
        set CountdownCount = 5
        call ConditionalTriggerExecute(udg_trigger117)
        call TriggerSleepAction(5.00)
        call PlaySoundBJ(udg_sound08)
        call DisplayTimedTextToForce(GetPlayersAll(),1.00,"|cffffcc00GO!!!|r")
        call SetAllCurrentlyFighting(true)
        call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_Battle_Royal_Func033001002)),function Trig_Battle_Royal_Func033A)
        if(Trig_Battle_Royal_Func034C())then
            set PlayerCount = 1
            call ConditionalTriggerExecute(udg_trigger122)
        else
        endif

        // Save debug codes
        call DebugCode_SavePlayerDebugEveryone()
        //call PauseAllUnitsBJ(false)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger42 = CreateTrigger()
        call TriggerAddAction(udg_trigger42,function Trig_Battle_Royal_Actions)
    endfunction


endlibrary
