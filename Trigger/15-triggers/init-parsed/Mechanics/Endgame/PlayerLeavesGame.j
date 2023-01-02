library PlayerLeavesGame initializer init requires RandomShit

    private function PlayerLeavesGameConditions takes nothing returns boolean
        return (not IsPlayerInForce(GetTriggerPlayer(), DefeatedPlayers))
    endfunction

    private function ResetHero takes unit u returns nothing
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
/*
    function Trig_Player_Leaves_Func007Func003002001001002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
    endfunction
*/
    function PlayerLeavesGameActions takes nothing returns nothing
        local player leaverPlayer = GetTriggerPlayer()
        local integer playerId = GetPlayerId(leaverPlayer)
        local location arenaLocation

        call PlaySoundBJ(udg_sound04)
        call ForceAddPlayer(LeaverPlayers, leaverPlayer)
        call DisplayTimedTextToForce(GetPlayersAll(), 5.00, GetPlayerNameColour(leaverPlayer) + " |cffffcc00has left the game!|r")
        call ResetHero(PlayerHeroes[playerId + 1])

        // Find a new host
        if (HostPlayer == leaverPlayer) then
            call ConditionalTriggerExecute(SetHostPlayerTrigger)
        endif

        /* Don't try to create a random hero if the player leaves. I think this is using the old hero selector behavior
        if (RoundNumber == 0 and PlayerHeroes[playerId + 1] == null) then
            set arenaLocation = GetRectCenter(PlayerArenaRects[GetConvertedPlayerId(GetTriggerPlayer())])

            set SpawnedHeroCount = SpawnedHeroCount + 1 
            call CreateNUnitsAtLoc(1,GetUnitTypeId(GroupPickRandomUnit(GetUnitsOfPlayerMatching(Player(8), Condition(function Trig_Player_Leaves_Func007Func003002001001002)))),GetTriggerPlayer(),arenaLocation,bj_UNIT_FACING)
            call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(GetTriggerPlayer())+(" |cffffcc00has randomed " +(GetUnitName(GetLastCreatedUnit())+ "! (+5 bonus gold)")))))
            call AdjustPlayerStateBJ(5,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)
            call ResourseRefresh(GetTriggerPlayer() )
            set PlayerHeroes[GetConvertedPlayerId(GetTriggerPlayer())]= GetLastCreatedUnit()
            call GroupAddUnit(OnPeriodGroup, GetLastCreatedUnit())
            call UnitAddItemByIdSwapped('ankh',GetLastCreatedUnit())
            call UnitAddItemByIdSwapped('pghe',GetLastCreatedUnit())
            call ResetToGameCameraForPlayer(GetTriggerPlayer(),0)
            call PanCameraToTimedLocForPlayer(GetTriggerPlayer(),arenaLocation,0.10)
            call SelectUnitForPlayerSingle(GetLastCreatedUnit(),GetTriggerPlayer())
            call TriggerSleepAction(2)
            call ResetToGameCameraForPlayer(GetTriggerPlayer(),0)

            call RemoveLocation(arenaLocation)
            set arenaLocation = null
        endif*/

        // Cleanup
        set leaverPlayer = null
    endfunction

    private function init takes nothing returns nothing
        set PlayerLeavesGameTrigger = CreateTrigger()
        call TriggerRegisterPlayerEventLeave(PlayerLeavesGameTrigger, Player(0))
        call TriggerRegisterPlayerEventLeave(PlayerLeavesGameTrigger, Player(1))
        call TriggerRegisterPlayerEventLeave(PlayerLeavesGameTrigger, Player(2))
        call TriggerRegisterPlayerEventLeave(PlayerLeavesGameTrigger, Player(3))
        call TriggerRegisterPlayerEventLeave(PlayerLeavesGameTrigger, Player(4))
        call TriggerRegisterPlayerEventLeave(PlayerLeavesGameTrigger, Player(5))
        call TriggerRegisterPlayerEventLeave(PlayerLeavesGameTrigger, Player(6))
        call TriggerRegisterPlayerEventLeave(PlayerLeavesGameTrigger, Player(7))
        call TriggerAddCondition(PlayerLeavesGameTrigger, Condition(function PlayerLeavesGameConditions))
        call TriggerAddAction(PlayerLeavesGameTrigger, function PlayerLeavesGameActions)
    endfunction

endlibrary
