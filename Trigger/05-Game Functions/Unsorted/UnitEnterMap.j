library UnitEnterMap initializer init requires RandomShit, Functions, SummonInfo, LearnAbsolute, PackingTape

    globals
        Table SummonLevel
        integer array SkeletonDefender
        boolean array bnos_a

        integer array SummonWildDefense
        integer array SummonHitPoints
        integer array SummonDamage
        integer array SummonArmor
    endglobals

    private function AddSummonAbility takes unit u, integer abilId, integer level returns nothing
        call UnitAddAbility(u, abilId)
        call SetUnitAbilityLevel(u, abilId, level)
    endfunction

    private function SummonUnit takes unit u returns nothing
        local integer summonTypeId = GetUnitTypeId(u)
        local integer i2 = 0
        local integer totalLevel = 0
        local integer pid = GetPlayerId(GetOwningPlayer(u))
        local unit hero = PlayerHeroes[pid]
        local integer UpgradeU = 15 * GetUnitItemTypeCount(hero,'I07K')
        local real wild = 1 + GetUnitCustomState(hero, BONUS_SUMMONPOW)/ 100
        local real r1

        //Prevent super summons?
        call ResetUnitCustomState(u)

        //check packing tape
        if UnitHasItemType(hero, PACKING_TAPE_ITEM_ID) and GetSummonSpell(summonTypeId) != 0 then
            if not PackingTape_CheckSummonCount(hero, u) then
                set hero = null
                return
            endif
        endif

        //register summons
        call RegisterPlayerSummon(hero, u)

        //Beastmaster
        if GetUnitTypeId(hero) == BEAST_MASTER_UNIT_ID then
            set UpgradeU = UpgradeU + R2I(GetHeroLevel(hero) * 0.3)
        endif

        //Mortar Team
        if GetUnitTypeId(hero) == MORTAR_TEAM_UNIT_ID then
            call AddUnitCustomState(u, BONUS_PHYSPOW, 15)
            if GetHeroLevel(hero) > 1 then
            call AddUnitCustomState(u, BONUS_PHYSPOW, 1.5 * (GetHeroLevel(hero) - 1))
            endif
        endif

        //Seer
        //if GetUnitTypeId(hero) == SEER_UNIT_ID then

           // if GetUnitAbilityLevel(hero, DESTRUCTION_ABILITY_ID) > 0 then
           // call UnitAddAbility(u, DESTRUCTION_ABILITY_ID)
           // call SetUnitAbilityLevel(u, DESTRUCTION_ABILITY_ID, GetUnitAbilityLevel(hero, DESTRUCTION_ABILITY_ID))
           // endif

          //  if GetUnitAbilityLevel(hero, PULVERIZE_ABILITY_ID) > 0 then
          //  call UnitAddAbility(u, PULVERIZE_ABILITY_ID)
          //  call SetUnitAbilityLevel(u, PULVERIZE_ABILITY_ID, GetUnitAbilityLevel(hero, PULVERIZE_ABILITY_ID))
         //   endif

          //  if GetUnitAbilityLevel(hero, ENVENOMED_WEAPONS_ABILITY_ID) > 0 then
          //  call UnitAddAbility(u, ENVENOMED_WEAPONS_ABILITY_ID)
         //   call SetUnitAbilityLevel(u, ENVENOMED_WEAPONS_ABILITY_ID, GetUnitAbilityLevel(hero, ENVENOMED_WEAPONS_ABILITY_ID))
         //   endif

         //   if GetUnitAbilityLevel(hero, INCINERATE_ABILITY_ID) > 0 then
         //   call UnitAddAbility(u, INCINERATE_ABILITY_ID)
         //   call SetUnitAbilityLevel(u, INCINERATE_ABILITY_ID, GetUnitAbilityLevel(hero, INCINERATE_ABILITY_ID))
         //   endif

         //   if GetUnitAbilityLevel(hero, BASH_ABILITY_ID) > 0 then
         //   call UnitAddAbility(u, BASH_ABILITY_ID)
         //   call SetUnitAbilityLevel(u, BASH_ABILITY_ID, GetUnitAbilityLevel(hero, BASH_ABILITY_ID))
         //   endif

         //   if GetUnitAbilityLevel(hero, LIQUID_FIRE_ABILITY_ID) > 0 then
         //   call UnitAddAbility(u, LIQUID_FIRE_ABILITY_ID)
         //   call SetUnitAbilityLevel(u, LIQUID_FIRE_ABILITY_ID, GetUnitAbilityLevel(hero, LIQUID_FIRE_ABILITY_ID))
         //   endif

        //    if GetUnitAbilityLevel(hero, CRITICAL_STRIKE_ABILITY_ID) > 0 then
         //   call UnitAddAbility(u, CRITICAL_STRIKE_ABILITY_ID)
         //   call SetUnitAbilityLevel(u, CRITICAL_STRIKE_ABILITY_ID, GetUnitAbilityLevel(hero, CRITICAL_STRIKE_ABILITY_ID))
         //   endif

         //   if GetUnitAbilityLevel(hero, DRUNKEN_MASTER_ABILITY_ID) > 0 then
        //    call UnitAddAbility(u, DRUNKEN_MASTER_ABILITY_ID)
         //   call SetUnitAbilityLevel(u, DRUNKEN_MASTER_ABILITY_ID, GetUnitAbilityLevel(hero, DRUNKEN_MASTER_ABILITY_ID))
         //   endif

         //   if GetUnitAbilityLevel(hero, CRUELTY_ABILITY_ID) > 0 then
         //   call UnitAddAbility(u, CRUELTY_ABILITY_ID)
         //   call SetUnitAbilityLevel(u, CRUELTY_ABILITY_ID, GetUnitAbilityLevel(hero, CRUELTY_ABILITY_ID))
         //   endif

        //endif

        //Druid of the Claw
        if GetUnitTypeId(hero) == DRUID_OF_THE_CLAY_UNIT_ID then
            set r1 = GetHeroLevel(hero) * 0.01
            call AddUnitCustomState(u, BONUS_MAGICPOW, (GetUnitCustomState(hero, BONUS_MAGICPOW) * r1))
            call AddUnitCustomState(u, BONUS_MAGICRES, (GetUnitCustomState(hero, BONUS_MAGICRES) * r1))
            call AddUnitCustomState(u, BONUS_EVASION, (GetUnitCustomState(hero, BONUS_EVASION) * r1))
            call AddUnitCustomState(u, BONUS_PHYSPOW, (GetUnitCustomState(hero, BONUS_PHYSPOW) * r1))
            call AddUnitCustomState(u, BONUS_LUCK, (GetUnitCustomState(hero, BONUS_LUCK) * r1))
            call AddUnitCustomState(u, BONUS_BLOCK, (GetUnitCustomState(hero, BONUS_BLOCK) * r1))
            call AddUnitBonus(u, BONUS_DAMAGE, R2I((GetUnitDamage(hero, 0) * r1)))
            call AddUnitBonus(u, BONUS_ARMOR, R2I((BlzGetUnitArmor(hero) * r1)))
        endif
        
        call AddUnitCustomState(u, BONUS_PVP, GetUnitCustomState(hero, BONUS_PVP))

        if SUMMONS.contains(summonTypeId) then
            set totalLevel = GetUnitAbilityLevel(hero, GetSummonSpell(summonTypeId)) + UpgradeU

            call GetSummonStatFunction(summonTypeId).evaluate(u, totalLevel)

            call BlzSetUnitAttackCooldown(u, RMaxBJ(0.4, BlzGetUnitAttackCooldown(u, 0)), 0)

            set SummonLevel[GetHandleId(u)] = totalLevel
            call BlzSetUnitName(u,GetUnitName(u)+ ": level " + I2S(totalLevel))
            call SetWidgetLife(u, BlzGetUnitMaxHP(u))
        endif

         //Wild Defense
        set i2 = GetUnitAbilityLevel(hero, WILD_DEFENSE_ABILITY_ID)
        if i2 > 0 then
            call AddUnitCustomState(u, BONUS_MAGICRES,3 * i2)
            call AddUnitCustomState(u, BONUS_EVASION,0.5 * i2)
            call AddUnitCustomState(u, BONUS_BLOCK, 10 * i2)
            call AddSummonAbility(u, WILD_DEFENSE_SUMMON_ABILITY_ID, i2)
        endif

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

        //wild
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

        //Brilliance Aura
        set i2 = GetUnitAbilityLevel(hero, BRILLIANCE_AURA_ABILITY_ID)
        if i2 > 0 then
            call AddUnitCustomState(u, BONUS_MAGICPOW, (i2))
        endif

        //Devotion Aura
        set i2 = GetUnitAbilityLevel(hero, DEVOTION_AURA_ABILITY_ID)
        if i2 > 0 then
            call AddUnitCustomState(u, BONUS_MAGICRES, (i2))
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

    private function UnitEnterMapActions takes nothing returns nothing
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
            call SetHeroStr(u, GetHeroStr(PlayerHeroes[pid], false), false)
            call SetHeroAgi(u, GetHeroAgi(PlayerHeroes[pid], false), false)
            call SetHeroInt(u, GetHeroInt(PlayerHeroes[pid], false), false)
        endif

        //Rock Golem
        if GetUnitTypeId(u) == ROCK_GOLEM_UNIT_ID then
            call AddUnitCustomState(u, BONUS_BLOCK, 50)
            call AddUnitCustomState(u, BONUS_MAGICRES, 15)
            call UnitAddAbility(u, ABSOLUTE_EARTH_ABILITY_ID)
            call BlzUnitDisableAbility(u,ABSOLUTE_EARTH_ABILITY_ID,false,true)
            
            if realUnit then
                call SaveInteger(HT, hid, 941561, 1)
                call UpdateHeroSpellList(ABSOLUTE_EARTH_ABILITY_ID, u, 1)
                call FuncEditParam(ABSOLUTE_EARTH_ABILITY_ID, u)
                call AddHeroMaxAbsoluteAbility(u)
            endif
        endif

        //Medivh
        if GetUnitTypeId(u) == MEDIVH_UNIT_ID then
            call AddUnitCustomState(u, BONUS_MAGICPOW, 15)
        endif

        //Mortar Team
        if GetUnitTypeId(u) == MORTAR_TEAM_UNIT_ID then
            call AddUnitCustomState(u, BONUS_PHYSPOW, 15)
        endif

        //Pit Lord
        if GetUnitTypeId(u) == PIT_LORD_UNIT_ID then
            call UnitAddAbility(u, ABSOLUTE_FIRE_ABILITY_ID)
            call BlzUnitDisableAbility(u,ABSOLUTE_FIRE_ABILITY_ID,false,true)

            if realUnit then
                call SaveInteger(HT, hid, 941561, 1)
                call UpdateHeroSpellList(ABSOLUTE_FIRE_ABILITY_ID, u, 1)
                call FuncEditParam(ABSOLUTE_FIRE_ABILITY_ID, u)
                call AddHeroMaxAbsoluteAbility(u)
            endif
        endif

        //Naga Siren
        if GetUnitTypeId(u) == NAGA_SIREN_UNIT_ID then
            call UnitAddAbility(u, ABSOLUTE_WATER_ABILITY_ID)
            call BlzUnitDisableAbility(u,ABSOLUTE_WATER_ABILITY_ID,false,true)

            if realUnit then
                call SaveInteger(HT, hid, 941561, 1)
                call UpdateHeroSpellList(ABSOLUTE_WATER_ABILITY_ID, u, 1)
                call FuncEditParam(ABSOLUTE_WATER_ABILITY_ID, u)
                call AddHeroMaxAbsoluteAbility(u)
                set NagaSirenBonus[hid] = 1
            endif
        endif

        //Satyr Trickster
        if GetUnitTypeId(u) == SATYR_TRICKSTER_UNIT_ID then
            call AddUnitCustomState(u, BONUS_EVASION, 10)
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

        //Troll Berserker
        if GetUnitTypeId(u) == TROLL_BERSERKER_UNIT_ID and realUnit then
            set TrollBerserkerBonus.real[hid] = 0.99
        endif

        //crypt Lord
        if GetUnitTypeId(u) == CRYPT_LORD_UNIT_ID and realUnit then
            set CryptLordLocustCount.integer[hid] = 1
        endif

        //Yeti
        if GetUnitTypeId(u) == YETI_UNIT_ID and realUnit then
            set YetiStrengthBonus.integer[hid] = 10
        endif

        //Sorcerer
        if GetUnitTypeId(u) == SORCERER_UNIT_ID and realUnit then
            call CreateSpellList(u, SORCERER_UNIT_ID, SpellListFilter.SorcerSpellListFilter)
            set SorcererAmount[hid] = 1
        endif

        //Gnoll Warden
        if GetUnitTypeId(u) == GNOLL_WARDEN_UNIT_ID and realUnit then
            call SetGnollWardenPassive(u, GNOLL_WARDEN_PASSIVE_HP, 0.01)
            call SetGnollWardenPassive(u, GNOLL_WARDEN_PASSIVE_INTERVAL, 1.0)
            call SetGnollWardenPassive(u, GNOLL_WARDEN_PASSIVE_LIMIT, 10)
        endif

        //Set base luck
        call AddUnitCustomState(u, BONUS_LUCK, 1)

        set u = null
    endfunction

    private function init takes nothing returns nothing
        local trigger unitEnterMapTrigger = CreateTrigger()
        set SummonLevel = Table.create()
        call TriggerRegisterEnterRectSimple(unitEnterMapTrigger, GetPlayableMapRect())
        call TriggerAddAction(unitEnterMapTrigger, function UnitEnterMapActions)
        set unitEnterMapTrigger = null
    endfunction

endlibrary
