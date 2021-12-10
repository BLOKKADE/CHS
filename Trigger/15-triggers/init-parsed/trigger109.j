library trigger109 initializer init requires RandomShit

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
        if(not(udg_integer02==1))then
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


    function Trig_Start_Level_Func003Func006A takes nothing returns nothing
        call DeleteUnit(GetEnumUnit())
    endfunction


    function Trig_Start_Level_Func011A takes nothing returns nothing
        call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_RESOURCE_FOOD_USED,udg_integer02)
        set ShowCreepAbilButton[GetPlayerId(GetEnumPlayer())] = false
        call ResourseRefresh(GetEnumPlayer()) 
    endfunction


    function Trig_Start_Level_Func013Func001C takes nothing returns boolean
        if((udg_boolean04==true))then
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


    function Trig_Start_Level_Func015C takes nothing returns boolean
        if(not(udg_integer02 > 1))then
            return false
        endif
        return true
    endfunction


    function Trig_Start_Level_Func015Func002001001001001 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(8))
    endfunction


    function Trig_Start_Level_Func015Func002Func003001002001 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
    endfunction


    function Trig_Start_Level_Func015Func002Func003A takes nothing returns nothing
        if GetUnitTypeId(GetEnumUnit()) != 'h00C' and GetUnitTypeId(GetEnumUnit()) != 'h00D' then
            if(Trig_Start_Level_Func015Func002Func003Func001001(GetEnumUnit()))then
                call DeleteUnit(GetEnumUnit())
            else
                call DoNothing()
            endif
            call ExplodeUnitBJ(GetEnumUnit())
        endif
    endfunction


    function Trig_Start_Level_Func015Func002Func004A takes nothing returns nothing
        call RemoveItem(GetEnumItem())
    endfunction


    function Trig_Start_Level_Func015Func002A takes nothing returns nothing
        set udg_booleans02[GetConvertedPlayerId(GetEnumPlayer())]= false
        set udg_booleans01[GetConvertedPlayerId(GetEnumPlayer())]= false
        call ForGroupBJ(GetUnitsOfPlayerMatching(GetEnumPlayer(),Condition(function Trig_Start_Level_Func015Func002Func003001002)),function Trig_Start_Level_Func015Func002Func003A)
        call EnumItemsInRectBJ(udg_rects01[GetConvertedPlayerId(GetEnumPlayer())],function Trig_Start_Level_Func015Func002Func004A)
        call SetUnitInvulnerable(udg_units01[GetConvertedPlayerId(GetEnumPlayer())],false)
        call SetUnitPositionLoc(udg_units01[GetConvertedPlayerId(GetEnumPlayer())],GetRectCenter(udg_rects01[GetConvertedPlayerId(GetEnumPlayer())]))
        set udg_unit01 = udg_units01[GetConvertedPlayerId(GetEnumPlayer())]
        call ConditionalTriggerExecute(udg_trigger82)
        call SelectUnitForPlayerSingle(udg_units01[GetConvertedPlayerId(GetEnumPlayer())],GetOwningPlayer(udg_units01[GetConvertedPlayerId(GetEnumPlayer())]))
        call PanCameraToTimedLocForPlayer(GetEnumPlayer(),GetRectCenter(udg_rects01[GetConvertedPlayerId(GetEnumPlayer())]),0)
        call SetCurrentlyFighting(GetEnumPlayer(), true)
    endfunction


    function Trig_Start_Level_Func015Func002001001001001 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(8))
    endfunction


    function StartLevelRoundOne takes nothing returns nothing
        call StartFunctionSpell(udg_units01[GetConvertedPlayerId(GetEnumPlayer())],3) 
        call SetCurrentlyFighting(GetEnumPlayer(), true)
    endfunction


    function Trig_Start_Level_Func018A takes nothing returns nothing
        call ShowUnitShow(GetEnumUnit())
        call SetUnitInvulnerable(GetEnumUnit(),false)
        //call StartFunctionSpell(GetEnumUnit(),3 ) 
        call PauseUnitBJ(false,GetEnumUnit())
    endfunction


    function Trig_Start_Level_Func015Func002001001001001 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(8))
    endfunction


    function StartFunctionSpells takes nothing returns nothing
        call StartFunctionSpell(udg_units01[GetConvertedPlayerId(GetEnumPlayer())],3) 
    endfunction


    function Trig_Start_Level_Actions takes nothing returns nothing
        local timerdialog td
        local timer t
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        if(Trig_Start_Level_Func003C())then
            set udg_boolean12 = true
            set udg_boolean09 = true
            call DisplayTextToForce(GetPlayersAll(),("|c00F08000Level " +(I2S(udg_integer02)+ "|r")))
            call ConditionalTriggerExecute(udg_trigger143)
            call ForGroupBJ(GetUnitsOfTypeIdAll('n00E'),function Trig_Start_Level_Func003Func006A)
        else
        endif
        call ForceClear(udg_force03)
        set udg_boolean01 = false
        set udg_integer08 = 0
        call ConditionalTriggerExecute(udg_trigger146)
        call ForForce(GetPlayersAll(),function Trig_Start_Level_Func011A)
        if(Trig_Start_Level_Func013C())then
            set udg_integer59 =((125 * udg_integer02)/ udg_integer03)
            set udg_integer61 =((125 * udg_integer02)-(udg_integer59 * udg_integer03))
        else
            set udg_integer59 =((80 * udg_integer02)/ udg_integer03)
            set udg_integer61 =((80 * udg_integer02)-(udg_integer59 * udg_integer03))
        endif
        if(Trig_Start_Level_Func015C())then
            call PlaySoundBJ(udg_sound03)
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
            call ForForce(GetPlayersMatching(Condition(function Trig_Start_Level_Func015Func002001001)),function StartLevelRoundOne)
        endif
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
