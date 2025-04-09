library BattleRoyaleHelper initializer init requires ItemStock, RandomShit, StartFunction, UnitFilteringUtility, ScoreboardManager, BattleCreatorManager, EventHelpers, HeroRefresh, BRLivesFrame

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

        integer BattleRoyaleStartTime = 0
        integer BattleRoyaleEndTime = 0
        integer FunBattleRoyaleStartTime = 0
        integer FunBattleRoyaleEndTime = 0

        integer BattleRoyalFunWaitTime = 30
        integer BattleRoyalWaitTime = 120
        integer BattleRoyalReviewWaitTime = 30
        integer FunBattleRoyalPrepTime = 120
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

        // Remove player hero from game if they left the game and are an observer
        if (IsPlayerInForce(GetEnumPlayer(), LeaverPlayers)) then
            call ResetHero(currentUnit)
            call RemoveUnit(currentUnit)
        endif

        // Cleanup
        call RemoveLocation(centerLocation)
        set centerLocation = null
        set currentUnit = null
    endfunction

    private function SaveItemsForPlayer takes player currentPlayer returns nothing
        local integer playerId = GetPlayerId(currentPlayer)
        local unit currentUnit = PlayerHeroes[playerId]
        local integer itemSlotIndex = 0
        local item currentItem

        if (GetPlayerSlotState(currentPlayer) != PLAYER_SLOT_STATE_LEFT) then
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
        set currentUnit = null
        set currentItem = null
    endfunction

    private function ResetItemsForPlayer takes player currentPlayer returns nothing
        local integer playerId = GetPlayerId(currentPlayer)
        local unit currentUnit = PlayerHeroes[playerId]
        local integer itemSlotIndex = 0
        local item currentItem

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

        // Cleanup
        set currentUnit = null
        set currentItem = null
    endfunction

    private function PlacePlayerHeroInCenterArena takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local integer playerId = GetPlayerId(currentPlayer)
        local unit currentUnit = PlayerHeroes[playerId]
        local PlayerStats ps = PlayerStats.forPlayer(currentPlayer)
        local location projectionLocation = PolarProjectionBJ(RectMidArenaCenter, 1200, I2R(CurrentPlayerHeroPlacement) * (360.0 / I2R(BRTeamCount)))

        // Place hero and pet in a circle
        call SetUnitPositionLocFacingLocBJ(currentUnit, projectionLocation, RectMidArenaCenter)

        call PauseUnit(currentUnit, true)

        if (ps.getPet() != null) then
            call SetUnitPositionLocFacingLocBJ(ps.getPet(), projectionLocation, RectMidArenaCenter)
        else
            // Revive the pet if it died
            call AchievementsFrame_TryToSummonPet(ps.getPetIndex(), currentPlayer, false)
        endif

        // Select and change camera to the player
        call SelectUnitForPlayerSingle(currentUnit, currentPlayer)
        call PanCameraToTimedLocForPlayer(currentPlayer, projectionLocation, 0.50)

        // Reset stats in the scoreboard
        call ResetPlayerBRProperties(currentPlayer)
        call ps.resetBRPVPKillCount()

        // Reset lives
        set PlayerBRDeaths[playerId] = 0

        // Update the UI
        call UpdateLivesForPlayer(currentPlayer, MaxBRDeathCount, true)

        // Save items
        call SaveItemsForPlayer(currentPlayer)

        call CustomGameEvent_FireEvent(EVENT_PLAYER_ROUND_TELEPORT, EventInfo.createAll(currentPlayer, 0, RoundNumber, true))

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

        call CustomGameEvent_FireEvent(EVENT_GAME_ROUND_START, EventInfo.createAll(currentPlayer, 0, RoundNumber, true))
        call PauseUnit(currentUnit, false)

        // Reset the hero
        set TempUnit = currentUnit // Used in HeroRefreshTrigger
        call ConditionalTriggerExecute(HeroRefreshTrigger)

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
                    call ShowUnit(draftBuilding1, b)
                    call ShowUnit(udg_Draft_DraftBuildings[i], b)
                    call SetTextTagVisibility(FloatingTextBuy, b)
                endif
                
                call ShowUnit(circle2, b)
                call ShowUnit(draftBuilding2, b)
                call ShowUnit(udg_Draft_UpgradeBuildings[i], b)
                call SetTextTagVisibility(FloatingTextUpgrade, b)
                set i = i + 1
                exitwhen i > 9
            endloop
        endif
    endfunction

    private function HideBattleCreatorForPlayer takes nothing returns nothing
        call PlayerStats.forPlayer(GetEnumPlayer()).setHasBattleCreatorOpen(false)
    endfunction

    private function ShowBattleCreatorForPlayer takes nothing returns nothing
        call PlayerStats.forPlayer(GetEnumPlayer()).setHasBattleCreatorOpen(true)
    endfunction

    private function HideScoreboardForPlayer takes nothing returns nothing
        call PlayerStats.forPlayer(GetEnumPlayer()).setHasScoreboardOpen(false)
    endfunction

    private function ShopFilter takes nothing returns boolean
        return (IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) == true)
    endfunction

    private function HideShop takes nothing returns nothing
        call ShowUnit(GetEnumUnit(), false)
    endfunction
    
    private function ShowShop takes nothing returns nothing
        call ShowUnit(GetEnumUnit(), true)
    endfunction
    
    private function ShowPlayerLivesRemaining takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local integer playerDeaths = PlayerBRDeaths[GetPlayerId(currentPlayer)]

        if (playerDeaths <= MaxBRDeathCount and IsPlayerInForce(currentPlayer, BRPlayers)) then
            call DisplayTimedTextToPlayer(currentPlayer, 0, 0, 10, "|cffffcc00You have |r" + I2S(IMaxBJ(MaxBRDeathCount - playerDeaths, 0)) + " |cffffcc00lives remaining.|r")

            // Update the UI
            call UpdateLivesForPlayer(currentPlayer, IMaxBJ(MaxBRDeathCount - playerDeaths, 0), true)
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

    private function SetShopVisibility takes boolean visible returns nothing
        local group shops = GetUnitsOfPlayerMatching(Player(PLAYER_NEUTRAL_PASSIVE), Condition(function ShopFilter))

        call ShowDraftBuildings(visible)

        if (visible) then
            call ForGroup(shops, function ShowShop)
        else
            call ForGroup(shops, function HideShop)
        endif

        // Cleanup
        call DestroyGroup(shops)
        set shops = null
    endfunction

    function StartBattleRoyale takes nothing returns nothing
        call DestroyTimer(BattleRoyalTimer)
        call DestroyTimerDialog(BattleRoyalTimerDialog)

        call ExecuteFunc("StartBattleRoyaleActions")
    endfunction

    function StartBattleRoyaleActions takes nothing returns nothing
        local integer forceIndex = 0
        local integer nestedForceIndex = 0
        local integer randomCount = 0
        
        set CurrentPlayerHeroPlacement = 0
        set MaxBRDeathCount = 3
        set WaitingForBattleRoyal = false

        call EventHelpers_FireEventForAllPlayers(EVENT_FUN_BR_ROUND_START, 0, RoundNumber, true)

        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())

        // Final message about BR, hide shops, cleanup before the actual fight
        set BrStarted = true
        call PlaySoundBJ(udg_sound10)

        call SetShopVisibility(false)

        call SetForceAllianceStateBJ(BRObservers, BRObservers, bj_ALLIANCE_ALLIED)

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

        // Teleport observers to an arena
        call ForForce(BRObservers, function MoveObserver)

        set forceIndex = 0

        // Set alliances for everyone
        loop
            exitwhen forceIndex == BRTeamCount

            call ForForce(BRRandomPlayerForce[forceIndex], function PlacePlayerHeroInCenterArena)

            set CurrentPlayerHeroPlacement = CurrentPlayerHeroPlacement + 1

            set forceIndex = forceIndex + 1
        endloop

        if (IsFunBRRound) then
            call DisplayTextToForce(GetPlayersAll(), "|cffffcc00EXTRA BATTLE - THE WINNER TAKES SOME PRIDE|r")
            call TriggerSleepAction(2)
            call DisplayTextToForce(GetPlayersAll(), "|cffff2b23Your items will be restored for further BR fun rounds, so feel free to drop items during the fight.|r")
        else
            call SetVersion()

            call DisplayTextToForce(GetPlayersAll(), "|cffffcc00FINAL BATTLE - THE WINNER TAKES IT ALL|r")
            call TriggerSleepAction(2)
            call DisplayTextToForce(GetPlayersAll(), "|cffff5e00Reminder: After the official BR, you can play additional BR rounds for fun!|r")
            call TriggerSleepAction(2)
            call DisplayTextToForce(GetPlayersAll(), "|cffff2b23Your items will be restored for further BR fun rounds, so feel free to drop items during the fight.|r")
        endif
        
        // Disable a whole bunch of trigger
        call DisableTrigger(CenterArenaInvulnerabilityTrigger)
        call DisableTrigger(CenterArenaRemoveUnitTrigger)
        call DisableTrigger(PlayerHeroDeathTrigger)
        call DisableTrigger(HeroDiesInRoundTrigger)
        call EnableTrigger(PlayerDiesInBattleRoyaleTrigger)

        // Show the BR lives
        call BlzFrameSetVisible(BRLivesFrameHandle, true) 

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

        if (IsFunBRRound) then
            set FunBattleRoyaleStartTime = T32_Tick
        else
            set BattleRoyaleStartTime = T32_Tick
        endif

        // Invisible timer with a random time to remove lives
        set BattleRoyalRemoveLifeTimer = CreateTimer()

        if (BRLivesMode == 2) then
            call TimerStart(BattleRoyalRemoveLifeTimer, GetRandomReal(BattleRoyalRemoveLifeLowTime, BattleRoyalRemoveLifeHighTime), true, function RemoveBattleRoyaleLife)
        endif
    endfunction

    function FinalizeBattleRoyaleSetup takes nothing returns nothing
        call DestroyTimer(BattleRoyalTimer)
        call DestroyTimerDialog(BattleRoyalTimerDialog)

        call ExecuteFunc("BattleRoyalPrep")
    endfunction

    private function SetupPlayerForPrep takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local integer playerId = GetPlayerId(currentPlayer)
        local unit currentUnit = PlayerHeroes[playerId]

        // Respawn hero in center arena
        call ReviveHeroLoc(currentUnit, RectMidArenaCenter, true)
        call SetUnitInvulnerable(currentUnit, true)
        call SetUnitPositionLoc(currentUnit, RectMidArenaCenter)

        call SetCurrentlyFighting(currentPlayer, false)

        // Reset items
        call ResetItemsForPlayer(currentPlayer)

        // Reset the hero
        set TempUnit = currentUnit // Used in HeroRefreshTrigger
        call PauseUnit(currentUnit, false)
        call ConditionalTriggerExecute(HeroRefreshTrigger)

        // Reset ready button
        call CustomGameEvent_FireEvent(EVENT_FUN_BR_ROUND_END, EventInfo.createAll(currentPlayer, 0, RoundNumber, true))

        // Cleanup
        set currentPlayer = null
        set currentUnit = null
    endfunction

    function BattleRoyalPrep takes nothing returns nothing
        local force playersToFight
        local integer currentPlayerId = 0

        call ForForce(GetPlayersAll(), function HideScoreboardForPlayer) 
        call BlzFrameSetVisible(ScoreboardFrameHandle, false)

        // Reset the dead hero count
        set CurrentDeadHeroCount = 0

        if (IsFunBRRound) then
            call CalculatePlayerForces()
        else
            set playersToFight = CreateForce()

            // Calculate the initial valid players
            loop
                exitwhen currentPlayerId == 8

                if (IsPlayerInForce(Player(currentPlayerId), LeaverPlayers)) then
                    call ResetHero(PlayerHeroes[currentPlayerId])
                    call RemoveUnit(PlayerHeroes[currentPlayerId])
                elseif (PlayerHeroes[currentPlayerId] != null and (not IsPlayerInForce(Player(currentPlayerId), DefeatedPlayers))) then
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
            call ResetScoreboardBrWinner()

            call TriggerSleepAction(5)

            call ForForce(GetPlayersAll(), function HideBattleCreatorForPlayer) 
            call BlzFrameSetVisible(BattleCreatorFrameHandle, false) 
        else
            call BlzFrameSetText(BRMessageTextFrameHandle, BR_MESSAGE_COLOR + "Invalid Fun Battle Royale Setup. Try again." + BR_COLOR_END_TAG)
            call BlzFrameSetVisible(BRMessageTextFrameHandle, true)

            call TriggerSleepAction(5)

            call BlzFrameSetVisible(BRMessageTextFrameHandle, false)

            call SetBRLockStatus(true)

            set BattleRoyalTimer = CreateTimer()
            set BattleRoyalTimerDialog = CreateTimerDialog(BattleRoyalTimer)
            call TimerDialogSetTitle(BattleRoyalTimerDialog, "Fun Battle Royale Setup...")
            call TimerDialogDisplay(BattleRoyalTimerDialog, true)

            call ResetBRPlayerSlots()
            call ResetBRPlayerForce()

            call TimerStart(BattleRoyalTimer, BattleRoyalFunWaitTime, false, function FinalizeBattleRoyaleSetup)

            return
        endif
        
        // Reset the player count since it gets decremented during the PlayerDiesInBattleRoyale trigger
        set PlayerCount = BRRoundPlayerCount

        call EnableTrigger(IsGameFinishedTrigger) // This probably doesn't need to be here?

        call RemoveUnitsInRect(bj_mapInitialPlayableArea)

        // If this is the fun BR round, respawn all heroes in the center for buying items. Otherwise just start the normal BR
        if (IsFunBRRound) then
            set WaitingForBattleRoyal = true

            // Remove all items on the ground
            call EnumItemsInRectBJ(GetPlayableMapRect(), function RemoveItemFromArena)

            // Revive/move all heroes to the middle of the center arena
            call ForForce(BRPlayers, function SetupPlayerForPrep)

            // Make everyone allied to wipe previous alliances
            call SetForceAllianceStateBJ(BRPlayers, BRPlayers, bj_ALLIANCE_ALLIED)

            // Show shops
            call SetShopVisibility(true)

            set BattleRoyalTimer = CreateTimer()
            set BattleRoyalTimerDialog = CreateTimerDialog(BattleRoyalTimer)
            call TimerDialogSetTitle(BattleRoyalTimerDialog, "Fun Battle Royale Prep...")
            call TimerDialogDisplay(BattleRoyalTimerDialog, true)
    
            call TimerStart(BattleRoyalTimer, FunBattleRoyalPrepTime, false, function StartBattleRoyale)
        else
            call StartBattleRoyale()
        endif
    endfunction

    private function InitializeBattleRoyale takes nothing returns nothing
        call DisplayTextToForce(GetPlayersAll(), "Hold |cffffcc00SHIFT|r while buying |cff7bff00glory buffs|r or |cff00ff37tomes|r to buy |cff00fff21000|r of them at once, provided you have the gold.")

        set BattleRoyalTimer = CreateTimer()
        set BattleRoyalTimerDialog = CreateTimerDialog(BattleRoyalTimer)
        call TimerDialogSetTitle(BattleRoyalTimerDialog, "Battle Royale...")
        call TimerDialogDisplay(BattleRoyalTimerDialog, true)

        set WaitingForBattleRoyal = true
        
        call SetUpItemStocks(GetPlayersAll())
        
        call TimerStart(BattleRoyalTimer, BattleRoyalWaitTime, false, function FinalizeBattleRoyaleSetup)
    endfunction
    
    function InitializeFunBattleRoyale takes nothing returns nothing
        call DestroyTimer(BattleRoyalTimer)
        call DestroyTimerDialog(BattleRoyalTimerDialog)

        call ForForce(GetPlayersAll(), function HideScoreboardForPlayer) 
        call BlzFrameSetVisible(ScoreboardFrameHandle, false)

        set BattleRoyalTimer = CreateTimer()
        set BattleRoyalTimerDialog = CreateTimerDialog(BattleRoyalTimer)
        call TimerDialogSetTitle(BattleRoyalTimerDialog, "Organize Teams...")
        call TimerDialogDisplay(BattleRoyalTimerDialog, true)

        // Reset some game state stuff for end game
        set IsFunBRRound = true
        set BrStarted = false
        set GameComplete = false

        call SetBRLockStatus(true)

        call ResetBRPlayerSlots()

        call BlzFrameSetVisible(BRMessageTextFrameHandle, false)

        call ForForce(GetPlayersAll(), function ShowBattleCreatorForPlayer) 
        call BlzFrameSetVisible(BattleCreatorFrameHandle, true) 

        call TimerStart(BattleRoyalTimer, BattleRoyalFunWaitTime, false, function FinalizeBattleRoyaleSetup)
    endfunction

    private function init takes nothing returns nothing
        set InitializeBattleRoyaleTrigger = CreateTrigger()
        call TriggerAddAction(InitializeBattleRoyaleTrigger, function InitializeBattleRoyale)
    endfunction

endlibrary
