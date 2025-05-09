library HeroLevelup initializer init requires HeroLvlTable, Tinker, WitchDoctor, SpiritTauren, Letinant, MartialRetribution
    
    globals
        integer array LastLvlHero
    endglobals

    private function UpdateAbilityDescriptionLevelup takes unit h, player p, integer heroLvl returns nothing
        local integer abilLvl
        
        set abilLvl = GetUnitAbilityLevel(h, MARTIAL_RETRIBUTION_ABILITY_ID)
        if abilLvl > 0 then
            call UpdateMartialRetributionText(GetHandleId(h), p, abilLvl, heroLvl)
        endif

        set abilLvl = GetUnitAbilityLevel(h, ICE_FORCE_ABILITY_ID)
        if abilLvl > 0 then
            call UpdateAbilityDescriptionString(GetAbilityDescription(ICE_FORCE_ABILITY_ID, abilLvl - 1), p, GetDummySpell(DamageTarget, ICE_FORCE_ABILITY_ID), ",s01,", R2S((1 - (500. / (500. + GetHeroInt(h, true)))) * 100), abilLvl)
        endif
    endfunction

    private function HeroLevelupActions takes nothing returns nothing
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
            // This weird math is a combination of previously getting lumber and gold
            call AdjustPlayerStateBJ((8 * (levelsGained) * 30) + (heroLevel + 20) * (levelsGained), p, PLAYER_STATE_RESOURCE_GOLD)
            call DisplayTimedTextToPlayer(p, 0, 0, 1, "|cffc300ffLevel " + I2S(heroLevel) + "|r: |cffffcc00+" + I2S((8 * (levelsGained) * 30) + (heroLevel + 20) * (levelsGained)) + " gold|r")
        endif

        set i = prevLevel + 1
        loop
            if ModuloInteger(i, 25) == 0 then
            call AdjustPlayerStateBJ(i * 30, p, PLAYER_STATE_RESOURCE_GOLD) 
            call DisplayTimedTextToPlayer(p, 0, 0, 10, "|cff1eff00+" + I2S(i * 30) + " bonus gold|r for reaching |cffbda546level " + I2S(i) + "!|r")
            endif

            set i = i + 1
            exitwhen i > heroLevel
        endloop

        call ResourseRefresh(p) 

        call UpdateStatsOnLevelup(u, levelsGained)
        
        if uid == LIEUTENANT_UNIT_ID then //Letinant    
            call LetinantBonus(u, levelsGained)
        elseif uid == ABOMINATION_UNIT_ID then
            call SetBonus(u, 0, 40 * (heroLevel))
        elseif uid == DRUID_OF_THE_CLAY_UNIT_ID then
            call SetBonus(u, 0, 1 * heroLevel)
        elseif uid == MAULER_UNIT_ID then  
            set i = prevLevel + 1
            loop
                if ModuloInteger(i, 10) == 0 then
                    call UpdateBonus(u, 0, 1)
                    call DisplayTimedTextToPlayer(GetOwningPlayer(u), 0, 0, 10,(GetFullElementText(8) + " |cffffcc00bonus acquired"))
                endif

                set i = i + 1
                exitwhen i >= heroLevel + 1
            endloop

        elseif uid == BLOOD_MAGE_UNIT_ID then  
            call SetBonus(u, 0, 60 - (3 * R2I((heroLevel - ModuloInteger(heroLevel, 30)) / 30)))
            //call BlzSetUnitMaxMana(u,  BlzGetUnitMaxMana(u) + (levelsGained * 250))
            
        elseif uid == MORTAR_TEAM_UNIT_ID then  
            call AddUnitCustomState(u, BONUS_PHYSPOW, levelsGained * 1.5)
            call SetBonus(u, 0, 1.5 * heroLevel)
        elseif uid == NAGA_SIREN_UNIT_ID then  
            set NagaSirenBonus.integer[hid] = 1 + ((heroLevel - ModuloInteger(heroLevel, 50)) / 50)
            call SetBonus(u, 0, 10 + (heroLevel * 0.1))   
            call SetBonus(u, 1, NagaSirenBonus.integer[hid])
        elseif uid == DEMON_HUNTER_UNIT_ID then 
            call SetBonus(u, 0, heroLevel * 20)
        elseif uid == DEADLORD_UNIT_ID then   
            call SetBonus(u, 0, heroLevel * 0.5)
        elseif uid == PYROMANCER_UNIT_ID then   
            call BlzSetUnitDiceSides(u, BlzGetUnitDiceSides(u, 0) + (35 * levelsGained), 0)  
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
            call SetBonus(u, 1, heroLevel * 40)
            call SetBonus(u, 2, heroLevel * 20)
            call SetBonus(u, 3, 1 + ((heroLevel - ModuloInteger(heroLevel, 75)) / 75))
            call PitlordLevelup(u, heroLevel)
        elseif uid == THUNDER_WITCH_UNIT_ID then      
            set ThunderBoltTargets.integer[hid] = 1 + ((heroLevel - ModuloInteger(heroLevel, 30)) / 30)
            call SetBonus(u, 0, heroLevel * 30)
            call SetBonus(u, 1, ThunderBoltTargets[hid] + 1)
        elseif uid == SORCERER_UNIT_ID then      
            set SorcererAmount.integer[hid] = 1 + ((heroLevel - ModuloInteger(heroLevel, 35)) / 35)
            call SetBonus(u, 0, RMaxBJ(50 - heroLevel * 0.2, 15))
            call SetBonus(u, 1, SorcererAmount[hid])
        elseif uid == WOLF_RIDER_UNIT_ID then       
            call SetBonus(u, 1, 10 + heroLevel)
            call SetBonus(u, 2, 8 + (0.01 * heroLevel))
        elseif uid == BLADE_MASTER_UNIT_ID then          
            set i = prevLevel + 1
            loop
                if ModuloInteger(i, 20) == 0 and BladestormAttackLimit.integer[hid] > 1 then
                    set BladestormAttackLimit[hid] = BladestormAttackLimit[hid] - 1
                    set BladestormArmorPierceBonus[hid] = BladestormArmorPierceBonus[hid] + 2
                endif
    
                set i = i + 1
                exitwhen i >= heroLevel + 1
            endloop

            call SetBonus(u, 0, 35 * heroLevel)
            call SetBonus(u, 1, 297 + 3 * heroLevel)
            call SetBonus(u, 2, 30 + BladestormArmorPierceBonus[hid])
            call SetBonus(u, 3, BladestormAttackLimit[hid])
        elseif uid == ORC_CHAMPION_UNIT_ID then   
            call AddUnitBonusReal(u, BONUS_HEALTH_REGEN, 5 * levelsGained)
            call BlzSetUnitArmor(u, BlzGetUnitArmor(u) + (2 * levelsGained))
            call UpdateBonus(u, 0, 2 * levelsGained)   
            call UpdateBonus(u, 1, 5 * levelsGained)
            call SetBonus(u, 2 , 10 + (heroLevel * 0.5)) 
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
            call SetUnitAbilityLevel(u, 'A031', 2)
            call BlzSetAbilityRealLevelField(BlzGetUnitAbility(u, 'A031'),ABILITY_RLF_ARMOR_BONUS_HAD1, 0, 0 - (heroLevel * 3))         
            call SetUnitAbilityLevel(u, 'A031', 1)
            call SetBonus(u, 0, heroLevel * 3)   
        elseif uid == HUNTRESS_UNIT_ID then         
            call SetBonus(u, 0, 24.5 + (heroLevel * 0.5))   
        elseif uid == SKELETON_BRUTE_UNIT_ID then   
            call SetBonus(u, 0, 1 + (heroLevel * 0.01))   
            call SetBonus(u, 1, 2 + (heroLevel * 0.05))   
            call SetBonus(u, 2, 50 + heroLevel)   
        elseif uid == URSA_WARRIOR_UNIT_ID then     
            call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u, 0) + (10 * levelsGained) , 0)  
            call UpdateBonus(u, 0, 10 * levelsGained)  
        elseif uid == WAR_GOLEM_UNIT_ID then             
            call SetBonus(u, 0, 49 + (heroLevel * 1))
        elseif uid == WITCH_DOCTOR_UNIT_ID then      
            call WitchDoctorLevelup(u, prevLevel + 1, heroLevel + 1)  
        elseif uid == RANGER_UNIT_ID then       
            call SetBonus(u, 0, heroLevel * 2)
        elseif uid == DARK_HUNTER_UNIT_ID then         
            call SetBonus(u, 0, heroLevel * 50)
            set DarkHunterStun.real[hid] =  0.20 + (R2I((heroLevel - ModuloInteger(heroLevel, 8)) / 8) * 0.01)
            call SetBonus(u, 1, DarkHunterStun.real[hid])
            call SetBonus(u, 2, DarkHunterStun.real[hid] + 0.40)
            set prevLevel = heroLevel     
        elseif uid == DOOM_GUARD_UNIT_ID then     
            call SetBonus(u, 0, heroLevel * 25)
        elseif uid == COLD_KNIGHT_UNIT_ID then              
            call SetBonus(u, 0, (heroLevel * 30))
            call SetBonus(u, 1, 0.15 + (heroLevel * 0.01))
        elseif uid == TIME_WARRIOR_UNIT_ID then         
            call BlzSetUnitMaxMana(u,  BlzGetUnitMaxMana(u) + (100 * levelsGained))
            call UpdateBonus(u, 1, (100 * levelsGained))
            call BlzSetUnitRealField(u, ConvertUnitRealField('umpr'), BlzGetUnitRealField(u, ConvertUnitRealField('umpr')) + (1 * levelsGained))
            call UpdateBonus(u, 2, 1  * levelsGained)   
            call SetBonus(u, 0, 20 + (0.1 * heroLevel))
        elseif uid == ROCK_GOLEM_UNIT_ID then
            call SetBonus(u, 0, 49 + heroLevel)
            call SetBonus(u, 1, heroLevel)
        elseif uid == LICH_UNIT_ID then
            call SetBonus(u, 0, 100 + heroLevel)
        elseif uid == GNOME_MASTER_UNIT_ID then
            call SetBonus(u, 0, heroLevel * 10)
            call SetBonus(u, 1, GnomeCharges.integer[hid])
        elseif uid == GREEDY_GOBLIN_UNIT_ID then
            call SetBonus(u, 0, 20 + (heroLevel * 4))
            call SetBonus(u, 1, 21 + (heroLevel * 3))
        elseif uid == CENTAUR_ARCHER_UNIT_ID then
            call SetBonus(u, 0, heroLevel * 5)
        elseif uid == OGRE_WARRIOR_UNIT_ID then
            call SetBonus(u, 0, heroLevel * 60)
        elseif uid == OGRE_MAGE_UNIT_ID then
            call SetBonus(u, 0, 15 + (heroLevel * 1.2))
        elseif uid == SEER_UNIT_ID then
            call SetBonus(u, 0, 20 + (heroLevel * 0.33))
        elseif uid == TROLL_BERSERKER_UNIT_ID then
            set TrollBerserkerBonus.real[hid] = Pow(0.995, heroLevel)
            call SetBonus(u, 0, heroLevel * 0.5)
        elseif uid == YETI_UNIT_ID then
            set YetiStrengthBonus.integer[hid] = 10 + ((heroLevel - ModuloInteger(heroLevel, 10)) / 20)
            call SetBonus(u, 0, YetiStrengthBonus.integer[hid])
        elseif uid == MURLOC_WARRIOR_UNIT_ID then
            call SetBonus(u, 0, (heroLevel / 10) + 1)
        elseif uid == GHOUL_UNIT_ID then
            call SetBonus(u, 0, (2.5 + (0.025 * heroLevel)))
        elseif uid == BANSHEE_UNIT_ID then

        elseif uid == CRYPT_LORD_UNIT_ID then      
            set CryptLordLocustCount.integer[hid] = 1 + ((heroLevel - ModuloInteger(heroLevel, 10)) / 10)
            call SetBonus(u, 0, 60 * heroLevel)
            call SetBonus(u, 1, 1 + CryptLordLocustCount[hid])

        elseif uid == GNOLL_WARDEN_UNIT_ID then
            // restored
            call SetBonus(u, 0, 1 + (0.01 * heroLevel))
            call SetGnollWardenPassive(u, GNOLL_WARDEN_PASSIVE_HP, 0.01 + (0.0001 * heroLevel))

            //interval
            call SetBonus(u, 1, 1.0 - ((heroLevel - ModuloInteger(heroLevel, 20)) / 20) * 0.025)
            call SetGnollWardenPassive(u, GNOLL_WARDEN_PASSIVE_INTERVAL, 1.0 - ((heroLevel - ModuloInteger(heroLevel, 20)) / 20) * 0.025)

            //limit
            call SetBonus(u, 2, 10 + ((heroLevel - ModuloInteger(heroLevel, 40)) / 40))
            call SetGnollWardenPassive(u, GNOLL_WARDEN_PASSIVE_LIMIT, 10 + ((heroLevel - ModuloInteger(heroLevel, 40)) / 40))
        elseif uid == SEER_UNIT_ID then

        elseif uid == SATYR_TRICKSTER_UNIT_ID then
            call AddUnitCustomState(u, BONUS_EVASION, 0.5 * levelsGained)
            call UpdateBonus(u, 0, 0.5 * levelsGained)
            call SetBonus(u, 1, 49 + (heroLevel * 1))
        elseif uid == MEDIVH_UNIT_ID then
            call AddUnitCustomState(u, BONUS_MAGICPOW, 1.5 * levelsGained)
            call UpdateBonus(u, 0, 1.5 * levelsGained)   
        endif
        
        call UpdateAbilityDescriptionLevelup(u, p, GetHeroLevel(u))
        set LastLvlHero[pid] = heroLevel  

        // Cleanup
        set u = null
        set p = null
    endfunction

    private function init takes nothing returns nothing
        local trigger heroLevelupTrigger = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(heroLevelupTrigger, EVENT_PLAYER_HERO_LEVEL)
        call TriggerAddAction(heroLevelupTrigger, function HeroLevelupActions)
        set heroLevelupTrigger = null
    endfunction

endlibrary