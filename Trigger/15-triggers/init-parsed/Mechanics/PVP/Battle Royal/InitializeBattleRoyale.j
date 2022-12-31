library InitializeBattleRoyale initializer init requires RandomShit, StartFunction, DebugCode, UnitFilteringUtility

    globals
        private integer PlayerIdIndex = 0
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
        set BrPlayerCount = BrPlayerCount + 1
        call SetPlayerAllianceStateBJ(GetOwningPlayer(GetEnumUnit()), Player(PlayerIdIndex), bj_ALLIANCE_UNALLIED)
    endfunction

    private function PlacePlayerHeroInCenterArena takes nothing returns nothing
        local unit currentUnit = GetEnumUnit()
        local player currentPlayer = GetOwningPlayer(currentUnit)
        local PlayerStats ps = PlayerStats.forPlayer(currentPlayer)
        local location arenaLocation = GetRectCenter(RectMidArena)
        local location unitLocation = GetUnitLoc(currentUnit)
        local location playableAreaLocation = GetRectCenter(GetPlayableMapRect())
        local location projectionLocation = PolarProjectionBJ(playableAreaLocation, 1200, (((I2R(GetPlayerId(currentPlayer))) * -45.00) - 225.00))

        set udg_unit01 = currentUnit // Used in HeroRefreshTrigger
        call PauseUnit(udg_unit01, true)
        call ConditionalTriggerExecute(HeroRefreshTrigger)

        // Place hero and pet in a circle using their player id as angle
        call SetUnitPositionLocFacingLocBJ(currentUnit, projectionLocation, arenaLocation)

        if (ps.getPet() != null) then
            call SetUnitPositionLocFacingLocBJ(ps.getPet(), projectionLocation, arenaLocation)
        endif

        call SelectUnitForPlayerSingle(currentUnit, currentPlayer)
        call PanCameraToTimedLocForPlayer(currentPlayer, unitLocation, 0.50)

        // Cleanup
        call RemoveLocation(arenaLocation)
        call RemoveLocation(unitLocation)
        call RemoveLocation(playableAreaLocation)
        call RemoveLocation(projectionLocation)
        set arenaLocation = null
        set unitLocation = null
        set playableAreaLocation = null
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

    private function InitializeBattleRoyaleActions takes nothing returns nothing
        local group shops
        local group playerUnits

        call TriggerSleepAction(5.00)

        // SHow the BR is starting
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call CreateTimerDialogBJ(GetLastCreatedTimerBJ(), "Battle Royal")
        call StartTimerBJ(GetLastCreatedTimerBJ(), false, 60.00)
        call DisplayTextToForce(GetPlayersAll(), "Hold |cffffcc00SHIFT|r while buying |cff7bff00glory buffs|r or |cff00ff37tomes|r to buy |cff00fff21000|r of them at once, provided you have the gold.")

        call TriggerSleepAction(60.00)

        // Final message about BR, hide shops, cleanup before the actual fight
        set BrStarted = true
        call SetVersion()
        call PlaySoundBJ(udg_sound10)
        call DisplayTextToForce(GetPlayersAll(), "|cffffcc00FINAL BATTLE - THE WINNER TAKES IT ALL")
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call ShowDraftBuildings(false)
        call RemoveUnitsInRect(bj_mapInitialPlayableArea)

        // Delete shops
        set shops = GetUnitsOfPlayerMatching(Player(PLAYER_NEUTRAL_PASSIVE), Condition(function ShopFilter))
        call ForGroup(shops, function DeleteShop)

        // Cleanup
        call DestroyGroup(shops)
        set shops = null

        // Set alliances for everyone
        loop
            exitwhen PlayerIdIndex == 8

            set playerUnits = GetUnitsInRectMatching(GetPlayableMapRect(), Condition(function IsValidPlayerHeroUnit))
            call ForGroup(playerUnits, function SetAllianceForPlayer)

            // Cleanup
            call DestroyGroup(playerUnits)
            set playerUnits = null

            set PlayerIdIndex = PlayerIdIndex + 1
        endloop

        // Place units in a circle in center arena
        set playerUnits = GetUnitsInRectMatching(GetPlayableMapRect(), Condition(function IsValidPlayerHeroUnit))
        call ForGroup(playerUnits, function PlacePlayerHeroInCenterArena)

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
        call ForGroup(playerUnits, function StartFightForPlayerHero)
        
        // Cleanup
        call DestroyGroup(playerUnits)
        set playerUnits = null

        if (BrPlayerCount == 1) then
            set PlayerCount = 1
            call ConditionalTriggerExecute(EndGameTrigger)
        endif

        // Save debug codes
        call DebugCode_SavePlayerDebugEveryone()
    endfunction

    private function init takes nothing returns nothing
        set InitializeBattleRoyaleTrigger = CreateTrigger()
        call TriggerAddAction(InitializeBattleRoyaleTrigger, function InitializeBattleRoyaleActions)
    endfunction

endlibrary
