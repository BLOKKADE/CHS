library trigger79 initializer init requires RandomShit, Functions, LoadCommand, ShopIndex, EconomyMode
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


    function Trig_Spawn_Hero_Func016A takes nothing returns nothing
        call DeleteUnit(GetEnumUnit())
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


    function Trig_Untitled_Trigger_001_Func001A takes nothing returns nothing
        call DeleteUnit( GetEnumUnit() )
    endfunction


    function CreateNeutralPassiveBuildings2 takes nothing returns nothing
        local player p = Player(PLAYER_NEUTRAL_PASSIVE)
        local unit u
        local integer unitID
        local trigger t
        local real life
    
        set udg_unit06 = CreateUnit(p,'ncop',0.0,- 256.0,270.000)
        set udg_unit07 = CreateUnit(p,'ncop',- 256.0,- 256.0,270.000)
        set udg_unit08 = CreateUnit(p,'ncop',- 256.0,0.0,270.000)
        set udg_unit09 = CreateUnit(p,'ncop',0.0,0.0,270.000)
        set udg_unit10 = CreateUnit(p,'ncop',256.0,0.0,270.000)
        set udg_unit11 = CreateUnit(p,'ncop',256.0,- 256.0,270.000)
        set udg_unit12 = CreateUnit(p,'ncop',256.0,- 512.0,270.000)
        set udg_unit13 = CreateUnit(p,'ncop',0.0,- 512.0,270.000)
        set udg_unit14 = CreateUnit(p,'ncop',- 256.0,- 512.0,270.000)
        set udg_unit15 = CreateUnit(p,'ncop',- 256.0,- 768.0,270.000)
        set udg_unit16 = CreateUnit(p,'ncop',0.0,- 768.0,270.000)
        set udg_unit17 = CreateUnit(p,'ncop',256.0,- 768.0,270.000)
        set udg_unit18 = CreateUnit(p,'ncop',512.0,- 768.0,270.000)
        set udg_unit19 = CreateUnit(p,'ncop',512.0,- 512.0,270.000)
        set udg_unit20 = CreateUnit(p,'ncop',512.0,- 256.0,270.000)
        set udg_unit21 = CreateUnit(p,'ncop',512.0,0.0,270.000)
        set udg_unit22 = CreateUnit(p,'ncop',256.0,256.0,270.000)
        set udg_unit23 = CreateUnit(p,'ncop',0.0,256.0,270.000)
        set udg_unit24 = CreateUnit(p,'ncop',- 256.0,256.0,270.000)
        set udg_unit25 = CreateUnit(p,'ncop',- 512.0,256.0,270.000)
        set udg_unit26 = CreateUnit(p,'ncop',- 512.0,0.0,270.000)
        set udg_unit27 = CreateUnit(p,'ncop',- 512.0,- 256.0,270.000)
        set udg_unit28 = CreateUnit(p,'ncop',- 512.0,- 512.0,270.000)
        set udg_unit29 = CreateUnit(p,'ncop',- 512.0,- 768.0,270.000)
        set udg_unit30 = CreateUnit(p,'ncop',0.0,- 1024.0,270.000)
        set udg_unit31 = CreateUnit(p,'ncop',- 768.0,- 256.0,270.000)
        set udg_unit32 = CreateUnit(p,'ncop',768.0,- 256.0,270.000)
        set CicrleUnit[0]= CreateUnit(p,'ncop',256,512.0,270.000)
        set CicrleUnit[1]= CreateUnit(p,'ncop',- 256,512.0,270.000)
        set CicrleUnit[2]= CreateUnit(p,'ncop',512,512.0,270.000)
        set CicrleUnit[3]= CreateUnit(p,'ncop',- 512,512.0,270.000)
        set CicrleUnit[4]= CreateUnit(p,'ncop',- 768.0,- 768.0,270.000)
        set CicrleUnit[5]= CreateUnit(p,'ncop',- 768.0,- 512.0,270.000)
        set CicrleUnit[6]= CreateUnit(p,'ncop',- 768.0,0.6,270.000)
        set CicrleUnit[7]= CreateUnit(p,'ncop',- 768.3,256,270.000)
        set CicrleUnit[8]= CreateUnit(p,'ncop',- 768.3,513,270.000)
        set CicrleUnit[9]= CreateUnit(p,'ncop',768.0,- 512.4,270.000)
        set CicrleUnit[10]= CreateUnit(p,'ncop',768.0,- 768.0,270.000)
        set CicrleUnit[11]= CreateUnit(p,'ncop',768.0,513,270.000)
        set CicrleUnit[12]= CreateUnit(p,'ncop',768.0,256,270.000)	
        set CicrleUnit[13]= CreateUnit(p,'ncop',768.0,0,270.000)	
        set CicrleUnit[14]= CreateUnit(p,'ncop',- 256,- 1024.0,270.000)
        set CicrleUnit[15]= CreateUnit(p,'ncop',256,- 1024.0,270.000)	
        set CicrleUnit[16]= CreateUnit(p,'ncop',512,- 1024.0,270.000)	
        set CicrleUnit[17]= CreateUnit(p,'ncop',- 512,- 1024.0,270.000)		
        set CicrleUnit[18]= CreateUnit(p,'ncop',- 768,- 1024.0,270.000)	
        set CicrleUnit[19]= CreateUnit(p,'ncop',768,- 1024.0,270.000)
        set CicrleUnit[20]= CreateUnit(p,'ncop',1024,- 1024.0,270.000)
        set udg_unit33 = CreateUnit(p,'ncop',0.0,512.0,270.000)
        set udg_unit34 = CreateUnit(p,'ncop',512.0,256.0,270.000)
        //	set u=CreateUnit(p,'n00A',-960.0,-604.0,270.000)
        //	set u=CreateUnit(p,'n00M',960.0,-604.0,270.000)
        if(udg_boolean05==false) and AbilityMode == 1 then
    
    
    
    
            //	 set u=CreateUnit(p,'n012',-124,707,270.000)
            //	 set u=CreateUnit(p,'n014',-372,707,270.000)
            //	 set u=CreateUnit(p,'n003',-620,707,270.000)     
            //	 set u=CreateUnit(p,'n00U',-868,707,270.000)   
    
            //	 set u=CreateUnit(p,'n001',124,707,270.000)
            //	 set u=CreateUnit(p,'n013',372,707,270.000)
            //	 set u=CreateUnit(p,'n00D',620,707,270.000)     
            //  set u=CreateUnit(p,'n00Y',868,707,270.000)  
            //  set u=CreateUnit(p,'n00S',1116,707,270.000)           
    
    
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
    
    
            //		set u=CreateUnit(p,'n001',384.0,576.0,270.000)
            //		set u=CreateUnit(p,'n003',960.0,0.0,270.000)
            //		set u=CreateUnit(p,'n00D',-960.0,0.0,270.000)
            //		set u=CreateUnit(p,'n012',-384.0,576.0,270.000)
            //		set u=CreateUnit(p,'n004',000.0,650.0,270.000)
            //		set u=CreateUnit(p,'n00Y',384.0,-1024.0,270.000)
            //	set u=CreateUnit(p,'n00U',-384.0,-1024.0,270.000)
            //		set u=CreateUnit(p,'n013',640.0,320.0,270.000)
            //	set u=CreateUnit(p,'n014',-640.0,320.0,270.000)
    
            //		set u=CreateUnit(p,'n00S',0,-1160,270.000)
        else
            //	set u=CreateUnit(p,'n004',0.0,640.0,270.000)
            //	set u=CreateUnit(p,'n016',-960.0,-256.0,270.000)
            //	set u=CreateUnit(p,'n016',0.0,-1152.0,270.000)
            //	set u=CreateUnit(p,'n016',960.0,-256.0,270.000)
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
        call ForGroupBJ( GetUnitsOfTypeIdAll('ncop'), function Trig_Untitled_Trigger_001_Func001A )
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


    function Trig_Spawn_Hero_Actions takes nothing returns nothing
        call ForceAddPlayerSimple(udg_player02,udg_force01)
        set udg_booleans03[GetConvertedPlayerId(udg_player02)]= true
        set SpawnedHeroCount =(SpawnedHeroCount + 1)
    
        if(Trig_Spawn_Hero_Func005C())then
            call CreateNUnitsAtLoc(1,GetUnitTypeId(GetTriggerUnit()),GetTriggerPlayer(),GetRectCenter(PlayerArenaRects[GetConvertedPlayerId(GetTriggerPlayer())]),bj_UNIT_FACING)
            call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(GetTriggerPlayer())+(" |cffffcc00has selected " +(GetUnitName(GetLastCreatedUnit())+ "!")))))
            call AdjustPlayerStateBJ(600,udg_player02,PLAYER_STATE_RESOURCE_GOLD)
            call ResourseRefresh( udg_player02   )
    
        else
            call CreateNUnitsAtLoc(1,GetUnitTypeId(GroupPickRandomUnit(GetUnitsOfPlayerMatching(Player(8),Condition(function Trig_Spawn_Hero_Func005Func001002001001002)))),udg_player02,GetRectCenter(PlayerArenaRects[GetConvertedPlayerId(udg_player02)]),bj_UNIT_FACING)
            call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(udg_player02)+(" |cffffcc00has randomed " +(GetUnitName(GetLastCreatedUnit())+ "! (+300 bonus gold)")))))
            call AdjustPlayerStateBJ(900,udg_player02,PLAYER_STATE_RESOURCE_GOLD)
            call ResourseRefresh( udg_player02   )
        endif
    
        // Try to load the code for the player
        call LoadCommand_AutoLoadPlayerSaveCode(udg_player02)
                    
    
        if GetLocalPlayer() == GetOwningPlayer(GetLastCreatedUnit()) then
            call BlzFrameSetVisible(SpellUP[0] ,true )
            call BlzFrameSetTexture(SpellFR[0], LoadStr(HT_data,GetUnitTypeId(GetLastCreatedUnit()) ,1 )  , 0, true)
    
        endif
    
    
    
        call BlzUnitHideAbility(GetLastCreatedUnit(),'A030',true)
        call BlzUnitHideAbility(GetLastCreatedUnit(),'A031',true)
        call BlzUnitHideAbility(GetLastCreatedUnit(),'A032',true)
        call BlzUnitHideAbility(GetLastCreatedUnit(),'A033',true)
        call BlzUnitHideAbility(GetLastCreatedUnit(),'A034',true)
        call BlzUnitHideAbility(GetLastCreatedUnit(),'A03H',true)    
    
        call FunctionStartUnit(GetLastCreatedUnit()) 
    
        call BlzSetHeroProperName( GetLastCreatedUnit(), GetPlayerNameNoTag( GetPlayerName(GetOwningPlayer(GetLastCreatedUnit())   )))
        call ConditionalTriggerExecute(udg_trigger130)
        set PlayerHeroes[GetConvertedPlayerId(udg_player02)]= GetLastCreatedUnit()
        call UnitAddItemByIdSwapped('ankh',GetLastCreatedUnit())
        call UnitAddItemByIdSwapped('pghe',GetLastCreatedUnit())
        call UnitAddItemByIdSwapped('I04R',GetLastCreatedUnit())
        call ResetToGameCameraForPlayer(udg_player02,0)
        call PanCameraToTimedLocForPlayer(udg_player02,GetRectCenter(PlayerArenaRects[GetConvertedPlayerId(udg_player02)]),0.00)
        call SelectUnitForPlayerSingle(GetLastCreatedUnit(),udg_player02)
        /*if(Trig_Spawn_Hero_Func013001())then
            call CreateNUnitsAtLoc(1,'e001',udg_player02,OffsetLocation(GetUnitLoc(PlayerHeroes[GetConvertedPlayerId(udg_player02)]),100.00,50.00),bj_UNIT_FACING)
        else
            call DoNothing()
        endif*/
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 3
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            if(Trig_Spawn_Hero_Func014Func001001())then
                call CreateNUnitsAtLoc(1,'e003',udg_player02,PolarProjectionBJ(GetUnitLoc(PlayerHeroes[GetConvertedPlayerId(udg_player02)]),50.00,(45.00 * I2R(GetForLoopIndexA()))),bj_UNIT_FACING)
            else
                call DoNothing()
            endif
            if(Trig_Spawn_Hero_Func014Func002001())then
                call SetUnitManaBJ(GetLastCreatedUnit(),GetRandomReal(0,GetUnitStateSwap(UNIT_STATE_MAX_MANA,GetLastCreatedUnit())))
            else
                call DoNothing()
            endif
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
        if(Trig_Spawn_Hero_Func015001())then
            set SingleplayerPlayer = GetOwningPlayer(GetLastCreatedUnit())
        else
            call DoNothing()
        endif
        call ForGroupBJ(GetUnitsOfPlayerAndTypeId(udg_player02,'n00E'),function Trig_Spawn_Hero_Func016A)
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
        else
        endif
        call TriggerSleepAction(2)
        if(Trig_Spawn_Hero_Func019C())then
            call TriggerExecute(udg_trigger109)
        else
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger79 = CreateTrigger()
        call TriggerAddAction(udg_trigger79,function Trig_Spawn_Hero_Actions)
    endfunction


endlibrary
