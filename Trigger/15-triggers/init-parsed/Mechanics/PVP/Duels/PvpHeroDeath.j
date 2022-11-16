library PvpHeroDeath initializer init requires RandomShit, PlayerTracking, CreepDeath, AchievementsFrame, UnitFilteringUtility, OldInitialization, PvpHelper

    private function PvpHeroDeathConditions takes nothing returns boolean
        return IsUnitInGroup(GetTriggerUnit(), DuelingHeroes) == true
    endfunction

    private function ResetToCenterArenaForPlayer takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local integer playerId = GetPlayerId(currentPlayer)
        local unit playerHero = PlayerHeroes[playerId + 1]
        local location arenaLocation = GetRectCenter(RectMidArena)
        local PlayerStats ps = PlayerStats.forPlayer(currentPlayer)
        local integer itemSlotIndex = 0
        local item tempItem

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

        // Reset items
        loop
            exitwhen itemSlotIndex == 6

            call RemoveItem(UnitItemInSlot(playerHero, itemSlotIndex))

            if GetPlayerSlotState(currentPlayer) != PLAYER_SLOT_STATE_LEFT then
                set tempItem = UnitAddItemByIdSwapped(PreDuelItemIds[playerId + itemSlotIndex], playerHero)

                if PreDuelItemCharges[playerId + itemSlotIndex] > 1 then
                    call SetItemCharges(tempItem, PreDuelItemCharges[playerId + itemSlotIndex])
                endif
            endif

            set itemSlotIndex = itemSlotIndex + 1
        endloop

        // Mark that they player is not fighting
        call SetCurrentlyFighting(currentPlayer, false)

        // Cleanup
        call RemoveLocation(arenaLocation)
        set arenaLocation = null
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
        local unit playerHero = PlayerHeroes[GetPlayerId(GetEnumPlayer()) + 1]

        call GroupAddUnit(DuelWinnerDisabled, playerHero) // Used to prevent heroes from casting abilities
        call GroupAddUnit(DuelWinners, playerHero) // Collection of all winners
        call SetUnitInvulnerable(playerHero, true)

        // Cleanup
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
    endfunction

    private function AllDuelsEndedPlayerActions takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local unit playerHero = PlayerHeroes[GetPlayerId(currentPlayer) + 1]

        // Save the code for everyone at the end so we don't call SaveCommand_SaveCodeForPlayer too much
        call SaveCommand_SaveCodeForPlayer(currentPlayer, false)

        // Stop the triggers for unit leaving an arena
        call StopRectLeaveDetection(GetHandleId(playerHero))
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

    function PvpHeroDeathActions takes nothing returns nothing
        local unit deadUnit = GetDyingUnit()
        local unit killingUnit = GetKillingUnit()
        local player deadUnitPlayer = GetOwningPlayer(deadUnit)
        local DuelGame duelGame = DuelGame.getPlayerDuelGame(deadUnitPlayer)
        local force deadPlayerForce = duelGame.getPlayerTeam(deadUnitPlayer)
        local force winningPlayerForce = duelGame.getEnemyPlayerTeam(deadUnitPlayer)

        // All players in the winning team should get the pvp kill
        call ForForce(winningPlayerForce, function AddPvpWinToPlayer)

        // Check if everyone is dead in the dead units team
        if (not AreAnyForceUnitsAlive(deadPlayerForce)) then
            set duelGame.isDuelOver = true
            
            // Add player unit to DuelWinnerDisabled, set invulnerable
            call ForForce(winningPlayerForce, function EndDuelActionsForWinningPlayer)

            // TODO Display message about the duel being over
        else
            // Only show message to the two teams
            call DisplayTimedTextToForce(duelGame.team1, 5.00, GetPlayerNameColour(GetOwningPlayer(killingUnit)) + " |cffffcc00has defeated |r" + GetPlayerNameColour(deadUnitPlayer) + "|cffffcc00!!|r")
            // TODO call DisplayTimedTextToForce(duelGame.team1, 5.00, GetPlayerNameColour(killingUnit) + " has |cffc2154f" + I2S(ps.getSeasonPVPWins()) + "|r PVP kills this season, |cffc2154f" + I2S(ps.getAllPVPWins()) + "|r all time for this game mode")
        endif

        // Stop the pvp properties once all fights are over
        if (DuelGame.areAllDuelsOver()) then
            // Disable sudden death
            call DisableTrigger(UpdatePvpSuddenDeathDamageTrigger)
            call DisableTrigger(ApplyPvpSuddenDeathDamageTrigger)
            call DisableTrigger(SinglePvpHeroDeathTrigger)
            call PvpStopSuddenDeathTimer()

            call ForForce(GetPlayersAll(), function AllDuelsEndedPlayerActions)

            // After some time, cleanup
            call TriggerSleepAction(4.00)

            // Reward glory and stuff
            call ForGroup(DuelWinners, function AwardFunToWinningUnit)

            // Setup the unallied alliance again? Not sure if this even needs to be done again
            call SetForceAllianceStateBJ(duelGame.team1, duelGame.team2, bj_ALLIANCE_UNALLIED)
            call SetForceAllianceStateBJ(duelGame.team2, duelGame.team1, bj_ALLIANCE_UNALLIED)

            // Move camera to center arena, revive units, pets, items
            call ForForce(GetPlayersAll(), function ResetToCenterArenaForPlayer)

            // Hand out bet rewards, try to end the game?
            call ConditionalTriggerExecute(DistributeBetsTrigger)
            call ConditionalTriggerExecute(EndGameTrigger)

            // Cleanup all arenas
            call RemoveItemsForAllArenas()

            // Clear the group of disabled units
            call GroupClear(DuelWinnerDisabled)

            call TriggerSleepAction(2)

            set udg_integer41 = udg_integer41 + 1
            call DestroyTimerDialog(GetLastCreatedTimerDialogBJ())

            call TriggerSleepAction(1.00)
    
            // This condition is absolutely pointless
            set PvpGoldWinAmount = DuelGoldReward[RoundNumber]
            
            // Show a fancy effect on the winners and give them their reward
            call ForGroup(DuelWinners, function ShowWinningSpecialEffect)
            call PlaySoundBJ(udg_sound07)
            call ConditionalTriggerExecute(DuelWinnerRewardsTrigger)
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, "|cffffcc00The PvP battles are over and all winners receive:|r |cff3bc739" + I2S(PvpGoldWinAmount) + " gold|r")
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, "|cffff0000Patch 1.33 broke saving/loading.|r\n|cff00ff15Restart Warcraft after every game to make sure your stats are properly saved!|r")

            // Go to the next basic level
            call ConditionalTriggerExecute(udg_trigger103) // Setup creeps for next wave
            call CreateTimerDialogBJ(GetLastCreatedTimerBJ(), "Next Level ...")
            call StartTimerBJ(GetLastCreatedTimerBJ(), false, 30)
            call TriggerSleepAction(30.00)
            call DestroyTimerDialog(GetLastCreatedTimerDialogBJ())
            call TriggerExecute(udg_trigger109)
        endif

        // Check if all single pvp rounds are over
        if (DuelGameListRemaining.size() > 0) then
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

        // Cleanup
        set deadUnit = null
        set killingUnit = null
        set deadUnitPlayer = null
        set deadPlayerForce = null
        set winningPlayerForce = null
    endfunction

    private function init takes nothing returns nothing
        set SinglePvpHeroDeathTrigger = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(SinglePvpHeroDeathTrigger, EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(SinglePvpHeroDeathTrigger, Condition(function PvpHeroDeathConditions))
        call TriggerAddAction(SinglePvpHeroDeathTrigger, function PvpHeroDeathActions)
    endfunction

endlibrary
