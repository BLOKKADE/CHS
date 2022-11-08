library trigger134 initializer init requires RandomShit

    function Trig_PvP_Func002001002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(8))
    endfunction


    function Trig_PvP_Func002A takes nothing returns nothing
        call GroupAddUnitSimple(GetEnumUnit(),PotentialDuelHeroes)
    endfunction

    function AwardDuelWinners takes nothing returns nothing
        local player awardingPlayer = GetOwningPlayer(GetEnumUnit())
        
        // Award gold
        if(GameModeShort==true)then
            if(RoundNumber==10)then
                call AdjustPlayerStateBJ(200,awardingPlayer,PLAYER_STATE_RESOURCE_GOLD)
            elseif(RoundNumber==15)then
                call AdjustPlayerStateBJ(400,awardingPlayer,PLAYER_STATE_RESOURCE_GOLD)
            elseif(RoundNumber==20)then
                call AdjustPlayerStateBJ(800,awardingPlayer,PLAYER_STATE_RESOURCE_GOLD)
            endif
        else
            if(RoundNumber==20)then
                call AdjustPlayerStateBJ(200,awardingPlayer,PLAYER_STATE_RESOURCE_GOLD)
            elseif(RoundNumber==30)then
                call AdjustPlayerStateBJ(400,awardingPlayer,PLAYER_STATE_RESOURCE_GOLD)
            elseif(RoundNumber==40)then
                call AdjustPlayerStateBJ(800,awardingPlayer,PLAYER_STATE_RESOURCE_GOLD)
            endif
        endif

        // Award bonus gold? Makes no sense since this variables is only assigned from DuelReward which is just an array of ints
        if(udg_integer15=='I01D')then // Armor of the goddess
            call AdjustPlayerStateBJ(1400,awardingPlayer,PLAYER_STATE_RESOURCE_GOLD)
        elseif(udg_integer15=='I01C')then // Soul reparer
            call AdjustPlayerStateBJ(1750,awardingPlayer,PLAYER_STATE_RESOURCE_GOLD)
        elseif(udg_integer15=='I01E')then // Rapier of the gods
            call AdjustPlayerStateBJ(2750,awardingPlayer,PLAYER_STATE_RESOURCE_GOLD)
        endif
    
        call ResourseRefresh(awardingPlayer )

        set awardingPlayer = null
    endfunction

    function Trig_PvP_Func002001002 takes nothing returns boolean
        return IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO) and UnitAlive(GetFilterUnit()) and GetOwningPlayer(GetFilterUnit())!=Player(11) and GetOwningPlayer(GetFilterUnit())!=Player(8)
    endfunction


    function Trig_PvP_Actions takes nothing returns nothing
        call TriggerSleepAction(5.00)
        call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_PvP_Func002001002)),function Trig_PvP_Func002A)
        call ForGroupBJ(DuelWinners,function AwardDuelWinners)
        call GroupClear(DuelWinners)
        
            /*
            call UpdatePlayerCount()
            call MoveRoundRobin()
            call DisplayDuelNemesis()*/
            
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call CreateTimerDialogBJ(GetLastCreatedTimerBJ(),"PvP Battle")
        call StartTimerBJ(GetLastCreatedTimerBJ(),false,25.00)
        call DisplayTimedTextToForce(GetPlayersAll(), 25, "|cff9dff00You can freely use items during PvP. They will be restored when finished.|r \n|cffff5050You will lose any items bought during the duel.\n|r|cffffcc00If there is an odd amount of players, losing a duel might mean you could duel again vs the last player.|r")
        call TriggerSleepAction(25.00)
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call ConditionalTriggerExecute(udg_trigger136)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger134 = CreateTrigger()
        call TriggerAddAction(udg_trigger134,function Trig_PvP_Actions)
    endfunction


endlibrary
