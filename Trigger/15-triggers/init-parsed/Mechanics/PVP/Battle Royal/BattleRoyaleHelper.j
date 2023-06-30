library BattleRoyaleHelper initializer init requires RandomShit, StartFunction, DebugCode, UnitFilteringUtility, ScoreboardManager, BattleCreatorManager

    globals
        // Track player's lives during the BR
        integer array PlayerBRDeaths
        integer MaxBRDeathCount = 3

        // Temp global variables
        private integer forceIndex = 0
        private integer CurrentPlayerHeroPlacement = 0

        // Flag if the official br round is complete
        boolean IsFunBRRound = false

        // Arrays containing items and item charges before the BR
        integer array PreBRItemIds
        integer array PreBRItemCharges

        // Timer properties
        integer BattleRoyalRemoveLifeLowTime = 120
        integer BattleRoyalRemoveLifeHighTime = 140

        integer BattleRoyalFunWaitTime = 30
        integer BattleRoyalWaitTime = 120
        integer BattleRoyalReviewWaitTime = 30
        timer BattleRoyalTimer
        timerdialog BattleRoyalTimerDialog
        timer BattleRoyalRemoveLifeTimer
        boolean WaitingForBattleRoyal = false
    endglobals

    private function IsValidPlayerHeroUnit takes nothing returns boolean
        return IsPlayerHero(GetFilterUnit()) and (not IsPlayerInForce(GetOwningPlayer(GetFilterUnit()), LeaverPlayers)) and (not IsPlayerInForce(GetOwningPlayer(GetFilterUnit()), DefeatedPlayers))
    endfunction

    private function MoveObserver takes nothing returns nothing
        local unit currentUnit = PlayerHeroes[GetPlayerId(GetEnumPlayer())]
        local location centerLocation = GetRectCenter(PlayerArenaRects[1])

        call ReviveHeroLoc(currentUnit, centerLocation, true)
        call SetUnitPositionLoc(currentUnit, centerLocation)

        // Cleanup
        call RemoveLocation(centerLocation)
        set centerLocation = null
        set currentUnit = null
    endfunction

    private function PlacePlayerHeroInCenterArena takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local integer playerId = GetPlayerId(currentPlayer)
        local unit currentUnit = PlayerHeroes[playerId]
        local PlayerStats ps = PlayerStats.forPlayer(currentPlayer)
        local location projectionLocation = PolarProjectionBJ(RectMidArenaCenter, 1200, I2R(CurrentPlayerHeroPlacement) * (360.0 / I2R(BRTeamCount)))
        local integer itemSlotIndex = 0
        local item currentItem

        // Place hero and pet in a circle
        call ReviveHeroLoc(currentUnit, projectionLocation, true)
        call SetUnitPositionLocFacingLocBJ(currentUnit, projectionLocation, RectMidArenaCenter)

        set TempUnit = currentUnit // Used in HeroRefreshTrigger
        call PauseUnit(TempUnit, true)
        call ConditionalTriggerExecute(HeroRefreshTrigger)

        if (ps.getPet() != null) then
            call SetUnitPositionLocFacingLocBJ(ps.getPet(), projectionLocation, RectMidArenaCenter)
        else
            // Revive the pet if it died
            call AchievementsFrame_TryToSummonPet(ps.getPetIndex(), currentPlayer, false)
        endif

        // Select and chagne camera to the player
        call SelectUnitForPlayerSingle(currentUnit, currentPlayer)
        call PanCameraToTimedLocForPlayer(currentPlayer, projectionLocation, 0.50)

        // Reset stats in the scoreboard
        call ResetPlayerBRProperties(currentPlayer)
        call ps.resetBRPVPKillCount()

        set PlayerBRDeaths[playerId] = 0

        call CustomGameEvent_FireEvent(EVENT_PLAYER_ROUND_TELEPORT, EventInfo.createAll(currentPlayer, 0, RoundNumber, true))

        if (IsFunBRRound) then
            if (GetPlayerSlotState(currentPlayer) != PLAYER_SLOT_STATE_LEFT) then
                // Restore all items
                loop
                    call RemoveItem(UnitItemInSlot(currentUnit, itemSlotIndex))

                    // Make sure there is an actual item
                    if (PreBRItemIds[(6 * playerId) + itemSlotIndex] != -1) then
                        set currentItem = UnitAddItemByIdSwapped(PreBRItemIds[(6 * playerId) + itemSlotIndex], currentUnit)
                        call SetItemUserData(currentItem, playerId + 1)

                        if PreBRItemCharges[(6 * playerId) + itemSlotIndex] > 1 then
                            call SetItemCharges(currentItem, PreBRItemCharges[(6 * playerId) + itemSlotIndex])
                        endif

                        call SetItemPawnable(currentItem, true)
                    endif

                    set itemSlotIndex = itemSlotIndex + 1
                    exitwhen itemSlotIndex == 6
                endloop
            endif
        else
            // Save the items and item charges for the player before the BR starts. Make items unpawnable as well
            loop
                set currentItem = UnitItemInSlot(currentUnit, itemSlotIndex)

                if (currentItem != null) then
                    // Save all item information in a single array with the playerId as the offset
                    set PreBRItemIds[(6 * playerId) + itemSlotIndex] = GetItemTypeId(currentItem)
                    set PreBRItemCharges[(6 * playerId) + itemSlotIndex] = GetItemCharges(currentItem)
                    call SetItemPawnable(currentItem, false)

                    // Cleanup
                    set currentItem = null
                else
                    set PreBRItemIds[(6 * playerId) + itemSlotIndex] = -1
                    set PreBRItemCharges[(6 * playerId) + itemSlotIndex] = -1
                endif

                set itemSlotIndex = itemSlotIndex + 1
                exitwhen itemSlotIndex == 6
            endloop
        endif

        // Cleanup
        call RemoveLocation(projectionLocation)
        set projectionLocation = null
        set currentUnit = null
        set currentPlayer = null
    endfunction

    private function RemoveItemFromArena takes nothing returns nothing
        call RemoveItem(GetEnumItem())
    endfunction

    private function StartFightForPlayerHero takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local integer playerId = GetPlayerId(currentPlayer)
        local unit currentUnit = PlayerHeroes[playerId]

        call CustomGameEvent_FireEvent(EVENT_GAME_ROUND_START, EventInfo.create(currentPlayer, 0, RoundNumber))
        call PauseUnit(currentUnit, false)
        call SetUnitInvulnerable(currentUnit, false)
        call RectLeaveDetection.create(currentUnit, RectMidArena)
        call FireRoundStartEvent(currentUnit, 1) // 1 = br

        // Cleanup
        set currentPlayer = null
        set currentUnit = null
    endfunction

    private function ShowDraftBuildings takes boolean b returns nothing
        local integer i = 0

        if AbilityMode != 0 then
            loop
                if AbilityMode == 2 then
                    call ShowUnit(circle1, b)
                    call ShowUnit(udg_Draft_DraftBuildings[i], b)
                    call SetTextTagVisibility(FloatingTextBuy, b)
                endif
                
                call ShowUnit(circle2, b)
                call ShowUnit(udg_Draft_UpgradeBuildings[i], b)
                call SetTextTagVisibility(FloatingTextUpgrade, b)
                set i = i + 1
                exitwhen i > 9
            endloop
        endif
    endfunction

    private function HideScoreboardForPlayer takes nothing returns nothing
        call PlayerStats.forPlayer(GetEnumPlayer()).setHasScoreboardOpen(false)
    endfunction

    private function ShopFilter takes nothing returns boolean
        return (IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) == true)
    endfunction

    private function DeleteShop takes nothing returns nothing
        call DeleteUnit(GetEnumUnit())
    endfunction
    
    function StartBattleRoyal takes nothing returns nothing
        call DestroyTimer(BattleRoyalTimer)
        call DestroyTimerDialog(BattleRoyalTimerDialog)

        call ExecuteFunc("BattleRoyalInitialization")
    endfunction

    private function ShowPlayerLivesRemaining takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local integer playerDeaths = PlayerBRDeaths[GetPlayerId(currentPlayer)]

        if (playerDeaths <= MaxBRDeathCount and IsPlayerInForce(currentPlayer, BRPlayers)) then
            call DisplayTimedTextToPlayer(currentPlayer, 0, 0, 10, "|cffffcc00You have |r" + I2S(IMaxBJ(MaxBRDeathCount - playerDeaths, 0)) + " |cffffcc00lives remaining.|r")
        endif

        // Cleanup
        set currentPlayer = null
    endfunction

    private function RemoveBattleRoyaleLife takes nothing returns nothing
        if (MaxBRDeathCount > 0) then
            set MaxBRDeathCount = MaxBRDeathCount - 1

            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, "|cffff3b3bThe BR has gone on for too long, removing one life from all remaining players.|r")

            call ForForce(GetPlayersAll(), function ShowPlayerLivesRemaining)
        endif
    endfunction

    function BattleRoyalInitialization takes nothing returns nothing
        local force playersToFight
        local group shops
        local unit randomUnit
        local integer currentPlayerId = 0
        local integer forceIndex = 0
        local integer nestedForceIndex = 0
        local integer randomCount = 0

        set CurrentPlayerHeroPlacement = 0
        set MaxBRDeathCount = 3

        call ForForce(GetPlayersAll(), function HideScoreboardForPlayer) 
        call BlzFrameSetVisible(ScoreboardFrameHandle, false)

        if (IsFunBRRound) then
            call CalculatePlayerForces()
            call ForForce(BRObservers, function MoveObserver)
            call SetForceAllianceStateBJ(BRObservers, BRObservers, bj_ALLIANCE_ALLIED)
        else
            set playersToFight = CreateForce()

            // Calculate the initial valid players
            loop
                exitwhen currentPlayerId == 8

                if (PlayerHeroes[currentPlayerId] != null and (not IsPlayerInForce(Player(currentPlayerId), LeaverPlayers)) and (not IsPlayerInForce(Player(currentPlayerId), DefeatedPlayers))) then
                    call ForceAddPlayer(playersToFight, Player(currentPlayerId))
                endif

                set currentPlayerId = currentPlayerId + 1
            endloop

            call CalculateFreeForAllPlayerForces(playersToFight)

            // Cleanup
            call DestroyForce(playersToFight)
            set playersToFight = null
        endif

        call SetBRLockStatus(false)

        if (IsBRSetupValid()) then
            set WaitingForBattleRoyal = false
            call ResetScoreboardBrWinner()

            call TriggerSleepAction(5)

            call BlzFrameSetVisible(BattleCreatorFrameHandle, false) 
        else
            call BlzFrameSetText(BRMessageTextFrameHandle, BR_MESSAGE_COLOR + "Invalid Battle Royale Setup. Try again." + BR_COLOR_END_TAG)
            call BlzFrameSetVisible(BRMessageTextFrameHandle, true)

            call TriggerSleepAction(5)

            call BlzFrameSetVisible(BRMessageTextFrameHandle, false)

            call SetBRLockStatus(true)

            set BattleRoyalTimer = CreateTimer()
            set BattleRoyalTimerDialog = CreateTimerDialog(BattleRoyalTimer)
            call TimerDialogSetTitle(BattleRoyalTimerDialog, "Extra Battle Royale...")
            call TimerDialogDisplay(BattleRoyalTimerDialog, true)

            call ResetBRPlayerSlots()
            call ResetBRPlayerForce()

            call TimerStart(BattleRoyalTimer, BattleRoyalFunWaitTime, false, function StartBattleRoyal)

            return
        endif

        // Reset the player count since it gets decrementing during the PlayerDiesInBattleRoyale trigger
        set PlayerCount = BRRoundPlayerCount

        call EnableTrigger(IsGameFinishedTrigger)
        // call ForceClear(DefeatedPlayers)

        // Final message about BR, hide shops, cleanup before the actual fight
        set BrStarted = true
        call PlaySoundBJ(udg_sound10)

        if (IsFunBRRound) then
            call DisplayTextToForce(GetPlayersAll(), "|cffffcc00EXTRA BATTLE - THE WINNER TAKES SOME PRIDE|r")
            call TriggerSleepAction(2)
            call DisplayTextToForce(GetPlayersAll(), "|cffff2b23Your items will be restored for further BR fun rounds, so feel free to drop items during the fight.|r")
            call TriggerSleepAction(2)
        else
            call SetVersion()

            call DisplayTextToForce(GetPlayersAll(), "|cffffcc00FINAL BATTLE - THE WINNER TAKES IT ALL|r")
            call TriggerSleepAction(2)
            call DisplayTextToForce(GetPlayersAll(), "|cffff5e00Reminder: After the official BR, you can play additional BR rounds for fun!|r")
            call TriggerSleepAction(2)
            call DisplayTextToForce(GetPlayersAll(), "|cffff2b23Your items will be restored for further BR fun rounds, so feel free to drop items during the fight.|r")
            call TriggerSleepAction(2)
        endif
        
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call ShowDraftBuildings(false)
        call RemoveUnitsInRect(bj_mapInitialPlayableArea)

        // Set alliances for everyone
        loop
            exitwhen forceIndex == BRTeamCount

            set nestedForceIndex = 0
            
            loop
                exitwhen nestedForceIndex == BRTeamCount

                if (forceIndex == nestedForceIndex) then
                    call SetForceAllianceStateBJ(BRPlayerForce[forceIndex], BRPlayerForce[nestedForceIndex], bj_ALLIANCE_ALLIED)
                    call SetForceAllianceStateBJ(BRPlayerForce[nestedForceIndex], BRPlayerForce[forceIndex], bj_ALLIANCE_ALLIED)
                else
                    call SetForceAllianceStateBJ(BRPlayerForce[forceIndex], BRPlayerForce[nestedForceIndex], bj_ALLIANCE_UNALLIED)
                    call SetForceAllianceStateBJ(BRPlayerForce[nestedForceIndex], BRPlayerForce[forceIndex], bj_ALLIANCE_UNALLIED)
                endif

                set nestedForceIndex = nestedForceIndex + 1
            endloop

            set forceIndex = forceIndex + 1
        endloop

        // Randomize the placement
        loop
            set forceIndex = GetRandomInt(0, BRTeamCount - 1)

            if (not UsedPlayerForce[forceIndex]) then
                set UsedPlayerForce[forceIndex] = true
                set BRRandomPlayerForce[randomCount] = BRPlayerForce[forceIndex]
                set randomCount = randomCount + 1
            endif

            exitwhen randomCount == BRTeamCount
        endloop

        // Delete shops
        set shops = GetUnitsOfPlayerMatching(Player(PLAYER_NEUTRAL_PASSIVE), Condition(function ShopFilter))
        call ForGroup(shops, function DeleteShop)

        // Cleanup
        call DestroyGroup(shops)
        set shops = null

        set forceIndex = 0

        // Set alliances for everyone
        loop
            exitwhen forceIndex == BRTeamCount

            call ForForce(BRRandomPlayerForce[forceIndex], function PlacePlayerHeroInCenterArena)

            set CurrentPlayerHeroPlacement = CurrentPlayerHeroPlacement + 1

            set forceIndex = forceIndex + 1
        endloop

        // Remove all items on the ground
        call EnumItemsInRectBJ(GetPlayableMapRect(), function RemoveItemFromArena)

        // Disable a whole bunch of trigger
        call DisableTrigger(CenterArenaInvulnerabilityTrigger)
        call DisableTrigger(CenterArenaRemoveUnitTrigger)
        call DisableTrigger(PlayerHeroDeathTrigger)
        call DisableTrigger(HeroDiesInRoundTrigger)
        call EnableTrigger(PlayerDiesInBattleRoyaleTrigger)

        call TriggerSleepAction(5)
        call DisplayTextToForce(GetPlayersAll(), "|cffffcc005|r")
        call PlaySoundBJ(udg_sound09) // Ticking noise
        call TriggerSleepAction(1)
        call DisplayTextToForce(GetPlayersAll(), "|cffffcc004|r")
        call PlaySoundBJ(udg_sound09) // Ticking noise
        call TriggerSleepAction(1)
        call DisplayTextToForce(GetPlayersAll(), "|cffffcc003|r")
        call PlaySoundBJ(udg_sound09) // Ticking noise
        call TriggerSleepAction(1)
        call DisplayTextToForce(GetPlayersAll(), "|cffffcc002|r")
        call PlaySoundBJ(udg_sound09) // Ticking noise
        call TriggerSleepAction(1)
        call DisplayTextToForce(GetPlayersAll(), "|cffffcc001|r")
        call PlaySoundBJ(udg_sound09) // Ticking noise
        call TriggerSleepAction(1)
        
        call PlaySoundBJ(udg_sound08) // Horn noise
        call DisplayTimedTextToForce(GetPlayersAll(), 1.00, "|cffffcc00GO!!!|r")
        call SetAllCurrentlyFighting(true)
        call ForForce(BRPlayers, function StartFightForPlayerHero)

        if (BRLivesMode == 2) then
            // Invisible timer with a random time to remove lives
            set BattleRoyalRemoveLifeTimer = CreateTimer()
            call TimerStart(BattleRoyalRemoveLifeTimer, GetRandomReal(BattleRoyalRemoveLifeLowTime, BattleRoyalRemoveLifeHighTime), true, function RemoveBattleRoyaleLife)
        endif

        // Save debug codes
        call DebugCode_SavePlayerDebugEveryone()
    endfunction

    function InitializeBattleRoyale takes nothing returns nothing
        call TriggerSleepAction(5.00)

        call DisplayTextToForce(GetPlayersAll(), "Hold |cffffcc00SHIFT|r while buying |cff7bff00glory buffs|r or |cff00ff37tomes|r to buy |cff00fff21000|r of them at once, provided you have the gold.")

        set BattleRoyalTimer = CreateTimer()
        set BattleRoyalTimerDialog = CreateTimerDialog(BattleRoyalTimer)
        call TimerDialogSetTitle(BattleRoyalTimerDialog, "Battle Royale...")
        call TimerDialogDisplay(BattleRoyalTimerDialog, true)

        set WaitingForBattleRoyal = true
        
        call TimerStart(BattleRoyalTimer, BattleRoyalWaitTime, false, function StartBattleRoyal)
    endfunction
    
    function InitializeFunBattleRoyale takes nothing returns nothing
        call DestroyTimer(BattleRoyalTimer)
        call DestroyTimerDialog(BattleRoyalTimerDialog)

        call ForForce(GetPlayersAll(), function HideScoreboardForPlayer) 
        call BlzFrameSetVisible(ScoreboardFrameHandle, false)

        set BattleRoyalTimer = CreateTimer()
        set BattleRoyalTimerDialog = CreateTimerDialog(BattleRoyalTimer)
        call TimerDialogSetTitle(BattleRoyalTimerDialog, "Extra Battle Royale...")
        call TimerDialogDisplay(BattleRoyalTimerDialog, true)

        // Reset some game state stuff for end game
        set IsFunBRRound = true
        set BrStarted = false
        set WaitingForBattleRoyal = true
        set GameComplete = false

        call SetBRLockStatus(true)

        call ResetBRPlayerSlots()
        call BlzFrameSetVisible(BattleCreatorFrameHandle, true) 

        call TimerStart(BattleRoyalTimer, BattleRoyalFunWaitTime, false, function StartBattleRoyal)
    endfunction

    private function init takes nothing returns nothing
        set InitializeBattleRoyaleTrigger = CreateTrigger()
        call TriggerAddAction(InitializeBattleRoyaleTrigger, function InitializeBattleRoyale)
    endfunction

endlibrary
