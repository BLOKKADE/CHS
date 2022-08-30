library heroLevel initializer init requires HeroLvlTable
    globals
        integer array LastLvlHero
    endglobals

    function LeutenantBonus takes unit u, integer levels returns nothing
        local integer RandomI
        local integer i = 0

        loop
            set RandomI = GetRandomInt(1,3)
            if RandomI == 1 then
                call SetHeroStr(u,GetHeroStr(u,false)+ 8,false) 
                call UpdateBonus(u, 0, 8)
            elseif RandomI == 2 then
                call SetHeroAgi(u,GetHeroAgi(u,false)+ 8,false)  
                call UpdateBonus(u, 1, 8) 
            elseif RandomI == 3 then    
                call SetHeroInt(u,GetHeroInt(u,false)+ 8,false) 
                call UpdateBonus(u, 2, 8)  
            endif
            set RandomI = GetRandomInt(1,3)
            if RandomI == 1 then
                call SetHeroStr(u,GetHeroStr(u,false)+ 8,false) 
                call UpdateBonus(u, 0, 8)
            elseif RandomI == 2 then
                call SetHeroAgi(u,GetHeroAgi(u,false)+ 8,false)   
                call UpdateBonus(u, 1, 8)
            elseif RandomI == 3 then    
                call SetHeroInt(u,GetHeroInt(u,false)+ 8,false)   
                call UpdateBonus(u, 2, 8)
            endif
            
            set i = i + 1
            exitwhen i >= levels
        endloop
    endfunction

    function WitchDoctorLevelup takes unit u, integer prevLevel, integer heroLevel returns nothing
        local integer i = prevLevel
        local integer j = 0

        loop
            if ModuloInteger(i, 25) == 0 then
                call AddHeroMaxAbsoluteAbility(u)
                call UpdateBonus(u, 0, 1)
            endif

            if ModuloInteger(i, 30) == 0 then
                set j = 0
                loop
                    set j = j + 1
                    exitwhen j > 15

                    if WitchDoctorHasAbsolute(u, j) then
                        call AddWitchDoctorAbsoluteLevel(u, j)
                    endif                
                endloop
            endif

            set i = i + 1
            exitwhen i >= heroLevel
        endloop
    endfunction

    struct TinkerData
        unit u
        integer xp
    endstruct

    function TinkerBonus takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local TinkerData td = GetTimerData(t)
        call AddHeroXP(td.u, td.xp, true)
        set td.u = null
        call ReleaseTimer(t)
        call td.destroy()
        set t = null
    endfunction

    function TinkerTimer takes unit u, integer xp returns nothing
        local timer t = NewTimer()
        local TinkerData td = TinkerData.create()
        set td.u = u
        set td.xp = xp
        call SetTimerData(t, td)
        call TimerStart(t, 0.1, false, function TinkerBonus)
        set t = null
    endfunction

    function UpdateAbilityDesc takes unit h, player p, integer heroLvl returns nothing
        local integer abilLvl
        local integer abilId
        local string s
        
        set abilId = MARTIAL_RETRIBUTION_ABILITY_ID
        set abilLvl = GetUnitAbilityLevel(h, abilId)
        if abilLvl > 0 then
            set s = GetAbilityDescription(abilId, abilLvl - 1)
            set s = UpdateAbilityDescription(s, p, abilId, ",s00,", R2I(SpellData[GetHandleId(h)].real[3]), abilLvl)
            call UpdateAbilityDescription(s, p, abilId, ",s01,", R2I((300 * abilLvl) * (1 + 0.02 * heroLvl)), abilLvl)
        endif
    endfunction

    function LevelBonusLoop takes unit u, integer levelsGained returns nothing
        local integer i = 0
        loop

            set i = i + 1
            exitwhen i >= levelsGained
        endloop
    endfunction

    function Trig_HeroLvl_Actions takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local integer uid = GetUnitTypeId(u)
        local integer heroLevel = GetHeroLevel(u)
        local player p = GetOwningPlayer(u)
        local integer pid = GetPlayerId(p)
        local integer prevLevel = IMaxBJ(LastLvlHero[pid], 1)
        local integer levelsGained = heroLevel - prevLevel
        local integer hid = GetHandleId(u)
        local integer i = 0

        if u == null then
            set u = null
            set p = null
            return
        endif

        if heroLevel < 250 then
            call AdjustPlayerStateBJ( (heroLevel + 20)*(levelsGained), p, PLAYER_STATE_RESOURCE_GOLD )
            call AdjustPlayerStateBJ( 8 *(levelsGained), p, PLAYER_STATE_RESOURCE_LUMBER)
            call DisplayTimedTextToPlayer(p, 0, 0, 1, "|cffc300ffLevel " + I2S(heroLevel) + "|r: |cffffcc00+" + I2S( (heroLevel + 20) * levelsGained) + " gold|r and |cff1eff00+" + I2S(8 * levelsGained) + " lumber|r")
        endif

        if ModuloInteger(heroLevel, 25) == 0 then
            call AdjustPlayerStateBJ( heroLevel, p, PLAYER_STATE_RESOURCE_LUMBER) 
            call DisplayTimedTextToPlayer(p, 0, 0, 10, "|cff1eff00+" + I2S(heroLevel) + " bonus lumber|r for reaching |cffbda546level " + I2S(heroLevel) + "!|r")
        endif

        call ResourseRefresh(p) 

        call SetHeroStr(u, GetHeroStr(u, false) + R2I(levelsGained * GetStrengthLevelBonus(u)), true)
        call SetHeroAgi(u, GetHeroAgi(u, false) + R2I(levelsGained * GetAgilityLevelBonus(u)), true)
        call SetHeroInt(u, GetHeroInt(u, false) + R2I(levelsGained * GetIntelligenceLevelBonus(u)), true)
        
        if uid == LIEUTENANT_UNIT_ID then //Letinant    
            call LeutenantBonus(u, levelsGained)
        elseif uid == ABOMINATION_UNIT_ID then
            call SetBonus(u, 0, 40 * (heroLevel))
        elseif uid == DRUID_OF_THE_CLAY_UNIT_ID then
            call SetBonus(u, 0, 1 * heroLevel)
        elseif uid == MAULER_UNIT_ID then  
            set i = prevLevel + 1
            loop
                if ModuloInteger(i, 10) == 0 then
                    call UpdateBonus(u, 0, 1)
                    call DisplayTimedTextToPlayer(GetOwningPlayer(u), 0, 0, 10,(ClassAbil[8] + " |cffffcc00bonus acquired"))
                endif

                set i = i + 1
                exitwhen i >= heroLevel + 1
            endloop

        elseif uid == BLOOD_MAGE_UNIT_ID then  
            call SetBonus(u, 0, (levelsGained * 7))
            call SetHeroInt(u,GetHeroInt(u,false)+ (7 * levelsGained),false) 
            //call BlzSetUnitMaxMana(u,  BlzGetUnitMaxMana(u) + (levelsGained * 250))
            
        elseif uid == MORTAR_TEAM_UNIT_ID then  
            call AddUnitPhysPow(u,levelsGained * 3)
            call SetBonus(u, 0, 3 * heroLevel)
        elseif uid == NAGA_SIREN_UNIT_ID then  
            call SetBonus(u, 0, 5 + (heroLevel * 0.05))   
            set i = prevLevel + 1
            loop
                if ModuloInteger(i, 50) == 0 then
                    set NagaSirenBonus[hid] = NagaSirenBonus[hid] + 1
                    call UpdateBonus(u, 1, 1)
                endif

                set i = i + 1
                exitwhen i >= heroLevel + 1
            endloop
        elseif uid == DEMON_HUNTER_UNIT_ID then 
            call SetBonus(u, 0, heroLevel * 20)
        elseif uid == DEADLORD_UNIT_ID then   
            call SetBonus(u, 0, heroLevel * 0.5)
        elseif uid == PYROMANCER_UNIT_ID then   
            call BlzSetUnitDiceSides(u, BlzGetUnitDiceSides(u,0) + (35 * levelsGained),0)  
            call UpdateBonus(u, 0, 35 * levelsGained)

            call SetBonus(u, 1, heroLevel * 0.5)
            call SetBonus(u, 2, heroLevel * 0.1)
            call SetBonus(u, 3, 149 + heroLevel)
        elseif uid == TAUREN_UNIT_ID then                   
            call SetBonus(u, 0, 0.1 + (0.0025 * heroLevel))
            call SetBonus(u, 1, 5 + (0.05 * heroLevel))
            call UpdateSpiritTaurenRuneBonus(u)
        elseif uid == MYSTIC_UNIT_ID then  
            set SummonDamage[pid] = SummonDamage[pid] + (2 * levelsGained)
            call UpdateBonus(u, 0, 40 * levelsGained)
            call SetBonus(u, 1, 3 * heroLevel)
        elseif uid == PIT_LORD_UNIT_ID then          
            call SetBonus(u, 0, heroLevel * 0.5)
        elseif uid == THUNDER_WITCH_UNIT_ID then      
            set i = prevLevel + 1
            loop
                if ModuloInteger(i, 30) == 0 then
                    set ThunderBoltTargets[hid] = ThunderBoltTargets[hid] + 1
                endif
    
                set i = i + 1
                exitwhen i >= heroLevel + 1
            endloop

            call SetBonus(u, 0, heroLevel * 30)
            call SetBonus(u, 1, ThunderBoltTargets[hid] + 1)
        elseif uid == WOLF_RIDER_UNIT_ID then       
            call SetBonus(u, 1, 10 + heroLevel)
            call SetBonus(u, 2, 6 + (0.01 * heroLevel))
        elseif uid == BLADE_MASTER_UNIT_ID then          
            set i = prevLevel + 1
            loop
                if ModuloInteger(i, 20) == 0 and BladestormAttackLimit.integer[hid] > 1 then
                    set BladestormAttackLimit[hid] = BladestormAttackLimit[hid] - 1
                endif
    
                set i = i + 1
                exitwhen i >= heroLevel + 1
            endloop

            call SetBonus(u, 0, 20 * heroLevel)
            call SetBonus(u, 1, 297 + 3 * heroLevel)
            call SetBonus(u, 2, BladestormAttackLimit[hid])
        elseif uid == ORC_CHAMPION_UNIT_ID then   
            call AddUnitBonusReal(u, BONUS_HEALTH_REGEN, 6 * levelsGained)
            call BlzSetUnitArmor(u, BlzGetUnitArmor(u) + (3 * levelsGained))
            call UpdateBonus(u, 0, 3 * levelsGained)   
            call UpdateBonus(u, 1, 6 * levelsGained)
            call SetBonus(u, 2 , 20 + heroLevel) 
        elseif uid == TROLL_HEADHUNTER_UNIT_ID then   
            call SetBonus(u, 0, 40 + 1.5 * heroLevel)
        elseif uid == TINKER_UNIT_ID then  
            set i = prevLevel + 1
            loop
                call TinkerTimer(u, (i)* 55)
                call UpdateBonus(u, 0, (i)* 55)

                set i = i + 1
                exitwhen i >= heroLevel + 1
            endloop
        elseif uid == ARENA_MASTER_UNIT_ID then        
            set Glory[pid] = Glory[pid] + (200 * levelsGained)
            call UpdateBonus(u, 0, 200 * levelsGained)   
            call ResourseRefresh(GetOwningPlayer(u)) 
        elseif uid == BEAST_MASTER_UNIT_ID then                  
            call SetBonus(u, 0, R2I(heroLevel / 3))   
        elseif uid == FALLEN_RANGER_UNIT_ID then                          
            call SetUnitAbilityLevel(u,'A031',2)
            call BlzSetAbilityRealLevelField( BlzGetUnitAbility(u,'A031'),ABILITY_RLF_ARMOR_BONUS_HAD1,0, 0 - (heroLevel * 3))         
            call SetUnitAbilityLevel(u,'A031',1)
            call SetBonus(u, 0, heroLevel * 3)   
        elseif uid == HUNTRESS_UNIT_ID then         
            call SetBonus(u, 0, 24.5 + (heroLevel * 0.25))   
        elseif uid == SKELETON_BRUTE_UNIT_ID then   
            call SetBonus(u, 0, 1 + (heroLevel * 0.01))   
            call SetBonus(u, 1, 2 + (heroLevel * 0.05))   
            call SetBonus(u, 2, 50 + heroLevel)   
        elseif uid == SORCERER_UNIT_ID then   
            call SetBonus(u, 0, heroLevel * 50)   
        elseif uid == URSA_WARRIOR_UNIT_ID then     
            call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u,0) + (10 * levelsGained) ,0)  
            call UpdateBonus(u, 0, 10 * levelsGained)  
        elseif uid == WAR_GOLEM_UNIT_ID then             
            call SetBonus(u, 0, 49 + (heroLevel * 1))
        elseif uid == WITCH_DOCTOR_UNIT_ID then      
            call WitchDoctorLevelup(u, prevLevel + 1, heroLevel + 1)  
        elseif uid == RANGER_UNIT_ID then       
            call SetBonus(u, 0, heroLevel * 5)
        elseif uid == DARK_HUNTER_UNIT_ID then         
            call SetBonus(u, 0, heroLevel * 50)
            set prevLevel = heroLevel     
        elseif uid == DOOM_GUARD_UNIT_ID then     
            call SetBonus(u, 0, heroLevel * 25)
        elseif uid == COLD_KNIGHT_UNIT_ID then              
            call SetUnitAbilityLevel(u,'A03H',2)
            call BlzSetAbilityRealLevelField( BlzGetUnitAbility(u,'A03H'),ABILITY_RLF_ATTACK_SPEED_INCREASE_PERCENT_OAE2,0, 0 - heroLevel * 0.06)
            call BlzSetAbilityRealLevelField( BlzGetUnitAbility(u,'A03H'),ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_OAE1,0, RMaxBJ(0 - heroLevel * 0.005, 0 - 0.95))
            call SetBonus(u, 0, (heroLevel * 0.06) * 100 )
            call SetBonus(u, 1, RMinBJ(heroLevel * 0.005, 0.95) * 100 )
            call SetUnitAbilityLevel(u,'A03H',1)
        elseif uid == TIME_WARRIOR_UNIT_ID then         
            call BlzSetUnitMaxMana(u,  BlzGetUnitMaxMana(u) + (100 * levelsGained))
            call UpdateBonus(u, 1, (100 * levelsGained))
            call BlzSetUnitRealField(u,ConvertUnitRealField('umpr'),BlzGetUnitRealField(u,ConvertUnitRealField('umpr')) + (1 * levelsGained))
            call UpdateBonus(u, 2, 1  * levelsGained)   
            call SetBonus(u, 0, 20 + (0.1 * heroLevel))
        elseif uid == ROCK_GOLEM_UNIT_ID then
            call SetBonus(u, 0, 49 + heroLevel)
            call SetBonus(u, 1, heroLevel)
        elseif uid == LICH_UNIT_ID then
            call SetBonus(u, 0, 100 + heroLevel)
        elseif uid == GNOME_MASTER_UNIT_ID then
            call SetBonus(u, 0, heroLevel * 55)
            call SetBonus(u, 1, heroLevel * 0.04)
            call SetBonus(u, 2, heroLevel * 0.08)
        elseif uid == GREEDY_GOBLIN_UNIT_ID then
            call SetBonus(u, 0, 20 + (heroLevel * 4))
            call SetBonus(u, 1, 21 + (heroLevel * 3))
        elseif uid == CENTAUR_ARCHER_UNIT_ID then
            call SetBonus(u, 0, heroLevel * 5)
        elseif uid == OGRE_WARRIOR_UNIT_ID then
            call SetBonus(u, 0, heroLevel * 60)
        elseif uid == OGRE_MAGE_UNIT_ID then
            call SetBonus(u, 0, 15 + (heroLevel * 2))
        elseif uid == TROLL_BERSERKER_UNIT_ID then
            call SetBonus(u, 0, heroLevel * 1)
        elseif uid == YETI_UNIT_ID then
            call SetBonus(u, 0, heroLevel * 20)
            call SetBonus(u, 1, 50 + (heroLevel * 2))
        elseif uid == MURLOC_WARRIOR_UNIT_ID then
            call SetBonus(u, 0, (heroLevel / 10) + 1 )
        elseif uid == GHOUL_UNIT_ID then
            call SetBonus(u, 0, (2.5 + (0.025 * heroLevel)))
        elseif uid == BANSHEE_UNIT_ID then

        elseif uid == GRUNT_UNIT_ID then
            call SetBonus(u, 0, heroLevel * 20)
            call SetBonus(u, 1, heroLevel * 20)
            call SetBonus(u, 2, 10 + (heroLevel * 0.1))
        elseif uid == SEER_UNIT_ID then

        elseif uid == SATYR_TRICKSTER_UNIT_ID then
            call AddUnitEvasion(u, 0.5 * levelsGained)
            call UpdateBonus(u, 0, 0.5 * levelsGained)
            call SetBonus(u, 1, 98 + (heroLevel * 2))
        elseif uid == MEDIVH_UNIT_ID then
            call AddUnitMagicDmg(u,2 * levelsGained)
            call UpdateBonus(u, 0, 2 * levelsGained)   
        endif
        
        call UpdateAbilityDesc(u, p, GetHeroLevel(u))
        set LastLvlHero[pid] = heroLevel  

        set u = null
        set p = null
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trg, EVENT_PLAYER_HERO_LEVEL )
        call TriggerAddAction( trg, function Trig_HeroLvl_Actions )
        set trg = null
    endfunction
endlibrary