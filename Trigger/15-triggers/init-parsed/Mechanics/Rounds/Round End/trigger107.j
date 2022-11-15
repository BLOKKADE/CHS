library trigger107 initializer init requires RandomShit

    function Trig_Complete_Level_Player_Func006Func002001001002 takes nothing returns boolean
        return (IsUnitAliveBJ(GetFilterUnit())==true) and (GetOwningPlayer(GetFilterUnit())==Player(11))
    endfunction

    function Trig_Complete_Level_Player_Conditions takes nothing returns boolean
        if(not(GetOwningPlayer(GetTriggerUnit())==Player(11)))then
            return false
        endif
        if(not(CountUnitsInGroup(GetUnitsInRectMatching(PlayerArenaRects[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))],Condition(function Trig_Complete_Level_Player_Func006Func002001001002)))==0))then
            return false
        endif
        if(not(IsPlayerInForce(GetOwningPlayer(GetKillingUnitBJ()),DefeatedPlayers)!=true))then
            return false
        endif
        if(not(IsPlayerInForce(GetOwningPlayer(GetKillingUnitBJ()),RoundPlayersCompleted)!=true))then
            return false
        endif
        if(not(GetOwningPlayer(GetKillingUnitBJ())!=Player(11)))then
            return false
        endif
        if(not(GetKillingUnitBJ()!=null))then
            return false
        endif
        return true
    endfunction

    function Trig_Complete_Level_Player_Func005C takes nothing returns boolean
        if(not(CountPlayersInForceBJ(RoundPlayersCompleted)< BettingPlayerCount))then
            return false
        endif
        //	if(not(GetUnitTypeId(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])!='N00K'))then
        //		return false
        //	endif
        return true
    endfunction

    function Trig_Complete_Level_Player_Actions takes nothing returns nothing
        local player p = GetOwningPlayer(GetKillingUnit())
        local integer pid = GetPlayerId(p)
        local location arenaLocation = GetRectCenter(GetPlayableMapRect())
        local real duration = (T32_Tick - RoundStartTick) / 32
        local real playerCountSub = RMaxBJ(8 - (0.5 * duration), 0)
        local integer roundClearXpBonus = R2I(playerCountSub * (5 * Pow(RoundNumber, 2)))

        if GetUnitTypeId(GetKillingUnit()) == TINKER_UNIT_ID then
            set roundClearXpBonus = roundClearXpBonus * 2
        endif

        if(RoundNumber==5)then
            set udg_boolean09 = false
        endif
        set BettingPlayerCount =(PlayerCount / 2)
        if(BettingPlayerCount > 3)then
            set BettingPlayerCount = 3
        endif

        call ForceAddPlayerSimple(p,RoundPlayersCompleted)
        call SetCurrentlyFighting(p, false)
        set RoundFinishedCount =(RoundFinishedCount + 1)
        call SetUnitInvulnerable(PlayerHeroes[pid + 1],true)
        if RoundLiveLost[pid] then
            set RoundLiveLost[pid] = false
            call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(p)+ " |cffff7300died and lost a life!|r |cffbe5ffd" + I2S(Lives[pid]) + " remaining.|r")))
        else
            if roundClearXpBonus == 0 then
                call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(p)+ " |cffffcc00survived the level!|r")))
            else
                call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(p)+(" |cffffcc00survived the level!|r |cff7bff00(+" +(I2S(roundClearXpBonus)+ " exp)|r")))))
                call AddHeroXPSwapped(roundClearXpBonus,PlayerHeroes[pid + 1],true)
            endif
        endif
        call CreateNUnitsAtLoc(1,PRIEST_1_UNIT_ID,p,arenaLocation,bj_UNIT_FACING)
        call UnitApplyTimedLifeBJ(2.00,'BTLF',GetLastCreatedUnit())
        call GroupAddUnitSimple(GetLastCreatedUnit(),GroupEmptyArenaCheck)

        call RemoveLocation(arenaLocation)
        set arenaLocation = null
        set p = null
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger107 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger107,EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(udg_trigger107,Condition(function Trig_Complete_Level_Player_Conditions))
        call TriggerAddAction(udg_trigger107,function Trig_Complete_Level_Player_Actions)
    endfunction


endlibrary
