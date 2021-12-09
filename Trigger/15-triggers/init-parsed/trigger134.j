library trigger134 initializer init requires RandomShit

    function Trig_PvP_Func002001002001 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())!=Player(8))
    endfunction


    function Trig_PvP_Func002A takes nothing returns nothing
        call GroupAddUnitSimple(GetEnumUnit(),udg_group01)
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


    function Trig_PvP_Actions takes nothing returns nothing
        call TriggerSleepAction(5.00)
        call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_PvP_Func002001002)),function Trig_PvP_Func002A)
        call ForGroupBJ(udg_group03,function Trig_PvP_Func004A)
        call GroupClear(udg_group03)
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
        call StartTimerBJ(GetLastCreatedTimerBJ(),false,15.00)
        call DisplayTimedTextToForce(GetPlayersAll(), 15, "|cff9dff00You can freely use items during PvP. They will be restored when finished.|r \n|cffff5050You will lose any items bought during the duel.\n|r|cffffcc00If there is an odd amount of players, losing a duel might mean you could duel again vs the last player.|r")
        call TriggerSleepAction(15.00)
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call ConditionalTriggerExecute(udg_trigger136)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger134 = CreateTrigger()
        call TriggerAddAction(udg_trigger134,function Trig_PvP_Actions)
    endfunction


endlibrary
