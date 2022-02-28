library trigger89 initializer init requires RandomShit

    function Trig_Map_Initialization_Func010001001001001 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(8))
    endfunction
    
    function Trig_Map_Initialization_Func010001001001002 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(11))
    endfunction
    
    function Trig_Map_Initialization_Func010001001001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Map_Initialization_Func010001001001001(),Trig_Map_Initialization_Func010001001001002())
    endfunction
    
    function Trig_Map_Initialization_Func010001001002001 takes nothing returns boolean
        return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
    endfunction
    
    function Trig_Map_Initialization_Func010001001002002 takes nothing returns boolean
        return(IsPlayerInForce(GetFilterPlayer(),udg_force07)==true)
    endfunction
    
    function Trig_Map_Initialization_Func010001001002 takes nothing returns boolean
        return GetBooleanOr(Trig_Map_Initialization_Func010001001002001(),Trig_Map_Initialization_Func010001001002002())
    endfunction
    
    function Trig_Map_Initialization_Func010001001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Map_Initialization_Func010001001001(),Trig_Map_Initialization_Func010001001002())
    endfunction


    function Trig_Map_Initialization_Func010A takes nothing returns nothing
        set PlayerCount =(PlayerCount + 1)
        set InitialPlayerCount =(InitialPlayerCount + 1)
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 8
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            call SetPlayerAllianceStateBJ(GetEnumPlayer(),ConvertedPlayer(GetForLoopIndexA()),bj_ALLIANCE_UNALLIED)
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
        call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_RESOURCE_FOOD_USED,0)
        call ResourseRefresh(GetEnumPlayer()) 
        call CreateFogModifierRectBJ(true,GetEnumPlayer(),FOG_OF_WAR_VISIBLE,GetPlayableMapRect())
        call CameraSetupApplyForPlayer(true,udg_camerasetup01,GetEnumPlayer(),0.00)
    endfunction


    function Trig_Map_Initialization_Func011C takes nothing returns boolean
        if(not(PlayerCount==1))then
            return false
        endif
        return true
    endfunction


    function Trig_Map_Initialization_Func018001001001001 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(8))
    endfunction
    
    function Trig_Map_Initialization_Func018001001001002 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(11))
    endfunction
    
    function Trig_Map_Initialization_Func018001001001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Map_Initialization_Func018001001001001(),Trig_Map_Initialization_Func018001001001002())
    endfunction
    
    function Trig_Map_Initialization_Func018001001002001 takes nothing returns boolean
        return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
    endfunction
    
    function Trig_Map_Initialization_Func018001001002002 takes nothing returns boolean
        return(IsPlayerInForce(GetFilterPlayer(),udg_force07)==true)
    endfunction
    
    function Trig_Map_Initialization_Func018001001002 takes nothing returns boolean
        return GetBooleanOr(Trig_Map_Initialization_Func018001001002001(),Trig_Map_Initialization_Func018001001002002())
    endfunction
    
    function Trig_Map_Initialization_Func018001001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Map_Initialization_Func018001001001(),Trig_Map_Initialization_Func018001001002())
    endfunction


    function Trig_Map_Initialization_Func018A takes nothing returns nothing
        call SetPlayerAllianceStateBJ(GetEnumPlayer(),Player(8),bj_ALLIANCE_ALLIED_VISION)
    endfunction


    function Trig_Map_Initialization_Actions takes nothing returns nothing
    
    
        call SetMapFlag(MAP_ALLIANCE_CHANGES_HIDDEN,true)
        call SetMapFlag(MAP_LOCK_RESOURCE_TRADING,true)
        call SetTimeOfDay(12)
        
        call ForForce(GetPlayersMatching(Condition(function Trig_Map_Initialization_Func010001001)),function Trig_Map_Initialization_Func010A)
        if(Trig_Map_Initialization_Func011C())then
            call DisableTrigger(udg_trigger118)
            call DisableTrigger(udg_trigger80)
            call EnableTrigger(udg_trigger81)
        else
        endif
        call ConditionalTriggerExecute(udg_trigger147)
        call SetUnitPositionLoc(udg_unit37,OffsetLocation(GetUnitLoc(udg_unit25),0.00,0.00))
        call SetUnitPositionLoc(udg_unit36,OffsetLocation(GetUnitLoc(udg_unit15),15.00,15.00))
        call SetUnitPositionLoc(udg_unit38,OffsetLocation(GetUnitLoc(udg_unit34),0.00,0.00))
        call SetUnitPositionLoc(udg_unit35,OffsetLocation(GetUnitLoc(udg_unit21),17.00,15.00))
        call TriggerSleepAction(0.00)
        call ForForce(GetPlayersMatching(Condition(function Trig_Map_Initialization_Func018001001)),function Trig_Map_Initialization_Func018A)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger89 = CreateTrigger()
        call TriggerAddAction(udg_trigger89,function Trig_Map_Initialization_Actions)
    endfunction


endlibrary
