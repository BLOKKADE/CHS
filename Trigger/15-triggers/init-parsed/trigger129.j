library trigger129 initializer init requires RandomShit

    function Trig_Player_Leaves_Conditions takes nothing returns boolean
        if(not(IsPlayerInForce(GetTriggerPlayer(),udg_force02)!=true))then
            return false
        endif
        return true
    endfunction


    function Trig_Player_Leaves_Func005001 takes nothing returns boolean
        return(GetTriggerPlayer()==udg_player03)
    endfunction


    function Trig_Player_Leaves_Func007Func001Func002001001002001 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
    endfunction


    function Trig_Player_Leaves_Func007Func001C takes nothing returns boolean
        if(not(udg_integer02==0))then
            return false
        endif
        if(not(CountUnitsInGroup(GetUnitsOfPlayerMatching(GetTriggerPlayer(),Condition(function Trig_Player_Leaves_Func007Func001Func002001001002)))==0))then
            return false
        endif
        return true
    endfunction


    function Trig_Player_Leaves_Func007C takes nothing returns boolean
        if(not Trig_Player_Leaves_Func007Func001C())then
            return false
        endif
        return true
    endfunction


    function Trig_Player_Leaves_Func007Func003002001001002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
    endfunction


    function Trig_Player_Leaves_Actions takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer()) + 1
        call PlaySoundBJ(udg_sound04)
        call ForceAddPlayerSimple(GetTriggerPlayer(),udg_force07)
        call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(GetTriggerPlayer()))+ " |cffffcc00has left the game!|r"))
        call ResetHero(udg_units01[pid])
        if(Trig_Player_Leaves_Func005001())then
            call ConditionalTriggerExecute(udg_trigger131)
        else
            call DoNothing()
        endif
        if(Trig_Player_Leaves_Func007C())then
            set udg_integer07 =(udg_integer07 + 1)
            call CreateNUnitsAtLoc(1,GetUnitTypeId(GroupPickRandomUnit(GetUnitsOfPlayerMatching(Player(8),Condition(function Trig_Player_Leaves_Func007Func003002001001002)))),GetTriggerPlayer(),GetRectCenter(udg_rects01[GetConvertedPlayerId(GetTriggerPlayer())]),bj_UNIT_FACING)
            call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(GetTriggerPlayer())+(" |cffffcc00has randomed " +(GetUnitName(GetLastCreatedUnit())+ "! (+5 bonus gold)")))))
            call AdjustPlayerStateBJ(5,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)
            call ResourseRefresh(GetTriggerPlayer() )
            set udg_units01[GetConvertedPlayerId(GetTriggerPlayer())]= GetLastCreatedUnit()
            call UnitAddItemByIdSwapped('ankh',GetLastCreatedUnit())
            call UnitAddItemByIdSwapped('pghe',GetLastCreatedUnit())
            call ResetToGameCameraForPlayer(GetTriggerPlayer(),0)
            call PanCameraToTimedLocForPlayer(GetTriggerPlayer(),GetRectCenter(udg_rects01[GetConvertedPlayerId(GetTriggerPlayer())]),0.10)
            call SelectUnitForPlayerSingle(GetLastCreatedUnit(),GetTriggerPlayer())
            call TriggerSleepAction(2)
            call ResetToGameCameraForPlayer(GetTriggerPlayer(),0)
        else
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger129 = CreateTrigger()
        call TriggerRegisterPlayerEventLeave(udg_trigger129,Player(0))
        call TriggerRegisterPlayerEventLeave(udg_trigger129,Player(1))
        call TriggerRegisterPlayerEventLeave(udg_trigger129,Player(2))
        call TriggerRegisterPlayerEventLeave(udg_trigger129,Player(3))
        call TriggerRegisterPlayerEventLeave(udg_trigger129,Player(4))
        call TriggerRegisterPlayerEventLeave(udg_trigger129,Player(5))
        call TriggerRegisterPlayerEventLeave(udg_trigger129,Player(6))
        call TriggerRegisterPlayerEventLeave(udg_trigger129,Player(7))
        call TriggerAddCondition(udg_trigger129,Condition(function Trig_Player_Leaves_Conditions))
        call TriggerAddAction(udg_trigger129,function Trig_Player_Leaves_Actions)
    endfunction


endlibrary
