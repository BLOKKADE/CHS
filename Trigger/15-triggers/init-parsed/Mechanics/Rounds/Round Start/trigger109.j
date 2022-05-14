library trigger109 initializer init requires RandomShit, StartFunction, SellItems, DebugCode, HeroSelectorAction

    function Trig_Start_Level_Conditions takes nothing returns boolean
        if(not(udg_boolean09==false))then
            return false
        endif
        return true
    endfunction


    function Trig_Start_Level_Func003Func001C takes nothing returns boolean
        if(not(udg_boolean12==false))then
            return false
        endif
        if(not(RoundNumber==1))then
            return false
        endif
        return true
    endfunction


    function Trig_Start_Level_Func003C takes nothing returns boolean
        if(not Trig_Start_Level_Func003Func001C())then
            return false
        endif
        return true
    endfunction

    function Trig_Start_Level_Func011A takes nothing returns nothing
        call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_RESOURCE_FOOD_USED,RoundNumber)
        set ShowCreepAbilButton[GetPlayerId(GetEnumPlayer())] = false
        call ResourseRefresh(GetEnumPlayer()) 
    endfunction


    function Trig_Start_Level_Func013Func001C takes nothing returns boolean
        if((ElimModeEnabled==true))then
            return true
        endif
        if((udg_boolean08==true))then
            return true
        endif
        return false
    endfunction


    function Trig_Start_Level_Func013C takes nothing returns boolean
        if(not Trig_Start_Level_Func013Func001C())then
            return false
        endif
        return true
    endfunction


    function Trig_Start_Level_Func015Func002001001001001 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(8))
    endfunction
    
    function Trig_Start_Level_Func015Func002001001001002 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(11))
    endfunction
    
    function Trig_Start_Level_Func015Func002001001001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Start_Level_Func015Func002001001001001(),Trig_Start_Level_Func015Func002001001001002())
    endfunction
    
    function Trig_Start_Level_Func015Func002001001002 takes nothing returns boolean
        return(IsPlayerInForce(GetFilterPlayer(),DefeatedPlayers)!=true)
    endfunction
    
    function Trig_Start_Level_Func015Func002001001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Start_Level_Func015Func002001001001(),Trig_Start_Level_Func015Func002001001002())
    endfunction

    function Trig_Start_Level_Func015Func002Func004A takes nothing returns nothing
        call RemoveItem(GetEnumItem())
    endfunction


    function Trig_Start_Level_Func015Func002A takes nothing returns nothing
        local PlayerStats ps = PlayerStats.forPlayer(GetEnumPlayer())
        local location arenaLocation = GetRectCenter(PlayerArenaRects[GetConvertedPlayerId(GetEnumPlayer())])

        call EnumItemsInRectBJ(PlayerArenaRects[GetConvertedPlayerId(GetEnumPlayer())],function Trig_Start_Level_Func015Func002Func004A)
        call SetUnitInvulnerable(PlayerHeroes[GetConvertedPlayerId(GetEnumPlayer())],false)
        call SetUnitPositionLoc(PlayerHeroes[GetConvertedPlayerId(GetEnumPlayer())],arenaLocation)

        if (ps.getPet() != null) then
            call SetUnitPositionLoc(ps.getPet(),arenaLocation)
        endif

        set udg_unit01 = PlayerHeroes[GetConvertedPlayerId(GetEnumPlayer())]
        call ConditionalTriggerExecute(udg_trigger82)
        call SelectUnitForPlayerSingle(PlayerHeroes[GetConvertedPlayerId(GetEnumPlayer())],GetOwningPlayer(PlayerHeroes[GetConvertedPlayerId(GetEnumPlayer())]))
        call PanCameraToTimedLocForPlayer(GetEnumPlayer(),arenaLocation,0)
        call SetCurrentlyFighting(GetEnumPlayer(), true)

        call RemoveLocation(arenaLocation)
        set arenaLocation = null
    endfunction


    function StartLevelRoundOne takes nothing returns nothing
        call StartFunctionSpell(PlayerHeroes[GetConvertedPlayerId(GetEnumPlayer())],3) 
        call SetCurrentlyFighting(GetEnumPlayer(), true)
    endfunction


    function Trig_Start_Level_Func018A takes nothing returns nothing
        call ShowUnitShow(GetEnumUnit())
        call SetUnitInvulnerable(GetEnumUnit(),false)
        //call StartFunctionSpell(GetEnumUnit(),3 ) 
        call PauseUnitBJ(false,GetEnumUnit())
    endfunction


    function StartFunctionSpells takes nothing returns nothing
        call StartFunctionSpell(PlayerHeroes[GetConvertedPlayerId(GetEnumPlayer())],3) 
    endfunction

    function Trig_Start_Level_Actions takes nothing returns nothing
        local timerdialog td
        local timer t
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())

        if(Trig_Start_Level_Func003C())then
            set udg_boolean12 = true
            set udg_boolean09 = true

            call DisplayTextToForce(GetPlayersAll(), GameDescription)
            call DisplayTextToForce(GetPlayersAll(),("|c00F08000Level " +(I2S(RoundNumber)+ "|r")))
            call ConditionalTriggerExecute(udg_trigger143)
        endif

        call ForceClear(RoundPlayersCompleted)
        
        set RoundFinishedCount = 0
        call ConditionalTriggerExecute(udg_trigger146)
        call ForForce(GetPlayersAll(),function Trig_Start_Level_Func011A)

        if(Trig_Start_Level_Func013C())then
            set udg_integer59 =((125 * RoundNumber)/ RoundCreepNumber)
            set udg_integer61 =((125 * RoundNumber)-(udg_integer59 * RoundCreepNumber))
        else
            set udg_integer59 =((80 * RoundNumber)/ RoundCreepNumber)
            set udg_integer61 =((80 * RoundNumber)-(udg_integer59 * RoundCreepNumber))
        endif

        if(RoundNumber > 1)then
            call PlaySoundBJ(udg_sound03)
            call RemoveUnitsInRect(bj_mapInitialPlayableArea)
            call ForForce(GetPlayersMatching(Condition(function Trig_Start_Level_Func015Func002001001)),function Trig_Start_Level_Func015Func002A)
            set t = NewTimer()
            set td = CreateTimerDialog(t)
            call TimerDialogSetTitle(td, "Starting in...")
            call TimerDialogDisplay(td, true)
            call TimerStart(t, 4, false, null)
            call TriggerSleepAction(1.00)
            call PlaySoundBJ(udg_sound09)
            call TriggerSleepAction(1.00)
            call PlaySoundBJ(udg_sound09)
            call TriggerSleepAction(1.00)
            call PlaySoundBJ(udg_sound09)
            call TriggerSleepAction(1.00)
            call ReleaseTimer(t)
            call TimerDialogDisplay(td, false)
            call DestroyTimerDialog(td)
            set t = null
            set td = null
        else
            call RemoveHeroPreviewUnit()
            call ForForce(GetPlayersMatching(Condition(function Trig_Start_Level_Func015Func002001001)),function StartLevelRoundOne)
        endif

        // Save debug codes
        call DebugCode_SavePlayerDebugEveryone()

        call PlaySoundBJ(udg_sound01)
        call ForGroupBJ(udg_group05,function Trig_Start_Level_Func018A)
        call ForForce(GetPlayersMatching(Condition(function Trig_Start_Level_Func015Func002001001)),function StartFunctionSpells)
        call ConditionalTriggerExecute(udg_trigger98)
        set udg_integer39 = 0
        call EnableTrigger(udg_trigger110)
        call StartSuddenDeathTimer()
        call EnableTrigger(udg_trigger116)
        call EnableTrigger(udg_trigger103)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger109 = CreateTrigger()
        call TriggerAddCondition(udg_trigger109,Condition(function Trig_Start_Level_Conditions))
        call TriggerAddAction(udg_trigger109,function Trig_Start_Level_Actions)
    endfunction


endlibrary
