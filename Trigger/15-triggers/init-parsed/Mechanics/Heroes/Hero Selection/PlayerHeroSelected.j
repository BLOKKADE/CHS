library PlayerHeroSelected requires RandomShit, Functions, LoadCommand, ShopIndex, Scoreboard, InitializeDraftMode, RewardsScreen, HeroPassiveDesc

    globals
        boolean ShopsCreated = false

        private timer GameStartTimer
        private timerdialog GameStartTimerDialog
        private integer GameStartWaitTime = 7
    endglobals

    private function CreateShops takes nothing returns nothing
        local player p = Player(PLAYER_NEUTRAL_PASSIVE)
    
        if (ArNotLearningAbil == false and AbilityMode == 1) then
            call SetShopIndex(CreateUnit(p, ACTIVE_SPELLS_IV_UNIT_ID, -124, 707, 270.00))
            call SetShopIndex(CreateUnit(p, ACTIVE_SPELLS_III_UNIT_ID, -372, 707, 270.00))
            call SetShopIndex(CreateUnit(p, ACTIVE_SPELLS_II_UNIT_ID, -620, 707, 270.00))
            call SetShopIndex(CreateUnit(p, ACTIVE_SPELLS_VI_UNIT_ID, -620, 707 + 248, 270.00))
            call SetShopIndex(CreateUnit(p, ACTIVE_SPELLS_I_UNIT_ID, -868, 707, 270.00))
            call SetShopIndex(CreateUnit(p, ACTIVE_SPELLS_V_UNIT_ID, -868, 707 + 248, 270.00))  	 	 
            call SetShopIndex(CreateUnit(p, CHRONUS_SPELLS_UNIT_ID, -1116, 707, 270.00))
            call SetShopIndex(CreateUnit(p, AUTOCAST_TOGGLE_SPELLS_UNIT_ID, 124, 707, 270.00))
            call SetShopIndex(CreateUnit(p, SUMMON_SPELLS_UNIT_ID, 372, 707, 270.00))
            call SetShopIndex(CreateUnit(p, PASSIVE_SPELLS_I_UNIT_ID, 620, 707, 270.00)) 
            call SetShopIndex(CreateUnit(p, PASSIVE_SPELLS_II_UNIT_ID, 868, 707, 270.00))
            call SetShopIndex(CreateUnit(p, PASSIVE_SPELLS_III_UNIT_ID, 1116, 707, 270.00))
            call SetShopIndex(CreateUnit(p, PASSIVE_SPELLS_IV_UNIT_ID, 1116, 707 + 248, 270.00))
            call SetShopIndex(CreateUnit(p, PASSIVE_SPELLS_V_UNIT_ID, 868, 707 + 248, 270.00))
            call SetShopIndex(CreateUnit(p, PASSIVE_SPELLS_VI_UNIT_ID, 620, 707 + 248, 270.00))
            call SetShopIndex(CreateUnit(p, PASSIVE_SPELLS_VII_UNIT_ID, 372, 707 + 248, 270.00))
        endif
        
        // call SetShopIndex(CreateUnit(p, SUMMON_BUFFS_SHOP_UNIT_ID, -868, -1152, 270.00))
        call SetShopIndex(CreateUnit(p, ITEM_SHOP_I_UNIT_ID, -620, -1152, 270.00))
        call SetShopIndex(CreateUnit(p, ITEM_SHOP_II_UNIT_ID, -372, -1152, 270.00))
        call SetShopIndex(CreateUnit(p, PVE_SHOP_I_UNIT_ID, -124, -1152, 270.00))
        call SetShopIndex(CreateUnit(p, PVE_SHOP_II_UNIT_ID, -124, -1152 - 256, 270.00))
        call SetShopIndex(CreateUnit(p, ITEM_SHOP_III_UNIT_ID, 124, -1152, 270.00))
        call SetShopIndex(CreateUnit(p, RUNESTONE_SHOP_UNIT_ID, 124, -1152 - 256, 270.00))
        call SetShopIndex(CreateUnit(p, ITEM_SHOP_IV_UNIT_ID, 372, -1152, 270.00))
        call SetShopIndex(CreateUnit(p, ELEMENTAL_ITEM_SHOP_UNIT_ID, 372, -1152 - 256, 270.00))
        call SetShopIndex(CreateUnit(p, ITEM_SHOP_V_UNIT_ID, 620, -1152, 270.00))
        call SetShopIndex(CreateUnit(p, ITEM_SHOP_VI_UNIT_ID, 868, -1152, 270.00))
        call SetShopIndex(CreateUnit(p, ITEM_SHOP_VII_UNIT_ID, 620, -1152 - 256, 270.00))
        call SetShopIndex(CreateUnit(p, ITEM_SHOP_VIII_UNIT_ID, 868, -1152 - 256, 270.00))

        set ShopsCreated = true

        // Cleanup
        set p = null
    endfunction

    private function HideScoreboardForPlayer takes nothing returns nothing
        call PlayerStats.forPlayer(GetEnumPlayer()).setHasScoreboardOpen(false)
    endfunction

    private function ShowScoreboardForPlayer takes nothing returns nothing
        call PlayerStats.forPlayer(GetEnumPlayer()).setHasScoreboardOpen(true)
    endfunction

    private function StartGame takes nothing returns nothing
        call DestroyTimer(GameStartTimer)
        call DestroyTimerDialog(GameStartTimerDialog)

        call CreateShops()

        call ForForce(GetPlayersAll(), function HideScoreboardForPlayer) 
        call BlzFrameSetVisible(ScoreboardFrameHandle, false)

        call TriggerExecute(StartLevelTrigger)
    endfunction

    public function AllPlayersHaveHeroesActions takes nothing returns nothing
        set AllPlayerHeroesSpawned = true
        set udg_boolean09 = true

        call StartScoreboardUpdate() // Start the automatic updating of the scoreboard
        call UpdateRewardsPrimaryStatIcon() // Update the primary stat icon for each player

        call PlaySoundBJ(udg_sound11)
        call DisplayTextToForce(GetPlayersAll(), "|c000070C0Get Ready!|r")
        call TriggerSleepAction(0.00)
        call ConditionalTriggerExecute(UnhideShopsTrigger)
        call ConditionalTriggerExecute(EnterShopModeTrigger)

        if (AbilityMode == 2 and DraftInitialised == false) then
            call InitDraftMode()
        elseif (AbilityMode == 1) then
            call InitUpgradeShop()
        endif

        call TriggerSleepAction(2)

        // Show the scoreboard to everyone, hide it after some time, then start the game
        call ForForce(GetPlayersAll(), function ShowScoreboardForPlayer) 
        call BlzFrameSetVisible(ScoreboardFrameHandle, true)

        set GameStartTimer = CreateTimer()
        set GameStartTimerDialog = CreateTimerDialog(GameStartTimer)
        call TimerDialogSetTitle(GameStartTimerDialog, "Game Starts...")
        call TimerDialogDisplay(GameStartTimerDialog, true)

        call TimerStart(GameStartTimer, GameStartWaitTime, false, function StartGame)
    endfunction

    public function SpawnedHeroActions takes player p, unit hero returns nothing
        local location projectionLocation
        local integer playerId = GetPlayerId(p)

        set SpawnedHeroCount = SpawnedHeroCount + 1
    
        call ResourseRefresh(p)

        if (GetLocalPlayer() == p) then
            call BlzFrameSetVisible(ButtonParentId[0], true)
            call BlzFrameSetTexture(ButtonId[0], GetHeroPassiveDescription(GetUnitTypeId(hero), HeroPassive_Icon), 0, true)
        endif
    
        call BlzUnitHideAbility(hero, 'A030', true)
        call BlzUnitHideAbility(hero, 'A031', true)
        call BlzUnitHideAbility(hero, TITANIUM_SPIKE_IMMUN_ABIL_ID, true)
        call BlzUnitHideAbility(hero, 'A033', true)
        call BlzUnitHideAbility(hero, SEARING_ARROWS_ABILITY_ID, true)
        call BlzUnitHideAbility(hero, 'A03H', true)    
    
        call FunctionStartUnit(hero) 
        call BlzSetHeroProperName(hero, GetPlayerNameNoTag(GetPlayerName(p)))
        call ConditionalTriggerExecute(SpacebarCameraTrigger)
        call ResetToGameCameraForPlayer(p, 0)
            
        // Try to load the code for the player
        call LoadCommand_AutoLoadPlayerSaveCode(p)
                    
        // Starting items
        call UnitAddItemByIdSwapped(ANKH_ITEM_ID, hero)
        call UnitAddItemByIdSwapped(POTION_OF_GREATER_HEALING_ITEM_ID, hero)
        call UnitAddItemByIdSwapped('I04R', hero)

        // Move hero and camera to arena
        call PanCameraToTimedLocForPlayer(p, PlayerArenaRectCenters[playerId], 0)
        call SelectUnitForPlayerSingle(hero, p)

        call CustomGameEvent_FireEvent(EVENT_PLAYER_ROUND_TELEPORT, EventInfo.create(p, 0, RoundNumber))

        // Create 3 of something at the hero location
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 3
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd

            if (GetUnitTypeId(hero) == SORCERER_UNIT_ID) then
                // Create the unit around the hero
                set projectionLocation = PolarProjectionBJ(PlayerArenaRectCenters[playerId], 50.00, 45.00 * I2R(bj_forLoopAIndex))
                call CreateUnitAtLoc(p, 'e003', projectionLocation, 270.00)

                // This makes no sense that we do it multiple times
                call SetUnitManaBJ(hero, GetRandomReal(0, GetUnitState(hero, UNIT_STATE_MAX_MANA)))

                // Cleanup
                call RemoveLocation(projectionLocation)
                set projectionLocation = null
            endif

            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop

        if (PlayerCount == 1) then
            set SingleplayerPlayer = p
        endif

        // Check if we are actually ready to start the game
        if AllPlayerHeroesSpawned == false and RoundNumber == 1 and SpawnedHeroCount >= GetValidPlayerForceCount() then
            call AllPlayersHaveHeroesActions()
        endif
    endfunction

endlibrary
