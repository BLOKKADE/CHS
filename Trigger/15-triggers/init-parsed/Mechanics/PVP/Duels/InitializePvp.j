library InitializePvp initializer init requires RandomShit, PvpRoundRobin, VotingResults, PvpHelper

    /*
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

        // Award bonus gold? Makes no sense since this variable is only assigned from DuelReward which is just an array of ints
        if(PvpGoldWinAmount=='I01D')then // Armor of the goddess
            call AdjustPlayerStateBJ(1400,awardingPlayer,PLAYER_STATE_RESOURCE_GOLD)
        elseif(PvpGoldWinAmount=='I01C')then // Soul reparer
            call AdjustPlayerStateBJ(1750,awardingPlayer,PLAYER_STATE_RESOURCE_GOLD)
        elseif(PvpGoldWinAmount=='I01E')then // Rapier of the gods
            call AdjustPlayerStateBJ(2750,awardingPlayer,PLAYER_STATE_RESOURCE_GOLD)
        endif
    
        call ResourseRefresh(awardingPlayer)

        set awardingPlayer = null
    endfunction
    */
    
    private function ResetPlayerArenaRects takes nothing returns nothing
        local integer playerArenaRectIndex = 0

        loop
            set PlayerArenaRects[playerArenaRectIndex] = null
            set playerArenaRectIndex = playerArenaRectIndex + 1
            exitwhen playerArenaRectIndex == 8
        endloop
    endfunction

    private function InitializePvpActions takes nothing returns nothing
        call TriggerSleepAction(5.00)
        // call ForGroupBJ(DuelWinners,function AwardDuelWinners)
        // call GroupClear(DuelWinners)
        
        call GroupClear(DuelingHeroes) // DuelingHeroes keeps track of all heroes that are fighting
        call ResetPlayerArenaRects() // PlayerArenaRects keeps track of the arena a player belongs in

        // Setup the fights
        call UpdatePlayerCount()
        call DisplayNemesisNames()
        
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call CreateTimerDialogBJ(GetLastCreatedTimerBJ(),"PvP Battle")
        call StartTimerBJ(GetLastCreatedTimerBJ(),false,25.00)
        call DisplayTimedTextToForce(GetPlayersAll(), 25, "|cff9dff00You can freely use items during PvP. They will be restored when finished.|r \n|cffff5050You will lose any items bought during the duel.\n|r|cffffcc00If there is an odd amount of players, losing a duel might mean you could duel again vs the last player.|r")
        call TriggerSleepAction(25.00)
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())

        // Run the fights
        if (SimultaneousDuelMode == 2) then
            call BJDebugMsg("Starting simultaneous duels setup. Size: " + I2S(DuelGameListRemaining.size()))

            loop
                exitwhen DuelGameListRemaining.size() == 0

                call StartDuelGame(GetNextDuel())
            endloop
        else
            call BJDebugMsg("Starting single duels setup. Size: " + I2S(DuelGameListRemaining.size()))
            call StartDuelGame(GetNextDuel())
        endif
    endfunction

    private function init takes nothing returns nothing
        set InitializePvpTrigger = CreateTrigger()
        call TriggerAddAction(InitializePvpTrigger,function InitializePvpActions)
    endfunction

endlibrary
