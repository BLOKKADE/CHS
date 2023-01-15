library PlayerHeroSelected requires RandomShit, Functions, LoadCommand, ShopIndex, Scoreboard, InitializeDraftMode

    globals
        boolean ShopsCreated = false
    endglobals

    private function CreateNeutralPassiveBuildings2 takes nothing returns nothing
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

        set ShopsCreated = true

        // Cleanup
        set p = null
    endfunction

    public function AllPlayersHaveHeroesActions takes nothing returns nothing
        set AllPlayerHeroesSpawned = true
        set udg_boolean09 = true

        call InitializeScoreboard() // Now that everyone has a hero, show the leaderboard

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

        call CreateNeutralPassiveBuildings2()

        call TriggerSleepAction(2)

        call TriggerExecute(StartLevelTrigger)
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
        call BlzUnitHideAbility(hero, 'A032', true)
        call BlzUnitHideAbility(hero, 'A033', true)
        call BlzUnitHideAbility(hero, 'A034', true)
        call BlzUnitHideAbility(hero, 'A03H', true)    
    
        call FunctionStartUnit(hero) 
        call BlzSetHeroProperName(hero, GetPlayerNameNoTag(GetPlayerName(p)))
        call ConditionalTriggerExecute(SpacebarCameraTrigger)
        call ResetToGameCameraForPlayer(p, 0)
            
        // Try to load the code for the player
        call LoadCommand_AutoLoadPlayerSaveCode(p)
                    
        // Starting items
        call UnitAddItemByIdSwapped('ankh', hero)
        call UnitAddItemByIdSwapped('pghe', hero)
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

            if (GetUnitTypeId(hero) == 'H008') then
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
