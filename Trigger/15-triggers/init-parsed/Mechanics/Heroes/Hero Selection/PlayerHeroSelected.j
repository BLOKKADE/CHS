library PlayerHeroSelected requires RandomShit, Functions, LoadCommand, ShopIndex, Scoreboard, InitializeDraftMode, RewardsScreen, HeroPassiveDesc

    globals
        boolean ShopsCreated = false
        private timer GameStartTimer
        private timerdialog GameStartTimerDialog
        private integer GameStartWaitTime = 7
        texttag FloatingTextActiveSpells = null
        texttag FloatingTextPassiveSpells = null
        texttag FloatingTextAbsoluteShop = null
        texttag FloatingTextGloryShops = null
        texttag FloatingTextStarterItems = null
        texttag FloatingTextOffensiveItems = null
        texttag FloatingTextDefensiveItems = null
        texttag FloatingTextPvEItems = null
        texttag FloatingTextTomes = null
        texttag FloatingTextInfoShops = null
        texttag FloatingTextMagicItems = null
        texttag FloatingTextOtherItems = null
    endglobals

        private function ShopTextLarge takes integer x, integer y, string text, integer r, integer g, integer b returns texttag
            local texttag floatingtext = CreateTextTag()
            call SetTextTagText(floatingtext, text, 0.046)
            call SetTextTagPos(floatingtext, x, y, 100.0)
            call SetTextTagColor(floatingtext, r, g, b, 255)
            call SetTextTagPermanent(floatingtext, true)
            return floatingtext
        endfunction

    private function CreateShops takes nothing returns nothing
        local player p = Player(PLAYER_NEUTRAL_PASSIVE)
    
        if (ArNotLearningAbil == false and AbilityMode == 1) then
            call SetShopIndex(CreateUnit(p, ACTIVE_SPELLS_1_UNIT_ID, -950, 700, 270.00))
            call SetShopIndex(CreateUnit(p, ACTIVE_SPELLS_2_UNIT_ID, -750, 700, 270.00))
            call SetShopIndex(CreateUnit(p, ACTIVE_SPELLS_3_UNIT_ID, -550, 700, 270.00))
            call SetShopIndex(CreateUnit(p, ACTIVE_SPELLS_4_UNIT_ID, -350, 700, 270.00))
            call SetShopIndex(CreateUnit(p, ACTIVE_SPELLS_5_UNIT_ID, -150, 700, 270.00)) 
            call SetShopIndex(CreateUnit(p, ACTIVE_SPELLS_6_UNIT_ID, 50, 700, 270.00))
            call SetShopIndex(CreateUnit(p, ACTIVE_SPELLS_7_UNIT_ID, -950, 950, 270.00))
            call SetShopIndex(CreateUnit(p, ACTIVE_SPELLS_8_UNIT_ID, -750, 950, 270.00))
            call SetShopIndex(CreateUnit(p, ACTIVE_SPELLS_9_UNIT_ID, -550, 950, 270.00))
            call SetShopIndex(CreateUnit(p, ACTIVE_SPELLS_10_UNIT_ID, -350, 950, 270.00))  	 	 
            call SetShopIndex(CreateUnit(p, ACTIVE_SPELLS_11_UNIT_ID, -150, 950, 270.00))
            call SetShopIndex(CreateUnit(p, ACTIVE_SPELLS_12_UNIT_ID, 50, 950, 270.00))
            call SetShopIndex(CreateUnit(p, SUMMON_SPELLS_1_UNIT_ID, -1150, 700, 270.00))
            call SetShopIndex(CreateUnit(p, SUMMON_SPELLS_2_UNIT_ID, -1150, 950, 270.00))
            call SetShopIndex(CreateUnit(p, PASSIVE_SPELLS_1_UNIT_ID, 350, 700, 270.00)) 
            call SetShopIndex(CreateUnit(p, PASSIVE_SPELLS_2_UNIT_ID, 550, 700, 270.00))
            call SetShopIndex(CreateUnit(p, PASSIVE_SPELLS_3_UNIT_ID, 750, 700, 270.00))
            call SetShopIndex(CreateUnit(p, PASSIVE_SPELLS_4_UNIT_ID, 950, 700, 270.00))
            call SetShopIndex(CreateUnit(p, PASSIVE_SPELLS_5_UNIT_ID, 350, 950, 270.00))
            //call ShopTextLarge(-700, 500, "Active Spells", 255, 255, 255)
            //call ShopTextLarge(500, 500, "Passive Spells", 255, 255, 255)
            //call ShopText(- 165, 350, "Choose an Absolute ability", 255, 255, 255)
            set FloatingTextActiveSpells = ShopTextLarge(-700, 500, "Active Spells", 255, 255, 255)
            set FloatingTextPassiveSpells = ShopTextLarge(500, 500, "Passive Spells", 255, 255, 255)
            call SetShopIndex(CreateUnit(p, PASSIVE_SPELLS_6_UNIT_ID, 550, 950, 270.00))
            call SetShopIndex(CreateUnit(p, PASSIVE_SPELLS_7_UNIT_ID, 750, 950, 270.00))
            call SetShopIndex(CreateUnit(p, PASSIVE_SPELLS_8_UNIT_ID, 950, 950, 270.00))
            call SetShopIndex(CreateUnit(p, CHRONUS_SPELLS_UNIT_ID, 1150, 950, 270.00))
            
            //call ShopText(- 165, OffsetY -150, "Choose an Absolute ability", 0, 255, 100)
        endif

 // call SetShopIndex(CreateUnit(p, SUMMON_BUFFS_SHOP_UNIT_ID, -868, -1152, 270.00))
            call SetShopIndex(CreateUnit(p, BASIC_ITEMS_SHOP_UNIT_ID, -600, -900, 270.00))//starter items
            set FloatingTextStarterItems = ShopText(-675, -1100, "Starter Items", 255, 255, 255) 

            call SetShopIndex(CreateUnit(p, PVE_SHOP_I_UNIT_ID, -600, -1300, 270.00))//pve shop 1
            //call SetShopIndex(CreateUnit(p, PVE_SHOP_II_UNIT_ID, -620, -1152 - 256, 270.00))//pve shop 2
            set FloatingTextPvEItems = ShopText(-650, -1500, "PvE Shop", 255, 255, 255)

            call SetShopIndex(CreateUnit(p, OFFENSIVE_ITEMS_1_SHOP_UNIT_ID, -300, -900, 270.00))//offensive 1
            call SetShopIndex(CreateUnit(p, OFFENSIVE_ITEMS_2_SHOP_UNIT_ID, -100, -900, 270.00))//offensive 2
            set FloatingTextOffensiveItems = ShopText(-280, -1100, "Offensive Items", 255, 255, 255)

            call SetShopIndex(CreateUnit(p, RUNESTONE_SHOP_UNIT_ID, 100, -1300, 270.00)) //runestone shop
            call SetShopIndex(CreateUnit(p, MAGIC_ITEMS_SHOP_UNIT_ID, -300, -1300, 270.00)) //magic items
            call SetShopIndex(CreateUnit(p, MAGIC_ITEMS_2_SHOP_UNIT_ID, -100, -1300, 270.00))//elemental items 
            set FloatingTextMagicItems = ShopText(-165, -1500, "Magic Items", 255, 255, 255)

            call SetShopIndex(CreateUnit(p, DEFENSIVE_ITEMS_1_SHOP_UNIT_ID, 200, -900, 270.00)) //defensive 1 
            call SetShopIndex(CreateUnit(p, DEFENSIVE_ITEMS_2_SHOP_UNIT_ID, 400, -900, 270.00)) //defensive 2
            call SetShopIndex(CreateUnit(p, DEFENSIVE_ITEMS_3_SHOP_UNIT_ID, 600, -900, 270.00)) //defensive 3
            set FloatingTextDefensiveItems = ShopText(300, -1100, "Defensive Items", 255, 255, 255)

            call SetShopIndex(CreateUnit(p, SUMMONER_ITEMS_SHOP_UNIT_ID, 400, -1300, 270.00)) //summoner shop
            call SetShopIndex(CreateUnit(p, MISC_ITEMS_SHOP_UNIT_ID, 600, -1300, 270.00)) //miscellaneous items
            set FloatingTextOtherItems = ShopText(400, -1500, "Other Items", 255, 255, 255)

            set FloatingTextAbsoluteShop = ShopText(- 165, 350, "Choose an Absolute ability", 255, 255, 255) // absolute shop
            set FloatingTextTomes = ShopText(1150, -535, "Tomes", 255, 255, 255) // tomes
            set FloatingTextGloryShops = ShopText(-1100, -240, "Glory Shops", 255, 255, 255) // glory shops

            call SetShopIndex(CreateUnit(p, INFO_SHOP_1_UNIT_ID, 2040, 1175, GetRandomReal(0.00, 360.00))) //info shop 1
            call SetShopIndex(CreateUnit(p, INFO_SHOP_2_UNIT_ID, 2345, 1240, GetRandomReal(0.00, 360.00))) //info shop 2
            call SetShopIndex(CreateUnit(p, INFO_SHOP_3_UNIT_ID, 2635, 1200, GetRandomReal(0.00, 360.00))) //info shop 3
            call SetShopIndex(CreateUnit(p, INFO_SHOP_4_UNIT_ID, 2900, 1160, GetRandomReal(0.00, 360.00))) //info shop 4
            set FloatingTextInfoShops = ShopText(2400, 1050, "Info Shops", 255, 255, 255) // glory shops

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
        call BlzFrameSetVisible(ScoreboardDarkerFrameHandle, false)

        call TriggerExecute(StartLevelTrigger)
    endfunction

    public function AllPlayersHaveHeroesActions takes nothing returns nothing
        set AllPlayerHeroesSpawned = true
        set udg_boolean09 = true

        call StartScoreboardUpdate() // Start the automatic updating of the scoreboard
        call UpdateRewardsPrimaryStatIcon() // Update the primary stat icon for each player

        call SetupHeroCamera_DisableHeroSelectionForcedCamera()

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
        call BlzFrameSetVisible(ScoreboardDarkerFrameHandle, true)

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
    
        call SaveUnitBaseValues(hero) 
        call BlzSetHeroProperName(hero, GetPlayerNameNoTag(GetPlayerName(p)))
        call ConditionalTriggerExecute(SpacebarCameraTrigger)
        call ResetToGameCameraForPlayer(p, 0)
            
        // Try to load the code for the player
        call LoadCommand_AutoLoadPlayerSaveCode(p)
                    
        // Starting items
        call UnitAddItemByIdSwapped(ANKH_ITEM_ID, hero)
        call UnitAddItemByIdSwapped(POTION_OF_GREATER_HEALING_ITEM_ID, hero)
        call UnitAddItemByIdSwapped(GOLDEN_RING_ITEM_ID, hero)

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
