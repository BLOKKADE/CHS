library PvpEnd initializer init requires RandomShit, PlayerTracking, CreepDeath, AchievementsFrame, UnitFilteringUtility, GameInit, PvpHelper, VotingResults, PlayerHeroDeath, CustomGameEvent, EventHelpers, Glory

    globals
        boolean PvpRoundEndWait = false
        timer PvpRoundEndTimer
        timerdialog PvpRoundEndTimerDialog
        
        DuelGame PvpEndDuelGame
    endglobals

    private function PvpHeroDeathConditions takes nothing returns boolean
        return IsUnitInGroup(GetTriggerUnit(), DuelingHeroes) == true
    endfunction

    private function ResetCameraToCenterArenaForPlayer takes nothing returns nothing
        // Move camera to center arena
        if not CamMoveDisabled[GetPlayerId(GetEnumPlayer())] then
            call PanCameraToTimedLocForPlayer(GetEnumPlayer(), RectMidArenaCenter, 0.20)
        endif
    endfunction

    private function ResetToCenterArenaForPlayer takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local integer playerId = GetPlayerId(currentPlayer)
        local unit playerHero = PlayerHeroes[playerId]
        local PlayerStats ps = PlayerStats.forPlayer(currentPlayer)

        // Revive the unit if it died
        call SetUnitPosition(playerHero, GetLocationX(RectMidArenaCenter) + GetRandomReal(-300, 300), GetLocationY(RectMidArenaCenter) + GetRandomReal(-300, 300))
        call ReviveHero(playerHero, GetUnitX(playerHero), GetUnitY(playerHero), true)

        // Move the pet
        if (ps.getPet() != null) then
            call SetUnitPositionLoc(ps.getPet(), RectMidArenaCenter)
        else
            // Revive the pet if it died
            call AchievementsFrame_TryToSummonPet(ps.getPetIndex(), currentPlayer, false)
        endif

        // Random crap
        call FixAbominationPassive(playerHero)

        // Cleanup
        set currentPlayer = null
        set playerHero = null
    endfunction

    private function ResetItemsForPlayer takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local integer playerId = GetPlayerId(currentPlayer)
        local unit playerHero = PlayerHeroes[playerId]
        local integer itemSlotIndex = 0
        local item tempItem

        if (playerHero != null) then
            // Reset items
            loop
                exitwhen itemSlotIndex == 6

                call RemoveItem(UnitItemInSlot(playerHero, itemSlotIndex))

                if GetPlayerSlotState(currentPlayer) != PLAYER_SLOT_STATE_LEFT then
                    // Make sure there is an actual item
                    if (PreDuelItemIds[(6 * playerId) + itemSlotIndex] != -1) then
                        set tempItem = UnitAddItemByIdSwapped(PreDuelItemIds[(6 * playerId) + itemSlotIndex], playerHero)
                        call SetItemUserData(tempItem, playerId + 1)

                        if PreDuelItemCharges[(6 * playerId) + itemSlotIndex] > 1 then
                            call SetItemCharges(tempItem, PreDuelItemCharges[(6 * playerId) + itemSlotIndex])
                        endif

                        call SetItemPawnable(tempItem, true)
                    endif
                endif

                set itemSlotIndex = itemSlotIndex + 1
            endloop
        endif
        
        // Cleanup
        set currentPlayer = null
        set playerHero = null
        set tempItem = null
    endfunction

    private function RemoveItemFromArena takes nothing returns nothing
        call RemoveItem(GetEnumItem())
    endfunction
    
    private function ShowWinningSpecialEffect takes nothing returns nothing
        call DestroyEffect(AddSpecialEffectTargetUnitBJ("origin", GetEnumUnit(), "Abilities\\Spells\\Human\\Resurrect\\ResurrectCaster.mdl"))
    endfunction
    
    private function DuelEndedPlayerActions takes player currentPlayer, unit playerHero returns nothing
        // Mark that they player is not fighting
        call SetCurrentlyFighting(currentPlayer, false)

        call GroupRemoveUnit(DuelingHeroes, playerHero)

        // Stop the triggers for unit leaving an arena
        call StopRectLeaveDetection(GetHandleId(playerHero))

        call CustomGameEvent_FireEvent(EVENT_PLAYER_ROUND_COMPLETE, EventInfo.createAll(currentPlayer, 0, RoundNumber, true))
    endfunction

    private function EndDuelActionsForWinningPlayer takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local unit playerHero = PlayerHeroes[GetPlayerId(currentPlayer)]
        local PlayerStats ps = PlayerStats.forPlayer(currentPlayer)
        local DuelGame duelGame = DuelGame.getPlayerDuelGame(currentPlayer)
        local string message

        call ps.addDuelWin()
        call ps.addPVPWin()

        set message = GetPlayerNameColour(currentPlayer) + " has |cffc2154f" + I2S(ps.getSeasonPVPWins()) + "|r PVP wins this season, |cffc2154f" + I2S(ps.getAllPVPWins()) + "|r all time for this game mode"

        // Show the PVP win count if this is not simultaneous duels. Otherwise it will be a lot of spam
        if (SimultaneousDuelMode == 1 or DuelGameList.size() == 1) then // No simultaneous duels or there is only one duel (Only 2 people in game, or odd player duel)
            call DisplayTimedTextToForce(GetPlayersAll(), 5.00, message)
        else
            // Otherwise show the pvp stats to everyone in the duel
            call DisplayTimedTextToForce(duelGame.team1, 5.00, message)
            call DisplayTimedTextToForce(duelGame.team2, 5.00, message)
        endif

        call GroupAddUnit(DuelWinnerDisabled, playerHero) // Used to prevent heroes from casting abilities

        // Don't add the winner twice for the odd duel
        if (not IsUnitInGroup(playerHero, DuelWinners)) then
            call GroupAddUnit(DuelWinners, playerHero) // Collection of all winners
        endif

        call SetUnitInvulnerable(playerHero, true)

        call DuelEndedPlayerActions(currentPlayer, playerHero)

        // Cleanup
        set currentPlayer = null
        set playerHero = null
    endfunction

    private function EndDuelActionsForDrawPlayer takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local unit playerHero = PlayerHeroes[GetPlayerId(currentPlayer)]
        local PlayerStats ps = PlayerStats.forPlayer(currentPlayer)

        call ps.addDuelLoss()

        // Don't add the loser twice
        if (not IsPlayerInForce(currentPlayer, DuelLosers)) then
            call ForceAddPlayer(DuelLosers, currentPlayer) // Collection of all losers
        endif

        call GroupAddUnit(DuelWinnerDisabled, playerHero) // Used to prevent heroes from casting abilities

        call SetUnitInvulnerable(playerHero, true)

        call DuelEndedPlayerActions(currentPlayer, playerHero)

        // Cleanup
        set currentPlayer = null
        set playerHero = null
    endfunction

    private function EndDuelActionsForLosingPlayer takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local unit playerHero = PlayerHeroes[GetPlayerId(currentPlayer)]
        local PlayerStats ps = PlayerStats.forPlayer(currentPlayer)

        call ps.addDuelLoss()

        // Don't add the loser twice
        if (not IsPlayerInForce(currentPlayer, DuelLosers)) then
            call ForceAddPlayer(DuelLosers, currentPlayer) // Collection of all losers
        endif

        call DuelEndedPlayerActions(currentPlayer, playerHero)

        // Cleanup
        set currentPlayer = null
        set playerHero = null
    endfunction

    private function AddPlayerKillToPlayer takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local unit playerHero = PlayerHeroes[GetPlayerId(currentPlayer)]
        local unit deadUnit = GetDyingUnit()
        local MidasTouch deadUnitMidasTouch = GetMidasTouch(GetHandleId(deadUnit))
        local PlayerStats ps = PlayerStats.forPlayer(currentPlayer)
        local real bonus = 1

        call ps.addPlayerKill()
        
        // Midas Touch
        if deadUnitMidasTouch != 0 then
            call CreepDeath_BountyText(playerHero, deadUnit, deadUnitMidasTouch.bonus)
            
            if ChestOfGreedBonus.boolean[GetHandleId(deadUnit)] then
                set bonus = CgBonus
            endif

            call SetPlayerState(currentPlayer, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(currentPlayer, PLAYER_STATE_RESOURCE_GOLD) + R2I(deadUnitMidasTouch.bonus * bonus))
            set deadUnitMidasTouch.stop = true
        endif

        // Cleanup
        set currentPlayer = null
        set playerHero = null
        set deadUnit = null
    endfunction

    private function AwardFunToWinningUnit takes nothing returns nothing
        call FunWinner(GetEnumUnit())
    endfunction

    // This function should only be called when all initial duels are over
    private function AfterDuelCleanupActions takes DuelGame duelGame returns nothing
        call TriggerSleepAction(3.00)

        // Move hero to center arena, pets, items
        call ForForce(duelGame.team1, function ResetToCenterArenaForPlayer)
        call ForForce(duelGame.team2, function ResetToCenterArenaForPlayer)

        // Move camera depending on game mode
        if (SimultaneousDuelMode == 2) then
            call ForForce(duelGame.team1, function ResetCameraToCenterArenaForPlayer)
            call ForForce(duelGame.team2, function ResetCameraToCenterArenaForPlayer)
        else
            call ForForce(GetPlayersAll(), function ResetCameraToCenterArenaForPlayer)
        endif

        // Reset to the items to before the duels
        call ForForce(duelGame.team1, function ResetItemsForPlayer)
        call ForForce(duelGame.team2, function ResetItemsForPlayer)

        // Remove the arena from used arenas so it can be used again
        call duelGame.removeUsedArena()

        call TriggerSleepAction(2.00)

        // Removes all non heroes/hops/dummy units
        call EnumItemsInRectBJ(duelGame.getDuelArena(), function RemoveItemFromArena)
        call RemoveUnitsInRect(duelGame.getDuelArena())
    endfunction

    function PvpStartNextRound takes nothing returns nothing
        set PvpRoundEndWait = false
        call DestroyTimer(PvpRoundEndTimer)
        call DestroyTimerDialog(PvpRoundEndTimerDialog)
        call TriggerExecute(StartLevelTrigger)
    endfunction

    function HandleOddDuelAndEndDuel takes DuelGame duelGame returns nothing
        local PlayerStats ps
        local boolean startSimultaneousOddDuel
        local boolean startNonSimultaneousOddDuel
        local player randomOddDuelPlayer
        local DuelGame oddDuelGame
        local integer gloryReward

        // Check if we should do an odd duel
        set startSimultaneousOddDuel = SimultaneousDuelMode == 2 and OddPlayer != -1 and OddPlayerDuelStarted == false
        set startNonSimultaneousOddDuel = SimultaneousDuelMode == 1 and DuelGame.areAllDuelsOver() and OddPlayer != -1 and OddPlayerDuelStarted == false

        if (startSimultaneousOddDuel or startNonSimultaneousOddDuel) then
            set OddPlayerDuelStarted = true

            // Create a new duel using a random loser
            set randomOddDuelPlayer = ForcePickRandomPlayer(DuelLosers)
            set oddDuelGame = AddOddPlayerDuel(randomOddDuelPlayer)

            call AfterDuelCleanupActions(duelGame)

            // Go to the next pvp battle for the odd player
            call DisplayTimedTextToForce(GetPlayersAll(), 15.00, "|cffff0000Odd player amount detected. Starting duel for the odd player out!|r")

            call oddDuelGame.setupNextPvpBattleTimer()
            call DisplayNemesisNames()
            call TriggerSleepAction(15.00)

            // Play the horn noise for everyone if it is a non-simultaneous duel
            if (startNonSimultaneousOddDuel) then
                call PlaySoundBJ(udg_sound08) // Horn noise for everyone!
            elseif (GetLocalPlayer() == randomOddDuelPlayer or GetLocalPlayer() == Player(OddPlayer)) then
                call PlaySoundBJ(udg_sound08) // Horn noise for just the odd duel!
            endif

            // Start the next fight
            call InitializeDuelGame(GetNextDuel())
            call StartDuels()

            // Cleanup
            set randomOddDuelPlayer = null

        // All duels are over, no odd player
        elseif (DuelGame.areAllDuelsOver()) then
            call AfterDuelCleanupActions(duelGame)
            call EnumItemsInRectBJ(RectMidArena, function RemoveItemFromArena) // Remove items from center arena when all duels are done

            // Reward glory and stuff
            call ForGroup(DuelWinners, function AwardFunToWinningUnit)

            // Try to end the game?
            call ConditionalTriggerExecute(EndGameTrigger)

            // udg_integer41 has some random math done on it and assigned to UnknownInteger01 which alters gold of players?
            call TriggerSleepAction(0.50)
            set udg_integer41 = udg_integer41 + 1 // Some variable used for calculating rewards
            call TriggerSleepAction(0.50)

            set PvpGoldWinAmount = DuelGoldReward[RoundNumber]
            
            // Calculate the glory reward based on the game mode
            if GameModeShort == true then
                set gloryReward = 4000 + ((RoundNumber / 5) - 1) * 2000
            else
                set gloryReward = 3000 + ((RoundNumber / 5) - 1) * 1000
            endif

            // Show a fancy effect on the winners and give them their reward
            call ForGroup(DuelWinners, function ShowWinningSpecialEffect)
            call PlaySoundBJ(udg_sound07)
            call ConditionalTriggerExecute(DuelWinnerRewardsTrigger)

            // Display the rewards message with both gold and glory
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, "|cffffd700The PvP battles are over and all winners receive:|r |cffffea00" + I2S(PvpGoldWinAmount) + " gold|r and |cffea00ff" + I2S(gloryReward) + " glory|r")

            // Removes all duel game structs
            call DuelGame.cleanupDuels()
            call ResetPvpState()

            // End round event for all players
            call EventHelpers_FireEventForAllPlayers(EVENT_GAME_ROUND_END, 0, RoundNumber, true)

            // Reshow the player lives
            if (ModeNoDeath == false) then
                call BlzFrameSetVisible(BRLivesFrameHandle, true)
            endif

            // Go to the next basic level
            call ConditionalTriggerExecute(GenerateNextCreepLevelTrigger) // Setup creeps for next wave
            set PvpRoundEndWait = true
            set PvpRoundEndTimer = CreateTimer()
            set PvpRoundEndTimerDialog = CreateTimerDialog(PvpRoundEndTimer)
            call TimerDialogSetTitle(PvpRoundEndTimerDialog, "Next Level...")
            call TimerDialogDisplay(PvpRoundEndTimerDialog, true)
            call TimerStart(PvpRoundEndTimer, RoundTime, false, function PvpStartNextRound)

                // Start the next normal level
        // Check if all single pvp rounds are over
        elseif (SimultaneousDuelMode == 1 and DuelGameListRemaining.size() > 0) then
            call AfterDuelCleanupActions(duelGame)

            // Go to the next pvp battle
            call CreateTimerDialogBJ(GetLastCreatedTimerBJ(), "Next PvP Battle...")
            call StartTimerBJ(GetLastCreatedTimerBJ(), false, 3.00)
            call TriggerSleepAction(3.00)
            call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())

            // Start the next fight
            call PlaySoundBJ(udg_sound08) // Horn noise for everyone!
            call InitializeDuelGame(GetNextDuel())
            call StartDuels()
        // Duels are not over but this duel is over, send them to the center
        // We need this trigger sleep later because it will cause race conditions when checking if all duels are complete
        else
            call AfterDuelCleanupActions(duelGame)
        endif
    endfunction

    function PvpDraw takes nothing returns nothing
        local DuelGame duelGame = PvpEndDuelGame

        set PvpEndDuelGame = 0
        
        set duelGame.isDuelOver = true
        set duelGame.winningTeam = 0

        call ForForce(duelGame.team1, function EndDuelActionsForDrawPlayer)
        call ForForce(duelGame.team2, function EndDuelActionsForDrawPlayer)

        call DisplayTimedTextToForce(GetPlayersAll(), 5.00, ConvertForceToUnitString(duelGame.team1) + " |cffffcc00vs |r" + ConvertForceToUnitString(duelGame.team2) + "|cffffcc00 has resulted in a draw.|r")
    
         // Alliance reset
         call SetForceAllianceStateBJ(duelGame.team1, duelGame.team1, bj_ALLIANCE_UNALLIED)
         call SetForceAllianceStateBJ(duelGame.team2, duelGame.team2, bj_ALLIANCE_UNALLIED)
         call SetForceAllianceStateBJ(duelGame.team2, duelGame.team1, bj_ALLIANCE_UNALLIED)
         call SetForceAllianceStateBJ(duelGame.team1, duelGame.team2, bj_ALLIANCE_UNALLIED)

         // Try to distribute bets
         call ConditionalTriggerExecute(DistributeBetsTrigger)

         call HandleOddDuelAndEndDuel(duelGame)
    endfunction

    function PvpHeroDeathActions takes nothing returns nothing
        local unit deadUnit = GetDyingUnit()
        local unit killingUnit = GetKillingUnit()
        local player deadUnitPlayer = GetOwningPlayer(deadUnit)
        local player killingUnitPlayer = GetOwningPlayer(killingUnit)
        local DuelGame duelGame = DuelGame.getPlayerDuelGame(deadUnitPlayer)
        local force deadPlayerForce = duelGame.getPlayerTeam(deadUnitPlayer)
        local force winningPlayerForce = duelGame.getEnemyPlayerTeam(deadUnitPlayer)

        // All players in the winning team should get the pvp kill
        call ForForce(winningPlayerForce, function AddPlayerKillToPlayer)

        // Check if everyone is dead in the dead units team
        if (not AreAnyForceUnitsAlive(deadPlayerForce)) then
            set duelGame.isDuelOver = true

            if IsPlayerInForce(deadUnitPlayer, duelGame.team1) then
                set duelGame.winningTeam = 1
            elseif IsPlayerInForce(deadUnitPlayer, duelGame.team2) then
                set duelGame.winningTeam = 2
            endif

            // Add player unit to DuelWinnerDisabled, set invulnerable
            call ForForce(deadPlayerForce, function EndDuelActionsForLosingPlayer) 
            call ForForce(winningPlayerForce, function EndDuelActionsForWinningPlayer)
            
            // Only display a message to everyone when this duel is completely over
            if (CountPlayersInForceBJ(winningPlayerForce) > 1) then
                call DisplayTimedTextToForce(GetPlayersAll(), 5.00, ConvertForceToUnitString(winningPlayerForce) + " |cffffcc00have defeated |r" + ConvertForceToUnitString(deadPlayerForce) + "|cffffcc00!!|r")
            else
                call DisplayTimedTextToForce(GetPlayersAll(), 5.00, ConvertForceToUnitString(winningPlayerForce) + " |cffffcc00has defeated |r" + ConvertForceToUnitString(deadPlayerForce) + "|cffffcc00!!|r")
            endif

            // Alliance reset
            call SetForceAllianceStateBJ(deadPlayerForce, deadPlayerForce, bj_ALLIANCE_UNALLIED)
            call SetForceAllianceStateBJ(winningPlayerForce, winningPlayerForce, bj_ALLIANCE_UNALLIED)
            call SetForceAllianceStateBJ(winningPlayerForce, deadPlayerForce, bj_ALLIANCE_UNALLIED)
            call SetForceAllianceStateBJ(deadPlayerForce, winningPlayerForce, bj_ALLIANCE_UNALLIED)

            // Try to distribute bets
            call ConditionalTriggerExecute(DistributeBetsTrigger)
        else
            // Only show message to the two teams if there are still units alive in the dead player force
            call DisplayTimedTextToForce(winningPlayerForce, 5.00, GetPlayerNameColour(killingUnitPlayer) + " |cffffcc00has defeated |r" + GetPlayerNameColour(deadUnitPlayer) + "|cffffcc00!!|r")
            call DisplayTimedTextToForce(deadPlayerForce, 5.00, GetPlayerNameColour(killingUnitPlayer) + " |cffffcc00has defeated |r" + GetPlayerNameColour(deadUnitPlayer) + "|cffffcc00!!|r")

            // Cleanup
            set deadUnit = null
            set killingUnit = null
            set killingUnitPlayer = null
            set deadUnitPlayer = null
            set deadPlayerForce = null
            set winningPlayerForce = null

            return
        endif

        call HandleOddDuelAndEndDuel(duelGame)

        // Cleanup
        set deadUnit = null
        set killingUnit = null
        set killingUnitPlayer = null
        set deadUnitPlayer = null
        set deadPlayerForce = null
        set winningPlayerForce = null
    endfunction

    private function init takes nothing returns nothing
        set SinglePvpHeroDeathTrigger = CreateTrigger()
        set DuelDrawTrigger = CreateTrigger()
        call TriggerAddAction(DuelDrawTrigger, function PvpDraw)
        call TriggerRegisterAnyUnitEventBJ(SinglePvpHeroDeathTrigger, EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(SinglePvpHeroDeathTrigger, Condition(function PvpHeroDeathConditions))
        call TriggerAddAction(SinglePvpHeroDeathTrigger, function PvpHeroDeathActions)
    endfunction

endlibrary
