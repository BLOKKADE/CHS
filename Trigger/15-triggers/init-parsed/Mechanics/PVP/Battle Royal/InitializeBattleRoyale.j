library InitializeBattleRoyale initializer init requires RandomShit, StartFunction, DebugCode, UnitFilteringUtility

    globals
        private integer PlayerIdIndex = 0
        private integer CurrentPlayerHeroPlacement = 0

        integer BattleRoyalWaitTime = 120
        timer BattleRoyalTimer
        timerdialog BattleRoyalTimerDialog
        boolean WaitingForBattleRoyal = false
    endglobals

    private function ShopFilter takes nothing returns boolean
        return (IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) == true)
    endfunction

    private function DeleteShop takes nothing returns nothing
        call DeleteUnit(GetEnumUnit())
    endfunction

    private function IsValidPlayerHeroUnit takes nothing returns boolean
        return IsAlivePlayerHero(GetFilterUnit())
    endfunction

    private function SetAllianceForPlayer takes nothing returns nothing
        call SetPlayerAllianceStateBJ(GetOwningPlayer(GetEnumUnit()), Player(PlayerIdIndex), bj_ALLIANCE_UNALLIED)
    endfunction

    private function PlacePlayerHeroInCenterArena takes nothing returns nothing
        local unit currentUnit = GetEnumUnit()
        local player currentPlayer = GetOwningPlayer(currentUnit)
        local PlayerStats ps = PlayerStats.forPlayer(currentPlayer)
        local location projectionLocation = PolarProjectionBJ(RectMidArenaCenter, 1200, I2R(CurrentPlayerHeroPlacement) * (360.0 / I2R(PlayerCount)))

        set TempUnit = currentUnit // Used in HeroRefreshTrigger
        call PauseUnit(TempUnit, true)
        call ConditionalTriggerExecute(HeroRefreshTrigger)

        // Place hero and pet in a circle using their player id as angle
        call SetUnitPositionLocFacingLocBJ(currentUnit, projectionLocation, RectMidArenaCenter)

        if (ps.getPet() != null) then
            call SetUnitPositionLocFacingLocBJ(ps.getPet(), projectionLocation, RectMidArenaCenter)
        endif

        call SelectUnitForPlayerSingle(currentUnit, currentPlayer)
        call PanCameraToTimedLocForPlayer(currentPlayer, projectionLocation, 0.50)

        set CurrentPlayerHeroPlacement = CurrentPlayerHeroPlacement + 1

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
        local unit currentUnit = GetEnumUnit()

        call PauseUnit(currentUnit, false)
        call SetUnitInvulnerable(currentUnit, false)
        call RectLeaveDetection.create(currentUnit, RectMidArena)
        call StartFunctionSpell(currentUnit, 1)

        // Cleanup
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

    private function BattleRoyalInitialization takes nothing returns nothing
        local group playerUnits = GetUnitsInRectMatching(GetPlayableMapRect(), Condition(function IsValidPlayerHeroUnit))
        local group shops = GetUnitsOfPlayerMatching(Player(PLAYER_NEUTRAL_PASSIVE), Condition(function ShopFilter))
        local group randomPlayerUnits = CreateGroup()
        local unit randomUnit

        // Final message about BR, hide shops, cleanup before the actual fight
        set BrStarted = true
        call SetVersion()
        call PlaySoundBJ(udg_sound10)
        call DisplayTextToForce(GetPlayersAll(), "|cffffcc00FINAL BATTLE - THE WINNER TAKES IT ALL")
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call ShowDraftBuildings(false)
        call RemoveUnitsInRect(bj_mapInitialPlayableArea)

        // Delete shops
        call ForGroup(shops, function DeleteShop)

        // Cleanup
        call DestroyGroup(shops)
        set shops = null

        // Set alliances for everyone
        loop
            exitwhen PlayerIdIndex == 20

            call ForGroup(playerUnits, function SetAllianceForPlayer)

            set PlayerIdIndex = PlayerIdIndex + 1
        endloop

        // Randomize the player hero group to mix things up every time
        loop
            set randomUnit = GroupPickRandomUnit(playerUnits)

            exitwhen randomUnit == null

            call GroupRemoveUnit(playerUnits, randomUnit)
            call GroupAddUnit(randomPlayerUnits, randomUnit)
        endloop

        // Cleanup
        call DestroyGroup(playerUnits)
        set playerUnits = null

        // Place units in a circle in center arena
        call ForGroup(randomPlayerUnits, function PlacePlayerHeroInCenterArena)

        // Remove all items on the ground
        call EnumItemsInRectBJ(GetPlayableMapRect(), function RemoveItemFromArena)

        // Disable a whole bunch of trigger
        call DisableTrigger(CenterArenaInvulnerabilityTrigger)
        call DisableTrigger(CenterArenaRemoveUnitTrigger)
        call DisableTrigger(PlayerHeroDeathTrigger)
        call DisableTrigger(HeroDiesInRoundTrigger)
        call EnableTrigger(PlayerDiesInBattleRoyaleTrigger)

        call TriggerSleepAction(2)

        set CountdownCount = 5
        call ConditionalTriggerExecute(PvpCountdownTimerTrigger)
        call TriggerSleepAction(5.00)
        call PlaySoundBJ(udg_sound08)
        call DisplayTimedTextToForce(GetPlayersAll(), 1.00, "|cffffcc00GO!!!|r")
        call SetAllCurrentlyFighting(true)
        call ForGroup(randomPlayerUnits, function StartFightForPlayerHero)
        
        // Cleanup
        call DestroyGroup(randomPlayerUnits)
        set randomPlayerUnits = null

        set playerUnits = GetUnitsInRectMatching(GetPlayableMapRect(), Condition(function IsValidPlayerHeroUnit))

        // Check if people left before the BR started
        if (CountUnitsInGroup(playerUnits) == 1) then
            call ConditionalTriggerExecute(EndGameTrigger)
        endif

        // Cleanup
        call DestroyGroup(playerUnits)
        set playerUnits = null

        // Save debug codes
        call DebugCode_SavePlayerDebugEveryone()
    endfunction

    function StartBattleRoyal takes nothing returns nothing
        set WaitingForBattleRoyal = false
        call DestroyTimer(BattleRoyalTimer)
        call DestroyTimerDialog(BattleRoyalTimerDialog)
        call BattleRoyalInitialization.execute()
    endfunction

    private function InitializeBattleRoyaleActions takes nothing returns nothing
        call TriggerSleepAction(5.00)

        call DisplayTextToForce(GetPlayersAll(), "Hold |cffffcc00SHIFT|r while buying |cff7bff00glory buffs|r or |cff00ff37tomes|r to buy |cff00fff21000|r of them at once, provided you have the gold.")

        set BattleRoyalTimer = CreateTimer()
        set BattleRoyalTimerDialog = CreateTimerDialog(BattleRoyalTimer)
        call TimerDialogSetTitle(BattleRoyalTimerDialog, "Battle Royal...")
        call TimerDialogDisplay(BattleRoyalTimerDialog, true)

        set WaitingForBattleRoyal = true
        
        call TimerStart(BattleRoyalTimer, BattleRoyalWaitTime, false, function StartBattleRoyal)
    endfunction

    private function init takes nothing returns nothing
        set InitializeBattleRoyaleTrigger = CreateTrigger()
        call TriggerAddAction(InitializeBattleRoyaleTrigger, function InitializeBattleRoyaleActions)
    endfunction

endlibrary
