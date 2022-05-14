library trigger79 initializer init requires RandomShit, Functions, LoadCommand, ShopIndex

    globals
        boolean ShopsCreated = false
    endglobals

    function Trig_Spawn_Hero_Func005C takes nothing returns boolean
        if(not(udg_boolean16==false))then
            return false
        endif
        if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Spawn_Hero_Func005Func001002001001002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
    endfunction


    function Trig_Spawn_Hero_Func013001 takes nothing returns boolean
        return(GetUnitTypeId(PlayerHeroes[GetConvertedPlayerId(udg_player02)])=='O008')
    endfunction


    function Trig_Spawn_Hero_Func014Func001001 takes nothing returns boolean
        return(GetUnitTypeId(PlayerHeroes[GetConvertedPlayerId(udg_player02)])=='H008')
    endfunction


    function Trig_Spawn_Hero_Func014Func002001 takes nothing returns boolean
        return(GetUnitTypeId(PlayerHeroes[GetConvertedPlayerId(udg_player02)])=='H008')
    endfunction


    function Trig_Spawn_Hero_Func015001 takes nothing returns boolean
        return(PlayerCount==1)
    endfunction

    function Trig_Spawn_Hero_Func017Func008C takes nothing returns boolean
        if(not(RoundNumber==1))then
            return false
        endif
        if(not(SpawnedHeroCount >= PlayerCount))then
            return false
        endif
        return true
    endfunction


    function Trig_Spawn_Hero_Func017C takes nothing returns boolean
        if(not Trig_Spawn_Hero_Func017Func008C())then
            return false
        endif
        return true
    endfunction

    function CreateNeutralPassiveBuildings2 takes nothing returns nothing
        local player p = Player(PLAYER_NEUTRAL_PASSIVE)
        local integer unitID
        local real life
    
        if(ArNotLearningAbil==false) and AbilityMode == 1 then
            call SetShopIndex(CreateUnit(p,ACTIVE_SPELLS_IV_UNIT_ID,- 124,707,270.000))
            call SetShopIndex(CreateUnit(p,ACTIVE_SPELLS_III_UNIT_ID,- 372,707,270.000))
            call SetShopIndex(CreateUnit(p,ACTIVE_SPELLS_II_UNIT_ID,- 620,707,270.000) )
            call SetShopIndex(CreateUnit(p,ACTIVE_SPELLS_VI_UNIT_ID,- 620,707 + 248,270.000) )
            call SetShopIndex(CreateUnit(p,ACTIVE_SPELLS_I_UNIT_ID,- 868,707,270.000)   )
            call SetShopIndex(CreateUnit(p,ACTIVE_SPELLS_V_UNIT_ID,- 868,707 + 248,270.000)   )  	 	 
            call SetShopIndex(CreateUnit(p,CHRONUS_SPELLS_UNIT_ID,- 1116,707,270.000) )
    
    
            call SetShopIndex(CreateUnit(p,AUTOCAST_TOGGLE_SPELLS_UNIT_ID,124,707,270.000))
            call SetShopIndex(CreateUnit(p,SUMMON_SPELLS_UNIT_ID,372,707,270.000))
            call SetShopIndex(CreateUnit(p,PASSIVE_SPELLS_I_UNIT_ID,620,707,270.000)    ) 
            call SetShopIndex(CreateUnit(p,PASSIVE_SPELLS_II_UNIT_ID,868,707,270.000)  )
            call SetShopIndex(CreateUnit(p,PASSIVE_SPELLS_III_UNIT_ID,1116,707,270.000)  )
            call SetShopIndex(CreateUnit(p,PASSIVE_SPELLS_IV_UNIT_ID,1116,707 + 248,270.000)  )
            call SetShopIndex(CreateUnit(p,PASSIVE_SPELLS_V_UNIT_ID,868,707 + 248,270.000)  )
            call SetShopIndex(CreateUnit(p,PASSIVE_SPELLS_VI_UNIT_ID,620,707 + 248,270.000) )
        endif
        
        call SetShopIndex(CreateUnit(p,SUMMON_BUFFS_SHOP_UNIT_ID,- 868,- 1152,270.000))
        call SetShopIndex(CreateUnit(p,ITEM_SHOP_I_UNIT_ID,- 620,- 1152,270.000) )
        call SetShopIndex(CreateUnit(p,ITEM_SHOP_II_UNIT_ID,- 372,- 1152,270.000) )
        call SetShopIndex(CreateUnit(p,PVE_SHOP_I_UNIT_ID,- 124,- 1152,270.000) )
        call SetShopIndex(CreateUnit(p,PVE_SHOP_II_UNIT_ID,- 124,- 1152 - 256,270.000))
        call SetShopIndex(CreateUnit(p,ITEM_SHOP_III_UNIT_ID,124,- 1152,270.000) )
        call SetShopIndex(CreateUnit(p,RUNESTONE_SHOP_UNIT_ID,124,- 1152 - 256,270.000) )
        call SetShopIndex(CreateUnit(p,ITEM_SHOP_IV_UNIT_ID,372,- 1152,270.000) )
        call SetShopIndex(CreateUnit(p,ELEMENTAL_ITEM_SHOP_UNIT_ID,372,- 1152 - 256,270.000) )
        call SetShopIndex(CreateUnit(p,ITEM_SHOP_V_UNIT_ID,620,- 1152,270.000) )
        call SetShopIndex(CreateUnit(p,ITEM_SHOP_VI_UNIT_ID,868,- 1152,270.000))

        set ShopsCreated = true

        set p = null
    endfunction


    function Trig_Spawn_Hero_Func019Func001C takes nothing returns boolean
        if(not(RoundNumber==1))then
            return false
        endif
        if(not(SpawnedHeroCount >= PlayerCount))then
            return false
        endif
        return true
    endfunction


    function Trig_Spawn_Hero_Func019C takes nothing returns boolean
        if(not Trig_Spawn_Hero_Func019Func001C())then
            return false
        endif
        return true
    endfunction


    public function SpawnedHeroActions takes player p, unit hero returns nothing
        local location heroLocation

        set udg_player02 = p

        set PlayerHeroPicked[GetConvertedPlayerId(udg_player02)]= true
        set SpawnedHeroCount =(SpawnedHeroCount + 1)
    
        call ResourseRefresh( udg_player02   )

        if GetLocalPlayer() == GetOwningPlayer(hero) then
            call BlzFrameSetVisible(SpellUP[0] ,true )
            call BlzFrameSetTexture(SpellFR[0], LoadStr(HT_data,GetUnitTypeId(hero) ,1 )  , 0, true)
    
        endif
    
        call BlzUnitHideAbility(hero,'A030',true)
        call BlzUnitHideAbility(hero,'A031',true)
        call BlzUnitHideAbility(hero,'A032',true)
        call BlzUnitHideAbility(hero,'A033',true)
        call BlzUnitHideAbility(hero,'A034',true)
        call BlzUnitHideAbility(hero,'A03H',true)    
    
        call FunctionStartUnit(hero) 
    
        call BlzSetHeroProperName( hero, GetPlayerNameNoTag( GetPlayerName(GetOwningPlayer(hero)   )))
        call ConditionalTriggerExecute(udg_trigger130)
        set PlayerHeroes[GetConvertedPlayerId(udg_player02)]= hero
            
        // Try to load the code for the player
        call LoadCommand_AutoLoadPlayerSaveCode(udg_player02)
                    
        // Starting items
        call UnitAddItemByIdSwapped('ankh',hero)
        call UnitAddItemByIdSwapped('pghe',hero)
        call UnitAddItemByIdSwapped('I04R',hero)

        call ResetToGameCameraForPlayer(udg_player02,0)
        call PanCameraToTimedLocForPlayer(udg_player02,GetRectCenter(PlayerArenaRects[GetConvertedPlayerId(udg_player02)]),0.00)
        call SelectUnitForPlayerSingle(hero,udg_player02)

        set heroLocation = GetUnitLoc(PlayerHeroes[GetConvertedPlayerId(udg_player02)])

        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 3
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd

            if(Trig_Spawn_Hero_Func014Func001001())then
                call CreateNUnitsAtLoc(1,'e003',udg_player02,PolarProjectionBJ(heroLocation,50.00,(45.00 * I2R(GetForLoopIndexA()))),bj_UNIT_FACING)
            endif

            if(Trig_Spawn_Hero_Func014Func002001())then
                call SetUnitManaBJ(hero,GetRandomReal(0,GetUnitStateSwap(UNIT_STATE_MAX_MANA,hero)))
            endif
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop

        call RemoveLocation(heroLocation)
        set heroLocation = null

        if(Trig_Spawn_Hero_Func015001())then
            set SingleplayerPlayer = GetOwningPlayer(hero)
        endif

        if(Trig_Spawn_Hero_Func017C())then
            set udg_boolean10 = true
            set udg_boolean09 = true
            call PlaySoundBJ(udg_sound11)
            call DisplayTextToForce(GetPlayersAll(),"|c000070C0Get Ready!|r")
            call TriggerSleepAction(0.00)
            call ConditionalTriggerExecute(udg_trigger148)
            call ConditionalTriggerExecute(udg_trigger143)
            if AbilityMode == 2 and DraftInitialised == false then
                call ConditionalTriggerExecute( gg_trg_DraftInit )
            elseif AbilityMode == 1 then
                call InitUpgradeShop()
            endif
            call CreateNeutralPassiveBuildings2()
        endif

        call TriggerSleepAction(2)

        if(Trig_Spawn_Hero_Func019C())then
            call TriggerExecute(udg_trigger109)
        endif
    endfunction

    private function init takes nothing returns nothing
        // set udg_trigger79 = CreateTrigger()
        // call TriggerAddAction(udg_trigger79,function Trig_Spawn_Hero_Actions)
    endfunction


endlibrary
