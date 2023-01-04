library StartLevel initializer init requires RandomShit, StartFunction, SellItems, DebugCode, HeroSelectorAction

    globals
        integer RoundStartTick
    endglobals

    private function StartLevelConditions takes nothing returns boolean
        return udg_boolean09 == false
    endfunction

    private function UpdateRoundNumberForPlayer takes nothing returns nothing
        call SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_FOOD_USED, RoundNumber)
        call ResourseRefresh(GetEnumPlayer()) 
    endfunction

    private function IsValidPlayer takes nothing returns boolean
        return (GetFilterPlayer() != Player(8)) and (GetFilterPlayer() != Player(11)) and (IsPlayerInForce(GetFilterPlayer(), DefeatedPlayers) != true)
    endfunction

    private function RemoveItemFromArena takes nothing returns nothing
        call RemoveItem(GetEnumItem())
    endfunction

    private function StartLevelForPlayer takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local integer currentPlayerId = GetPlayerId(currentPlayer)
        local unit playerHero = PlayerHeroes[currentPlayerId + 1]
        local rect playerArena = PlayerArenaRects[currentPlayerId + 1]
        local location arenaLocation = GetRectCenter(playerArena)
        local PlayerStats ps = PlayerStats.forPlayer(currentPlayer)

        call EnumItemsInRectBJ(playerArena, function RemoveItemFromArena)
        call SetUnitInvulnerable(playerHero, false)
        call SetUnitPositionLoc(playerHero, arenaLocation)

        if (ps.getPet() != null) then
            call SetUnitPositionLoc(ps.getPet(), arenaLocation)
        endif

        set TempUnit = playerHero // Used in HeroRefreshTrigger
        call ConditionalTriggerExecute(HeroRefreshTrigger)

        if (not CamMoveDisabled[GetPlayerId(GetEnumPlayer())]) then
            call SelectUnitForPlayerSingle(playerHero, GetOwningPlayer(playerHero))
            call PanCameraToTimedLocForPlayer(currentPlayer, arenaLocation, 0)
        endif

        call SetCurrentlyFighting(currentPlayer, true)

        // Cleanup
        call RemoveLocation(arenaLocation)
        set arenaLocation = null
        set currentPlayer = null
        set playerHero = null
        set playerArena = null
    endfunction

    private function StartLevelForCreep takes nothing returns nothing
        local unit currentUnit = GetEnumUnit()

        call ShowUnitShow(currentUnit)
        call SetUnitInvulnerable(currentUnit, false)
        call PauseUnit(currentUnit, false)

        // Cleanup
        set currentUnit = null
    endfunction

    private function StartFunctionSpells takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()

        call StartFunctionSpell(PlayerHeroes[GetPlayerId(currentPlayer) + 1],3)
        set ShowCreepAbilButton[GetPlayerId(currentPlayer)] = false
        call SetCurrentlyFighting(currentPlayer, true) 

        // Cleanup
        set currentPlayer = null
    endfunction

    private function StartLevelActions takes nothing returns nothing
        local timerdialog td
        local timer t
        local force validPlayerForce

        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())

        if (udg_boolean12 == false and RoundNumber == 1) then
            set udg_boolean12 = true
            set udg_boolean09 = true

            call DisplayTextToForce(GetPlayersAll(), GameDescription)
            call DisplayTextToForce(GetPlayersAll(), "|c00F08000Level " + I2S(RoundNumber)+ "|r")
            call ConditionalTriggerExecute(EnterShopModeTrigger)
        endif

        call ForceClear(RoundPlayersCompleted)
        
        set RoundFinishedCount = 0
        call ConditionalTriggerExecute(UpdateItemsTrigger)
        call ForForce(GetPlayersAll(), function UpdateRoundNumberForPlayer)

        if (ElimModeEnabled == true or GameModeShort == true) then
            set udg_integer59 = (200 * RoundNumber) / RoundCreepNumber
            set udg_integer61 = (200 * RoundNumber) - (udg_integer59 * RoundCreepNumber)
        else
            set udg_integer59 = (80 * RoundNumber) / RoundCreepNumber
            set udg_integer61 = (80 * RoundNumber) - (udg_integer59 * RoundCreepNumber)
        endif

        set validPlayerForce = GetPlayersMatching(Condition(function IsValidPlayer))

        if (RoundNumber > 1) then
            call PlaySoundBJ(udg_sound03)
            call RemoveUnitsInRect(bj_mapInitialPlayableArea)

            call ForForce(validPlayerForce, function StartLevelForPlayer)
            set t = NewTimer()
            set td = CreateTimerDialog(t)
            call TimerDialogSetTitle(td, "Starting in...")
            call TimerDialogDisplay(td, true)
            call TimerStart(t, 4, false, null)
            call TriggerSleepAction(1.00)
            call PlaySoundBJ(udg_sound09)
            call TriggerSleepAction(1.00)
            call PlaySoundBJ(udg_sound09)
            call TriggerSleepAction(1.00)
            call PlaySoundBJ(udg_sound09)
            call TriggerSleepAction(1.00)
            call ReleaseTimer(t)
            call TimerDialogDisplay(td, false)
            call DestroyTimerDialog(td)

            // Cleanup
            set t = null
            set td = null
        else
            call RemoveHeroPreviewUnit()
        endif

        // Save debug codes
        call DebugCode_SavePlayerDebugEveryone()

        call PlaySoundBJ(udg_sound01)
        call ForGroup(RoundCreeps, function StartLevelForCreep)
        call ForForce(validPlayerForce, function StartFunctionSpells)
        call ConditionalTriggerExecute(CreepPeriodicAttackTrigger)
        set SuddenDeathTick = 0
        set RoundStartTick = T32_Tick
        call EnableTrigger(SuddenDeathCreepTimerTrigger)
        call StartSuddenDeathTimer()
        call EnableTrigger(PlayerAntiStuckTrigger)
        call EnableTrigger(GenerateNextCreepLevelTrigger)

        // Cleanup
        call DestroyForce(validPlayerForce)
        set validPlayerForce = null
    endfunction

    private function init takes nothing returns nothing
        set StartLevelTrigger = CreateTrigger()
        call TriggerAddCondition(StartLevelTrigger, Condition(function StartLevelConditions))
        call TriggerAddAction(StartLevelTrigger, function StartLevelActions)
    endfunction

endlibrary
