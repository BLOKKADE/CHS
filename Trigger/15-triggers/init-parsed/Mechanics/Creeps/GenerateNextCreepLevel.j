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
        integer RoundCreepChanceFingerOfDeath = 0
        integer RoundCreepChanceHex = 0
        integer RoundCreepChanceFirebolt = 0
        integer RoundCreepChanceSilence = 0
        integer RoundCreepChanceAerialShackles = 0
        integer RoundCreepChanceBanish = 0
        integer RoundCreepChanceHolyLight = 0
        integer RoundCreepChanceTranquility = 0
        integer RoundCreepChanceChainLightning = 0
        integer RoundCreepChanceWarStomp = 0
        integer RoundCreepChanceEnvenomedWeapons = 0
        integer RoundCreepChanceDestruction = 0
        integer RoundCreepChanceCripple = 0
        integer RoundCreepChanceFrostArmor = 0
        integer RoundCreepChanceImpale = 0
        integer RoundCreepChanceSleep = 0
        integer RoundCreepChanceCurse = 0
        integer RoundCreepChanceSpellImmunity = 0
        integer RoundCreepChanceReincarnation = 0
        integer RoundCreepChanceDevastatingBlow = 0    
        integer RoundCreepChanceDeathCoil = 0
        integer RoundCreepChanceFingerOfPain = 0
        integer RoundCreepChanceHowlOfTerror = 0
        integer RoundCreepChanceEnergyShield = 0
        integer RoundCreepChanceFastMagic = 0
        integer RoundCreepChanceCruelty = 0
        integer RoundCreepChanceCutting = 0
        integer RoundCreepChanceLiquidFire = 0
        integer RoundCreepChanceSoulBurn = 0
        integer RoundCreepChanceColdWind = 0
        integer RoundCreepChanceIncinerate = 0
        integer RoundCreepChanceFearAura = 0
        integer RoundCreepChanceForkedLightning = 0
        integer RoundCreepChanceHardenedSkin = 0
        integer RoundCreepChanceIcyBreath = 0
        integer RoundCreepChanceFrostBolt = 0
        integer RoundCreepChancePolymorph = 0
        integer RoundCreepChanceFrenzy = 0
        integer RoundCreepChanceUnholyFrenzy = 0

//tested and not working yet:
        integer RoundCreepChanceBattleRoar = 0
        integer RoundCreepChanceFeedback = 0
        integer RoundCreepChanceStasisTrap = 0
        integer RoundCreepChanceInnerFire = 0
        integer RoundCreepChanceLightningShield = 0
        integer RoundCreepChancePurge = 0
        integer RoundCreepChanceCrushingWave = 0
        integer RoundCreepChanceCarrionSwarm = 0
        integer RoundCreepChanceDeathAndDecay = 0
        integer RoundCreepChanceCyclone = 0

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
    
    private function ResetRoundCreepChances takes nothing returns nothing
        set RoundCreepChanceReflectAura = 0
        set RoundCreepChanceWizardbane = 0
        set RoundCreepChanceDrunkMaster = 0
        set RoundCreepChanceSlowAura = 0
        set RoundCreepChancePulverize = 0
        set RoundCreepChanceLastBreath = 0
        set RoundCreepChanceBloodlust = 0
        set RoundCreepChanceUnlimitedAgony = 0
        set RoundCreepChanceCorrosiveSkin = 0
        set RoundCreepChanceImmortalAura = 0
        set RoundCreepChanceDivineShield = 0
        set RoundCreepChanceEnsnare = 0
        set RoundCreepChanceGuardianSpirit = 0
        set RoundCreepChanceAvatar = 0
        set RoundCreepChanceHealingWave = 0
        set RoundCreepChanceRainOfFire = 0
        set RoundCreepChanceAntiMagicShell = 0
        set RoundCreepChanceStoneProt = 0
        set RoundCreepChanceDivineBubble = 0
        set RoundCreepChanceAncientTeaching = 0
        set RoundCreepChanceIceForce = 0
        set RoundCreepChanceBlizzard = 0
        set RoundCreepChanceFrostNova = 0
        set RoundCreepChanceEntanglingRoots = 0
        set RoundCreepChanceStormBolt = 0
        set RoundCreepChanceFingerOfDeath = 0
        set RoundCreepChanceHex = 0
        set RoundCreepChanceFirebolt = 0
        set RoundCreepChanceSilence = 0
        set RoundCreepChanceAerialShackles = 0
        set RoundCreepChanceBanish = 0
        set RoundCreepChanceHolyLight = 0
        set RoundCreepChanceTranquility = 0
        set RoundCreepChanceChainLightning = 0
        set RoundCreepChanceWarStomp = 0
        set RoundCreepChanceEnvenomedWeapons = 0
        set RoundCreepChanceDestruction = 0
        set RoundCreepChanceCripple = 0
        set RoundCreepChanceFrostArmor = 0
        set RoundCreepChanceImpale = 0
        set RoundCreepChanceSleep = 0
        set RoundCreepChanceCurse = 0
        set RoundCreepChanceSpellImmunity = 0
        set RoundCreepChanceReincarnation = 0
        set RoundCreepChanceDevastatingBlow = 0
        set RoundCreepChanceDeathCoil = 0
        set RoundCreepChanceFingerOfPain = 0
        set RoundCreepChanceHowlOfTerror = 0
        set RoundCreepChanceEnergyShield = 0
        set RoundCreepChanceFastMagic = 0
        set RoundCreepChanceCruelty = 0
        set RoundCreepChanceCutting = 0
        set RoundCreepChanceLiquidFire = 0
        set RoundCreepChanceSoulBurn = 0
        set RoundCreepChanceColdWind = 0
        set RoundCreepChanceIncinerate = 0
        set RoundCreepChanceFearAura = 0
        set RoundCreepChanceForkedLightning = 0
        set RoundCreepChanceFrostBolt = 0
        set RoundCreepChanceCyclone = 0
        set RoundCreepChanceIcyBreath = 0
        set RoundCreepChanceHardenedSkin = 0
        set RoundCreepChanceBattleRoar = 0
        set RoundCreepChanceFeedback = 0
        set RoundCreepChanceStasisTrap = 0
        set RoundCreepChanceInnerFire = 0
        set RoundCreepChanceLightningShield = 0
        set RoundCreepChancePurge = 0
        set RoundCreepChanceCrushingWave = 0
        set RoundCreepChanceCarrionSwarm = 0
        set RoundCreepChanceDeathAndDecay = 0
        set RoundCreepChanceBash = 0
        set RoundCreepChanceHurlBoulder = 0
        set RoundCreepChanceRejuv = 0
        set RoundCreepChanceSlow = 0
        set RoundCreepChanceBigBadV = 0
        set RoundCreepChanceBlink = 0
        set RoundCreepChanceCritStrike = 0
        set RoundCreepChanceShockwave = 0
        set RoundCreepChanceThunderClap = 0
        set RoundCreepChanceEvasion = 0
        set RoundCreepChanceFaerieFire = 0
        set RoundCreepChanceLifesteal = 0
        set RoundCreepChanceManaBurn = 0
        set RoundCreepChanceCleave = 0
        set RoundCreepChanceThorns = 0
        set RoundCreepChanceShadowStrike = 0
        set RoundCreepChancePolymorph = 0
        set RoundCreepChanceFrenzy = 0
        set RoundCreepChanceUnholyFrenzy = 0
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
    
        if RoundCreepChanceAerialShackles == 1 then
            set s = ConcatAbility(s, "|cffff00ffAerial Shackles")
            call AddRoundAbility(AERIALSHACKLES_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceAncientTeaching == 1 then
            set s = ConcatAbility(s, "Ancient Teaching")
            call AddRoundAbility(ANCIENT_TEACHING_ABILITY_ID)
        endif

        if RoundCreepChanceAntiMagicShell == 1 then
            set s = ConcatAbility(s, "Anti-Magic Shell")
            call AddRoundAbility(ANTI_MAGIC_SHEL_ABILITY_ID)
        endif

        if RoundCreepChanceAvatar == 1 then
            set s = ConcatAbility(s, "Avatar")
            call AddRoundAbility(ACTIVATE_AVATAR_ABILITY_ID)
        endif

        if RoundCreepChanceImmortalAura == 1 then
            set s = ConcatAbility(s, "Aura of Immortality")
            call AddRoundAbility(AURA_OF_IMMORTALITY_ABILITY_ID)
        endif

        if RoundCreepChanceBackStab == 1 then
            set s = ConcatAbility(s, "Backstab")
            call AddRoundAbility(BACKSTAB_ABILITY_ID)
        endif

        if RoundCreepChanceBanish == 1 then
            set s = ConcatAbility(s, "Banish")
            call AddRoundAbility(BANISH_ABILITY_ID)
        endif

        if RoundCreepChanceBash == 1 and RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
            set s = ConcatAbility(s, "|cffff00ffBash")
            call AddRoundAbility('ACbh')
        endif

        if RoundCreepChanceBattleRoar == 1 then
            set s = ConcatAbility(s, "Battle Roar")
            call AddRoundAbility(BATTLE_ROAR_ABILITY_ID)
        endif

        if RoundCreepChanceBigBadV == 1 then
            set s = ConcatAbility(s, "Big Bad Voodoo")
            call AddRoundAbility(BIGBADVOODOO_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceBlizzard == 1 then
            set s = ConcatAbility(s, "|cffff00ffBlizzard")
            call AddRoundAbility(BLIZZARD_ABILITY_ID)
        endif

        if RoundCreepChanceBlink == 1 then
            set s = ConcatAbility(s, "Blink")
            call AddRoundAbility(BLINK_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceBloodlust == 1 then
            set s = ConcatAbility(s, "Bloodlust")
            call AddRoundAbility(BLOODLUST_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceCarrionSwarm == 1 then
            set s = ConcatAbility(s, "|cffff00ffCarrion Swarm")
            call AddRoundAbility(CARRION_SWARM_ABILITY_ID)
        endif

        if RoundCreepChanceChainLightning == 1 then
            set s = ConcatAbility(s, "|cffff00ffChain Lightning")
            call AddRoundAbility(CHAINLIGHTNING_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceCleave == 1 and RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' and RoundCreepTypeId != 'n01p' and RoundCreepTypeId != 'n01g' and RoundCreepTypeId != 'n01t' and RoundCreepTypeId != 'n01F' and RoundCreepTypeId != 'n01A' and RoundCreepTypeId != 'n006' then
            set s = ConcatAbility(s, "|cffff00ffCleave")
            call AddRoundAbility(CLEAVE_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceColdWind == 1 then
            set s = ConcatAbility(s, "Cold Wind")
            call AddRoundAbility(COLD_WIND_ABILITY_ID)
        endif

        if RoundCreepChanceCorrosiveSkin == 1 then
            set s = ConcatAbility(s, "|cffff00ffCorrosive Skin")
            call AddRoundAbility(CORROSIVE_SKIN_ABILITY_ID)
        endif

        if RoundCreepChanceCripple == 1 then
            set s = ConcatAbility(s, "Cripple")
            call AddRoundAbility(CRIPPLE_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceCritStrike == 1 and RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
            set s = ConcatAbility(s, "Critical Strike")
            call AddRoundAbility(CRITICAL_STRIKE_ABILITY_ID)
        endif

        if RoundCreepChanceCruelty == 1 and RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
            set s = ConcatAbility(s, "Cruelty")
            call AddRoundAbility(CRUELTY_ABILITY_ID)
        endif

        if RoundCreepChanceCrushingWave == 1 then
            set s = ConcatAbility(s, "Crushing Wave")
            call AddRoundAbility(CRUSHING_WAVE_ABILITY_ID)
        endif

        if RoundCreepChanceCurse == 1 then
            set s = ConcatAbility(s, "Curse")
            call AddRoundAbility(CURSE_ABILITY_ID)
        endif

        if RoundCreepChanceCutting == 1 and RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
            set s = ConcatAbility(s, "Cutting")
            call AddRoundAbility(CUTTING_ABILITY_ID)
        endif

        if RoundCreepChanceCyclone == 1 then
            set s = ConcatAbility(s, "|cffff00ffCyclone")
            call AddRoundAbility(CYCLONE_ABILITY_ID)
        endif

        if RoundCreepChanceDeathAndDecay == 1 then
            set s = ConcatAbility(s, "|cffff00ffDeath and Decay")
            call AddRoundAbility(DEATH_AND_DECAY_ABILITY_ID)
        endif

        if RoundCreepChanceDeathCoil == 1 then
            set s = ConcatAbility(s, "|cffff00ffDeath Coil")
            call AddRoundAbility(DEATHCOIL_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceDestruction == 1 and RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
            set s = ConcatAbility(s, "|cffff00ffDestruction")
            call AddRoundAbility(DESTRUCTION_ABILITY_ID)
        endif

        if RoundCreepChanceDevastatingBlow == 1 then
            set s = ConcatAbility(s, "|cffff00ffDevastating Blow")
            call AddRoundAbility(DEVASTATING_BLOW_ABILITY_ID)
        endif

        if RoundCreepChanceDivineBubble == 1 then
            set s = ConcatAbility(s, "Divine Bubble")
            call AddRoundAbility(DIVINE_BUBBLE_ABILITY_ID)
        endif

        if RoundCreepChanceDivineShield == 1 then
            set s = ConcatAbility(s, "Divine Shield")
            call AddRoundAbility(DIVINE_SHIELD_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceDrunkMaster == 1 and RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
            set s = ConcatAbility(s, "Drunken Master")
            call AddRoundAbility(DRUNKEN_MASTER_ABILITY_ID)
        endif

        if RoundCreepChanceEnergyShield == 1 then
            set s = ConcatAbility(s, "Energy Shield")
            call AddRoundAbility(ENERGY_SHIELD_ABILITY_ID)
        endif

        if RoundCreepChanceEnsnare == 1 then
            set s = ConcatAbility(s, "Ensnare")
            call AddRoundAbility(ENSNARE_ABILITY_ID)
        endif

        if RoundCreepChanceEntanglingRoots == 1 then
            set s = ConcatAbility(s, "|cffff00ffEntangling Roots")
            call AddRoundAbility(ENTAGLING_ROOTS_ABILITY_ID)
        endif

        if RoundCreepChanceEnvenomedWeapons == 1 and RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
            set s = ConcatAbility(s, "|cffff00ffEnvenomed Weapons")
            call AddRoundAbility(ENVENOMED_WEAPONS_ABILITY_ID)
        endif

        if RoundCreepChanceEvasion == 1 then
            set s = ConcatAbility(s, "Evasion")
        endif

        if RoundCreepChanceFaerieFire == 1 then
            set s = ConcatAbility(s, "Faerie Fire")
            call AddRoundAbility(FAERIE_FIRE_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceFastMagic == 1 then
            set s = ConcatAbility(s, "Fast Magic")
            call AddRoundAbility(FAST_MAGIC_ABILITY_ID)
        endif

        if RoundCreepChanceFearAura == 1 then
            set s = ConcatAbility(s, "Fear Aura")
            call AddRoundAbility(AURA_OF_FEAR_ABILITY_ID)
        endif

        if RoundCreepChanceFeedback == 1 then
            set s = ConcatAbility(s, "Feedback")
            call AddRoundAbility(FEEDBACK_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceFingerOfDeath == 1 then
            set s = ConcatAbility(s, "|cffff00ffFinger of Death")
            call AddRoundAbility(FINGER_OF_DEATH_ABILITY_ID)
        endif

        if RoundCreepChanceFingerOfPain == 1 then
            set s = ConcatAbility(s, "|cffff00ffFinger of Pain")
            call AddRoundAbility(FINGEROFPAIN_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceFirebolt == 1 then
            set s = ConcatAbility(s, "|cffff00ffFirebolt")
            call AddRoundAbility(FIREBOLT_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceForkedLightning == 1 then
            set s = ConcatAbility(s, "|cffff00ffForked Lightning")
            call AddRoundAbility(FORKED_LIGHTNING_ABILITY_ID)
        endif

        if RoundCreepChanceFrostBolt == 1 then
            set s = ConcatAbility(s, "|cffff00ffFrost Bolt")
            call AddRoundAbility(FROSTBOLT_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceIcyBreath == 1 then
            set s = ConcatAbility(s, "|cffff00ffIcy Breath")
            call AddRoundAbility(ICY_BREATH_ABILITY_ID)
        endif

        if RoundCreepChanceFrenzy == 1 then
            set s = ConcatAbility(s, "Frenzy")
            call AddRoundAbility(FRENZY_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceFrostArmor == 1 then
            set s = ConcatAbility(s, "Frost Armor")
            call AddRoundAbility(FROST_ARMOR_ABILITY_ID)
        endif

        if RoundCreepChanceFrostNova == 1 then
            set s = ConcatAbility(s, "|cffff00ffFrost Nova")
            call AddRoundAbility(FROST_NOVA_ABILITY_ID)
        endif

        if RoundCreepChanceGuardianSpirit == 1 then
            set s = ConcatAbility(s, "Guardian Spirit")
            call AddRoundAbility(GUARDIAN_SPIRIT_ABILITY_ID)
        endif

        if RoundCreepChanceHardenedSkin == 1 then
            set s = ConcatAbility(s, "Hardened Skin")
            call AddRoundAbility(HARDENED_SKIN_ABILITY_ID)
        endif

        if RoundCreepChanceHealingWave == 1 then
            set s = ConcatAbility(s, "Healing Wave")
            call AddRoundAbility(HEALING_WAVE_ABILITY_ID)
        endif

        if RoundCreepChanceHex == 1 then
            set s = ConcatAbility(s, "Hex")
            call AddRoundAbility(HEX_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceHolyLight == 1 then
            set s = ConcatAbility(s, "|cffff00ffHoly Light")
            call AddRoundAbility(HOLY_LIGHT_ABILITY_ID)
        endif

        if RoundCreepChanceHowlOfTerror == 1 then
            set s = ConcatAbility(s, "Howl of Terror")
            call AddRoundAbility(HOWL_OF_TERROR_ABILITY_ID)
        endif

        if RoundCreepChanceHurlBoulder == 1 then
            set s = ConcatAbility(s, "|cffff00ffHurl Boulder")
            call AddRoundAbility(HURL_BOULDER_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceIceForce == 1 then
            set s = ConcatAbility(s, "Ice Force")
            call AddRoundAbility(ICE_ARMOR_SUMMON_ABILITY_ID)
        endif

        if RoundCreepChanceImpale == 1 then
            set s = ConcatAbility(s, "|cffff00ffImpale")
            call AddRoundAbility(IMPALE_ABILITY_ID)
        endif

        if RoundCreepChanceIncinerate == 1 and RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
            set s = ConcatAbility(s, "Incinerate")
            call AddRoundAbility(INCINERATE_ABILITY_ID)
        endif

        if RoundCreepChanceInnerFire == 1 then
            set s = ConcatAbility(s, "Inner Fire")
            call AddRoundAbility(INNER_FIRE_ABILITY_ID)
        endif

        if RoundCreepChanceLastBreath == 1 then
            set s = ConcatAbility(s, "Last Breaths")
            call AddRoundAbility(LAST_BREATHS_ABILITY_ID)
        endif

        if RoundCreepChanceLifesteal == 1 then
            set s = ConcatAbility(s, "Lifesteal")
            call AddRoundAbility(LIFESTEAL_CREEP_ABILITY_ID )
        endif

        if RoundCreepChanceLightningShield == 1 then
            set s = ConcatAbility(s, "|cffff00ffLightning Shield")
            call AddRoundAbility(LIGHTNING_SHIELD_ABILITY_ID)
        endif

        if RoundCreepChanceLiquidFire == 1 and RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
            set s = ConcatAbility(s, "|cffff00ffLiquid Fire")
            call AddRoundAbility(LIQUID_FIRE_ABILITY_ID)
        endif

        if RoundCreepChanceManaBurn == 1 then
            set s = ConcatAbility(s, "|cffff00ffMana Burn")
            call AddRoundAbility(MANA_BURN_CREEP_ABILITY_ID)
        endif

        if RoundCreepChancePolymorph == 1 then
            set s = ConcatAbility(s, "Polymorph")
            call AddRoundAbility(POLYMORPH_CREEP_ABILITY_ID)
        endif

        if RoundCreepChancePulverize == 1 and RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
            set s = ConcatAbility(s, "|cffff00ffPulverize")
            call AddRoundAbility(PULVERIZE_ABILITY_ID)
        endif

        if RoundCreepChancePurge == 1 then
            set s = ConcatAbility(s, "Purge")
            call AddRoundAbility(PURGE_ABILITY_ID)
        endif

        if RoundCreepChanceRainOfFire == 1 then
            set s = ConcatAbility(s, "|cffff00ffRain of Fire")
            call AddRoundAbility(RAIN_OF_FIRE_ABILITY_ID)
        endif

        /*if RoundCreepChanceRandomSpell == 1 then
            set s = ConcatAbility(s, "Random Spell")
            call AddRoundAbility(RANDOM_SPELL_ABILITY_ID)
        endif*/

        if RoundCreepChanceReflectAura == 1 then
            set s = ConcatAbility(s, "|cffff00ffReflection Aura")
            call AddRoundAbility(REFLECTION_AUR_ABILITY_ID)
        endif

        if RoundCreepChanceReincarnation == 1 then
            set s = ConcatAbility(s, "Reincarnation")
            call AddRoundAbility(REINCARNATION_ABILITY_ID)
        endif

        if RoundCreepChanceRejuv == 1 then
            set s = ConcatAbility(s, "Rejuvenation")
            call AddRoundAbility(REJUVENATION_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceShadowStrike == 1 then
            set s = ConcatAbility(s, "|cffff00ffShadow Strike")
            call AddRoundAbility(SHADOW_STRIKE_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceShockwave == 1 then
            set s = ConcatAbility(s, "|cffff00ffShockwave")
            call AddRoundAbility(SHOCKWAVE_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceSilence == 1 then
            set s = ConcatAbility(s, "Silence")
            call AddRoundAbility(SILENCE_ABILITY_ID)
        endif

        if RoundCreepChanceSleep == 1 then
            set s = ConcatAbility(s, "Sleep")
            call AddRoundAbility(SLEEP_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceSlow == 1 then
            set s = ConcatAbility(s, "Slow")
            call AddRoundAbility(SLOW_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceSlowAura == 1 then
            set s = ConcatAbility(s, "Slow Aura")
            call AddRoundAbility(SLOW_AURA_ABILITY_ID)
        endif

        if RoundCreepChanceSoulBurn == 1 then
            set s = ConcatAbility(s, "|cffff00ffThorns Aura|r")
            call AddRoundAbility(SOUL_BURN_ABILITY_ID)
        endif

        if RoundCreepChanceSpellImmunity == 1 then
            set s = ConcatAbility(s, "Spell Immunity")
            call AddRoundAbility(SPELL_IMMUNITY_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceStasisTrap == 1 then
            set s = ConcatAbility(s, "Stasis Trap")
            call AddRoundAbility(STASIS_TRAP_ABILITY_ID)
        endif

        if RoundCreepChanceStoneProt == 1 then
            set s = ConcatAbility(s, "|cffff00ffStone Protection")
            call AddRoundAbility(STONE_PROTECTION_ABILITY_ID)
        endif

        if RoundCreepChanceStormBolt == 1 then
            set s = ConcatAbility(s, "|cffff00ffStorm Bolt")
            call AddRoundAbility(STORM_BOLT_ABILITY_ID)
        endif

        if RoundCreepChanceThorns == 1 then
            set s = ConcatAbility(s, "|cffff00ffThorns Aura")
            call AddRoundAbility(THORNS_AURA_ABILITY_ID)
        endif

        if RoundCreepChanceThunderClap == 1 then
            set s = ConcatAbility(s, "|cffff00ffThunder Clap")
            call AddRoundAbility(THUNDER_CLAP_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceTranquility == 1 then
            set s = ConcatAbility(s, "Tranquility")
            call AddRoundAbility(TRANQUILITY_ABILITY_ID)
        endif

        if RoundCreepChanceUnholyFrenzy == 1 then
            set s = ConcatAbility(s, "Unholy Frenzy")
            call AddRoundAbility(UNHOLYFRENZY_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceUnlimitedAgony == 1 then
            set s = ConcatAbility(s, "Unlimited Agony")
            call AddRoundAbility(UNLIMITED_AGON_ABILITY_ID)
        endif

        if RoundCreepChanceWarStomp == 1 then
            set s = ConcatAbility(s, "|cffff00ffWar Stomp")
            call AddRoundAbility(WAR_STOMP_ABILITY_ID)
        endif

        if RoundCreepChanceWizardbane == 1 then
            set s = ConcatAbility(s, "|cffff00ffWizardbane Aura")
            call AddRoundAbility(WIZARDBANE_AURA_ABILITY_ID)
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
    
        if RoundCreepChanceAerialShackles == 1 then
            call UnitAddAbility(u, AERIALSHACKLES_CREEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, AERIALSHACKLES_CREEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceAncientTeaching == 1 then
            call UnitAddAbility(u, ANCIENT_TEACHING_ABILITY_ID)
            call SetUnitAbilityLevel(u, ANCIENT_TEACHING_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceAntiMagicShell == 1 then
            call UnitAddAbility(u, ANTI_MAGIC_SHEL_ABILITY_ID)
            call SetUnitAbilityLevel(u, ANTI_MAGIC_SHEL_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceAvatar == 1 then
            call UnitAddAbility(u, ACTIVATE_AVATAR_ABILITY_ID)
            call SetUnitAbilityLevel(u, ACTIVATE_AVATAR_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceBackStab == 1 then
            call UnitAddAbility(u, BACKSTAB_ABILITY_ID)
            call SetUnitAbilityLevel(u, BACKSTAB_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceBanish == 1 then
            call UnitAddAbility(u, BANISH_ABILITY_ID)
            call SetUnitAbilityLevel(u, BANISH_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.4), 30))
        endif

        if RoundCreepChanceBattleRoar == 1 then
            call UnitAddAbility(u, BATTLE_ROAR_ABILITY_ID)
            call SetUnitAbilityLevel(u, BATTLE_ROAR_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceBlizzard == 1 then
            call UnitAddAbility(u, BLIZZARD_ABILITY_ID)
            call SetUnitAbilityLevel(u, BLIZZARD_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceBloodlust == 1 then
            call UnitAddAbility(u, BLOODLUST_CREEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, BLOODLUST_CREEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceCarrionSwarm == 1 then
            call UnitAddAbility(u, CARRION_SWARM_ABILITY_ID)
            call SetUnitAbilityLevel(u, CARRION_SWARM_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.4), 30))
        endif

        if RoundCreepChanceChainLightning == 1 then
            call UnitAddAbility(u, CHAINLIGHTNING_CREEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, CHAINLIGHTNING_CREEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.4), 30))
        endif

        if RoundCreepChanceColdWind == 1 then
            call UnitAddAbility(u, COLD_WIND_ABILITY_ID)
            call SetUnitAbilityLevel(u, COLD_WIND_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.2), 30))
        endif

        if RoundCreepChanceCorrosiveSkin == 1 then
            call UnitAddAbility(u, CORROSIVE_SKIN_ABILITY_ID)
            call SetUnitAbilityLevel(u, CORROSIVE_SKIN_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.4), 30))
        endif

        if RoundCreepChanceCripple == 1 then
            call UnitAddAbility(u, CRIPPLE_CREEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, CRIPPLE_CREEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceCritStrike == 1 and RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
            call SetUnitAbilityLevel(u, CRITICAL_STRIKE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.4), 30))
        endif

        if RoundCreepChanceCruelty == 1 and RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
            call UnitAddAbility(u, CRUELTY_ABILITY_ID)
            call SetUnitAbilityLevel(u, CRUELTY_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.4), 30))
        endif

        if RoundCreepChanceCrushingWave == 1 then
            call UnitAddAbility(u, CRUSHING_WAVE_ABILITY_ID)
            call SetUnitAbilityLevel(u, CRUSHING_WAVE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceCurse == 1 then
            call UnitAddAbility(u, CURSE_ABILITY_ID)
            call SetUnitAbilityLevel(u, CURSE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.4), 30))
        endif

        if RoundCreepChanceCutting == 1 and RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
            call UnitAddAbility(u, CUTTING_ABILITY_ID)
            call SetUnitAbilityLevel(u, CUTTING_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceCyclone == 1 then
            call UnitAddAbility(u, CYCLONE_ABILITY_ID)
            call SetUnitAbilityLevel(u, CYCLONE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceDeathAndDecay == 1 then
            call UnitAddAbility(u, DEATH_AND_DECAY_ABILITY_ID)
            call SetUnitAbilityLevel(u, DEATH_AND_DECAY_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceDeathCoil == 1 then
            call UnitAddAbility(u, DEATHCOIL_CREEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, DEATHCOIL_CREEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceDestruction == 1 and RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
            call UnitAddAbility(u, DESTRUCTION_ABILITY_ID)
            call SetUnitAbilityLevel(u, DESTRUCTION_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.2), 30))
        endif

        if RoundCreepChanceDevastatingBlow == 1 then
            call UnitAddAbility(u, DEVASTATING_BLOW_ABILITY_ID)
            call SetUnitAbilityLevel(u, DEVASTATING_BLOW_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.3), 30))
        endif

        if RoundCreepChanceDivineBubble == 1 then
            call UnitAddAbility(u, DIVINE_BUBBLE_ABILITY_ID)
            call SetUnitAbilityLevel(u, DIVINE_BUBBLE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceDivineShield == 1 then
            call UnitAddAbility(u, DIVINE_SHIELD_CREEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, DIVINE_SHIELD_CREEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceDrunkMaster == 1 and RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
            call UnitAddAbility(u, DRUNKEN_MASTER_ABILITY_ID)
            call FuncEditParam(DRUNKEN_MASTER_ABILITY_ID, u)
            call SetUnitAbilityLevel(u, DRUNKEN_MASTER_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.3), 30))
        endif

        if RoundCreepChanceEnergyShield == 1 then
            call UnitAddAbility(u, ENERGY_SHIELD_ABILITY_ID)
            call SetUnitAbilityLevel(u, ENERGY_SHIELD_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceEnsnare == 1 then
            call UnitAddAbility(u, ENSNARE_ABILITY_ID)
            call SetUnitAbilityLevel(u, ENSNARE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceEntanglingRoots == 1 then
            call UnitAddAbility(u, ENTAGLING_ROOTS_ABILITY_ID)
            call SetUnitAbilityLevel(u, ENTAGLING_ROOTS_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceEnvenomedWeapons == 1 and RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
            call UnitAddAbility(u, ENVENOMED_WEAPONS_ABILITY_ID)
            call SetUnitAbilityLevel(u, ENVENOMED_WEAPONS_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.1), 30))
        endif

        if RoundCreepChanceFastMagic == 1 then
            call UnitAddAbility(u, FAST_MAGIC_ABILITY_ID)
            call SetUnitAbilityLevel(u, FAST_MAGIC_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceFearAura == 1 then
            call UnitAddAbility(u, AURA_OF_FEAR_ABILITY_ID)
            call SetUnitAbilityLevel(u, AURA_OF_FEAR_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceFeedback == 1 then
            call UnitAddAbility(u, FEEDBACK_CREEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, FEEDBACK_CREEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceFingerOfDeath == 1 then
            call UnitAddAbility(u, FINGER_OF_DEATH_ABILITY_ID)
            call SetUnitAbilityLevel(u, FINGER_OF_DEATH_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceFingerOfPain == 1 then
            call UnitAddAbility(u, FINGEROFPAIN_CREEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, FINGEROFPAIN_CREEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceFirebolt == 1 then
            call UnitAddAbility(u, FIREBOLT_CREEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, FIREBOLT_CREEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceForkedLightning == 1 then
            call UnitAddAbility(u, FORKED_LIGHTNING_ABILITY_ID)
            call SetUnitAbilityLevel(u, FORKED_LIGHTNING_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceFrenzy == 1 then
            call UnitAddAbility(u, FRENZY_CREEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, FRENZY_CREEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceFrostBolt == 1 then
            call UnitAddAbility(u, FROSTBOLT_CREEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, FROSTBOLT_CREEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceIcyBreath == 1 then
            call UnitAddAbility(u, ICY_BREATH_ABILITY_ID)
            call SetUnitAbilityLevel(u, ICY_BREATH_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceFrostArmor == 1 then
            call UnitAddAbility(u, FROST_ARMOR_ABILITY_ID)
            call SetUnitAbilityLevel(u, FROST_ARMOR_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceFrostNova == 1 then
            call UnitAddAbility(u, FROST_NOVA_ABILITY_ID)
            call SetUnitAbilityLevel(u, FROST_NOVA_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.3), 30))
        endif

        if RoundCreepChanceGuardianSpirit == 1 then
            call UnitAddAbility(u, GUARDIAN_SPIRIT_ABILITY_ID)
            call SetUnitAbilityLevel(u, GUARDIAN_SPIRIT_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceHardenedSkin == 1 then
            call UnitAddAbility(u, HARDENED_SKIN_ABILITY_ID)
            call SetUnitAbilityLevel(u, HARDENED_SKIN_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.3), 30))
            call AddUnitCustomState(u, BONUS_BLOCK, (RoundNumber * 0.3) * 50)	// have to manually add bc the ability doesnt normally gibs
        endif

        if RoundCreepChanceHealingWave == 1 then
            call UnitAddAbility(u, HEALING_WAVE_ABILITY_ID)
            call SetUnitAbilityLevel(u, HEALING_WAVE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceHex == 1 then
            call UnitAddAbility(u, HEX_CREEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, HEX_CREEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceHolyLight == 1 then
            call UnitAddAbility(u, HOLY_LIGHT_ABILITY_ID)
            call SetUnitAbilityLevel(u, HOLY_LIGHT_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceHowlOfTerror == 1 then
            call UnitAddAbility(u, HOWL_OF_TERROR_ABILITY_ID)
            call SetUnitAbilityLevel(u, HOWL_OF_TERROR_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceIceForce == 1 then
            call UnitAddAbility(u, ICE_ARMOR_SUMMON_ABILITY_ID)
            call SetUnitAbilityLevel(u, ICE_ARMOR_SUMMON_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceImmortalAura == 1 then
            call UnitAddAbility(u, AURA_OF_IMMORTALITY_ABILITY_ID)
            call SetUnitAbilityLevel(u, AURA_OF_IMMORTALITY_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceImpale == 1 then
            call UnitAddAbility(u, IMPALE_ABILITY_ID)
            call SetUnitAbilityLevel(u, IMPALE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceIncinerate == 1 and RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
            call UnitAddAbility(u, INCINERATE_ABILITY_ID)
            call SetUnitAbilityLevel(u, INCINERATE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceInnerFire == 1 then
            call UnitAddAbility(u, INNER_FIRE_ABILITY_ID)
            call SetUnitAbilityLevel(u, INNER_FIRE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceLastBreath == 1 then
            call UnitAddAbility(u, LAST_BREATHS_ABILITY_ID)
            call FuncEditParam(LAST_BREATHS_ABILITY_ID, u)
            call SetUnitAbilityLevel(u, LAST_BREATHS_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceLightningShield == 1 then
            call UnitAddAbility(u, LIGHTNING_SHIELD_ABILITY_ID)
            call SetUnitAbilityLevel(u, LIGHTNING_SHIELD_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceLiquidFire == 1 then
            call UnitAddAbility(u, LIQUID_FIRE_ABILITY_ID)
            call SetUnitAbilityLevel(u, LIQUID_FIRE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.4), 30))
        endif

        if RoundCreepChancePolymorph == 1 then
            call UnitAddAbility(u, POLYMORPH_CREEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, POLYMORPH_CREEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChancePurge == 1 then
            call UnitAddAbility(u, PURGE_ABILITY_ID)
            call SetUnitAbilityLevel(u, PURGE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChancePulverize == 1 and RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
            call UnitAddAbility(u, PULVERIZE_ABILITY_ID)
            call SetUnitAbilityLevel(u, PULVERIZE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.3), 30))
        endif

        if RoundCreepChanceRainOfFire == 1 then
            call UnitAddAbility(u, RAIN_OF_FIRE_ABILITY_ID)
            call SetUnitAbilityLevel(u, RAIN_OF_FIRE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        /* if RoundCreepChanceRandomSpell == 1 then
            call UnitAddAbility(u, RANDOM_SPELL_ABILITY_ID)
            call SetUnitAbilityLevel(u, RANDOM_SPELL_ABILITY_ID, IMinBJ(R2I(RoundNumber * 1.34), 30))
        endif */

        if RoundCreepChanceReflectAura == 1 then
            call UnitAddAbility(u, REFLECTION_AUR_ABILITY_ID)
            call SetUnitAbilityLevel(u, REFLECTION_AUR_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.4), 30))
        endif

        if RoundCreepChanceReincarnation == 1 then
            call UnitAddAbility(u, REINCARNATION_ABILITY_ID)
            call SetUnitAbilityLevel(u, REINCARNATION_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceShadowStrike == 1 then
            call UnitAddAbility(u, SHADOW_STRIKE_CREEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, SHADOW_STRIKE_CREEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceSilence == 1 then
            call UnitAddAbility(u, SILENCE_ABILITY_ID)
            call SetUnitAbilityLevel(u, SILENCE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceSleep == 1 then
            call UnitAddAbility(u, SLEEP_CREEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, SLEEP_CREEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceSlowAura == 1 then
            call UnitAddAbility(u, SLOW_AURA_ABILITY_ID)
            call SetUnitAbilityLevel(u, SLOW_AURA_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.3), 30))
        endif

        if RoundCreepChanceSoulBurn == 1 then
            call UnitAddAbility(u, SOUL_BURN_ABILITY_ID)
            call SetUnitAbilityLevel(u, SOUL_BURN_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceSpellImmunity == 1 then
            call UnitAddAbility(u, SPELL_IMMUNITY_CREEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, SPELL_IMMUNITY_CREEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceStasisTrap == 1 then
            call UnitAddAbility(u, STASIS_TRAP_ABILITY_ID)
            call SetUnitAbilityLevel(u, STASIS_TRAP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceStoneProt == 1 then
            call UnitAddAbility(u, STONE_PROTECTION_ABILITY_ID)
            call SetUnitAbilityLevel(u, STONE_PROTECTION_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.3), 30))
        endif

        if RoundCreepChanceStormBolt == 1 then
            call UnitAddAbility(u, STORM_BOLT_ABILITY_ID)
            call SetUnitAbilityLevel(u, STORM_BOLT_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceTranquility == 1 then
            call UnitAddAbility(u, TRANQUILITY_ABILITY_ID)
            call SetUnitAbilityLevel(u, TRANQUILITY_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceUnholyFrenzy == 1 then
            call UnitAddAbility(u, UNHOLYFRENZY_CREEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, UNHOLYFRENZY_CREEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceUnlimitedAgony == 1 then
            call UnitAddAbility(u, UNLIMITED_AGON_ABILITY_ID)
            call SetUnitAbilityLevel(u, UNLIMITED_AGON_ABILITY_ID, 30)
        endif

        if RoundCreepChanceWarStomp == 1 then
            call UnitAddAbility(u, WAR_STOMP_ABILITY_ID)
            call SetUnitAbilityLevel(u, WAR_STOMP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceWizardbane == 1 then
            call UnitAddAbility(u, WIZARDBANE_AURA_ABILITY_ID)
            call SetUnitAbilityLevel(u, WIZARDBANE_AURA_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.4), 30))
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
        call ResetRoundCreepChances()

        //stop magic damage units spawning before R15
        if RoundNumber < 15 then
            set RoundCreepTypeId = CreepUnitTypeIds[GetRandomInt(1, MaxCreepUnitTypes - 2)]
        else
            loop
                set RoundCreepTypeId = CreepUnitTypeIds[GetRandomInt(1, MaxCreepUnitTypes)]
                exitwhen RoundCreepTypeId != CreepUnitTypeIds[29] and RoundCreepTypeId != CreepUnitTypeIds[30] and RoundCreepTypeId != CreepUnitTypeIds[31] and RoundCreepTypeId != CreepUnitTypeIds[32] and RoundCreepTypeId != CreepUnitTypeIds[33] and RoundCreepTypeId != CreepUnitTypeIds[34]
            endloop
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

        if RoundNumber > 5 and RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
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

            if RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' and RoundCreepTypeId != 'n01p' and RoundCreepTypeId != 'n01g' and RoundCreepTypeId != 'n01t' and RoundCreepTypeId != 'n01F' and RoundCreepTypeId != 'n01A' and RoundCreepTypeId != 'n006' then
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

        if RoundNumber >= 34 then
            if RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
                //set RoundCreepChanceLiquidFire = GetRandomInt(1, 20) //Liquid Fire chance
                set RoundCreepChanceIncinerate = GetRandomInt(1, 20) //Incinerate chance
                set RoundCreepChanceFearAura = GetRandomInt(1, 20) //Fear Aura chance
                set RoundCreepChanceCruelty = GetRandomInt(1, 20) //Cruelty chance
                set RoundCreepChanceCutting = GetRandomInt(1, 15) //Cutting chance
                set RoundCreepChanceDestruction = GetRandomInt(1, 20) //Destruction chance
                set RoundCreepChanceEnvenomedWeapons = GetRandomInt(1, 180) //Envenomed Weapons chance
                set RoundCreepChanceFrostNova = GetRandomInt(1, 15) //Frost Nova creep chance
            endif
        endif

        if RoundNumber >= 14 then
            set RoundCreepChanceAntiMagicShell = GetRandomInt(1, 35) //Anti magic shell creep chance
            set RoundCreepChanceBackStab = GetRandomInt(1, 15) //Backstab creep chance
            set RoundCreepChanceDivineShield = GetRandomInt(1, 180)  //Divine Shield creep chance
            set RoundCreepChanceBloodlust = GetRandomInt(1, 15) //Bloodlust creep chance
            set RoundCreepChanceEnsnare = GetRandomInt(1, 80) //Ensnare creep chance
            set RoundCreepChanceStoneProt = GetRandomInt(1, 50) //Stone Protection creep chance
            set RoundCreepChanceShadowStrike = GetRandomInt(1, 15) //Shadow Strike creep chance
            set RoundCreepChanceGuardianSpirit = GetRandomInt(1, 10) //Guardian Spirit creep chance
            set RoundCreepChanceAvatar = GetRandomInt(1, 180) //Avatar creep chance
            set RoundCreepChanceHealingWave = GetRandomInt(1, 25) //Healing Wave creep chance
            set RoundCreepChanceIceForce = GetRandomInt(1, 15) //Ice Force creep chance
            set RoundCreepChanceEntanglingRoots = GetRandomInt(1, 180) //Entangling Roots creep chance
            set RoundCreepChanceStormBolt = GetRandomInt(1, 40) //Storm Bolt creep chance
            set RoundCreepChanceFingerOfDeath = GetRandomInt(1, 10000) //Finger of Death chance
            set RoundCreepChanceAncientTeaching = GetRandomInt(1, 15) //Ancient Teaching creep chance
            //set RoundCreepChanceHex = GetRandomInt(1, 80) //Hex chance <- apparently stops xp gain and certain items so disabled for now
            set RoundCreepChanceFirebolt = GetRandomInt(1, 80) //Firebolt chance
            set RoundCreepChanceSilence = GetRandomInt(1, 35) //Silence chance
            set RoundCreepChanceAerialShackles = GetRandomInt(1, 80) //Aerial Shackles chance
            set RoundCreepChanceBanish = GetRandomInt(1, 3000) //Banish chance
            set RoundCreepChanceHolyLight = GetRandomInt(1, 35) //Holy Light chance
            set RoundCreepChanceTranquility = GetRandomInt(1, 80) //Tranquility chance
            set RoundCreepChanceChainLightning = GetRandomInt(1, 80) //Chain Lightning chance
            set RoundCreepChanceWarStomp = GetRandomInt(1, 80) //War Stomp chance     
            set RoundCreepChanceCripple = GetRandomInt(1, 35) //Cripple chance
            set RoundCreepChanceFrostArmor = GetRandomInt(1, 35) //Frost Armor chance
            set RoundCreepChanceImpale = GetRandomInt(1, 80) //Impale chance
            set RoundCreepChanceSleep = GetRandomInt(1, 800) //Sleep chance
            set RoundCreepChanceCurse = GetRandomInt(1, 80) //Curse chance
            set RoundCreepChanceSpellImmunity = GetRandomInt(1, 10000) //Spell Immunity chance
            set RoundCreepChanceReincarnation = GetRandomInt(1, 80) //Reincarnation chance
            set RoundCreepChanceDevastatingBlow = GetRandomInt(1, 10000) //Devastating Blow chance
            set RoundCreepChanceDeathCoil = GetRandomInt(1, 35) //Death Coil chance
            set RoundCreepChanceFingerOfPain = GetRandomInt(1, 80) //Finger of Pain chance
            set RoundCreepChanceHowlOfTerror = GetRandomInt(1, 35) //Howl of Terror chance
            set RoundCreepChanceEnergyShield = GetRandomInt(1, 35) //Energy Shield chance
            set RoundCreepChanceFastMagic = GetRandomInt(1, 25) //Fast Magic chance        
            set RoundCreepChanceForkedLightning = GetRandomInt(1, 80) //Forked Lightning chance
            set RoundCreepChanceFrostBolt = GetRandomInt(1, 80) //Frost bolt chance
            //set RoundCreepChancePolymorph = GetRandomInt(1, 80) //Polymorph chance <- apparently stops xp gain and certain items so disabled for now
            set RoundCreepChanceFrenzy = GetRandomInt(1, 15) //Frenzy chance
            set RoundCreepChanceUnholyFrenzy = GetRandomInt(1, 25) //Unholy frenzy chance
            set RoundCreepChanceIcyBreath = GetRandomInt(1, 35) //icy breath chance
            set RoundCreepChanceSoulBurn = GetRandomInt(1, 35) //Soul Burn chance
            set RoundCreepChanceColdWind = GetRandomInt(1, 25) //Cold Wind chance
            set RoundCreepChanceHardenedSkin = GetRandomInt(1, 25) //Hardened Skin chance*/
//dees isnt workkin yet:
            /*set RoundCreepChanceBattleRoar = GetRandomInt(1, 15) //Battle Roar chance
            set RoundCreepChanceFeedback = GetRandomInt(1, 15) //Feedback chance
            set RoundCreepChanceStasisTrap = GetRandomInt(1, 15) //Stasis Trap chance
            set RoundCreepChanceInnerFire = GetRandomInt(1, 15) //Inner Fire chance
            set RoundCreepChanceLightningShield = GetRandomInt(1, 15) //Lightning Shield chance
            set RoundCreepChancePurge = GetRandomInt(1, 15) //Purge chance
            set RoundCreepChanceCrushingWave = GetRandomInt(1, 15) //Crushing Wave chance
            set RoundCreepChanceCarrionSwarm = GetRandomInt(1, 15) //Carrion Swarm chance*/
            //set RoundCreepChanceDeathAndDecay = GetRandomInt(1, 15) //Death and Decay chance
            //set RoundCreepChanceRandomSpell = 15 //Random Spell creep chance
            //set RoundCreepChanceCyclone = GetRandomInt(1, 1) //Cyclone chance
            if GetRemainingPlayerCount() <= 6 then //antilag measure
                set RoundCreepChanceBlizzard = GetRandomInt(1, 20) //Blizzard creep chance
                set RoundCreepChanceRainOfFire = GetRandomInt(1, 30) //Rain of Fire creep chance
                set RoundCreepChanceDivineBubble = GetRandomInt(1, 15)  //Divine Bubble creep chance
            endif
        endif
    
        if RoundNumber == 28 or RoundNumber == 38 or RoundNumber == 48 then
            set RoundCreepChanceLastBreath = GetRandomInt(1, 2) //Last Breaths creep chance
        elseif RoundNumber > 20 then
            set RoundCreepChanceLastBreath = GetRandomInt(1, 50)
        else
            set RoundCreepChanceLastBreath = 2
        endif

        if RoundNumber >= 49 then //Boss round
            call PlaySoundBJ(rescuesound)
            call ResetRoundCreepChances()
            if GetRemainingPlayerCount() <= 4 then 
                set RoundSkillGroupRoll = GetRandomInt(4, 6)
                if RoundSkillGroupRoll == 4 then
                    set RoundCreepTypeId = CreepUnitTypeIds[30]//burning archer
                    //set RoundCreepChanceLiquidFire = 1
                    set RoundCreepChanceIncinerate = 1
                    set RoundCreepChanceCutting = 1
                    set RoundCreepChanceDestruction = 1
                    set RoundCreepChanceEnvenomedWeapons = 1
                    set RoundCreepChanceBash = 1
                    set RoundCreepChanceDrunkMaster = 1
                    set RoundCreepChancePulverize = 1
                    set RoundCreepChanceUnlimitedAgony = 1
                elseif RoundSkillGroupRoll == 5 then
                    set RoundCreepTypeId = CreepUnitTypeIds[31] //holy defenders
                    set RoundCreepChanceImmortalAura = 1
                    set RoundCreepChanceAvatar = 1
                    set RoundCreepChanceDivineBubble = 1
                    set RoundCreepChanceDivineShield = 1
                    set RoundCreepChanceGuardianSpirit = 1
                    set RoundCreepChanceHealingWave = 1
                    set RoundCreepChanceAntiMagicShell = 1
                    set RoundCreepChanceHolyLight = 1
                    set RoundCreepChanceTranquility = 1
                    set RoundCreepChanceUnlimitedAgony = 1
                elseif RoundSkillGroupRoll == 6 then
                    set RoundCreepTypeId = CreepUnitTypeIds[34]//Thunder Lizard
                    set RoundCreepChanceChainLightning = 1
                    set RoundCreepChanceForkedLightning = 1
                    set RoundCreepChanceStormBolt = 1
                    set RoundCreepChanceThunderClap = 1
                    set RoundCreepChanceFastMagic = 1
                    set RoundCreepChanceAncientTeaching = 1
                    set RoundCreepChanceUnlimitedAgony = 1
                endif
            else 
                set RoundSkillGroupRoll = GetRandomInt(7, 9)
                if RoundSkillGroupRoll == 7 then
                    set RoundCreepTypeId = CreepUnitTypeIds[32] //Dragon turtle
                    set RoundCreepChanceThorns = 1
                    set RoundCreepChanceReflectAura = 1
                    set RoundCreepChanceWizardbane = 1
                    set RoundCreepChanceCorrosiveSkin = 1
                    set RoundCreepChanceUnlimitedAgony = 1
                elseif RoundSkillGroupRoll == 8 then
                    set RoundCreepTypeId = CreepUnitTypeIds[29]//Magnataur
                    set RoundCreepChanceSlowAura = 1
                    set RoundCreepChanceFrostNova = 1
                    set RoundCreepChanceBlizzard = 1
                    set RoundCreepChanceIcyBreath = 1
                    set RoundCreepChanceIceForce = 1
                    set RoundCreepChanceColdWind = 1
                    set RoundCreepChanceFrostArmor = 1
                    set RoundCreepChanceFrostBolt = 1
                    set RoundCreepChanceAncientTeaching = 1
                    set RoundCreepChanceUnlimitedAgony = 1
                elseif RoundSkillGroupRoll == 9 then
                    set RoundCreepTypeId = CreepUnitTypeIds[33] //Chaos Warlord
                    set RoundCreepChanceBloodlust = 1
                    set RoundCreepChanceCleave = 1
                    set RoundCreepChanceCritStrike = 1
                    set RoundCreepChanceCruelty = 1
                    set RoundCreepChanceHowlOfTerror = 1
                    set RoundCreepChanceBackStab = 1
                    set RoundCreepChanceUnlimitedAgony = 1
                endif
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
            set RoundCreepNumber = GetRandomInt(2,39) //creep count with 2 players
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
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.6))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.6))	
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (0.9 * (RoundNumber)))
                    elseif RoundNumber < 19  then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 1.5) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 6 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 60 * RoundNumber)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))  
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (1.0 * (RoundNumber)))      
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))       	
                    elseif RoundNumber < 24  then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber *4.5) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 14 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 80 * RoundNumber)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))		    
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (1.3 * (RoundNumber)))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif RoundNumber < 35  then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 7.5) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 55 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 120 * RoundNumber)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))				    
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (1.5 * (RoundNumber)))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif RoundNumber < 41  then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 12) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 200 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 225 * RoundNumber)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))		
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (2 * (RoundNumber)))	  
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif RoundNumber < 45  then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 15) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 400 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 450 * RoundNumber)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))	
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (2.25 * (RoundNumber)))
                    elseif RoundNumber < 49  then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 24) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 500 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 1350 * RoundNumber)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))	
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (3 * (RoundNumber)))                              
                    else
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 36) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 900 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 5000 * RoundNumber)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))	
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
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
                        if (RoundNumber > 49) then
                            set RoundCreepTitle = "|cffff0000Boss Round|r (+150% gold/xp|r): |cffdd9bf1" + I2S(RoundCreepNumber) + " |r|cff77d2fc" + GetObjectName(RoundCreepTypeId) + "|r"
                        else
                            set RoundCreepTitle = "|cffdd9bf1" + I2S(RoundCreepNumber) + " |r|cff77d2fc" + GetObjectName(RoundCreepTypeId) + "|r"
                        endif
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
                            call DisplayTimedTextToPlayer(Player(playerId), 0, 0, 20, "Round " + I2S(RoundNumber)+" : " + s)
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
