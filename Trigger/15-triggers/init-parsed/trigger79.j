library trigger79 initializer init requires RandomShit

    function Trig_Spawn_Hero_Func005Func001002001001002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
    endfunction


    function Trig_Spawn_Hero_Func016A takes nothing returns nothing
        call DeleteUnit(GetEnumUnit())
    endfunction


    function Trig_Spawn_Hero_Actions takes nothing returns nothing
        call ForceAddPlayerSimple(udg_player02,udg_force01)
        set udg_booleans03[GetConvertedPlayerId(udg_player02)]= true
        set udg_integer07 =(udg_integer07 + 1)
    
        if(Trig_Spawn_Hero_Func005C())then
            call CreateNUnitsAtLoc(1,GetUnitTypeId(GetTriggerUnit()),GetTriggerPlayer(),GetRectCenter(udg_rects01[GetConvertedPlayerId(GetTriggerPlayer())]),bj_UNIT_FACING)
            call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(GetTriggerPlayer())+(" |cffffcc00has selected " +(GetUnitName(GetLastCreatedUnit())+ "!")))))
            call AdjustPlayerStateBJ(600,udg_player02,PLAYER_STATE_RESOURCE_GOLD)
            call ResourseRefresh( udg_player02   )
    
        else
            call CreateNUnitsAtLoc(1,GetUnitTypeId(GroupPickRandomUnit(GetUnitsOfPlayerMatching(Player(8),Condition(function Trig_Spawn_Hero_Func005Func001002001001002)))),udg_player02,GetRectCenter(udg_rects01[GetConvertedPlayerId(udg_player02)]),bj_UNIT_FACING)
            call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(udg_player02)+(" |cffffcc00has randomed " +(GetUnitName(GetLastCreatedUnit())+ "! (+300 bonus gold)")))))
            call AdjustPlayerStateBJ(900,udg_player02,PLAYER_STATE_RESOURCE_GOLD)
            call ResourseRefresh( udg_player02   )
        endif
    
    
    
                    
    
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
        set udg_units01[GetConvertedPlayerId(udg_player02)]= GetLastCreatedUnit()
        call UnitAddItemByIdSwapped('ankh',GetLastCreatedUnit())
        call UnitAddItemByIdSwapped('pghe',GetLastCreatedUnit())
        call UnitAddItemByIdSwapped('I04R',GetLastCreatedUnit())
        call ResetToGameCameraForPlayer(udg_player02,0)
        call PanCameraToTimedLocForPlayer(udg_player02,GetRectCenter(udg_rects01[GetConvertedPlayerId(udg_player02)]),0.00)
        call SelectUnitForPlayerSingle(GetLastCreatedUnit(),udg_player02)
        /*if(Trig_Spawn_Hero_Func013001())then
            call CreateNUnitsAtLoc(1,'e001',udg_player02,OffsetLocation(GetUnitLoc(udg_units01[GetConvertedPlayerId(udg_player02)]),100.00,50.00),bj_UNIT_FACING)
        else
            call DoNothing()
        endif*/
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 3
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            if(Trig_Spawn_Hero_Func014Func001001())then
                call CreateNUnitsAtLoc(1,'e003',udg_player02,PolarProjectionBJ(GetUnitLoc(udg_units01[GetConvertedPlayerId(udg_player02)]),50.00,(45.00 * I2R(GetForLoopIndexA()))),bj_UNIT_FACING)
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
            set udg_player01 = GetOwningPlayer(GetLastCreatedUnit())
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
