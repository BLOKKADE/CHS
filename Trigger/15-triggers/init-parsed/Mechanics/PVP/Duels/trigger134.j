library trigger134 initializer init requires RandomShit

    function Trig_PvP_Func002001002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(8))
    endfunction


    function Trig_PvP_Func002A takes nothing returns nothing
        call GroupAddUnitSimple(GetEnumUnit(),PotentialDuelHeroes)
    endfunction


    function Trig_PvP_Func004Func001C takes nothing returns boolean
        if(not(GameModeShort==true))then
            return false
        endif
        return true
    endfunction


    function Trig_PvP_Func004Func001Func004001 takes nothing returns boolean
        return(RoundNumber==10)
    endfunction


    function Trig_PvP_Func004Func001Func005001 takes nothing returns boolean
        return(RoundNumber==15)
    endfunction


    function Trig_PvP_Func004Func001Func006001 takes nothing returns boolean
        return(RoundNumber==20)
    endfunction


    function Trig_PvP_Func004Func001Func001001 takes nothing returns boolean
        return(RoundNumber==20)
    endfunction


    function Trig_PvP_Func004Func001Func002001 takes nothing returns boolean
        return(RoundNumber==30)
    endfunction


    function Trig_PvP_Func004Func001Func003001 takes nothing returns boolean
        return(RoundNumber==40)
    endfunction


    function Trig_PvP_Func004Func002001 takes nothing returns boolean
        return(udg_integer15=='I01D')
    endfunction


    function Trig_PvP_Func004Func003001 takes nothing returns boolean
        return(udg_integer15=='I01C')
    endfunction


    function Trig_PvP_Func004Func004001 takes nothing returns boolean
        return(udg_integer15=='I01E')
    endfunction


    function Trig_PvP_Func004A takes nothing returns nothing
        if(Trig_PvP_Func004Func001C())then
            if(Trig_PvP_Func004Func001Func004001())then
                call AdjustPlayerStateBJ(200,GetOwningPlayer(GetEnumUnit()),PLAYER_STATE_RESOURCE_GOLD)
            else
                call DoNothing()
            endif
            if(Trig_PvP_Func004Func001Func005001())then
                call AdjustPlayerStateBJ(400,GetOwningPlayer(GetEnumUnit()),PLAYER_STATE_RESOURCE_GOLD)
            else
                call DoNothing()
            endif
            if(Trig_PvP_Func004Func001Func006001())then
                call AdjustPlayerStateBJ(800,GetOwningPlayer(GetEnumUnit()),PLAYER_STATE_RESOURCE_GOLD)
            else
                call DoNothing()
            endif
        else
            if(Trig_PvP_Func004Func001Func001001())then
                call AdjustPlayerStateBJ(200,GetOwningPlayer(GetEnumUnit()),PLAYER_STATE_RESOURCE_GOLD)
            else
                call DoNothing()
            endif
            if(Trig_PvP_Func004Func001Func002001())then
                call AdjustPlayerStateBJ(400,GetOwningPlayer(GetEnumUnit()),PLAYER_STATE_RESOURCE_GOLD)
            else
                call DoNothing()
            endif
            if(Trig_PvP_Func004Func001Func003001())then
                call AdjustPlayerStateBJ(800,GetOwningPlayer(GetEnumUnit()),PLAYER_STATE_RESOURCE_GOLD)
            else
                call DoNothing()
            endif
        endif
        if(Trig_PvP_Func004Func002001())then
            call AdjustPlayerStateBJ(1400,GetOwningPlayer(GetEnumUnit()),PLAYER_STATE_RESOURCE_GOLD)
        else
            call DoNothing()
        endif
        if(Trig_PvP_Func004Func003001())then
            call AdjustPlayerStateBJ(1750,GetOwningPlayer(GetEnumUnit()),PLAYER_STATE_RESOURCE_GOLD)
        else
            call DoNothing()
        endif
        if(Trig_PvP_Func004Func004001())then
            call AdjustPlayerStateBJ(2750,GetOwningPlayer(GetEnumUnit()),PLAYER_STATE_RESOURCE_GOLD)
        else
            call DoNothing()
        endif
    
        call ResourseRefresh(GetOwningPlayer(GetEnumUnit()) )
    endfunction


    function Trig_PvP_Func007C takes nothing returns boolean
        if(not(udg_boolean07==true))then
            return false
        endif
        return true
    endfunction

    function Trig_PvP_Func002001002 takes nothing returns boolean
        return IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO) and UnitAlive(GetFilterUnit()) and GetOwningPlayer(GetFilterUnit())!=Player(11) and GetOwningPlayer(GetFilterUnit())!=Player(8)
    endfunction


    function Trig_PvP_Actions takes nothing returns nothing
        call TriggerSleepAction(5.00)
        call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_PvP_Func002001002)),function Trig_PvP_Func002A)
        call ForGroupBJ(DuelWinners,function Trig_PvP_Func004A)
        call GroupClear(DuelWinners)
        if(Trig_PvP_Func007C())then
            call DisplayTextToForce(GetPlayersAll(),"|cffffcc00Death Match - Survive to advance to the next level!")
        else
            /*
            call UpdatePlayerCount()
            call MoveRoundRobin()
            call DisplayDuelNemesis()*/
        endif
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
