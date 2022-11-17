library PvpHeroDeath initializer init requires RandomShit, PlayerTracking, CreepDeath, AchievementsFrame, UnitFilteringUtility, OldInitialization, PvpHelper, VotingResults

    private function PvpHeroDeathConditions takes nothing returns boolean
        return IsUnitInGroup(GetTriggerUnit(), DuelingHeroes) == true
    endfunction

    private function ResetToCenterArenaForPlayer takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local integer playerId = GetPlayerId(currentPlayer)
        local unit playerHero = PlayerHeroes[playerId + 1]
        local location arenaLocation = GetRectCenter(RectMidArena)
        local PlayerStats ps = PlayerStats.forPlayer(currentPlayer)

        // Move camera to center arena
        call PanCameraToTimedLocForPlayer(currentPlayer, arenaLocation, 0.20)

        // Revive the unit if it died
        if (IsUnitAliveBJ(playerHero)) then
            call SetUnitPositionLoc(playerHero, arenaLocation)
        else
            call ReviveHeroLoc(playerHero, arenaLocation, true)
        endif

        // Move the pet
        if (ps.getPet() != null) then
            call SetUnitPositionLoc(ps.getPet(), arenaLocation)
        endif
        
        // Revive the pet if it died
        call AchievementsFrame_TryToSummonPet(ps.getPetIndex(), currentPlayer, false)

        // Random crap
        call FixAbominationPassive(playerHero)

        // Cleanup
        call RemoveLocation(arenaLocation)
        set arenaLocation = null
        set currentPlayer = null
        set playerHero = null
    endfunction

    private function ResetItemsForPlayer takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local integer playerId = GetPlayerId(currentPlayer)
        local unit playerHero = PlayerHeroes[playerId + 1]
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

    private function EndDuelActionsForWinningPlayer takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local unit playerHero = PlayerHeroes[GetPlayerId(currentPlayer) + 1]

        call GroupAddUnit(DuelWinnerDisabled, playerHero) // Used to prevent heroes from casting abilities
        call GroupAddUnit(DuelWinners, playerHero) // Collection of all winners
        call GroupRemoveUnit(DuelingHeroes, playerHero)
        call SetUnitInvulnerable(playerHero, true)
        
        // Mark that they player is not fighting
        call SetCurrentlyFighting(currentPlayer, false)

        // Cleanup
        set currentPlayer = null
        set playerHero = null
    endfunction

    private function EndDuelActionsForLosingPlayer takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local unit playerHero = PlayerHeroes[GetPlayerId(currentPlayer) + 1]

        call ForceAddPlayer(DuelLosers, currentPlayer) // Collection of all losers
        call GroupRemoveUnit(DuelingHeroes, playerHero)

        // Mark that they player is not fighting
        call SetCurrentlyFighting(currentPlayer, false)
        
        // Cleanup
        set currentPlayer = null
        set playerHero = null
    endfunction

    private function AddPvpWinToPlayer takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local unit playerHero = PlayerHeroes[GetPlayerId(currentPlayer) + 1]
        local unit deadUnit = GetDyingUnit()
        local PlayerStats ps = PlayerStats.forPlayer(currentPlayer)
        local MidasTouch deadUnitMidasTouch = GetMidasTouch(GetHandleId(deadUnit))
        local real bonus = 1

        call ps.addPVPWin() // TODO Switch to addGroupPVPWin

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

    private function DuelEndedPlayerActions takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local unit playerHero = PlayerHeroes[GetPlayerId(currentPlayer) + 1]

        // Save the code for everyone at the end so we don't call SaveCommand_SaveCodeForPlayer too much
        call SaveCommand_SaveCodeForPlayer(currentPlayer, false)

        // Stop the triggers for unit leaving an arena
        call StopRectLeaveDetection(GetHandleId(playerHero))

        // Cleanup
        set currentPlayer = null
        set playerHero = null
    endfunction

    private function AwardFunToWinningUnit takes nothing returns nothing
        call FunWinner(GetEnumUnit())
    endfunction

    private function RemoveItemsForAllArenas takes nothing returns nothing
        local integer playerArenaIndex = 1

        loop
            exitwhen playerArenaIndex > 8
            call EnumItemsInRectBJ(PlayerArenaRects[playerArenaIndex], function RemoveItemFromArena)
            set playerArenaIndex = playerArenaIndex + 1
        endloop
    endfunction

    // This function should only be called when all initial duels are over
    private function AfterDuelCleanupActions takes DuelGame duelGame returns nothing
        // Disable sudden death
        call DestroyTimerDialog(GetLastCreatedTimerDialogBJ())
        call DisableTrigger(UpdatePvpSuddenDeathDamageTrigger)
        call DisableTrigger(ApplyPvpSuddenDeathDamageTrigger)
        call DisableTrigger(SinglePvpHeroDeathTrigger)
        call PvpStopSuddenDeathTimer()

        // Cleanup all arenas
        call RemoveItemsForAllArenas()

        call TriggerSleepAction(3.00)

        // Move camera to center arena, revive units, pets, items
        call ForForce(duelGame.team1, function ResetToCenterArenaForPlayer)
        call ForForce(duelGame.team2, function ResetToCenterArenaForPlayer)

        call TriggerSleepAction(2.00)

        // Removes all non heroes/hops/dummy units
        call RemoveUnitsInRect(bj_mapInitialPlayableArea)
    endfunction

    function PvpHeroDeathActions takes nothing returns nothing
        local unit deadUnit = GetDyingUnit()
        local unit killingUnit = GetKillingUnit()
        local player deadUnitPlayer = GetOwningPlayer(deadUnit)
        local player killingUnitPlayer = GetOwningPlayer(killingUnit)
        local DuelGame duelGame = DuelGame.getPlayerDuelGame(deadUnitPlayer)
        local force deadPlayerForce = duelGame.getPlayerTeam(deadUnitPlayer)
        local force winningPlayerForce = duelGame.getEnemyPlayerTeam(deadUnitPlayer)
        local PlayerStats ps

        // All players in the winning team should get the pvp kill
        call ForForce(winningPlayerForce, function AddPvpWinToPlayer)

        // Check if everyone is dead in the dead units team
        if (not AreAnyForceUnitsAlive(deadPlayerForce)) then
            set duelGame.isDuelOver = true
            set duelGame.team1Won = IsPlayerInForce(deadUnitPlayer, duelGame.team2)

            // Add player unit to DuelWinnerDisabled, set invulnerable
            call ForForce(winningPlayerForce, function EndDuelActionsForWinningPlayer)
            call ForForce(deadPlayerForce, function EndDuelActionsForLosingPlayer) 

            // Alliance reset
            call SetForceAllianceStateBJ(duelGame.team1, duelGame.team1, bj_ALLIANCE_UNALLIED)
            call SetForceAllianceStateBJ(duelGame.team2, duelGame.team2, bj_ALLIANCE_UNALLIED)
            call SetForceAllianceStateBJ(duelGame.team2, duelGame.team1, bj_ALLIANCE_UNALLIED)
            call SetForceAllianceStateBJ(duelGame.team1, duelGame.team2, bj_ALLIANCE_UNALLIED)

            // Save code, end arena leave detection
            call ForForce(duelGame.team1, function DuelEndedPlayerActions)
            call ForForce(duelGame.team2, function DuelEndedPlayerActions)
            
            // Only display a message to everyone when this duel is completely over
            call DisplayTimedTextToForce(GetPlayersAll(), 5.00, ConvertForceToString(winningPlayerForce) + " |cffffcc00has defeated |r" + ConvertForceToString(deadPlayerForce) + "|cffffcc00!!|r")

            // Show the PVP kill count if this is not simultaneous duels. Otherwise it will be a lot of spam
            if (SimultaneousDuelMode == 1 or DuelGameList.size() == 1) then // No simultaneous duels or there is only one duel (Only 2 people in game, or odd player duel)
                set ps = PlayerStats.forPlayer(killingUnitPlayer)
                call DisplayTimedTextToForce(GetPlayersAll(), 5.00, GetPlayerNameColour(killingUnitPlayer) + " has |cffc2154f" + I2S(ps.getSeasonPVPWins()) + "|r PVP kills this season, |cffc2154f" + I2S(ps.getAllPVPWins()) + "|r all time for this game mode")
            endif
        else
            // Only show message to the two teams if there are still units alive in the dead player force
            call DisplayTimedTextToForce(duelGame.team1, 5.00, GetPlayerNameColour(killingUnitPlayer) + " |cffffcc00has defeated |r" + GetPlayerNameColour(deadUnitPlayer) + "|cffffcc00!!|r")
            call DisplayTimedTextToForce(duelGame.team2, 5.00, GetPlayerNameColour(killingUnitPlayer) + " |cffffcc00has defeated |r" + GetPlayerNameColour(deadUnitPlayer) + "|cffffcc00!!|r")

            // Cleanup
            set deadUnit = null
            set killingUnit = null
            set killingUnitPlayer = null
            set deadUnitPlayer = null
            set deadPlayerForce = null
            set winningPlayerForce = null

            return
        endif

        // Cleanup
        set deadUnit = null
        set killingUnit = null
        set killingUnitPlayer = null
        set deadUnitPlayer = null
        set deadPlayerForce = null
        set winningPlayerForce = null

        // Check if we need a duel with an odd player
        if (DuelGame.areAllDuelsOver() and OddPlayer != -1) then
            call AfterDuelCleanupActions(duelGame)

            // Create a new duel using a random loser. TODO Validate there is a loser?
            call AddOddPlayerDuel(ForcePickRandomPlayer(DuelLosers))

            // Set this back to -1 for the next time this trigger runs
            set OddPlayer = -1

            // Go to the next pvp battle for the odd player
            call DisplayTimedTextToForce(GetPlayersAll(), 5.00, "|cffff0000Odd player amount detected. Starting duel for odd player out!|r")

            call DestroyTimerDialog(GetLastCreatedTimerDialogBJ())
            call CreateTimerDialogBJ(GetLastCreatedTimerBJ(), "Next PvP Battle ...")
            call DisplayNemesisNames()
            call StartTimerBJ(GetLastCreatedTimerBJ(), false, 5.00)
            call TriggerSleepAction(5.00)
            call DestroyTimerDialog(GetLastCreatedTimerDialogBJ())

            // Start the next fight
            call InitializeDuelGame(GetNextDuel())
            call StartDuels()
        // All duels are over, no odd player
        elseif (DuelGame.areAllDuelsOver() and OddPlayer == -1) then
            call AfterDuelCleanupActions(duelGame)

            // Reset to the items to before the duels
            call ForForce(GetPlayersAll(), function ResetItemsForPlayer)

            // Reward glory and stuff
            call ForGroup(DuelWinners, function AwardFunToWinningUnit)

            // Hand out bet rewards, try to end the game?
            call ConditionalTriggerExecute(DistributeBetsTrigger)
            call ConditionalTriggerExecute(EndGameTrigger)

            // Reset 
            call ResetPvpState()

            // udg_integer41 has some random math done on it and assigned to UnknownInteger01 which alters gold/lumber of players?
            call TriggerSleepAction(2)
            set udg_integer41 = udg_integer41 + 1 // Some variable used for calculating rewards
            call TriggerSleepAction(1.00)
    
            set PvpGoldWinAmount = DuelGoldReward[RoundNumber]
            
            // Show a fancy effect on the winners and give them their reward
            call ForGroup(DuelWinners, function ShowWinningSpecialEffect)
            call PlaySoundBJ(udg_sound07)
            call ConditionalTriggerExecute(DuelWinnerRewardsTrigger)
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, "|cffffcc00The PvP battles are over and all winners receive:|r |cff3bc739" + I2S(PvpGoldWinAmount) + " gold|r")
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, "|cffff0000Patch 1.33 broke saving/loading.|r\n|cff00ff15Restart Warcraft after every game to make sure your stats are properly saved!|r")

            // Go to the next basic level
            call ConditionalTriggerExecute(udg_trigger103) // Setup creeps for next wave
            call DestroyTimerDialog(GetLastCreatedTimerDialogBJ())
            call CreateTimerDialogBJ(GetLastCreatedTimerBJ(), "Next Level ...")
            call StartTimerBJ(GetLastCreatedTimerBJ(), false, 30)
            call TriggerSleepAction(30.00)
            call DestroyTimerDialog(GetLastCreatedTimerDialogBJ())
            call TriggerExecute(udg_trigger109) // Start the next normal level
        // Check if all single pvp rounds are over
        elseif (SimultaneousDuelMode == 1 and DuelGameListRemaining.size() > 0) then
            call AfterDuelCleanupActions(duelGame)

            // Go to the next pvp battle
            call DestroyTimerDialog(GetLastCreatedTimerDialogBJ())
            call CreateTimerDialogBJ(GetLastCreatedTimerBJ(), "Next PvP Battle ...")
            call StartTimerBJ(GetLastCreatedTimerBJ(), false, 3.00)
            call TriggerSleepAction(3.00)
            call DestroyTimerDialog(GetLastCreatedTimerDialogBJ())

            // Start the next fight
            call InitializeDuelGame(GetNextDuel())
            call StartDuels()
        endif
    endfunction

    private function init takes nothing returns nothing
        set SinglePvpHeroDeathTrigger = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(SinglePvpHeroDeathTrigger, EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(SinglePvpHeroDeathTrigger, Condition(function PvpHeroDeathConditions))
        call TriggerAddAction(SinglePvpHeroDeathTrigger, function PvpHeroDeathActions)
    endfunction

endlibrary
