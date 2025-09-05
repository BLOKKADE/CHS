library GenerateNextCreepLevel initializer init requires RandomShit, Functions, CustomGameEvent

    globals
        integer RoundCreepChanceReflectAura = 0
        integer RoundCreepChanceWizardbane = 0
        integer RoundCreepChanceDrunkMaster = 0
        integer RoundCreepChanceSlowAura = 0
        integer RoundCreepChancePulverize = 0 
        integer RoundCreepChanceLastBreath = 0
        integer RoundCreepChanceBloodlust = 0
        integer RoundCreepChanceUnlimitedAgony = 0
        integer RoundCreepChanceCorrosiveSkin = 0 
        integer RoundCreepChanceImmortalAura = 0
        integer RoundCreepChanceDivineShield = 0
        integer RoundCreepChanceEnsnare = 0
        integer RoundCreepChanceGuardianSpirit = 0
        integer RoundCreepChanceAvatar = 0
        integer RoundCreepChanceHealingWave = 0
        integer RoundCreepChanceRainOfFire = 0
        integer RoundCreepChanceAntiMagicShell = 0
        integer RoundCreepChanceStoneProt = 0
        integer RoundCreepChanceDivineBubble = 0
        integer RoundCreepChanceAncientTeaching = 0
        integer RoundCreepChanceIceForce = 0
        integer RoundCreepChanceBlizzard = 0
        integer RoundCreepChanceFrostNova = 0
        integer RoundCreepChanceEntanglingRoots = 0
        integer RoundCreepChanceStormBolt = 0
        integer RoundSkillGroupRoll = 0
        boolean wizardbaneDebug = false
        HashTable PlayerRoundCreeps
    endglobals

    function GetRemainingPlayerCount takes nothing returns integer
        local integer i = 0
        local integer count = 0
        local player p

        loop
            exitwhen i >= bj_MAX_PLAYERS // usually 12
            set p = Player(i)
            if GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING and GetPlayerController(p) == MAP_CONTROL_USER then
                set count = count + 1
            endif
            set i = i + 1
        endloop

        return count
    endfunction

    private function GenerateNextCreepLevelConditions takes nothing returns boolean
        return IsTriggerEnabled(GetTriggeringTrigger()) == true
    endfunction

    private function ResetRoundAbilities takes nothing returns nothing
        local integer index = roundAbilities.integer[0]
        loop
            set roundAbilities.integer[index] = 0
            set index = index - 1
            exitwhen index <= 0
        endloop
        set roundAbilities.integer[0] = 0
    endfunction

    private function AddRoundAbility takes integer abilityId returns nothing
        local integer index = roundAbilities.integer[0] + 1
        set roundAbilities[index] = abilityId
        set roundAbilities.integer[0] = index
    endfunction

    private function ConcatAbility takes string currentAbilities, string nextAbility returns string
        if currentAbilities == "" then
            return "|cff77fc94" + nextAbility + "|r"
        endif

        return currentAbilities + ", |cff77fc94" + nextAbility + "|r"
    endfunction

    private function CheckUnitAbilities takes nothing returns nothing
        local string s = ""
    
        if RoundCreepChanceBash == 1 and RoundCreepTypeId != 'n01H' or RoundCreepTypeId != 'n00W' then
            set s = ConcatAbility(s, "Bash")
            call AddRoundAbility('ACbh')
        endif
    
        if RoundCreepChanceHurlBoulder == 1 then
            set s = ConcatAbility(s, "Hurl Boulder")
            call AddRoundAbility(HURL_BOULDER_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceEntanglingRoots == 1 then
            set s = ConcatAbility(s, "Entangling Roots")
            call AddRoundAbility(ENTAGLING_ROOTS_ABILITY_ID)
        endif

        if RoundCreepChanceBlizzard == 1 then
            set s = ConcatAbility(s, "Blizzard")
            call AddRoundAbility(BLIZZARD_ABILITY_ID)
        endif

        if RoundCreepChanceFrostNova == 1 then
            set s = ConcatAbility(s, "Frost Nova")
            call AddRoundAbility(FROST_NOVA_ABILITY_ID)
        endif

        if RoundCreepChanceAncientTeaching == 1 then
            set s = ConcatAbility(s, "Ancient Teaching")
            call AddRoundAbility(ANCIENT_TEACHING_ABILITY_ID)
        endif
    
        if RoundCreepChanceRejuv == 1 then
            set s = ConcatAbility(s, "Rejuvenation")
            call AddRoundAbility(REJUVENATION_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceDivineShield == 1 then
            set s = ConcatAbility(s, "Divine Shield")
            call AddRoundAbility('ACds')
        endif

        if RoundCreepChanceEnsnare == 1 then
            set s = ConcatAbility(s, "Ensnare")
            call AddRoundAbility(ENSNARE_ABILITY_ID)
        endif

        if RoundCreepChanceGuardianSpirit == 1 then
            set s = ConcatAbility(s, "Guardian Spirit")
            call AddRoundAbility(GUARDIAN_SPIRIT_ABILITY_ID)
        endif

        if RoundCreepChanceAvatar == 1 then
            set s = ConcatAbility(s, "Avatar")
            call AddRoundAbility(ACTIVATE_AVATAR_ABILITY_ID)
        endif

        if RoundCreepChanceHealingWave == 1 then
            set s = ConcatAbility(s, "Healing Wave")
            call AddRoundAbility(HEALING_WAVE_ABILITY_ID)
        endif

        if RoundCreepChanceRainOfFire == 1 then
            set s = ConcatAbility(s, "Rain of Fire")
            call AddRoundAbility(RAIN_OF_FIRE_ABILITY_ID)
        endif

        if RoundCreepChanceAntiMagicShell == 1 then
            set s = ConcatAbility(s, "Anti-Magic Shell")
            call AddRoundAbility(ANTI_MAGIC_SHEL_ABILITY_ID)
        endif

        if RoundCreepChanceStoneProt == 1 then
            set s = ConcatAbility(s, "Stone Protection")
            call AddRoundAbility(STONE_PROTECTION_ABILITY_ID)
        endif

        if RoundCreepChanceDivineBubble == 1 then
            set s = ConcatAbility(s, "Divine Bubble")
            call AddRoundAbility(DIVINE_BUBBLE_ABILITY_ID)
        endif
    
        if RoundCreepChanceBigBadV == 1 then
            set s = ConcatAbility(s, "Big Bad Voodoo")
            call AddRoundAbility('A018')
        endif

        if RoundCreepChanceBackStab == 1 then
            set s = ConcatAbility(s, "Backstab")
            call AddRoundAbility(BACKSTAB_ABILITY_ID)
        endif
    
        if RoundCreepChanceBlink == 1 then
            set s = ConcatAbility(s, "Blink")
            call AddRoundAbility('A01A')
        endif
    
        if RoundCreepChanceCritStrike == 1 and RoundCreepTypeId != 'n01H' or RoundCreepTypeId != 'n00W' then
            set s = ConcatAbility(s, "Critical Strike")
            call AddRoundAbility(CRITICAL_STRIKE_ABILITY_ID)
        endif
    
        if RoundCreepChanceEvasion == 1 then
            set s = ConcatAbility(s, "Evasion")
        endif
    
        if RoundCreepChanceFaerieFire == 1 then
            set s = ConcatAbility(s, "Faerie Fire")
            call AddRoundAbility(FAERIE_FIRE_CREEP_ABILITY_ID)
        endif
    
        if RoundCreepChanceLifesteal == 1 then
            set s = ConcatAbility(s, "Lifesteal")
            call AddRoundAbility('SCva')
        endif
    
        if RoundCreepChanceManaBurn == 1 then
            set s = ConcatAbility(s, "Mana Burn")
            call AddRoundAbility(MANA_BURN_CREEP_ABILITY_ID)
        endif
    
        if RoundCreepChanceShockwave == 1 then
            set s = ConcatAbility(s, "Shockwave")
            call AddRoundAbility(SHOCKWAVE_CREEP_ABILITY_ID)
        endif
    
        if RoundCreepChanceSlow == 1 then
            set s = ConcatAbility(s, "Slow")
            call AddRoundAbility('A013')
        endif
    
        if RoundCreepChanceCleave == 1 and RoundCreepTypeId != 'n01H' or RoundCreepTypeId != 'n00W' or RoundCreepTypeId != 'n01p' or RoundCreepTypeId != 'n01g' or RoundCreepTypeId != 'n01t' or RoundCreepTypeId != 'n01F' or RoundCreepTypeId != 'n01A' or RoundCreepTypeId != 'n006' then
            set s = ConcatAbility(s, "Cleave")
            call AddRoundAbility('ACce')
        endif
    
        if RoundCreepChanceThorns == 1 then
            set s = ConcatAbility(s, "Thorns Aura")
            call AddRoundAbility(THORNS_AURA_ABILITY_ID)
        endif
    
        if RoundCreepChanceThunderClap == 1 then
            set s = ConcatAbility(s, "Thunder Clap")
            call AddRoundAbility(THUNDER_CLAP_CREEP_ABILITY_ID)
        endif
    
        if RoundCreepChanceReflectAura == 1 then
            set s = ConcatAbility(s, "Reflection Aura")
            call AddRoundAbility(REFLECTION_AUR_ABILITY_ID)
        endif
    
        if RoundCreepChanceWizardbane == 1 then
            set s = ConcatAbility(s, "Wizardbane Aura")
            call AddRoundAbility(WIZARDBANE_AURA_ABILITY_ID)
        endif
    
        if RoundCreepChanceDrunkMaster == 1 and RoundCreepTypeId != 'n01H' or RoundCreepTypeId != 'n00W' then
            set s = ConcatAbility(s, "Drunken Master")
            call AddRoundAbility(DRUNKEN_MASTER_ABILITY_ID)
        endif
    
        if RoundCreepChanceSlowAura == 1 then
            set s = ConcatAbility(s, "Slow Aura")
            call AddRoundAbility(SLOW_AURA_ABILITY_ID)
        endif
    
        if RoundCreepChancePulverize == 1 and RoundCreepTypeId != 'n01H' or RoundCreepTypeId != 'n00W' then
            set s = ConcatAbility(s, "Pulverize")
            call AddRoundAbility(PULVERIZE_ABILITY_ID)
        endif
    
        if RoundCreepChanceLastBreath == 1 then
            set s = ConcatAbility(s, "Last Breath")
            call AddRoundAbility(LAST_BREATHS_ABILITY_ID)
        endif
    
        if RoundCreepChanceCorrosiveSkin == 1 then
            set s = ConcatAbility(s, "Corrosive Skin")
            call AddRoundAbility(CORROSIVE_SKIN_ABILITY_ID)
        endif

        if RoundCreepChanceShadowStrike == 1 then
            set s = ConcatAbility(s, "Shadow Strike")
            call AddRoundAbility(SHADOW_STRIKE_CREEP_ABILITY_ID)
        endif

        /*if RoundCreepChanceRandomSpell == 1 then
            set s = ConcatAbility(s, "Random Spell")
            call AddRoundAbility(RANDOM_SPELL_ABILITY_ID)
        endif*/

        if RoundCreepChanceBloodlust == 1 then
            set s = ConcatAbility(s, "Bloodlust")
            call AddRoundAbility(BLOODLUST_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceUnlimitedAgony == 1 then
            set s = ConcatAbility(s, "Unlimited Agony")
            call AddRoundAbility('A0AQ')
        endif

        if RoundCreepChanceStormBolt == 1 then
            set s = ConcatAbility(s, "Storm Bolt")
            call AddRoundAbility(STORM_BOLT_ABILITY_ID)
        endif

        if RoundCreepChanceIceForce == 1 then
            set s = ConcatAbility(s, "Ice Force")
            call AddRoundAbility(ICE_ARMOR_SUMMON_ABILITY_ID)
        endif

        if RoundCreepChanceImmortalAura == 1 then
            set s = ConcatAbility(s, "Aura of Immortality")
            call AddRoundAbility(AURA_OF_IMMORTALITY_ABILITY_ID)
        endif
    
        if s == "" then
            set RoundAbilities = "|cff77fc94No abilities|r"
        else
            set RoundAbilities = s
        endif
    endfunction

    //removes creeps already created, not sure if it actually does anything
    private function RemovePreviousUnit takes nothing returns nothing
        call DeleteUnit(GetEnumUnit())
    endfunction

    function UnitAddNewAbilities takes unit u returns nothing
        if RoundCreepChanceCritStrike == 1 then
            call SetUnitAbilityLevel(u, CRITICAL_STRIKE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.2), 30))
        endif
    
        if RoundCreepChanceDrunkMaster == 1 and RoundCreepTypeId != 'n01H' or RoundCreepTypeId != 'n00W' then
            call UnitAddAbility(u, DRUNKEN_MASTER_ABILITY_ID)
            call FuncEditParam(DRUNKEN_MASTER_ABILITY_ID,u)
            call SetUnitAbilityLevel(u, DRUNKEN_MASTER_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.3), 30))
        endif
    
        if RoundCreepChanceReflectAura == 1 then
            call UnitAddAbility(u, REFLECTION_AUR_ABILITY_ID)
            call SetUnitAbilityLevel(u, REFLECTION_AUR_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.4), 30))
        endif
    
        if RoundCreepChanceWizardbane == 1 then
            call UnitAddAbility(u, WIZARDBANE_AURA_ABILITY_ID)
            call SetUnitAbilityLevel(u, WIZARDBANE_AURA_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.4), 30))
        endif
    
        if RoundCreepChanceSlowAura == 1 then
            call UnitAddAbility(u, SLOW_AURA_ABILITY_ID)
            call SetUnitAbilityLevel(u, SLOW_AURA_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.75), 30))
        endif

        if RoundCreepChanceStormBolt == 1 then
            call UnitAddAbility(u, STORM_BOLT_ABILITY_ID)
            call SetUnitAbilityLevel(u, STORM_BOLT_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.75), 30))
        endif

        if RoundCreepChanceDivineShield == 1 then
            call UnitAddAbility(u, 'ACds')
            call SetUnitAbilityLevel(u, 'ACds', IMinBJ(R2I(RoundNumber * 1), 30))
        endif

        if RoundCreepChanceIceForce == 1 then
            call UnitAddAbility(u, ICE_ARMOR_SUMMON_ABILITY_ID)
            call SetUnitAbilityLevel(u, ICE_ARMOR_SUMMON_ABILITY_ID, IMinBJ(R2I(RoundNumber * 1), 30))
        endif

        if RoundCreepChanceAncientTeaching == 1 then
            call UnitAddAbility(u, ANCIENT_TEACHING_ABILITY_ID)
            call SetUnitAbilityLevel(u, ANCIENT_TEACHING_ABILITY_ID, IMinBJ(R2I(RoundNumber * 1), 30))
        endif

        if RoundCreepChanceGuardianSpirit == 1 then
            call UnitAddAbility(u, GUARDIAN_SPIRIT_ABILITY_ID)
            call SetUnitAbilityLevel(u, GUARDIAN_SPIRIT_ABILITY_ID, IMinBJ(R2I(RoundNumber * 1), 30))
        endif

        if RoundCreepChanceAvatar == 1 then
            call UnitAddAbility(u, ACTIVATE_AVATAR_ABILITY_ID)
            call SetUnitAbilityLevel(u, ACTIVATE_AVATAR_ABILITY_ID, IMinBJ(R2I(RoundNumber * 1), 30))
        endif

        if RoundCreepChanceBlizzard == 1 then
            call UnitAddAbility(u, BLIZZARD_ABILITY_ID)
            call SetUnitAbilityLevel(u, BLIZZARD_ABILITY_ID, IMinBJ(R2I(RoundNumber * 1), 30))
        endif

        if RoundCreepChanceHealingWave == 1 then
            call UnitAddAbility(u, HEALING_WAVE_ABILITY_ID)
            call SetUnitAbilityLevel(u, HEALING_WAVE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 1), 30))
        endif

        if RoundCreepChanceRainOfFire == 1 then
            call UnitAddAbility(u, RAIN_OF_FIRE_ABILITY_ID)
            call SetUnitAbilityLevel(u, RAIN_OF_FIRE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.5), 30))
        endif

        if RoundCreepChanceAntiMagicShell == 1 then
            call UnitAddAbility(u, ANTI_MAGIC_SHEL_ABILITY_ID)
            call SetUnitAbilityLevel(u, ANTI_MAGIC_SHEL_ABILITY_ID, IMinBJ(R2I(RoundNumber * 1), 30))
        endif

        if RoundCreepChanceEnsnare == 1 then
            call UnitAddAbility(u, ENSNARE_ABILITY_ID)
            call SetUnitAbilityLevel(u, ENSNARE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 1), 30))
        endif
        
        if RoundCreepChanceStoneProt == 1 then
            call UnitAddAbility(u, STONE_PROTECTION_ABILITY_ID)
            call SetUnitAbilityLevel(u, STONE_PROTECTION_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.5), 30))
        endif

        if RoundCreepChanceDivineBubble == 1 then
            call UnitAddAbility(u, DIVINE_BUBBLE_ABILITY_ID)
            call SetUnitAbilityLevel(u, DIVINE_BUBBLE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 1), 30))
        endif
    
        if RoundCreepChancePulverize == 1 and RoundCreepTypeId != 'n01H' or RoundCreepTypeId != 'n00W' then
            call UnitAddAbility(u, PULVERIZE_ABILITY_ID)
            call SetUnitAbilityLevel(u, PULVERIZE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.4), 30))
        endif
    
        if RoundCreepChanceLastBreath == 1 then
            call UnitAddAbility(u, LAST_BREATHS_ABILITY_ID)
            call FuncEditParam(LAST_BREATHS_ABILITY_ID, u)
            call SetUnitAbilityLevel(u, LAST_BREATHS_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.2), 30))
        endif
    
        if RoundCreepChanceCorrosiveSkin == 1 then
            call UnitAddAbility(u, CORROSIVE_SKIN_ABILITY_ID)
            call SetUnitAbilityLevel(u, CORROSIVE_SKIN_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif
    
        if RoundCreepChanceBackStab == 1 then
            call UnitAddAbility(u, BACKSTAB_ABILITY_ID)
            call SetUnitAbilityLevel(u, BACKSTAB_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceShadowStrike == 1 then
            call UnitAddAbility(u, SHADOW_STRIKE_CREEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, SHADOW_STRIKE_CREEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

       /* if RoundCreepChanceRandomSpell == 1 then
            call UnitAddAbility(u, RANDOM_SPELL_ABILITY_ID)
            call SetUnitAbilityLevel(u, RANDOM_SPELL_ABILITY_ID, IMinBJ(R2I(RoundNumber * 1.34), 30))
        endif*/

        if RoundCreepChanceBloodlust == 1 then
            call UnitAddAbility(u, BLOODLUST_CREEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, BLOODLUST_CREEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 2), 30))
        endif

        if RoundCreepChanceEntanglingRoots == 1 then
            call UnitAddAbility(u, ENTAGLING_ROOTS_ABILITY_ID)
            call SetUnitAbilityLevel(u, ENTAGLING_ROOTS_ABILITY_ID, IMinBJ(R2I(RoundNumber * 1), 30))
        endif

        if RoundCreepChanceFrostNova == 1 then
            call UnitAddAbility(u, FROST_NOVA_ABILITY_ID)
            call SetUnitAbilityLevel(u, FROST_NOVA_ABILITY_ID, IMinBJ(R2I(RoundNumber * 1), 30))
        endif

        if RoundCreepChanceUnlimitedAgony == 1 then
            call UnitAddAbility(u, 'A0AQ')
            call SetUnitAbilityLevel(u, 'A0AQ', IMinBJ(R2I(RoundNumber * 2), 30))
        endif

        if RoundCreepChanceImmortalAura == 1 then
            call UnitAddAbility(u, AURA_OF_IMMORTALITY_ABILITY_ID)
            call SetUnitAbilityLevel(u, AURA_OF_IMMORTALITY_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif
    endfunction

    private function GenerateNextCreepLevelActions takes nothing returns nothing
        local integer newAbilChance = 50
        local integer oldAbilChance = 20
        local real magicPowerBonus = 0
        local real magicDefBonus = 0
        local real evasionBonus = 0
        local real blockBonus = 0
        local integer damageBonus = 0
        local string s = ""
        local integer temp = 0
        local location unitSpawnOffset
        local unit creep
        local integer playerId = 0
        local group g = null
        local integer creepDamage

        set RoundCreepInfo[0] = ""
        set RoundCreepInfo[1] = ""
        set RoundCreepInfo[2] = ""
        set RoundCreepInfo[3] = ""
        set RoundCreepInfo[4] = ""
        set RoundCreepInfo[5] = ""
        set RoundCreepInfo[6] = ""
        set RoundCreepInfo[7] = ""

        call DisableTrigger(GetTriggeringTrigger())
        call ConditionalTriggerExecute(CreepTypesTrigger)
        call ResetRoundAbilities()

        //stop magic damage units spawning before R15
        if RoundNumber < 15 then
            set RoundCreepTypeId = CreepUnitTypeIds[GetRandomInt(1, MaxCreepUnitTypes - 2)]
        else
            set RoundCreepTypeId = CreepUnitTypeIds[GetRandomInt(1, MaxCreepUnitTypes)]
        endif

        //set movement and attack speeds
        set RoundCreepMoveSpeed = GetRandomInt(GetRandomInt(150, 150 + RoundNumber * 2), 422 + RoundNumber * 2)
        set RoundCreepMaxAttackSpeed = GetRandomInt(1, RoundNumber)
        
        if RoundNumber > 25 then
            set newAbilChance = 20
        endif
        if RoundNumber > 40 then
            set oldAbilChance = 15
        endif

        if RoundNumber > 5 and RoundCreepTypeId != 'n01H' or RoundCreepTypeId != 'n00W' then
            set RoundCreepChanceBash = GetRandomInt(1, 20) //Bash creep chance
        endif

        if RoundNumber > 5 then
            set RoundCreepChanceHurlBoulder = GetRandomInt(1, 20) //hurl Boulder creep chance
            set RoundCreepChanceRejuv = GetRandomInt(1, 20) //Rejuvenation creep chance
            set RoundCreepChanceSlow = GetRandomInt(1, oldAbilChance) //Slow creep chance
            set RoundCreepChanceSlowAura = GetRandomInt(1, newAbilChance) //Slow Aura creep chance
            set RoundCreepChanceImmortalAura = GetRandomInt(1, newAbilChance) //Immortality Aura creep chance
        endif

        if ((RoundNumber + 1) > 1) then
            set RoundCreepChanceBigBadV = GetRandomInt(1, oldAbilChance) //Big Bad Voodoo creep chance
            set RoundCreepChanceBlink = GetRandomInt(1, oldAbilChance) //Blink creep chance

            if RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
                set RoundCreepChanceCritStrike = GetRandomInt(1, oldAbilChance) //Critical Strike creep chance
                set RoundCreepChanceShockwave = GetRandomInt(1, oldAbilChance) //Shockwave creep chance
                if RoundNumber > 5 then
                    set RoundCreepChanceThunderClap = GetRandomInt(1, oldAbilChance) //Thunderclap creep chance 
                endif
            else
                set RoundCreepChanceCritStrike = 0
                set RoundCreepChanceShockwave = 0
                set RoundCreepChanceThunderClap = 0
            endif

            set RoundCreepChanceEvasion = GetRandomInt(1, oldAbilChance) //Evasion creep chance
            set RoundCreepChanceFaerieFire = GetRandomInt(1, oldAbilChance) //Faerie Fire creep chance
            set RoundCreepChanceLifesteal = GetRandomInt(1, oldAbilChance) //Lifesteal creep chance
            set RoundCreepChanceManaBurn = GetRandomInt(1, oldAbilChance) //Mana Burn creep chance

            if RoundCreepTypeId != 'n01H' or RoundCreepTypeId != 'n00W' or RoundCreepTypeId != 'n01p' or RoundCreepTypeId != 'n01g' or RoundCreepTypeId != 'n01t' or RoundCreepTypeId != 'n01F' or RoundCreepTypeId != 'n01A' or RoundCreepTypeId != 'n006' then
                set RoundCreepChanceCleave = GetRandomInt(1, oldAbilChance) //Cleave creep chance
            endif
            set RoundCreepChanceThorns = 0
            set RoundCreepChanceReflectAura = 0

            if wizardbaneDebug then
                set RoundCreepChanceWizardbane = 1
            else
                set RoundCreepChanceWizardbane = 0
                if GetRandomInt(1, oldAbilChance) == 1 then
                    set temp = GetRandomInt(1, 4)
                    if temp == 1 then
                        set RoundCreepChanceThorns = 1
                    elseif temp == 2 then
                        set RoundCreepChanceReflectAura = 1
                    elseif temp == 3 then
                        set RoundCreepChanceWizardbane = 1
                    elseif RoundNumber > 20 then
                        if RoundNumber > 40 then
                            set RoundCreepChanceThorns = GetRandomInt(1, 2)
                            set RoundCreepChanceReflectAura = GetRandomInt(1, 2)
                            set RoundCreepChanceWizardbane = GetRandomInt(1, 2)
                        else
                            set RoundCreepChanceThorns = GetRandomInt(1, 3)
                            set RoundCreepChanceReflectAura = GetRandomInt(1, 3)
                            set RoundCreepChanceWizardbane = GetRandomInt(1, 3)
                        endif
                    endif
                endif
            endif
        endif

        if RoundNumber > 10 then
            if RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
                set RoundCreepChanceDrunkMaster = GetRandomInt(1, oldAbilChance) //Drunken Master creep chance
                set RoundCreepChancePulverize = GetRandomInt(1, newAbilChance) //Pulverize creep chance
            endif
            set RoundCreepChanceCorrosiveSkin = GetRandomInt(1, newAbilChance) //Corrosive Skin creep chance
        endif
        
        if RoundNumber >= 14 then
            set RoundCreepChanceBackStab = GetRandomInt(1, 15) //Backstab creep chance
        endif

        if RoundNumber >= 14 then
            set RoundCreepChanceDivineShield = GetRandomInt(1, 15)  //Divine Shield creep chance
        endif

        if RoundNumber >= 14 then
            set RoundCreepChanceDivineBubble = 15  //Divine Bubble creep chance
        endif

        if RoundNumber >= 14 and RoundCreepChanceDivineShield == 0 and RoundCreepChanceDivineBubble == 0 then
            set RoundCreepChanceBloodlust = GetRandomInt(1, 15) //Bloodlust creep chance
        endif

        if RoundNumber >= 14 then
            set RoundCreepChanceEnsnare = GetRandomInt(1, 15) //Ensnare creep chance
        endif

        if RoundNumber >= 14 then
            set RoundCreepChanceStoneProt = GetRandomInt(1, 50) //Stone Protection creep chance
        endif

        if RoundNumber >= 14 then
            set RoundCreepChanceShadowStrike = GetRandomInt(1, 15) //Shadow Strike creep chance
        endif

        if RoundNumber >= 14 then
            set RoundCreepChanceGuardianSpirit = GetRandomInt(1, 13) //Guardian Spirit creep chance
        endif

        if RoundNumber >= 14 then
            set RoundCreepChanceAvatar = GetRandomInt(1, 15) //Avatar creep chance
        endif

        if RoundNumber >= 14 then
            set RoundCreepChanceHealingWave = GetRandomInt(1, 15) //Healing Wave creep chance
        endif

        if RoundNumber >= 14 then
            set RoundCreepChanceRainOfFire = GetRandomInt(1, 30) //Rain of Fire creep chance
        endif

        if RoundNumber >= 14 then
            set RoundCreepChanceBlizzard = GetRandomInt(1, 20) //Blizzard creep chance
        endif

        if RoundNumber >= 14 then
            set RoundCreepChanceIceForce = GetRandomInt(1, 15) //Ice Force creep chance
        endif

        if RoundNumber >= 14 then
            set RoundCreepChanceEntanglingRoots = GetRandomInt(1, 40) //Entangling Roots creep chance
        endif

        if RoundNumber >= 14 then
            set RoundCreepChanceStormBolt = GetRandomInt(1, 15) //Storm Bolt creep chance
        endif

        if RoundNumber >= 10 then
            set RoundCreepChanceFrostNova = GetRandomInt(1, 15) //Frost Nova creep chance
        endif

        if RoundNumber >= 14 then
            set RoundCreepChanceAncientTeaching = GetRandomInt(1, 15) //Ancient Teaching creep chance
        endif

        if RoundCreepChanceRainOfFire == 1 then
            set RoundCreepChanceEnsnare = 1
        endif

        if RoundNumber >= 14 then
            set RoundCreepChanceAntiMagicShell = GetRandomInt(1, 15) //Anti magic shell creep chance
        endif

        /*if RoundNumber >= 14 then
            set RoundCreepChanceRandomSpell = 15 //Random Spell creep chance
        endif*/
    
        if RoundNumber == 28 or RoundNumber == 38 or RoundNumber == 48 then
            set RoundCreepChanceLastBreath = GetRandomInt(1, 2) //Last Breaths creep chance
        elseif RoundNumber > 20 then
            set RoundCreepChanceLastBreath = GetRandomInt(1, 50)
        else
            set RoundCreepChanceLastBreath = 2
        endif

        if RoundNumber >= 49 then // final round guaranteed skills
            set RoundSkillGroupRoll = GetRandomInt(1, 8)
            if RoundSkillGroupRoll == 1 then
                set RoundCreepChanceUnlimitedAgony = 1
                set RoundCreepChanceDivineBubble = 1
                set RoundCreepChanceEnsnare = 1
                set RoundCreepChanceCorrosiveSkin = 1
                set RoundCreepChanceShadowStrike = 1
                set RoundCreepChanceThunderClap = 1
            elseif RoundSkillGroupRoll == 2 then
                set RoundCreepChanceUnlimitedAgony = 1
                set RoundCreepChanceDivineShield = 1
                set RoundCreepChanceStoneProt = 1
                set RoundCreepChanceBackStab = 1
                set RoundCreepChanceCleave = 1
                set RoundCreepChanceCritStrike = 1
            elseif RoundSkillGroupRoll == 3 then
                set RoundCreepChanceUnlimitedAgony = 1
                set RoundCreepChanceGuardianSpirit = 1
                set RoundCreepChanceAntiMagicShell = 1
                set RoundCreepChanceEnsnare = 1
                set RoundCreepChanceRainOfFire = 1
                set RoundCreepChanceHealingWave = 1
            elseif RoundSkillGroupRoll == 4 then
                set RoundCreepChanceUnlimitedAgony = 1
                set RoundCreepChanceThorns = 1
                set RoundCreepChanceReflectAura = 1
                set RoundCreepChanceWizardbane = 1
                set RoundCreepChanceBloodlust = 1
            elseif RoundSkillGroupRoll == 5 then
                set RoundCreepChanceUnlimitedAgony = 1
                set RoundCreepChanceDrunkMaster = 1
                set RoundCreepChancePulverize = 1
                set RoundCreepChanceImmortalAura = 1
                set RoundCreepChanceCritStrike = 1
                set RoundCreepChanceBloodlust = 1
                set RoundCreepChanceHurlBoulder = 1
                set RoundCreepChanceAvatar = 1
            elseif RoundSkillGroupRoll == 6 then
                set RoundCreepChanceUnlimitedAgony = 1
                set RoundCreepChanceImmortalAura = 1
                set RoundCreepChanceAvatar = 1
                set RoundCreepChanceDivineBubble = 1
                set RoundCreepChanceDivineShield = 1
                set RoundCreepChanceGuardianSpirit = 1
                set RoundCreepChanceHealingWave = 1
                set RoundCreepChanceAntiMagicShell = 1
            elseif RoundSkillGroupRoll == 7 then
                set RoundCreepChanceUnlimitedAgony = 1
                set RoundCreepChanceEntanglingRoots = 1
                set RoundCreepChanceHurlBoulder = 1
                set RoundCreepChanceStormBolt = 1
                set RoundCreepChanceAncientTeaching = 1
            elseif RoundSkillGroupRoll == 8 then
                set RoundCreepChanceUnlimitedAgony = 1
                set RoundCreepChanceSlowAura = 1
                set RoundCreepChanceFrostNova = 1
                set RoundCreepChanceBlizzard = 1
                set RoundCreepChanceIceForce = 1
                set RoundCreepChanceAncientTeaching = 1
            endif
        endif
    
        if RoundNumber < 5 then
            set RoundCreepNumber = RoundNumber + 1   //creep count R1-5
        elseif RoundCreepChanceLastBreath == 1 then
            set RoundCreepNumber = GetRandomInt(2,5) //creep count with last breaths
        elseif GetRemainingPlayerCount() == 6 then
            set RoundCreepNumber = GetRandomInt(2,27) //creep count with 6 players
        elseif GetRemainingPlayerCount() == 5 then
            set RoundCreepNumber = GetRandomInt(2,29) //creep count with 5 players
        elseif GetRemainingPlayerCount() == 4 then
            set RoundCreepNumber = GetRandomInt(2,31) //creep count if 4 players
        elseif GetRemainingPlayerCount() == 3 then
            set RoundCreepNumber = GetRandomInt(2,35) //creep count with 3 players
        elseif GetRemainingPlayerCount() <= 2 then
            set RoundCreepNumber = GetRandomInt(2,40) //creep count with 2 players
        else
            set RoundCreepNumber = GetRandomInt(2,25) //creep count for everyone
        endif

        if RoundNumber >= 45 then
            if RoundCreepChanceLastBreath == 1 then
                set RoundCreepNumber = GetRandomInt(2, 5)
            else
                // R45+ anti lag creep reduction
                if GetRemainingPlayerCount() >= 6 then
                    set RoundCreepNumber = GetRandomInt(2, 5)
                elseif GetRemainingPlayerCount() == 4 or GetRemainingPlayerCount() == 5 then
                    set RoundCreepNumber = GetRandomInt(2, 10)
                elseif GetRemainingPlayerCount() <= 3 then
                    set RoundCreepNumber = GetRandomInt(2, 25)
                endif
            endif
        endif
    
        //item buddy arrival
        if RoundNumber == 46 then
            call SetUpItemStocks(GetValidPlayerForce())
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, "|cffffcc00Item Buddy has arrived!|r You can use it to swap items during the Battle Royale using Shift + Q and Shift + W")
            call PlaySoundBJ(itembuddyarrivalsound)
        endif
    
        if RoundNumber > 0 then
            call CheckUnitAbilities()
        endif

        set RoundNumber = (RoundNumber + 1)

        loop
            exitwhen playerId == 8

            set g = NewGroup()
            set RoundGenCreepIndex = 1

            loop
                exitwhen RoundGenCreepIndex > RoundCreepNumber
                
                if RoundGenCreepIndex > 4 then
                    set RoundCreepChanceBigBadV = 2
                endif

                if RoundNumber > 0 then
                    set ShowCreepAbilButton[playerId] = true
                endif
                
                //Creep upgrade bonuses
                if RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
                    set magicPowerBonus = 1 * (BonusNeutral + BonusNeutralPlayer[playerId])
                    set damageBonus = ((BonusNeutral + BonusNeutralPlayer[playerId]) * RoundNumber)
                else
                    set magicPowerBonus = 0
                endif

                set magicDefBonus = 0.09 * (BonusNeutral + BonusNeutralPlayer[playerId])
                set evasionBonus = 0.06 * (BonusNeutral + BonusNeutralPlayer[playerId])
                set blockBonus = 0.12 * (BonusNeutral + BonusNeutralPlayer[playerId])

                if RoundNumber < 40 then
                    set damageBonus = damageBonus / 2
                endif
    
                if (GetPlayerSlotState(Player(playerId)) != PLAYER_SLOT_STATE_EMPTY and IsPlayerInForce(Player(playerId), DefeatedPlayers) != true) then
                    set unitSpawnOffset = OffsetLocation(PlayerArenaRectCenters[playerId], GetRandomReal(-600.00, 600.00), GetRandomReal(-600.00, 600.00))
                    set creep = CreateUnitAtLocSaveLast(Player(11), RoundCreepTypeId, unitSpawnOffset, GetRandomDirectionDeg())

                    call GroupAddUnit(g, creep)
                    call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + damageBonus, 0)
    
                    call SetUnitCustomState(creep, BONUS_MAGICPOW, magicPowerBonus)
                    call SetUnitCustomState(creep, BONUS_EVASION, evasionBonus)	
                    call SetUnitCustomState(creep, BONUS_BLOCK, blockBonus + (1 * (RoundNumber)))

                    if wizardbaneDebug then
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, 5000)
                    endif

                    //Add mana
                    if RoundCreepChanceEnsnare == 1 or RoundCreepChanceGuardianSpirit == 1 or RoundCreepChanceAvatar == 1 or RoundCreepChanceAntiMagicShell == 1 or RoundCreepChanceHealingWave == 1 then
                        call BlzSetUnitMaxMana(creep, BlzGetUnitMaxMana(creep) + R2I(100.0 * RoundNumber))
                        call SetUnitState(creep, UNIT_STATE_MANA, BlzGetUnitMaxMana(creep))
                    endif

                    if RoundCreepChanceRainOfFire == 1 or RoundCreepChanceStormBolt == 1 or RoundCreepChanceEntanglingRoots == 1 or RoundCreepChanceFrostNova == 1  then
                        call BlzSetUnitMaxMana(creep, BlzGetUnitMaxMana(creep) + R2I(200.0 * RoundNumber))
                        call SetUnitState(creep, UNIT_STATE_MANA, BlzGetUnitMaxMana(creep))
                    endif

                    if RoundNumber < 3 then
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) - 3, 0)
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (0.8 * (RoundNumber)))
                    elseif RoundNumber < 8  then
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 1 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 4 * RoundNumber)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (1 * (RoundNumber)))
                    elseif RoundNumber < 11  then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 2 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 12 * RoundNumber)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep)) 	
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (0.9 * (RoundNumber)))	
                    elseif RoundNumber < 19  then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 1.5) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 6 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 60 * RoundNumber)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))  
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (1.0 * (RoundNumber)))              	
                    elseif RoundNumber < 24  then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber *4.5) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 14 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 80 * RoundNumber)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))		    
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (1.3 * (RoundNumber)))
                    elseif RoundNumber < 35  then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 7.5) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 55 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 120 * RoundNumber)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))				    
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (1.5 * (RoundNumber)))
                    elseif RoundNumber < 41  then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 12) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 200 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 225 * RoundNumber)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))	
                        call BlzSetUnitMaxMana(creep, BlzGetUnitMaxMana(creep) + R2I(200.0 * RoundNumber))
                        call SetUnitState(creep, UNIT_STATE_MANA, BlzGetUnitMaxMana(creep))		
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (2 * (RoundNumber)))	    
                    elseif RoundNumber < 45  then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 15) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 400 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 450 * RoundNumber)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))	
                        call BlzSetUnitMaxMana(creep, BlzGetUnitMaxMana(creep) + R2I(350.0 * RoundNumber))
                        call SetUnitState(creep, UNIT_STATE_MANA, BlzGetUnitMaxMana(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (2.25 * (RoundNumber)))
                    elseif RoundNumber < 49  then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 24) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 500 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 1350 * RoundNumber)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))	
                        call BlzSetUnitMaxMana(creep, BlzGetUnitMaxMana(creep) + R2I(1000.0 * RoundNumber))
                        call SetUnitState(creep, UNIT_STATE_MANA, BlzGetUnitMaxMana(creep))   
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (3 * (RoundNumber)))                              
                    else
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 30) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 900 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 5000 * RoundNumber)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))	
                        call BlzSetUnitMaxMana(creep, BlzGetUnitMaxMana(creep) + R2I(3000.0 * RoundNumber))
                        call SetUnitState(creep, UNIT_STATE_MANA, BlzGetUnitMaxMana(creep))   
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (5 * (RoundNumber)))          			    
                    endif
    
                    call SetUnitScalePercent(creep, (85.00 + ((I2R(RoundNumber) - 1.00) * 0.50)), 100, 100)
                    call UnitAddNewAbilities(creep)
                    call ConditionalTriggerExecute(ModifyCreepAbilitiesTrigger)
                    call ConditionalTriggerExecute(CreepPowerAndHpTrigger)
                    call SetUnitMoveSpeed(creep, I2R(RoundCreepMoveSpeed))
                    call SetUnitAbilityLevelSwapped('A000', creep, (R2I(RoundCreepPower) / 2))
                    call SetUnitAbilityLevelSwapped('A002', creep,RoundCreepMaxAttackSpeed)
                    call PauseUnitBJ(true, creep)
                    call SetUnitInvulnerable(creep, true)
                    call ShowUnitHide(creep)
    
                    if SantaHatOn then
                        call UnitAddAbility(creep, 'A0B1')
                    endif
                    
                    if RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
                        call BlzSetUnitBaseDamage(creep, R2I(BlzGetUnitBaseDamage(creep, 0) * 0.5), 0)
                    endif
    
                    //call BJDebugMsg("rci: " + I2S(playerId))
                    if RoundCreepInfo[playerId] == "" then
                        //call BJDebugMsg("a")
                        set RoundCreepTitle = "|cffdd9bf1" + I2S(RoundCreepNumber) + " |r|cff77d2fc" + GetObjectName(RoundCreepTypeId) + "|r"
                        set s = RoundCreepTitle + ": "
                        set RoundCreepInfo[playerId] = "|cfff19b9bHit points|r: " + I2S(BlzGetUnitMaxHP(creep)) + "|n"
                        //call BJDebugMsg("b")
                        if IsUnitType(creep, UNIT_TYPE_MELEE_ATTACKER) then
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cffebde71Range|r: Melee |n"
                        else
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff82f373Range|r: " + I2S(R2I(BlzGetUnitWeaponRealField(creep, UNIT_WEAPON_RF_ATTACK_RANGE, 0))) + "|n"
                            set s = s + "|cff82f373Ranged|r: "
                        endif
                        //call BJDebugMsg("c")
                        if RoundCreepTypeId == 'n01H' or RoundCreepTypeId == 'n00W' then
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9bddf1Damage Type|r: Magic |n"
                            set s = s + "|cffff00ffMagic Damage|r: "
                        else
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cfff167daDamage Type|r: Physical |n"
                        endif
                        //call BJDebugMsg("d")
                        set creepDamage = BlzGetUnitBaseDamage(creep, 0) + BlzGetUnitDiceNumber(creep, 0) + BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(creep, 'A000'), ABILITY_ILF_ATTACK_BONUS, (R2I(RoundCreepPower) / 2) - 1) + damageBonus

                        if BonusNeutral == 0 and BonusNeutralPlayer[playerId] == 0 then
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cfff19bb8Damage|r: " + I2S(creepDamage) + "|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9babf1Armor|r: " + I2S(R2I(BlzGetUnitArmor(creep))) + "|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff78729eBlock|r: " + I2S(R2I(GetUnitCustomState(creep, BONUS_BLOCK))) + "|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9bc7f1Magic power|r: " + I2S(R2I(GetUnitCustomState(creep, BONUS_MAGICPOW))) + "|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9bf1a9Magic protection|r: " + I2S(R2I(GetUnitCustomState(creep, BONUS_MAGICRES))) + "|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cfff1cc9bEvasion|r: " + I2S(R2I(GetUnitCustomState(creep, BONUS_EVASION))) + "|n"
                        else
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cfff19bb8Damage|r: " + I2S(creepDamage) + "|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9babf1Armor|r: " + I2S(R2I(BlzGetUnitArmor(creep))) + "|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff78729eBlock|r: " + I2S(R2I(GetUnitCustomState(creep, BONUS_BLOCK) - blockBonus)) + " + |cff78729e" + I2S(R2I(blockBonus)) + "|r|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9bc7f1Magic power|r: " + I2S(R2I(GetUnitCustomState(creep, BONUS_MAGICPOW) - magicPowerBonus)) + " + |cff9bc7f1" + I2S(R2I(magicPowerBonus)) + "|r|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9bf1a9Magic protection|r: " + I2S(R2I(GetUnitCustomState(creep, BONUS_MAGICRES) - magicDefBonus)) + " + |cff9bf1a9" + I2S(R2I(magicDefBonus)) + "|r|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cfff1cc9bEvasion|r: " + I2S(R2I(GetUnitCustomState(creep, BONUS_EVASION) - evasionBonus)) + " + |cfff1cc9b" + I2S(R2I(evasionBonus)) + "|r |n"
                        endif

                        set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9bf1a9Movespeed|r: " + I2S(RoundCreepMoveSpeed)
                        //call BJDebugMsg("e")
                        set s = s + RoundAbilities

                        if (RoundNumber > 1) then
                            call DisplayTimedTextToPlayer(Player(playerId), 0, 0, 20, "Next: " + s)
                        endif
                        //call BJDebugMsg("f")
                    endif
                    //call BJDebugMsg("rci finish: " + I2S(playerId))

                    // Cleanup
                    call RemoveLocation(unitSpawnOffset)
                    set unitSpawnOffset = null
                    set creep = null
                endif

                set PlayerRoundCreeps[RoundNumber].group[playerId] = g

                set RoundGenCreepIndex = RoundGenCreepIndex + 1
            endloop
            
            set playerId = playerId + 1
        endloop

        set g = null
    endfunction

    private function init takes nothing returns nothing
        set PlayerRoundCreeps = HashTable.create()
        set GenerateNextCreepLevelTrigger = CreateTrigger()
        call TriggerAddCondition(GenerateNextCreepLevelTrigger, Condition(function GenerateNextCreepLevelConditions))
        call TriggerAddAction(GenerateNextCreepLevelTrigger, function GenerateNextCreepLevelActions)
    endfunction

endlibrary
