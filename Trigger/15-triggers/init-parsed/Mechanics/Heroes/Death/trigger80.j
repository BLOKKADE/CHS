library trigger80 initializer init requires RandomShit, DebugCommands

    function Trig_Hero_Dies_Func026C takes nothing returns boolean
        if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
            return false
        endif
        if(not(GetOwningPlayer(GetTriggerUnit())!=Player(8)))then
            return false
        endif
        if(not(GetOwningPlayer(GetTriggerUnit())!=Player(11)))then
            return false
        endif
        if(not(IsUnitInGroup(GetTriggerUnit(),udg_group02)!=true))then
            return false
        endif
        return true
    endfunction


    function EnableDeathTrigger takes nothing returns nothing
        local integer pid = GetTimerData(GetExpiredTimer())
        local unit u = udg_units01[pid+1]

        call ReviveHeroLoc(u,GetRectCenter(udg_rect09),true)
        call FixDeath(u)
        call PanCameraToForPlayer(GetOwningPlayer(u),GetUnitX(u),GetUnitY(u))
        call ReleaseTimer(GetExpiredTimer())

        set u = null
    endfunction


    function Trig_Hero_Dies_Conditions takes nothing returns boolean
        local unit u = GetDyingUnit()
        local integer pid = GetPlayerId(GetOwningPlayer(u))
        //call BJDebugMsg(GetUnitName(u))
        if(not Trig_Hero_Dies_Func026C()) then
            return false
        endif
        //udg_boolean07
        if ModeNoDeath == true and udg_boolean07 == false and udg_boolean02 == false and GetPlayerSlotState(GetOwningPlayer(u)) != PLAYER_SLOT_STATE_LEFT then
            call ReviveHeroLoc(u,GetRectCenter(udg_rect09),true)
            call FixDeath(u)
            call PanCameraToForPlayer(GetOwningPlayer(u),GetUnitX(u),GetUnitY(u))
    
            call ForGroupBJ(GetUnitsInRectMatching(udg_rects01[pid + 1],Condition( function Trig_Hero_Dies_Func024Func001Func0010010025551) ),function Trig_Hero_Dies_Func024Func001Func001A111a)
            
            set u = null
            return false
        endif
    
        if Lives[GetPlayerId(GetOwningPlayer(u))] > 0 and udg_boolean07 == false and udg_boolean02 == false and GetPlayerSlotState(GetOwningPlayer(u)) != PLAYER_SLOT_STATE_LEFT then
            call TimerStart(NewTimerEx(pid), 1, false, function EnableDeathTrigger)
            set RoundLiveLost[pid] = true
            call ForGroupBJ(GetUnitsInRectMatching(udg_rects01[pid + 1],Condition( function Trig_Hero_Dies_Func024Func001Func0010010025551) ),function Trig_Hero_Dies_Func024Func001Func001A111a)
    
            set Lives[pid] = Lives[pid] - 1
            call DisplayTextToPlayer(GetOwningPlayer(u) ,0,0,"You have " + I2S(Lives[pid]) + " lives left")
            
            set u = null
            return false
        endif
    
        set u = null
        return true
    endfunction


    function Trig_Hero_Dies_Func008A takes nothing returns nothing
        call DeleteUnit(GetEnumUnit())
    endfunction


    function Trig_Hero_Dies_Func011C takes nothing returns boolean
        if(not(GetPlayerController(GetOwningPlayer(GetTriggerUnit()))==MAP_CONTROL_USER))then
            return false
        endif
        return true
    endfunction


    function Trig_Hero_Dies_Func013C takes nothing returns boolean
        if(not(udg_boolean04==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Hero_Dies_Func013Func001001 takes nothing returns boolean
        return((udg_integer31 - 5)>= udg_integer02)
    endfunction


    function Trig_Hero_Dies_Func013Func002001001001001 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(8))
    endfunction
    
    function Trig_Hero_Dies_Func013Func002001001001002 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(11))
    endfunction
    
    function Trig_Hero_Dies_Func013Func002001001001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Hero_Dies_Func013Func002001001001001(),Trig_Hero_Dies_Func013Func002001001001002())
    endfunction
    
    function Trig_Hero_Dies_Func013Func002001001002 takes nothing returns boolean
        return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
    endfunction
    
    function Trig_Hero_Dies_Func013Func002001001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Hero_Dies_Func013Func002001001001(),Trig_Hero_Dies_Func013Func002001001002())
    endfunction


    function Trig_Hero_Dies_Func013Func002A takes nothing returns nothing
        call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_RESOURCE_FOOD_CAP,udg_integer31)
        call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_FOOD_CAP_CEILING,udg_integer31)
        call ResourseRefresh(GetEnumPlayer()) 
    endfunction


    function Trig_Hero_Dies_Func014C takes nothing returns boolean
        if(not(udg_boolean07==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Hero_Dies_Func014Func001C takes nothing returns boolean
        if(not(udg_boolean08==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Hero_Dies_Func014Func001Func003001001 takes nothing returns boolean
        return(udg_integer06==2)
    endfunction
    
    function Trig_Hero_Dies_Func014Func001Func003001002 takes nothing returns boolean
        return(udg_integer06==3)
    endfunction
    
    function Trig_Hero_Dies_Func014Func001Func003001 takes nothing returns boolean
        return GetBooleanOr(Trig_Hero_Dies_Func014Func001Func003001001(),Trig_Hero_Dies_Func014Func001Func003001002())
    endfunction


    function Trig_Hero_Dies_Func014Func001Func004001 takes nothing returns boolean
        return(udg_integer06 >= 4)
    endfunction


    function Trig_Hero_Dies_Func014Func001Func001001001 takes nothing returns boolean
        return(udg_integer06==2)
    endfunction
    
    function Trig_Hero_Dies_Func014Func001Func001001002 takes nothing returns boolean
        return(udg_integer06==3)
    endfunction
    
    function Trig_Hero_Dies_Func014Func001Func001001 takes nothing returns boolean
        return GetBooleanOr(Trig_Hero_Dies_Func014Func001Func001001001(),Trig_Hero_Dies_Func014Func001Func001001002())
    endfunction


    function Trig_Hero_Dies_Func014Func001Func002001 takes nothing returns boolean
        return(udg_integer06 >= 4)
    endfunction


    function Trig_Hero_Dies_Func014Func002001001001001 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(8))
    endfunction
    
    function Trig_Hero_Dies_Func014Func002001001001002 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(11))
    endfunction
    
    function Trig_Hero_Dies_Func014Func002001001001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Hero_Dies_Func014Func002001001001001(),Trig_Hero_Dies_Func014Func002001001001002())
    endfunction
    
    function Trig_Hero_Dies_Func014Func002001001002 takes nothing returns boolean
        return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
    endfunction
    
    function Trig_Hero_Dies_Func014Func002001001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Hero_Dies_Func014Func002001001001(),Trig_Hero_Dies_Func014Func002001001002())
    endfunction


    function Trig_Hero_Dies_Func014Func002A takes nothing returns nothing
        call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_RESOURCE_FOOD_CAP,udg_integer31)
        call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_FOOD_CAP_CEILING,udg_integer31)
        call ResourseRefresh(GetEnumPlayer()) 
    endfunction


    function Trig_Hero_Dies_Func016C takes nothing returns boolean
        if(not(udg_boolean02==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Hero_Dies_Func024Func001C takes nothing returns boolean
        if(not(RectContainsUnit(udg_rects01[udg_integer42],GetTriggerUnit())==true))then
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
        call ForceAddPlayerSimple(GetOwningPlayer(GetTriggerUnit()),udg_force02)
        set udg_integer06 =(udg_integer06 - 1)
        call AllowSinglePlayerCommands()
        set udg_booleans02[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]= true
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
    
        if(Trig_Hero_Dies_Func013C())then
            if(Trig_Hero_Dies_Func013Func001001())then
                set udg_integer31 =(udg_integer31 - 5)
            else
                call DoNothing()
            endif
            call ForForce(GetPlayersMatching(Condition(function Trig_Hero_Dies_Func013Func002001001)),function Trig_Hero_Dies_Func013Func002A)
        endif
    
        if(Trig_Hero_Dies_Func014C())then
            if(Trig_Hero_Dies_Func014Func001C())then
                if(Trig_Hero_Dies_Func014Func001Func003001())then
                    set udg_integer31 =(5 *(udg_integer41 + 1))
                else
                    call DoNothing()
                endif
                if(Trig_Hero_Dies_Func014Func001Func004001())then
                    set udg_integer31 =(5 *(udg_integer41 + 2))
                else
                    call DoNothing()
                endif
            else
                if(Trig_Hero_Dies_Func014Func001Func001001())then
                    set udg_integer31 =(10 *(udg_integer41 + 1))
                else
                    call DoNothing()
                endif
                if(Trig_Hero_Dies_Func014Func001Func002001())then
                    set udg_integer31 =(10 *(udg_integer41 + 2))
                else
                    call DoNothing()
                endif
            endif
            call ForForce(GetPlayersMatching(Condition(function Trig_Hero_Dies_Func014Func002001001)),function Trig_Hero_Dies_Func014Func002A)
        endif
    
        if(Trig_Hero_Dies_Func016C())then
            call ConditionalTriggerExecute(udg_trigger122)
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
                call ForGroupBJ(GetUnitsInRectMatching(udg_rects01[udg_integer42],Condition(function Trig_Hero_Dies_Func024Func001Func001001002)),function Trig_Hero_Dies_Func024Func001Func001A)
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
