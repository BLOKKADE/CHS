library trigger129 initializer init requires RandomShit

    function Trig_Player_Leaves_Conditions takes nothing returns boolean
        if(not(IsPlayerInForce(GetTriggerPlayer(),DefeatedPlayers)!=true))then
            return false
        endif
        return true
    endfunction


    function ResetHero takes unit u returns nothing
    
        if IsUnitType(u, UNIT_TYPE_HERO) then
            call RemoveItem(UnitItemInSlot(u, 0))
            call RemoveItem(UnitItemInSlot(u, 1))
            call RemoveItem(UnitItemInSlot(u, 2))
            call RemoveItem(UnitItemInSlot(u, 3))
            call RemoveItem(UnitItemInSlot(u, 4))
            call RemoveItem(UnitItemInSlot(u, 5))
    
            call RemoveHeroAbilities(u)
        endif
        call UnitRemoveAbility(u, 'ANr2')
    endfunction


    function Trig_Player_Leaves_Func005001 takes nothing returns boolean
        return(GetTriggerPlayer()==udg_player03)
    endfunction


    function Trig_Player_Leaves_Func007Func001Func002001001002001 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
    endfunction
    
    function Trig_Player_Leaves_Func007Func001Func002001001002002 takes nothing returns boolean
        return(UnitAlive(GetFilterUnit())==true)
    endfunction
    
    function Trig_Player_Leaves_Func007Func001Func002001001002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Player_Leaves_Func007Func001Func002001001002001(),Trig_Player_Leaves_Func007Func001Func002001001002002())
    endfunction


    function Trig_Player_Leaves_Func007Func001C takes nothing returns boolean
        if(not(RoundNumber==0))then
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
        local location arenaLocation

        call PlaySoundBJ(udg_sound04)
        call ForceAddPlayerSimple(GetTriggerPlayer(),udg_force07)
        call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(GetTriggerPlayer()))+ " |cffffcc00has left the game!|r"))
        call ResetHero(PlayerHeroes[pid])
        if(Trig_Player_Leaves_Func005001())then
            call ConditionalTriggerExecute(udg_trigger131)
        else
            call DoNothing()
        endif
        if(Trig_Player_Leaves_Func007C())then
            set arenaLocation = GetRectCenter(PlayerArenaRects[GetConvertedPlayerId(GetTriggerPlayer())])

            set SpawnedHeroCount =(SpawnedHeroCount + 1)
            call CreateNUnitsAtLoc(1,GetUnitTypeId(GroupPickRandomUnit(GetUnitsOfPlayerMatching(Player(8),Condition(function Trig_Player_Leaves_Func007Func003002001001002)))),GetTriggerPlayer(),arenaLocation,bj_UNIT_FACING)
            call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(GetTriggerPlayer())+(" |cffffcc00has randomed " +(GetUnitName(GetLastCreatedUnit())+ "! (+5 bonus gold)")))))
            call AdjustPlayerStateBJ(5,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)
            call ResourseRefresh(GetTriggerPlayer() )
            set PlayerHeroes[GetConvertedPlayerId(GetTriggerPlayer())]= GetLastCreatedUnit()
            call GroupAddUnit(OnPeriodGroup, GetLastCreatedUnit())
            call UnitAddItemByIdSwapped('ankh',GetLastCreatedUnit())
            call UnitAddItemByIdSwapped('pghe',GetLastCreatedUnit())
            call ResetToGameCameraForPlayer(GetTriggerPlayer(),0)
            if not CamMoveDisabled[pid - 1] then
                call PanCameraToTimedLocForPlayer(GetTriggerPlayer(),arenaLocation,0.10)
                call SelectUnitForPlayerSingle(GetLastCreatedUnit(),GetTriggerPlayer())
            endif
            call TriggerSleepAction(2)
            call ResetToGameCameraForPlayer(GetTriggerPlayer(),0)

            call RemoveLocation(arenaLocation)
            set arenaLocation = null
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
