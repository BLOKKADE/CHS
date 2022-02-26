library HeroLevel initializer init requires HeroLvlTable
    globals
        integer array LastLvlHero
        integer array BRL_BONUS 
        boolean array Bonus25l
        boolean array Bonus50l
        boolean array Bonus75l
        boolean array Bonus100l
        boolean array Bonus125l
        boolean array Bonus150l
        boolean array Bonus175l
        boolean array Bonus200l
    endglobals

    function LetinantBonus takes unit UnitHero returns nothing
        local integer RandomI
        
        set RandomI = GetRandomInt(1,3)
        if RandomI == 1 then
            call SetHeroStr(UnitHero,GetHeroStr(UnitHero,false)+ 8,false) 
            call UpdateBonus(UnitHero, 0, 8)
        elseif RandomI == 2 then
            call SetHeroAgi(UnitHero,GetHeroAgi(UnitHero,false)+ 8,false)  
            call UpdateBonus(UnitHero, 1, 8) 
        elseif RandomI == 3 then    
            call SetHeroInt(UnitHero,GetHeroInt(UnitHero,false)+ 8,false) 
            call UpdateBonus(UnitHero, 2, 8)  
        endif
        set RandomI = GetRandomInt(1,3)
        if RandomI == 1 then
            call SetHeroStr(UnitHero,GetHeroStr(UnitHero,false)+ 8,false) 
            call UpdateBonus(UnitHero, 0, 8)
        elseif RandomI == 2 then
            call SetHeroAgi(UnitHero,GetHeroAgi(UnitHero,false)+ 8,false)   
            call UpdateBonus(UnitHero, 1, 8)
        elseif RandomI == 3 then    
            call SetHeroInt(UnitHero,GetHeroInt(UnitHero,false)+ 8,false)   
            call UpdateBonus(UnitHero, 2, 8)
        endif

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


    function Trig_HeroLvl_Actions takes nothing returns nothing
        local integer RandomI
        local unit UnitHero = GetTriggerUnit()
        local integer TypeHero = GetUnitTypeId(UnitHero)
        local integer I_l = GetHeroLevel(UnitHero)- 1
        local player Pl = GetOwningPlayer(UnitHero)
        local integer Pid = GetPlayerId(Pl)
        local integer RI = I_l - LastLvlHero[Pid]
        local boolean Economic = GetUnitAbilityLevel(UnitHero,PILLAGE_ABILITY_ID) == 0 and GetUnitAbilityLevel(UnitHero, MIDAS_TOUCH_ABILITY_ID) == 0
        local integer i = 0
        local integer hid = GetHandleId(UnitHero)

        if UnitHero == null then
            set UnitHero = null
            set Pl = null
            return
        endif

        if I_l < 250 then
            call AdjustPlayerStateBJ( (I_l + 20)*(RI), Pl, PLAYER_STATE_RESOURCE_GOLD )
            call AdjustPlayerStateBJ( 8 *(RI), Pl, PLAYER_STATE_RESOURCE_LUMBER)
            call DisplayTimedTextToPlayer(Pl, 0, 0, 1, "|cffc300ffLevel " + I2S(I_l + 1) + "|r: |cffffcc00+" + I2S((I_l + 2)*(RI)) + " gold|r and |cff1eff00+" + I2S(4 *(RI)) + " lumber|r")
        endif

        if ModuloInteger(I_l + 1, 25) == 0 then
            call AdjustPlayerStateBJ( I_l + 1, Pl, PLAYER_STATE_RESOURCE_LUMBER) 
            call DisplayTimedTextToPlayer(Pl, 0, 0, 10, "|cff1eff00+" + I2S(I_l + 1) + " bonus lumber|r for reaching |cffbda546level " + I2S(I_l + 1) + "!|r")
        endif

        /*
        if (Bonus25l[Pid])==false and I_l >= 25 then
            set Bonus25l[Pid] = true
            call AdjustPlayerStateBJ( 25, Pl, PLAYER_STATE_RESOURCE_LUMBER) 
        endif
        if (Bonus50l[Pid])==false and I_l >= 50 then
            set Bonus50l[Pid] = true
            call AdjustPlayerStateBJ( 50, Pl, PLAYER_STATE_RESOURCE_LUMBER)
        endif
        if (Bonus75l[Pid])==false and I_l >= 75 then
            set Bonus75l[Pid] = true
            call AdjustPlayerStateBJ( 75, Pl, PLAYER_STATE_RESOURCE_LUMBER)
        endif
        if (Bonus100l[Pid])==false and I_l >= 100 then
            set Bonus100l[Pid] = true
            call AdjustPlayerStateBJ( 125, Pl, PLAYER_STATE_RESOURCE_LUMBER)
        endif
        if (Bonus125l[Pid])==false and I_l >= 125 then
            set Bonus125l[Pid] = true
            call AdjustPlayerStateBJ( 150, Pl, PLAYER_STATE_RESOURCE_LUMBER)
        endif
        if (Bonus150l[Pid])==false and I_l >= 150 then
            set Bonus150l[Pid] = true
            call AdjustPlayerStateBJ( 175, Pl, PLAYER_STATE_RESOURCE_LUMBER)
        endif
        if (Bonus175l[Pid])==false and I_l >= 175 then
            set Bonus175l[Pid] = true
            call AdjustPlayerStateBJ( 200, Pl, PLAYER_STATE_RESOURCE_LUMBER)
        endif
        if (Bonus200l[Pid])==false and I_l >= 200 then
            set Bonus200l[Pid] = true
            call AdjustPlayerStateBJ( 300, Pl, PLAYER_STATE_RESOURCE_LUMBER)
        endif
        */
        call ResourseRefresh(Pl) 

        call SetHeroStr(UnitHero, GetHeroStr(UnitHero, false) + R2I(GetStrengthLevelBonus(UnitHero)), true)
        call SetHeroAgi(UnitHero, GetHeroAgi(UnitHero, false) + R2I(GetAgilityLevelBonus(UnitHero)), true)
        call SetHeroInt(UnitHero, GetHeroInt(UnitHero, false) + R2I(GetIntelligenceLevelBonus(UnitHero)), true)
        
        if TypeHero == LIEUTENANT_UNIT_ID then //Letinant    

            loop
                exitwhen LastLvlHero[Pid] ==  I_l
                call LetinantBonus(UnitHero)
                set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
            endloop
        
        elseif TypeHero == ABOMINATION_UNIT_ID then

            call SetBonus(UnitHero, 0, 40 * (I_l + 1))
            call SetUnitAbilityLevel(UnitHero,'A08L',2)
            call BlzSetAbilityRealLevelField(BlzGetUnitAbility(UnitHero,'A08L'), ABILITY_RLF_DAMAGE_PER_INTERVAL, 0, 40 * (I_l + 1))
            call SetUnitAbilityLevel(UnitHero,'A08L',1)
            call SetPlayerAbilityAvailable(Player(Pid), 'A08L', false)
            call SetPlayerAbilityAvailable(Player(Pid), 'A08L', true)
            set LastLvlHero[Pid] = I_l
                
        elseif TypeHero == DRUID_OF_THE_CLAY_UNIT_ID then
            call SetBonus(UnitHero, 0, 1 * (I_l + 1))
        elseif TypeHero == MAULER_UNIT_ID then  
        
            if ModuloInteger(I_l + 1, 8) == 0 then
                call UpdateBonus(UnitHero, 0, 1)
                call DisplayTimedTextToPlayer(GetOwningPlayer(UnitHero), 0, 0, 10,(ClassAbil[8] + " |cffffcc00bonus acquired"))
            endif

        elseif TypeHero == BLOOD_MAGE_UNIT_ID then  
    
            loop
                exitwhen LastLvlHero[Pid] ==  I_l     
                call UpdateBonus(UnitHero, 0, 250)
                call BlzSetUnitMaxMana(UnitHero,  BlzGetUnitMaxMana(UnitHero) + 250)
                
                set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
            endloop  
    
        elseif TypeHero == 'H004' then  
            loop
                exitwhen LastLvlHero[Pid] ==  I_l
                call AddUnitPhysPow(UnitHero, 3)
                set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
            endloop
            call SetBonus(UnitHero, 0, 3 * (I_l + 1))
        
        elseif TypeHero == NAHA_SIREN_UNIT_ID then     
            loop
                exitwhen LastLvlHero[Pid] ==  I_l     
                set i = GetRandomInt(1,11)
                call SetHeroInt(UnitHero, GetHeroInt(UnitHero,false) + i ,false)
                call UpdateBonus(UnitHero, 0, i)
                if GetHeroStr(UnitHero,false) == 0 then
                    set i = GetRandomInt(1,11)
                    call SetHeroInt(UnitHero, GetHeroInt(UnitHero,false) + i ,false)
                    call UpdateBonus(UnitHero, 0, i)
                endif
                if GetHeroAgi(UnitHero,false) == 0 then
                    set i = GetRandomInt(1,11)
                    call SetHeroInt(UnitHero, GetHeroInt(UnitHero,false) + i ,false)
                    call UpdateBonus(UnitHero, 0, i)
                endif  
                set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
            endloop  
            
        elseif TypeHero == AVATAR_SPIRIT_UNIT_ID then   
                
        elseif TypeHero == DEMON_HUNTER_UNIT_ID then 
            call SetBonus(UnitHero, 0, (I_l + 1) * 20)
        elseif TypeHero == DEADLORD_UNIT_ID then   
            call SetBonus(UnitHero, 0, (I_l + 1) * 0.5)
        elseif TypeHero == PYROMANCER_UNIT_ID then   
        
            loop
                exitwhen LastLvlHero[Pid] ==  I_l  
                    
                //call BlzSetUnitBaseDamage(UnitHero, BlzGetUnitBaseDamage(UnitHero,0) + 15 ,0)          
                call BlzSetUnitDiceSides(UnitHero, BlzGetUnitDiceSides(UnitHero,0) + 35 ,0)  
                call UpdateBonus(UnitHero, 0, 35)
                set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
            endloop      
            call SetBonus(UnitHero, 1, (I_l + 1) * 0.5)
            call SetBonus(UnitHero, 2, (I_l + 1) * 0.1)
            call SetBonus(UnitHero, 3, 149 + (I_l + 1))
        elseif TypeHero == TAUREN_UNIT_ID then                   
            call SetBonus(UnitHero, 0, 5 + (0.25 * (I_l + 1)))
            call SetBonus(UnitHero, 1, 5 + (0.05 * (I_l + 1)))
        elseif TypeHero == MYSTIC_UNIT_ID then  
        
            loop
                exitwhen LastLvlHero[Pid] ==  I_l
                set SummonDamage[Pid] = SummonDamage[Pid] + 2
                call UpdateBonus(UnitHero, 0, 40)
                set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
            endloop   
            call SetBonus(UnitHero, 1, 3 * (I_l + 1))
        elseif TypeHero == PIT_LORD_UNIT_ID then          
            call SetBonus(UnitHero, 0, (I_l + 1) * 0.5)
        elseif TypeHero == THUNDER_WITCH_UNIT_ID then      
            loop
                exitwhen LastLvlHero[Pid] ==  I_l or LastLvlHero[Pid] == 0
                
                if ModuloInteger(LastLvlHero[Pid] + 2, 30) == 0 then
                    set ThunderBoltTargets[hid] = ThunderBoltTargets[hid] + 1
                endif
    
                set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
            endloop
            call SetBonus(UnitHero, 0, (I_l + 1) * 30)
            call SetBonus(UnitHero, 1, ThunderBoltTargets[hid] + 1)
        elseif TypeHero == 'U000' then       
            call SetBonus(UnitHero, 1, 10 + ((I_l + 1)))
            call SetBonus(UnitHero, 2, 6 + (0.01 * (I_l + 1)))
        elseif TypeHero == BLADE_MASTER_UNIT_ID then          
            
            loop
                exitwhen LastLvlHero[Pid] ==  I_l or LastLvlHero[Pid] == 0
                
                if ModuloInteger(LastLvlHero[Pid] + 2, 20) == 0 and BladestormAttackLimit.integer[hid] > 1 then
                    set BladestormAttackLimit[hid] = BladestormAttackLimit[hid] - 1
                endif
    
                set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
            endloop
            call SetBonus(UnitHero, 0, 20 * (I_l + 1))
            call SetBonus(UnitHero, 1, 297 + 3 * (I_l + 1))
            call SetBonus(UnitHero, 2, BladestormAttackLimit[hid])
        elseif TypeHero == ORC_CHAMPION_UNIT_ID then   
            loop
                exitwhen LastLvlHero[Pid] ==  I_l  
                    
                call BlzSetUnitRealField(UnitHero,ConvertUnitRealField('uhpr'),BlzGetUnitRealField(UnitHero,ConvertUnitRealField('uhpr')) + 6)
                call BlzSetUnitArmor(UnitHero, BlzGetUnitArmor(UnitHero) + 3 )
                call UpdateBonus(UnitHero, 0, 3)   
                call UpdateBonus(UnitHero, 1, 6)
                set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
            endloop      
            call SetBonus(UnitHero, 2 , 20 + (I_l + 1)) 
        elseif TypeHero == TROLL_HEADHUNTER_UNIT_ID then   
            call SetBonus(UnitHero, 0, 40 + 1.5 * (I_l + 1))
        elseif TypeHero == 'N00L' then  

            loop
                exitwhen LastLvlHero[Pid] ==  I_l  
                    
                call TinkerTimer(UnitHero, (LastLvlHero[Pid]+ 1)* 55)
                call UpdateBonus(UnitHero, 0, (LastLvlHero[Pid]+ 1)* 55)
                    
                set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
            endloop  
            
                
        elseif TypeHero == ARENA_MASTER_UNIT_ID then  
        
            loop
                exitwhen LastLvlHero[Pid] ==  I_l  
                    
                    
                set Glory[Pid] = Glory[Pid] + 200
                call UpdateBonus(UnitHero, 0, 200)   
                        
                set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
            endloop          
                
            call ResourseRefresh(GetOwningPlayer(UnitHero)) 
        elseif TypeHero == BEAST_MASTER_UNIT_ID then              
                
            call SetBonus(UnitHero, 0, R2I(I_l / 3))   
            /*
            loop
                exitwhen BRL_BONUS [Pid] ==  I_l / 2
                    
                call MasterBonus(UnitHero)      
        
                set BRL_BONUS[Pid] = BRL_BONUS[Pid] + 1
            endloop   
            */
        
        elseif TypeHero == FALLEN_RANGER_UNIT_ID then                          
        
            call SetUnitAbilityLevel(UnitHero,'A031',2)
            call BlzSetAbilityRealLevelField( BlzGetUnitAbility(UnitHero,'A031'),ABILITY_RLF_ARMOR_BONUS_HAD1,0, -(I_l + 1)* 3 )         
            call SetUnitAbilityLevel(UnitHero,'A031',1)
            call SetBonus(UnitHero, 0, (I_l + 1)* 3)   
                
            set LastLvlHero[Pid]  = I_l 
    
        elseif TypeHero == 'N00R' then         
            call SetBonus(UnitHero, 0, 49.5 + ((I_l + 1) * 0.5))   
        elseif TypeHero == SKELETON_BRUTE_UNIT_ID then   
            call SetBonus(UnitHero, 0, 1 + ((I_l + 1) * 0.01))   
            call SetBonus(UnitHero, 1, 2 + ((I_l + 1) * 0.05))   
            call SetBonus(UnitHero, 2, 20 + ((I_l + 1) * 30))   
        elseif TypeHero == SORCERER_UNIT_ID then   
            call SetBonus(UnitHero, 0, (I_l + 1) * 50)   
        
        elseif TypeHero == URSA_WARRIOR_UNIT_ID then     
            
            loop
                exitwhen LastLvlHero[Pid] ==  I_l  
                
                call BlzSetUnitBaseDamage(UnitHero, BlzGetUnitBaseDamage(UnitHero,0) + 10 ,0)  
                call UpdateBonus(UnitHero, 0, 10)           
    
                set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
            endloop          
                
        elseif TypeHero == WAR_GOLEM_UNIT_ID then             
            call SetBonus(UnitHero, 0, 49 + ((I_l + 1) * 1))
        elseif TypeHero == WITCH_DOCTOR_UNIT_ID then      
            //TODO?
            loop
                exitwhen LastLvlHero[Pid] == I_l or LastLvlHero[Pid] == 0
                if ModuloInteger(LastLvlHero[Pid] +2, 20) == 0 then
                    call AddHeroMaxAbsoluteAbility(UnitHero)
                    call UpdateBonus(UnitHero, 0, 1)
                endif
    
                if ModuloInteger(LastLvlHero[Pid] + 2, 25) == 0 then
                    loop
                        set i = i + 1
                        exitwhen i > 15
    
                        if WitchDoctorHasAbsolute(UnitHero, i) then
                            call AddWitchDoctorAbsoluteLevel(UnitHero, i)
                        endif                
                    endloop
                endif
    
                set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
            endloop     

            
            
        elseif TypeHero == RANGER_UNIT_ID then       
            
            call SetBonus(UnitHero, 0, (I_l + 1) * 5)
            
        elseif TypeHero == DARK_HUNTER_UNIT_ID then         
            call SetBonus(UnitHero, 0, (I2R(I_l + 1)* 50))
            set LastLvlHero[Pid] = I_l     
                            
        elseif TypeHero == DOOM_GUARD_UNIT_ID then     
        
        
        
            
            call SetUnitAbilityLevel(UnitHero,'A038',2)
            call BlzSetAbilityRealLevelField( BlzGetUnitAbility(UnitHero,'A038'),ABILITY_RLF_INITIAL_DAMAGE_PXF1,0, I2R(I_l + 1)* 50 )
            call SetBonus(UnitHero, 0, I2R(I_l + 1)* 50)
            call BlzSetAbilityRealLevelField( BlzGetUnitAbility(UnitHero,'A038'),ABILITY_RLF_DAMAGE_PER_SECOND_PXF2,0, I2R(I_l + 1)* 10 )
            call SetBonus(UnitHero, 1, I2R(I_l + 1)* 10)
            call SetUnitAbilityLevel(UnitHero,'A038',1)
            
            set LastLvlHero[Pid] = I_l   
                
        elseif TypeHero == COLD_KNIGHT_UNIT_ID then  
                                        
                                        
            call SetUnitAbilityLevel(UnitHero,'A03H',2)
            call BlzSetAbilityRealLevelField( BlzGetUnitAbility(UnitHero,'A03H'),ABILITY_RLF_ATTACK_SPEED_INCREASE_PERCENT_OAE2,0, -(I_l + 1)* 0.06)
            call BlzSetAbilityRealLevelField( BlzGetUnitAbility(UnitHero,'A03H'),ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_OAE1,0, RMaxBJ(-(I_l + 1)* 0.005, - 0.95))
            call SetBonus(UnitHero, 0, ((I_l + 1)* 0.06)* 100 )
            call SetBonus(UnitHero, 1, RMinBJ((I_l + 1)* 0.005, 0.95)* 100 )
            call SetUnitAbilityLevel(UnitHero,'A03H',1)
                
            set LastLvlHero[Pid]  = I_l  

        elseif TypeHero == TIME_WARRIOR_UNIT_ID then         
        
            loop
                exitwhen LastLvlHero[Pid] ==  I_l  
                    
                call BlzSetUnitMaxMana(UnitHero,  BlzGetUnitMaxMana(UnitHero) + 100)
                call UpdateBonus(UnitHero, 1, 100)   
                call BlzSetUnitRealField(UnitHero,ConvertUnitRealField('umpr'),BlzGetUnitRealField(UnitHero,ConvertUnitRealField('umpr')) + 1)
                call UpdateBonus(UnitHero, 2, 1)   

                set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
            endloop 
            call SetBonus(UnitHero, 0, 20 + (0.1 * (I_l + 1)))
        elseif TypeHero == ROCK_GOLEM_UNIT_ID then
        
            call SetBonus(UnitHero, 0, 49 + (I_l + 1))
            call SetBonus(UnitHero, 1, (I_l + 1) * 0.5)
            
        elseif TypeHero == LICH_UNIT_ID then
            call SetBonus(UnitHero, 0, 100 + (I_l + 1))
        elseif TypeHero == GNOME_MASTER_UNIT_ID then
            call SetBonus(UnitHero, 0, (I_l + 1) * 55)
            call SetBonus(UnitHero, 1, (I_l + 1) * 0.04)
            call SetBonus(UnitHero, 2, (I_l + 1) * 0.08)
        elseif TypeHero == 'N02P' then
            call SetBonus(UnitHero, 0, 20 + ((I_l + 1) * 4))
            call SetBonus(UnitHero, 1, 21 + ((I_l + 1) * 3))
        elseif TypeHero == CENTAUR_ARCHER_UNIT_ID then
            call SetBonus(UnitHero, 0, (I_l + 1) * 5)
        elseif TypeHero == OGRE_WARRIOR_UNIT_ID then
            call SetBonus(UnitHero, 0, (I_l + 1) * 60)
        elseif TypeHero == OGRE_MAGE_UNIT_ID then
            call SetBonus(UnitHero, 0, 15 + ((I_l + 1) * 2))
        elseif TypeHero == TROLL_BERSERKER_UNIT_ID then
            call SetBonus(UnitHero, 0, (I_l + 1) * 1)
        elseif TypeHero == YETI_UNIT_ID then
            call SetBonus(UnitHero, 0, (I_l + 1) * 20)
            call SetBonus(UnitHero, 1, 50 + ((I_l + 1) * 2))
        elseif TypeHero == 'H01F' then
            call SetBonus(UnitHero, 0, ((I_l + 1) / 10) + 1 )
        elseif TypeHero == GHOUL_UNIT_ID then
            call SetBonus(UnitHero, 0, (2.5 + (0.025 * (I_l + 1))))
        elseif TypeHero == BANSHEE_UNIT_ID then

        elseif TypeHero == GRUNT_UNIT_ID then
            call SetBonus(UnitHero, 0, (I_l + 1) * 20)
            call SetBonus(UnitHero, 1, (I_l + 1) * 20)
            call SetBonus(UnitHero, 2, 10 + ((I_l + 1) * 0.1))
        elseif TypeHero == SEER_UNIT_ID then

        elseif TypeHero == SATYR_TRICKSTER_UNIT_ID then
        
            loop
                exitwhen LastLvlHero[Pid] ==  I_l    
                call AddUnitEvasion(UnitHero, 0.5)
                call UpdateBonus(UnitHero, 0, 0.5)
                set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
            endloop 
            call SetBonus(UnitHero, 1, 98 + ((I_l + 1) * 2))
        elseif TypeHero == MEDIVH_UNIT_ID then
        
            loop
                exitwhen LastLvlHero[Pid] ==  I_l    
                call AddUnitMagicDmg(UnitHero,2)
                call UpdateBonus(UnitHero, 0, 2)   
                set LastLvlHero[Pid] = LastLvlHero[Pid] + 1
            endloop 
            
        endif
        
        
        call UpdateAbilityDesc(UnitHero, Pl, GetHeroLevel(UnitHero))
        set LastLvlHero[Pid]  = I_l  
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trg, EVENT_PLAYER_HERO_LEVEL )
        call TriggerAddAction( trg, function Trig_HeroLvl_Actions )
        set trg = null
    endfunction
endlibrary