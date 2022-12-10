library UnitEnterMap initializer init requires RandomShit, Functions, SummonSpells, LearnAbsolute
    globals
        integer array SkeletonDefender
        boolean array bnos_a

        integer array SummonCrit
        integer array SummonCutting
        integer array SummonLastBreath
        integer array SummonIceArmor
        integer array SummonWildDefense
        integer array SummonDomeProtection
        integer array SummonHitPoints
        integer array SummonDamage
        integer array SummonArmor
    endglobals

    function AddSummonAbility takes unit u, integer abilId, integer level returns nothing
        call UnitAddAbility(u, abilId)
        call SetUnitAbilityLevel(u, abilId, level)
    endfunction

    function SummonUnit takes unit u returns nothing
        local integer i = GetUnitTypeId(u)
        local integer i2 = 0
        local integer totalLevel = 0
        local integer pid = GetPlayerId(GetOwningPlayer(u))
        local unit hero = PlayerHeroes[pid + 1]
        local integer UpgradeU = 15 * GetUnitItemTypeCount(hero,'I07K')
        local real wild = 1 + GetUnitCustomState(hero, BONUS_SUMMONPOW)/ 100
        local real r1

        //Prevent super summons?
        call ResetUnitCustomState(u)

        //Beastmaster
        if GetUnitTypeId(hero) == BEAST_MASTER_UNIT_ID then
            set UpgradeU = UpgradeU + R2I(GetHeroLevel(hero) * 0.3)
        endif

        //Mortar Team
        if GetUnitTypeId(hero) == MORTAR_TEAM_UNIT_ID then
            call AddUnitCustomState(u, BONUS_PHYSPOW, 2 * GetHeroLevel(hero))  
        endif

        //Druid of the Claw
        if GetUnitTypeId(hero) == DRUID_OF_THE_CLAY_UNIT_ID then
            set r1 = GetHeroLevel(hero) * 0.01
            call AddUnitCustomState(u, BONUS_MAGICPOW, (GetUnitCustomState(hero, BONUS_MAGICPOW) * r1))
            call AddUnitCustomState(u, BONUS_MAGICRES, (GetUnitCustomState(hero, BONUS_MAGICRES) * r1))
            call AddUnitBonus(u, BONUS_DAMAGE, R2I((GetUnitDamage(hero, 0) * r1)))
            call AddUnitBonus(u, BONUS_ARMOR, R2I((BlzGetUnitArmor(hero) * r1)))
        endif

        call AddUnitCustomState(u, BONUS_PVP, GetUnitCustomState(hero, BONUS_PVP))

        if SUMMONS.contains(i) then
            set totalLevel = GetUnitAbilityLevel(hero, GetSummonSpell(i)) + UpgradeU
            if i == WATER_ELEMENTAL_1_UNIT_ID then
                //call BJDebugMsg("we")
                call WaterElementalStats(u, totalLevel)
            elseif i == FERAL_SPIRIT_WOLF_1_UNIT_ID then
                //call BJDebugMsg("fw")
                call SpiritWolfStats(u, totalLevel)
            elseif i == SERPENT_WARD_1_UNIT_ID then
                //call BJDebugMsg("sw")
                call SerpentWardStats(u, totalLevel)
            elseif i == MOUNTAIN_GIANT_1_UNIT_ID then
                //call BJDebugMsg("mg")
                call MountainGiantStats(u, totalLevel)
            elseif i == BEAR_1_UNIT_ID then
                //call BJDebugMsg("be")
                call BearStats(u, totalLevel)
            elseif i == HAWK_1_UNIT_ID then
                //call BJDebugMsg("ha")
                call HawkStats(u, totalLevel)
            elseif i == QUILBEAST_1_UNIT_ID then
                //call BJDebugMsg("qu")
                call QuilbeastStats(u, totalLevel)
            elseif i == PHOENIX_1_UNIT_ID then
                //call BJDebugMsg("ph")
                call PhoenixStats(u, totalLevel)
            elseif i == INFERNAL_1_UNIT_ID then
                //call BJDebugMsg("in")
                call InfernoStats(u, totalLevel)
            elseif i == LAVA_SPAWN_1_UNIT_ID then
                //call BJDebugMsg("ls")
                call LavaSpawnStats(u, totalLevel)
            elseif i == POCKET_FACTORY_1_UNIT_ID then
                //call BJDebugMsg("pf")
                call PocketFactoryStats(u, totalLevel)
            elseif i == CLOCKWORK_GOBLIN_1_UNIT_ID then
                //call BJDebugMsg("cg")
                call ClockwerkGoblinStats(u, totalLevel)
            elseif i == PARASITE_1_UNIT_ID then
                //call BJDebugMsg("pa")
                call ParasiteStats(u, totalLevel)
            elseif i == CARRION_BEETLE_1_UNIT_ID then
                //call BJDebugMsg("cb")
                call CarrionBeetleStats(u, totalLevel)
            elseif i == SKELETON_BATTLEMASTER_1_UNIT_ID then
                //call BJDebugMsg("basb")
                call BlackArrowMeleeSkeletonStats(u, totalLevel)
            elseif i == SKELETON_WARMAGE_1_UNIT_ID then
                //call BJDebugMsg("basw")
                call BlackArrowRangedSkeletonStats(u, totalLevel)
            elseif SKELLIESCAPTAINS.contains(i) then
                //call BJDebugMsg("rest")
                call SkeletonStats(u, totalLevel)
            endif

            call BlzSetUnitName(u,GetUnitName(u)+ " level " + I2S(totalLevel) )
            call SetWidgetLife(u, BlzGetUnitMaxHP(u))
        endif

         //Wild Defense
         set i2 = GetUnitAbilityLevel(hero, WILD_DEFENSE_ABILITY_ID)
         if i2 > 0 then
            call AddUnitCustomState(u, BONUS_MAGICRES,3 * i2)
            call AddUnitCustomState(u, BONUS_EVASION,0.5 * i2)
            call AddUnitCustomState(u, BONUS_BLOCK,10 * i2)
            call AddSummonAbility(u, WILD_DEFENSE_SUMMON_ABILITY_ID, i2)
        endif

        /*
        if SummonCrit[pid] > 0 and i != PHOENIX_1_UNIT_ID then
            call AddSummonAbility(u, CRITICAL_STRIKE_ABILITY_ID, SummonCrit[pid])
        endif

        if SummonCutting[pid] > 0 then
            call AddSummonAbility(u, CUTTING_ABILITY_ID, SummonCutting[pid])
        endif

        if SummonLastBreath[pid] > 0 then
            call AddSummonAbility(u, LAST_BREATHS_ABILITY_ID, SummonLastBreath[pid])
        endif

        if SummonIceArmor[pid] > 0 then
            call AddSummonAbility(u, ICE_FORCE_ABILITY_ID, SummonIceArmor[pid])
        endif

        if SummonDomeProtection[pid] > 0 then
            call AddSummonAbility(u, DOME_OF_PROTECTION_ABILITY_ID, SummonDomeProtection[pid])
        endif
        */

        if SummonHitPoints[pid] > 0 then
            call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + SummonHitPoints[pid] * 200)
            call SetUnitState(u, UNIT_STATE_LIFE, BlzGetUnitMaxHP(u))
        endif

        if SummonArmor[pid] > 0 then
            call BlzSetUnitArmor(u, BlzGetUnitArmor(u) + (SummonArmor[pid] * 2))
        endif

        if SummonDamage[pid] > 0 then
            call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u, 0) + (20 * SummonDamage[pid]), 0)
        endif

        //wild Defense
        if wild != 1 then      
            call BlzSetUnitBaseDamage(u,R2I(I2R(BlzGetUnitBaseDamage(u,0))* wild),0)  
            call BlzSetUnitMaxHP(u,R2I(I2R(BlzGetUnitMaxHP(u))* wild))
            call SetWidgetLife(u,BlzGetUnitMaxHP(u))
        endif

        //Trueshot Aura
        set i2 = GetUnitAbilityLevel(hero, TRUESHOT_AURA_ABILITY_ID)
        if i2 > 0 then
            call AddUnitBonus(u, BONUS_DAMAGE, R2I(BlzGetUnitBaseDamage(u, 0) * (0.05 * i2)))
        endif

        //Command Aura
        set i2 = GetUnitAbilityLevel(hero, COMMAND_AURA_ABILITY_ID)
        if i2 > 0 then
            call AddUnitBonus(u, BONUS_DAMAGE, R2I(BlzGetUnitBaseDamage(u, 0) * (0.1 * i2)))
        endif

        //Banner of Many
        if UnitHasItemType(hero, BANNER_OF_MANY_ITEM_ID) then

            if GetUnitAbilityLevel(u, ENDURANCE_AURA_ABILITY_ID) == 0 then
                call AddUnitBonusReal(u, BONUS_ATTACK_SPEED, 1.5)
            endif

            if GetUnitAbilityLevel(hero, TRUESHOT_AURA_ABILITY_ID) == 0 and GetUnitAbilityLevel(hero, COMMAND_AURA_ABILITY_ID) == 0 then
                call AddUnitBonus(u, BONUS_DAMAGE, R2I(BlzGetUnitBaseDamage(u, 0) * 1.5))
            endif

            call UnitAddAbility(u, BANNER_OF_MANY_DUMMY_ABILITY_ID)
        endif
        
        set u = null
        set hero = null
    endfunction

    function Trig_UnitStateSys_Actions takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local integer pid = GetPlayerId(GetOwningPlayer(u))
        local boolean realUnit = IsUnitIllusion(u) == false
        local integer hid = GetHandleId(u)

        //Summons
        if (not IsUnitExcluded(u)) and GetOwningPlayer(u) != Player(PLAYER_NEUTRAL_PASSIVE) and GetOwningPlayer(u) != Player(11) then
            call SummonUnit(u)
        endif

        //Illusion
        if (not realUnit) and IsUnitType(u, UNIT_TYPE_HERO) then
            call SetHeroStr(u, GetHeroStr(PlayerHeroes[pid + 1], false), false)
            call SetHeroAgi(u, GetHeroAgi(PlayerHeroes[pid + 1], false), false)
            call SetHeroInt(u, GetHeroInt(PlayerHeroes[pid + 1], false), false)
        endif

        //Rock Golem
        if GetUnitTypeId(u) == ROCK_GOLEM_UNIT_ID then
            call AddUnitCustomState(u, BONUS_BLOCK,50)
            call AddUnitCustomState(u, BONUS_MAGICRES,15)
        endif

        //Medivh
        if GetUnitTypeId(u) == MEDIVH_UNIT_ID then
            call AddUnitCustomState(u, BONUS_MAGICPOW,15)
        endif

        //Pit Lord
        if GetUnitTypeId(u) == PIT_LORD_UNIT_ID then
            call UnitAddAbility(u, ABSOLUTE_FIRE_ABILITY_ID)
            call BlzUnitDisableAbility(u,ABSOLUTE_FIRE_ABILITY_ID,false,true)

            if realUnit then
                call SaveInteger(HT,hid,941561, 1)
                call UpdateHeroSpellList(ABSOLUTE_FIRE_ABILITY_ID,u,1)
                call FuncEditParam(ABSOLUTE_FIRE_ABILITY_ID,u)
                call AddHeroMaxAbsoluteAbility(u)
            endif
        endif

        //Naga Siren
        if GetUnitTypeId(u) == NAGA_SIREN_UNIT_ID then
            call UnitAddAbility(u, ABSOLUTE_WATER_ABILITY_ID)
            call BlzUnitDisableAbility(u,ABSOLUTE_WATER_ABILITY_ID,false,true)

            if realUnit then
                call SaveInteger(HT,hid,941561, 1)
                call UpdateHeroSpellList(ABSOLUTE_WATER_ABILITY_ID,u,1)
                call FuncEditParam(ABSOLUTE_WATER_ABILITY_ID,u)
                call AddHeroMaxAbsoluteAbility(u)
                set NagaSirenBonus[hid] = 1
            endif
        endif

        //Satyr Trickster
        if GetUnitTypeId(u) == SATYR_TRICKSTER_UNIT_ID then
            call AddUnitCustomState(u, BONUS_EVASION,10)
        endif

        //Witch Doctor
        if GetUnitTypeId(u) == WITCH_DOCTOR_UNIT_ID and realUnit then
            call AddHeroMaxAbsoluteAbility(u)
            call SetBonus(u, 0, 1)
        endif

        //Blademaster
        if GetUnitTypeId(u) == BLADE_MASTER_UNIT_ID and realUnit then
            set BladestormAttackLimit[hid] = 9
        endif

        //Thunder Witch
        if GetUnitTypeId(u) == THUNDER_WITCH_UNIT_ID and realUnit then
            set ThunderBoltTargets[hid] = 1
        endif

        if GetUnitTypeId(u) == SORCERER_UNIT_ID and realUnit then
            call CreateSpellList(u, SORCERER_UNIT_ID, SpellListFilter.SorcerSpellListFilter)
            set SorcererAmount[hid] = 1
        endif

        //Mortar Team
        if GetUnitTypeId(u) == MORTAR_TEAM_UNIT_ID then
            call AddUnitCustomState(u, BONUS_PHYSPOW, 2)  
        endif

        //Set base luck
        call AddUnitCustomState(u, BONUS_LUCK, 1)

        set u = null
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterEnterRectSimple( trg, GetPlayableMapRect() )
        call TriggerAddAction( trg, function Trig_UnitStateSys_Actions )
        set trg = null
    endfunction
endlibrary
