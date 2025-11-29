library GenerateNextCreepLevel initializer init requires RandomShit, Functions, CustomGameEvent

    globals
        integer RoundCreepChanceBash = 0
        integer RoundCreepChanceBigBadV = 0
        integer RoundCreepChanceBlink = 0
        integer RoundCreepChanceCleave = 0
        integer RoundCreepChanceCritStrike = 0
        integer RoundCreepChanceEvasion = 0
        integer RoundCreepChanceFaerieFire = 0
        integer RoundCreepChanceHurlBoulder = 0
        integer RoundCreepChanceLifesteal = 0
        integer RoundCreepChanceManaBurn = 0
        integer RoundCreepChanceRejuv = 0
        integer RoundCreepChanceShockwave = 0
        integer RoundCreepChanceSlow = 0
        integer RoundCreepChanceThorns = 0
        integer RoundCreepChanceThunderClap = 0
        integer RoundCreepChanceBackStab = 0
        integer RoundCreepChanceShadowStrike = 0
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
        integer RoundCreepChanceDemolish = 0
        integer RoundCreepChanceBrillianceAura = 0
        integer RoundCreepChanceDousingHex = 0
        integer RoundCreepChanceBlinkStrike = 0
        integer RoundCreepChanceMegaLuck = 0
        integer RoundCreepChanceLuckyTrigger = 0
        integer RoundCreepChanceSpikedCarapace = 0
        integer RoundCreepChanceFireShield = 0
        integer RoundCreepChanceMagicCriticalHit = 0
        integer RoundCreepChanceArcaneAssault = 0
        integer RoundCreepChanceStampede = 0
        integer RoundCreepChanceMirrorImage = 0
        integer RoundCreepChanceHeavyBlow = 0
        integer RoundCreepChanceMultishot = 0
        integer RoundCreepChanceTrueShotAura = 0
        integer RoundCreepChanceReaction = 0
        integer RoundCreepChanceEnduranceAura     = 0 
        integer RoundCreepChanceVulnerabilityAura = 0
        integer RoundCreepChanceVampiricAura      = 0
        integer RoundCreepChanceUnholyAura    = 0
        integer RoundCreepChanceCharm    = 0
        integer RoundCreepChanceWhirlWind    = 0
        integer RoundCreepChanceAcidSpray = 0
        integer RoundCreepChanceSlowPoison = 0
        integer RoundCreepChanceDevotionAura = 0
        integer RoundCreepChanceChaosMagic = 0
        integer RoundCreepChanceFinishingBlow = 0
        integer RoundCreepChancePlague = 0
        integer RoundCreepChanceEnergyBombardment = 0
        integer RoundCreepChanceColdArrows = 0
        integer RoundCreepChanceSearingArrows = 0
        integer RoundCreepChanceSpiritShackle = 0
        integer RoundCreepChancePowerOfIce = 0
        integer RoundCreepChanceFireForce = 0
        integer RoundCreepChanceArcaneStrike = 0
        integer RoundCreepChanceCombustion = 0
        integer RoundCreepChanceDivineGift = 0
        integer RoundCreepChanceEarthquake = 0
        integer RoundCreepChanceFatalFlaw = 0
        integer RoundCreepChanceFrostbiteOfTheSoul = 0
        integer RoundCreepChanceMartialRetribution = 0
        integer RoundCreepChanceMartialTheft = 0
        integer RoundCreepChanceMysteriousTalent = 0
        integer RoundCreepChanceOverload = 0
        integer RoundCreepChancePowerOfWater = 0
        integer RoundCreepChanceShadowDance = 0
        integer RoundCreepChanceShadowStep = 0
        integer RoundCreepChanceThunderForce = 0
        integer RoundCreepChanceTimeManipulation = 0
        integer RoundCreepChanceWildDefense = 0
        integer RoundCreepChanceManaStarvation = 0
        integer RoundCreepChanceExtradimensionalCooperation = 0
        integer RoundCreepChanceHeroForce = 0
        integer RoundCreepChanceTemporaryInvisibility = 0
        integer RoundCreepChanceTemporaryPower = 0
        integer RoundCreepChanceHeroBuff = 0
        integer RoundCreepChanceRapidRecovery = 0
        integer RoundCreepChanceNecromancersArmy = 0
        integer RoundCreepChanceBlackArrow = 0
        integer RoundCreepChanceManaBonus = 0
        integer RoundCreepChanceMegaSpeed = 0
        integer RoundCreepChanceFearlessDefenders = 0
        integer RoundCreepChanceCheaterMagic = 0
        integer RoundCreepChanceBlessedProtection = 0
        integer RoundCreepChanceFog = 0
        integer RoundCreepChanceWindWalk = 0
        integer RoundCreepChanceBerserk = 0
        integer RoundCreepChanceFlameStrike = 0

        integer RoundCreepChanceAbsoluteDark = 0
        integer RoundCreepChanceAbsolutePoison = 0
        integer RoundCreepChanceAbsoluteLight = 0
        integer RoundCreepChanceAbsoluteWind = 0
        integer RoundCreepChanceAbsoluteEarth = 0
        integer RoundCreepChanceAbsoluteWater = 0
        integer RoundCreepChanceAbsoluteCold = 0
        integer RoundCreepChanceAbsoluteArcane = 0
        integer RoundCreepChanceAbsoluteFire = 0
        integer RoundCreepChanceAbsoluteBlood = 0
        integer RoundCreepChanceAbsoluteWild = 0

        integer RoundCreepChanceSummonCarrionBeetles
        integer RoundCreepChanceSummonFeralSpirit
        integer RoundCreepChanceSummonHawk
        integer RoundCreepChanceSummonInferno
        integer RoundCreepChanceSummonLavaSpawn
        integer RoundCreepChanceSummonMountainGiant
        integer RoundCreepChanceSummonPhoenix
        integer RoundCreepChanceSummonPocketFactory
        integer RoundCreepChanceSummonSerpentWard
        integer RoundCreepChanceSummonQuilbeast
        integer RoundCreepChanceSummonWaterElemental

//tested and not working yet:
        //integer RoundCreepChanceRandomSpell = 0
        integer RoundCreepChanceCommandAura       = 0 
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
        integer RoundCreepChanceDemonsCurse = 0
        integer RoundCreepChanceMulticast = 0

        integer RoundSkillGroupRoll = 0
        integer MagicWaveRoll = 0
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
        set RoundCreepChanceDemolish = 0
        set RoundCreepChanceBrillianceAura = 0
        set RoundCreepChanceDousingHex = 0
        set RoundCreepChanceBlinkStrike = 0
        set RoundCreepChanceMegaLuck = 0
        set RoundCreepChanceLuckyTrigger = 0
        set RoundCreepChanceSpikedCarapace = 0
        set RoundCreepChanceFireShield = 0
        set RoundCreepChanceMagicCriticalHit = 0
        set RoundCreepChanceArcaneAssault = 0
        set RoundCreepChanceStampede = 0
        set RoundCreepChanceMirrorImage = 0
        set RoundCreepChanceHeavyBlow = 0
        set RoundCreepChanceMultishot = 0
        set RoundCreepChanceTrueShotAura = 0
        set RoundCreepChanceReaction = 0
        set RoundCreepChanceEnduranceAura     = 0
        set RoundCreepChanceCommandAura       = 0
        set RoundCreepChanceVulnerabilityAura = 0
        set RoundCreepChanceVampiricAura      = 0
        set RoundCreepChanceUnholyAura    = 0
        set RoundCreepChanceCharm    = 0
        set RoundCreepChanceWhirlWind    = 0
        set RoundCreepChanceAcidSpray = 0
        set RoundCreepChanceDemonsCurse = 0
        set RoundCreepChanceSlowPoison = 0
        set RoundCreepChanceDevotionAura = 0
        set RoundCreepChanceMulticast = 0
        set RoundCreepChanceChaosMagic = 0

        //not checked yet
        set RoundCreepChanceFinishingBlow = 0
        set RoundCreepChancePlague = 0
        set RoundCreepChanceEnergyBombardment = 0
        set RoundCreepChanceColdArrows = 0
        set RoundCreepChanceSearingArrows = 0
        set RoundCreepChanceSpiritShackle = 0
        set RoundCreepChancePowerOfIce = 0
        set RoundCreepChanceFireForce = 0
        set RoundCreepChanceArcaneStrike = 0
        set RoundCreepChanceCombustion = 0
        set RoundCreepChanceDivineGift = 0
        set RoundCreepChanceEarthquake = 0
        set RoundCreepChanceFatalFlaw = 0
        set RoundCreepChanceFrostbiteOfTheSoul = 0
        set RoundCreepChanceMartialRetribution = 0
        set RoundCreepChanceMartialTheft = 0
        set RoundCreepChanceMysteriousTalent = 0
        set RoundCreepChanceOverload = 0
        set RoundCreepChancePowerOfWater = 0
        set RoundCreepChanceShadowDance = 0
        set RoundCreepChanceShadowStep = 0
        set RoundCreepChanceThunderForce = 0
        set RoundCreepChanceTimeManipulation = 0
        set RoundCreepChanceWildDefense = 0
        set RoundCreepChanceManaStarvation = 0
        set RoundCreepChanceExtradimensionalCooperation = 0
        set RoundCreepChanceHeroForce = 0
        set RoundCreepChanceTemporaryInvisibility = 0
        set RoundCreepChanceTemporaryPower = 0
        set RoundCreepChanceHeroBuff = 0
        set RoundCreepChanceRapidRecovery = 0
        set RoundCreepChanceNecromancersArmy = 0
        set RoundCreepChanceBlackArrow = 0
        set RoundCreepChanceManaBonus = 0
        set RoundCreepChanceMegaSpeed = 0
        set RoundCreepChanceFearlessDefenders = 0
        set RoundCreepChanceCheaterMagic = 0
        set RoundCreepChanceBlessedProtection = 0
        set RoundCreepChanceFog = 0
        set RoundCreepChanceWindWalk = 0
        set RoundCreepChanceBerserk = 0
        set RoundCreepChanceFlameStrike = 0

        set RoundCreepChanceAbsoluteDark = 0
        set RoundCreepChanceAbsolutePoison = 0
        set RoundCreepChanceAbsoluteLight = 0
        set RoundCreepChanceAbsoluteWind = 0
        set RoundCreepChanceAbsoluteEarth = 0
        set RoundCreepChanceAbsoluteWater = 0
        set RoundCreepChanceAbsoluteCold = 0
        set RoundCreepChanceAbsoluteArcane = 0
        set RoundCreepChanceAbsoluteFire = 0
        set RoundCreepChanceAbsoluteBlood = 0
        set RoundCreepChanceAbsoluteWild = 0

        set RoundCreepChanceSummonCarrionBeetles = 0
        set RoundCreepChanceSummonFeralSpirit    = 0
        set RoundCreepChanceSummonHawk           = 0
        set RoundCreepChanceSummonInferno        = 0
        set RoundCreepChanceSummonLavaSpawn      = 0
        set RoundCreepChanceSummonMountainGiant  = 0
        set RoundCreepChanceSummonPhoenix        = 0
        set RoundCreepChanceSummonPocketFactory  = 0
        set RoundCreepChanceSummonSerpentWard    = 0
        set RoundCreepChanceSummonQuilbeast      = 0
        set RoundCreepChanceSummonWaterElemental = 0
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

        if RoundCreepChanceAbsoluteDark == 1 then
            set s = ConcatAbility(s, "Absolute Dark")
            call AddRoundAbility(ABSOLUTE_DARK_ABILITY_ID)
        endif

        if RoundCreepChanceAbsolutePoison == 1 then
            set s = ConcatAbility(s, "Absolute Poison")
            call AddRoundAbility(ABSOLUTE_POISON_ABILITY_ID)
        endif

        if RoundCreepChanceAbsoluteLight == 1 then
            set s = ConcatAbility(s, "Absolute Light")
            call AddRoundAbility(ABSOLUTE_LIGHT_ABILITY_ID)
        endif

        if RoundCreepChanceAbsoluteWind == 1 then
            set s = ConcatAbility(s, "Absolute Wind")
            call AddRoundAbility(ABSOLUTE_WIND_ABILITY_ID)
        endif

        if RoundCreepChanceAbsoluteEarth == 1 then
            set s = ConcatAbility(s, "Absolute Earth")
            call AddRoundAbility(ABSOLUTE_EARTH_ABILITY_ID)
        endif

        if RoundCreepChanceAbsoluteWater == 1 then
            set s = ConcatAbility(s, "Absolute Water")
            call AddRoundAbility(ABSOLUTE_WATER_ABILITY_ID)
        endif

        if RoundCreepChanceAbsoluteCold == 1 then
            set s = ConcatAbility(s, "Absolute Cold")
            call AddRoundAbility(ABSOLUTE_COLD_ABILITY_ID)
        endif

        if RoundCreepChanceAbsoluteArcane == 1 then
            set s = ConcatAbility(s, "Absolute Arcane")
            call AddRoundAbility(ABSOLUTE_ARCANE_ABILITY_ID)
        endif

        if RoundCreepChanceAbsoluteFire == 1 then
            set s = ConcatAbility(s, "Absolute Fire")
            call AddRoundAbility(ABSOLUTE_FIRE_ABILITY_ID)
        endif

        if RoundCreepChanceAbsoluteBlood == 1 then
            set s = ConcatAbility(s, "Absolute Blood")
            call AddRoundAbility(ABSOLUTE_BLOOD_ABILITY_ID)
        endif

        if RoundCreepChanceAbsoluteWild == 1 then
            set s = ConcatAbility(s, "Absolute Wild")
            call AddRoundAbility(ABSOLUTE_WILD_ABILITY_ID)
        endif

        if RoundCreepChanceAcidSpray == 1 then
            set s = ConcatAbility(s, "|cffff00ffAcid Spray")
            call AddRoundAbility(ACID_SPRAY_ABILITY_ID)
        endif
    
        if RoundCreepChanceAerialShackles == 1 then
            set s = ConcatAbility(s, "|cffff00ffAerial Shackles")
            call AddRoundAbility(AERIALSHACKLES_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceArcaneAssault == 1 then
            set s = ConcatAbility(s, "Arcane Assault")
            call AddRoundAbility(ARCANE_ASSAULT_ABILITY_ID)
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

        if RoundCreepChanceVulnerabilityAura == 1 then
            set s = ConcatAbility(s, "Aura of Vulnerability")
            call AddRoundAbility(AURA_OF_VULNERABILITY_ABILITY_ID)
        endif

        if RoundCreepChanceBackStab == 1 then
            set s = ConcatAbility(s, "Backstab")
            call AddRoundAbility(BACKSTAB_ABILITY_ID)
        endif

        if RoundCreepChanceBanish == 1 then
            set s = ConcatAbility(s, "Banish")
            call AddRoundAbility(BANISH_ABILITY_ID)
        endif

        if RoundCreepChanceBash == 1 and DamageSourceTypeId != SLUDGE_MINION_CREEP_UNIT_ID and DamageSourceTypeId != DRAENEI_MAGE_CREEP_UNIT_ID and DamageSourceTypeId != WIND_SERPENT_CREEP_UNIT_ID and RoundCreepTypeId != WRAITH_CREEP_UNIT_ID then
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

        if RoundCreepChanceBlinkStrike == 1 then
            set s = ConcatAbility(s, "Blink Strike")
            call AddRoundAbility(BLINK_STRIKE_ABILITY_ID)
        endif

        if RoundCreepChanceBloodlust == 1 then
            set s = ConcatAbility(s, "Bloodlust")
            call AddRoundAbility(BLOODLUST_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceBrillianceAura == 1 then
            set s = ConcatAbility(s, "Brilliance Aura")
            call AddRoundAbility(BRILLIANCE_AURA_ABILITY_ID)
        endif

        if RoundCreepChanceCarrionSwarm == 1 then
            set s = ConcatAbility(s, "|cffff00ffCarrion Swarm")
            call AddRoundAbility(CARRION_SWARM_ABILITY_ID)
        endif

        if RoundCreepChanceChainLightning == 1 then
            set s = ConcatAbility(s, "|cffff00ffChain Lightning")
            call AddRoundAbility(CHAINLIGHTNING_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceCharm == 1 then
            set s = ConcatAbility(s, "Charm")
            call AddRoundAbility(CHARM_ABILITY_ID)
        endif

        if RoundCreepChanceCleave == 1 and DamageSourceTypeId != SLUDGE_MINION_CREEP_UNIT_ID and DamageSourceTypeId != DRAENEI_MAGE_CREEP_UNIT_ID and DamageSourceTypeId != WIND_SERPENT_CREEP_UNIT_ID and RoundCreepTypeId != WRAITH_CREEP_UNIT_ID and RoundCreepTypeId != CENTAUR_IMPALER_CREEP_UNIT_ID and RoundCreepTypeId != 'n01g' and RoundCreepTypeId != BANDIT_SPEAR_THROWER_CREEP_UNIT_ID and RoundCreepTypeId != HARPY_CREEP_UNIT_ID and RoundCreepTypeId != SKELETON_ARCHER_CREEP_UNIT_ID and RoundCreepTypeId != 'n006' then
            set s = ConcatAbility(s, "|cffff00ffCleave")
            call AddRoundAbility(CLEAVE_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceColdWind == 1 then
            set s = ConcatAbility(s, "Cold Wind")
            call AddRoundAbility(COLD_WIND_ABILITY_ID)
        endif

        if RoundCreepChanceCommandAura == 1 then
            set s = ConcatAbility(s, "Command Aura")
            call AddRoundAbility(COMMAND_AURA_ABILITY_ID)
        endif

        if RoundCreepChanceCorrosiveSkin == 1 then
            set s = ConcatAbility(s, "|cffff00ffCorrosive Skin")
            call AddRoundAbility(CORROSIVE_SKIN_ABILITY_ID)
        endif

        if RoundCreepChanceCripple == 1 then
            set s = ConcatAbility(s, "Cripple")
            call AddRoundAbility(CRIPPLE_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceCritStrike == 1 and DamageSourceTypeId != SLUDGE_MINION_CREEP_UNIT_ID and DamageSourceTypeId != DRAENEI_MAGE_CREEP_UNIT_ID and DamageSourceTypeId != WIND_SERPENT_CREEP_UNIT_ID and RoundCreepTypeId != WRAITH_CREEP_UNIT_ID then
            set s = ConcatAbility(s, "Critical Strike")
            call AddRoundAbility(CRITICAL_STRIKE_ABILITY_ID)
        endif

        if RoundCreepChanceCruelty == 1 and DamageSourceTypeId != SLUDGE_MINION_CREEP_UNIT_ID and DamageSourceTypeId != DRAENEI_MAGE_CREEP_UNIT_ID and DamageSourceTypeId != WIND_SERPENT_CREEP_UNIT_ID and RoundCreepTypeId != WRAITH_CREEP_UNIT_ID then
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

        if RoundCreepChanceCutting == 1 and DamageSourceTypeId != SLUDGE_MINION_CREEP_UNIT_ID and DamageSourceTypeId != DRAENEI_MAGE_CREEP_UNIT_ID and DamageSourceTypeId != WIND_SERPENT_CREEP_UNIT_ID and RoundCreepTypeId != WRAITH_CREEP_UNIT_ID then
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

        if RoundCreepChanceDemolish == 1 then
            set s = ConcatAbility(s, "|cffff00ffDemolish")
            call AddRoundAbility(DEMOLISH_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceDemonsCurse == 1 then
            set s = ConcatAbility(s, "Demon's Curse")
            call AddRoundAbility(DEMONS_CURSE_ABILITY_ID)
        endif

        if RoundCreepChanceDestruction == 1 and DamageSourceTypeId != SLUDGE_MINION_CREEP_UNIT_ID and DamageSourceTypeId != DRAENEI_MAGE_CREEP_UNIT_ID and DamageSourceTypeId != WIND_SERPENT_CREEP_UNIT_ID and RoundCreepTypeId != WRAITH_CREEP_UNIT_ID then
            set s = ConcatAbility(s, "|cffff00ffDestruction")
            call AddRoundAbility(DESTRUCTION_ABILITY_ID)
        endif

        if RoundCreepChanceDevastatingBlow == 1 then
            set s = ConcatAbility(s, "|cffff00ffDevastating Blow")
            call AddRoundAbility(DEVASTATING_BLOW_ABILITY_ID)
        endif

        if RoundCreepChanceDevotionAura == 1 then
            set s = ConcatAbility(s, "Devotion Aura")
            call AddRoundAbility(DEVOTION_AURA_ABILITY_ID)
        endif

        if RoundCreepChanceDivineBubble == 1 then
            set s = ConcatAbility(s, "Divine Bubble")
            call AddRoundAbility(DIVINE_BUBBLE_ABILITY_ID)
        endif

        if RoundCreepChanceDivineShield == 1 then
            set s = ConcatAbility(s, "Divine Shield")
            call AddRoundAbility(DIVINE_SHIELD_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceDousingHex == 1 then
            set s = ConcatAbility(s, "Dousing Hex")
            call AddRoundAbility(DOUSING_HEX_ABILITY_ID)
        endif

        if RoundCreepChanceDrunkMaster == 1 and DamageSourceTypeId != SLUDGE_MINION_CREEP_UNIT_ID and DamageSourceTypeId != DRAENEI_MAGE_CREEP_UNIT_ID and DamageSourceTypeId != WIND_SERPENT_CREEP_UNIT_ID and RoundCreepTypeId != WRAITH_CREEP_UNIT_ID then
            set s = ConcatAbility(s, "Drunken Master")
            call AddRoundAbility(DRUNKEN_MASTER_ABILITY_ID)
        endif

        if RoundCreepChanceEnduranceAura == 1 then
            set s = ConcatAbility(s, "Endurance Aura")
            call AddRoundAbility(ENDURANCE_AURA_ABILITY_ID)
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

        if RoundCreepChanceEnvenomedWeapons == 1 and DamageSourceTypeId != SLUDGE_MINION_CREEP_UNIT_ID and DamageSourceTypeId != DRAENEI_MAGE_CREEP_UNIT_ID and DamageSourceTypeId != WIND_SERPENT_CREEP_UNIT_ID and RoundCreepTypeId != WRAITH_CREEP_UNIT_ID then
            set s = ConcatAbility(s, "|cffff00ffEnvenomed Weapons")
            call AddRoundAbility(ENVENOMED_WEAPONS_ABILITY_ID)
        endif

        if (RoundCreepChanceEvasion == 1) then
            set s = ConcatAbility(s, "Evasion")
            call AddRoundAbility(EVASION_ABILITY_ID)
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

        if RoundCreepChanceFireShield == 1 then
            set s = ConcatAbility(s, "|cffff00ffFire Shield")
            call AddRoundAbility(FIRE_SHIELD_ABILITY_ID)
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

        if RoundCreepChanceHeavyBlow == 1 then
            set s = ConcatAbility(s, "Heavy Blow")
            call AddRoundAbility(HEAVY_BLOW_ABILITY_ID)
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

        if RoundCreepChanceIncinerate == 1 and DamageSourceTypeId != SLUDGE_MINION_CREEP_UNIT_ID and DamageSourceTypeId != DRAENEI_MAGE_CREEP_UNIT_ID and DamageSourceTypeId != WIND_SERPENT_CREEP_UNIT_ID and RoundCreepTypeId != WRAITH_CREEP_UNIT_ID then
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

        if RoundCreepChanceLiquidFire == 1 and DamageSourceTypeId != SLUDGE_MINION_CREEP_UNIT_ID and DamageSourceTypeId != DRAENEI_MAGE_CREEP_UNIT_ID and DamageSourceTypeId != WIND_SERPENT_CREEP_UNIT_ID and RoundCreepTypeId != WRAITH_CREEP_UNIT_ID then
            set s = ConcatAbility(s, "|cffff00ffLiquid Fire")
            call AddRoundAbility(LIQUID_FIRE_ABILITY_ID)
        endif

        if RoundCreepChanceLuckyTrigger == 1 then
            set s = ConcatAbility(s, "Lucky Trigger")
            call AddRoundAbility(LUCKY_TRIGGER_ABILITY_ID)
        endif

        if RoundCreepChanceMagicCriticalHit == 1 then
            set s = ConcatAbility(s, "Magic Critical Hit")
            call AddRoundAbility(MAGIC_CRITICAL_HIT_ABILITY_ID)
        endif

        if RoundCreepChanceMegaLuck == 1 then
            set s = ConcatAbility(s, "Mega Luck")
            call AddRoundAbility(MEGA_LUCK_ABILITY_ID)
        endif

        if RoundCreepChanceManaBurn == 1 then
            set s = ConcatAbility(s, "|cffff00ffMana Burn")
            call AddRoundAbility(MANA_BURN_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceMirrorImage == 1 then
            set s = ConcatAbility(s, "Mirror Image")
            call AddRoundAbility(MIRROR_IMAGE_ABILITY_ID)
        endif

        if RoundCreepChanceMulticast == 1 then
            set s = ConcatAbility(s, "Multicast")
            call AddRoundAbility(MULTICAST_ABILITY_ID)
        endif

        if RoundCreepChanceMultishot == 1 then
            set s = ConcatAbility(s, "|cffff00ffMultishot")
            call AddRoundAbility(MULTISHOT_ABILITY_ID)
        endif

        if RoundCreepChancePolymorph == 1 then
            set s = ConcatAbility(s, "Polymorph")
            call AddRoundAbility(POLYMORPH_CREEP_ABILITY_ID)
        endif

        if RoundCreepChancePulverize == 1 and DamageSourceTypeId != SLUDGE_MINION_CREEP_UNIT_ID and DamageSourceTypeId != DRAENEI_MAGE_CREEP_UNIT_ID and DamageSourceTypeId != WIND_SERPENT_CREEP_UNIT_ID and RoundCreepTypeId != WRAITH_CREEP_UNIT_ID then
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

        if RoundCreepChanceReaction == 1 then
            set s = ConcatAbility(s, "Reaction")
            call AddRoundAbility(REACTION_ABILITY_ID)
        endif

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

        if RoundCreepChanceSlowPoison == 1 then
            set s = ConcatAbility(s, "|cffff00ffSlow Poison")
            call AddRoundAbility(SLOW_POISON_ABILITY_ID)
        endif

        if RoundCreepChanceSpikedCarapace == 1 then
            set s = ConcatAbility(s, "|cffff00ffSpiked Carapace")
            call AddRoundAbility(SPIKED_CARAPACE_ABILITY_ID)
        endif

        if RoundCreepChanceSoulBurn == 1 then
            set s = ConcatAbility(s, "|cffff00ffThorns Aura|r")
            call AddRoundAbility(SOUL_BURN_ABILITY_ID)
        endif

        if RoundCreepChanceSpellImmunity == 1 then
            set s = ConcatAbility(s, "Spell Immunity")
            call AddRoundAbility(SPELL_IMMUNITY_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceStampede == 1 then
            set s = ConcatAbility(s, "|cffff00ffStampede")
            call AddRoundAbility(STAMPEDE_ABILITY_ID)
        endif

        if RoundCreepChanceStasisTrap == 1 then
            set s = ConcatAbility(s, "Stasis Trap")
            call AddRoundAbility(STASIS_TRAP_ABILITY_ID)
        endif

        if RoundCreepChanceStoneProt == 1 then
            set s = ConcatAbility(s, "|cffff00ffStone Protection")
            call AddRoundAbility(STONE_PROTECTION_ABILITY_ID)
        endif

        if RoundCreepChanceSummonCarrionBeetles == 1 then
            set s = ConcatAbility(s, "Summon Carrion Beetles")
            call AddRoundAbility(SUMMON_CARRION_BEETLES_ABILITY_ID)
        endif

        if RoundCreepChanceSummonFeralSpirit == 1 then
            set s = ConcatAbility(s, "Summon Feral Spirit")
            call AddRoundAbility(SUMMON_FERAL_SPIRIT_ABILITY_ID)
        endif

        if RoundCreepChanceSummonHawk == 1 then
            set s = ConcatAbility(s, "Summon Hawk")
            call AddRoundAbility(SUMMON_HAWK_ABILITY_ID)
        endif

        if RoundCreepChanceSummonInferno == 1 then
            set s = ConcatAbility(s, "Summon Inferno")
            call AddRoundAbility(SUMMON_INFERNO_ABILITY_ID)
        endif

        if RoundCreepChanceSummonLavaSpawn == 1 then
            set s = ConcatAbility(s, "Summon Lava Spawn")
            call AddRoundAbility(SUMMON_LAVA_SPAWN_ABILITY_ID)
        endif

        if RoundCreepChanceSummonMountainGiant == 1 then
            set s = ConcatAbility(s, "Summon Mountain Giant")
            call AddRoundAbility(SUMMON_MOUNTAIN_GIANT_ABILITY_ID)
        endif

        if RoundCreepChanceSummonPhoenix == 1 then
            set s = ConcatAbility(s, "Summon Phoenix")
            call AddRoundAbility(SUMMON_PHOENIX_ABILITY_ID)
        endif

        if RoundCreepChanceSummonPocketFactory == 1 then
            set s = ConcatAbility(s, "Summon Pocket Factory")
            call AddRoundAbility(SUMMON_POCKET_FACTORY_ABILITY_ID)
        endif

        if RoundCreepChanceSummonSerpentWard == 1 then
            set s = ConcatAbility(s, "|cffff00ffSummon Serpent Ward")
            call AddRoundAbility(SUMMON_SERPENT_WARD_ABILITY_ID)
        endif

        if RoundCreepChanceSummonQuilbeast == 1 then
            set s = ConcatAbility(s, "Summon Quilbeast")
            call AddRoundAbility(SUMMON_QUILBEAST_ABILITY_ID)
        endif

        if RoundCreepChanceSummonWaterElemental == 1 then
            set s = ConcatAbility(s, "Summon Water Elemental")
            call AddRoundAbility(SUMMON_WATER_ELEMENTAL_ABILITY_ID)
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

        if RoundCreepChanceTrueShotAura == 1 then
            set s = ConcatAbility(s, "Trueshot Aura")
            call AddRoundAbility(TRUESHOT_AURA_ABILITY_ID)
        endif

        if RoundCreepChanceUnholyFrenzy == 1 then
            set s = ConcatAbility(s, "Unholy Frenzy")
            call AddRoundAbility(UNHOLYFRENZY_CREEP_ABILITY_ID)
        endif

        if RoundCreepChanceUnlimitedAgony == 1 then
            set s = ConcatAbility(s, "Unlimited Agony")
            call AddRoundAbility(UNLIMITED_AGON_ABILITY_ID)
        endif

        if RoundCreepChanceUnholyAura == 1 then
            set s = ConcatAbility(s, "Unholy Aura")
            call AddRoundAbility(UNHOLY_AURA_ABILITY_ID)
        endif

        if RoundCreepChanceWarStomp == 1 then
            set s = ConcatAbility(s, "|cffff00ffWar Stomp")
            call AddRoundAbility(WAR_STOMP_ABILITY_ID)
        endif

        if RoundCreepChanceVampiricAura == 1 then
            set s = ConcatAbility(s, "Vampiric Aura")
            call AddRoundAbility(VAMPIRIC_AURA_ABILITY_ID)
        endif

        if RoundCreepChanceWizardbane == 1 then
            set s = ConcatAbility(s, "|cffff00ffWizardbane Aura")
            call AddRoundAbility(WIZARDBANE_AURA_ABILITY_ID)
        endif

        if RoundCreepChanceWhirlWind == 1 then
            set s = ConcatAbility(s, "|cffff00ffWhirlwind")
            call AddRoundAbility(WHIRLWIND_ABILITY_ID)
        endif

        //not tested yet
        if RoundCreepChanceFinishingBlow == 1 then
            set s = ConcatAbility(s, "Finishing Blow")
            call AddRoundAbility(FINISHING_BLOW_ABILITY_ID)
        endif

        if RoundCreepChancePlague == 1 then
            set s = ConcatAbility(s, "|cffff00ffPlague")
            call AddRoundAbility(PLAGUE_ABILITY_ID)
        endif

        if RoundCreepChanceEnergyBombardment == 1 then
            set s = ConcatAbility(s, "Energy Bombardment")
            call AddRoundAbility(ENERGY_BOMBARDMENT_ABILITY_ID)
        endif

        if RoundCreepChanceColdArrows == 1 then
            set s = ConcatAbility(s, "|cffff00ffCold Arrows")
            call AddRoundAbility(COLD_ARROWS_ABILITY_ID)
        endif

        if RoundCreepChanceSearingArrows == 1 then
            set s = ConcatAbility(s, "|cffff00ffSearing Arrows")
            call AddRoundAbility(SEARING_ARROWS_ABILITY_ID)
        endif

        if RoundCreepChanceSpiritShackle == 1 then
            set s = ConcatAbility(s, "Spirit Shackle")
            call AddRoundAbility(SPIRIT_SHACKLE_ABILITY_ID)
        endif

        if RoundCreepChancePowerOfIce == 1 then
            set s = ConcatAbility(s, "|cffff00ffPower Of Ice")
            call AddRoundAbility(POWER_OF_ICE_ABILITY_ID)
        endif

        if RoundCreepChanceFireForce == 1 then
            set s = ConcatAbility(s, "|cffff00ffFire Force")
            call AddRoundAbility(FIRE_FORCE_ABILITY_ID)
        endif

        if RoundCreepChanceArcaneStrike == 1 then
            set s = ConcatAbility(s, "Arcane Strike")
            call AddRoundAbility(ARCANE_STRIKE_ABILITY_ID)
        endif

        if RoundCreepChanceCombustion == 1 then
            set s = ConcatAbility(s, "Combustion")
            call AddRoundAbility(COMBUSTION_ABILITY_ID)
        endif

        if RoundCreepChanceDivineGift == 1 then
            set s = ConcatAbility(s, "Divine Gift")
            call AddRoundAbility(DIVINE_GIFT_ABILITY_ID)
        endif

        if RoundCreepChanceEarthquake == 1 then
            set s = ConcatAbility(s, "|cffff00ffEarthquake")
            call AddRoundAbility(EARTHQUAKE_ABILITY_ID)
        endif

        if RoundCreepChanceFatalFlaw == 1 then
            set s = ConcatAbility(s, "Fatal Flaw")
            call AddRoundAbility(FATAL_FLAW_ABILITY_ID)
        endif

        if RoundCreepChanceFrostbiteOfTheSoul == 1 then
            set s = ConcatAbility(s, "Frostbite Of The Soul")
            call AddRoundAbility(FROSTBITE_OF_THE_SOUL_ABILITY_ID)
        endif

        if RoundCreepChanceMartialRetribution == 1 then
            set s = ConcatAbility(s, "Martial Retribution")
            call AddRoundAbility(MARTIAL_RETRIBUTION_ABILITY_ID)
        endif

        if RoundCreepChanceMartialTheft == 1 then
            set s = ConcatAbility(s, "Martial Theft")
            call AddRoundAbility(MARTIAL_THEFT_ABILITY_ID)
        endif

        if RoundCreepChanceMysteriousTalent == 1 then
            set s = ConcatAbility(s, "Mysterious Talent")
            call AddRoundAbility(MYSTERIOUS_TALENT_ABILITY_ID)
        endif

        if RoundCreepChanceOverload == 1 then
            set s = ConcatAbility(s, "Overload")
            call AddRoundAbility(OVERLOAD_ABILITY_ID)
        endif

        if RoundCreepChancePowerOfWater == 1 then
            set s = ConcatAbility(s, "Power Of Water")
            call AddRoundAbility(POWER_OF_WATER_ABILITY_ID)
        endif

        if RoundCreepChanceShadowDance == 1 then
            set s = ConcatAbility(s, "Shadow Dance")
            call AddRoundAbility(SHADOW_DANCE_ABILITY_ID)
        endif

        if RoundCreepChanceShadowStep == 1 then
            set s = ConcatAbility(s, "Shadow Step")
            call AddRoundAbility(SHADOW_STEP_ABILITY_ID)
        endif

        if RoundCreepChanceThunderForce == 1 then
            set s = ConcatAbility(s, "Thunder Force")
            call AddRoundAbility(THUNDER_FORCE_ABILITY_ID)
        endif

        if RoundCreepChanceTimeManipulation == 1 then
            set s = ConcatAbility(s, "Time Manipulation")
            call AddRoundAbility(TIME_MANIPULATION_ABILITY_ID)
        endif

        if RoundCreepChanceWildDefense == 1 then
            set s = ConcatAbility(s, "Wild Defense")
            call AddRoundAbility(WILD_DEFENSE_ABILITY_ID)
        endif

        if RoundCreepChanceManaStarvation == 1 then
            set s = ConcatAbility(s, "Mana Starvation")
            call AddRoundAbility(MANA_STARVATION_ABILITY_ID)
        endif

        if RoundCreepChanceExtradimensionalCooperation == 1 then
            set s = ConcatAbility(s, "Extradimensional Cooperation")
            call AddRoundAbility(EXTRADIMENSIONAL_COOPERATION_ABILITY_ID)
        endif

        if RoundCreepChanceHeroForce == 1 then
            set s = ConcatAbility(s, "Hero Force")
            call AddRoundAbility(HERO_FORCE_ABILITY_ID)
        endif

        if RoundCreepChanceTemporaryInvisibility == 1 then
            set s = ConcatAbility(s, "Temporary Invisibility")
            call AddRoundAbility(TEMPORARY_INVISIBILITY_ABILITY_ID)
        endif

        if RoundCreepChanceTemporaryPower == 1 then
            set s = ConcatAbility(s, "Temporary Power")
            call AddRoundAbility(TEMPORARY_POWER_ABILITY_ID)
        endif

        if RoundCreepChanceHeroBuff == 1 then
            set s = ConcatAbility(s, "Hero Buff")
            call AddRoundAbility(HERO_BUFF_ABILITY_ID)
        endif

        if RoundCreepChanceRapidRecovery == 1 then
            set s = ConcatAbility(s, "Rapid Recovery")
            call AddRoundAbility(RAPID_RECOVERY_ABILITY_ID)
        endif

        if RoundCreepChanceNecromancersArmy == 1 then
            set s = ConcatAbility(s, "Necromancers Army")
            call AddRoundAbility(NECROMANCERS_ARMY_ABILITY_ID)
        endif

        if RoundCreepChanceBlackArrow == 1 then
            set s = ConcatAbility(s, "Black Arrow")
            call AddRoundAbility(BLACK_ARROW_ABILITY_ID)
        endif

        if RoundCreepChanceManaBonus == 1 then
            set s = ConcatAbility(s, "Mana Bonus")
            call AddRoundAbility(MANA_BONUS_ABILITY_ID)
        endif

        if RoundCreepChanceMegaSpeed == 1 then
            set s = ConcatAbility(s, "Mega Speed")
            call AddRoundAbility(MEGA_SPEED_ABILITY_ID)
        endif

        if RoundCreepChanceFearlessDefenders == 1 then
            set s = ConcatAbility(s, "Fearless Defenders")
            call AddRoundAbility(FEARLESS_DEFENDERS_ABILITY_ID)
        endif

        if RoundCreepChanceCheaterMagic == 1 then
            set s = ConcatAbility(s, "Cheater Magic")
            call AddRoundAbility(CHEATER_MAGIC_ABILITY_ID)
        endif

        if RoundCreepChanceChaosMagic == 1 then
            set s = ConcatAbility(s, "|cffff00ffChaos Magic")
            call AddRoundAbility(CHAOS_MAGIC_ABILITY_ID)
        endif

        if RoundCreepChanceBlessedProtection == 1 then
            set s = ConcatAbility(s, "Blessed Protection")
            call AddRoundAbility(BLESSED_PROTECTION_ABILITY_ID)
        endif

        if RoundCreepChanceFog == 1 then
            set s = ConcatAbility(s, "Fog")
            call AddRoundAbility(FOG_ABILITY_ID)
        endif

        if RoundCreepChanceWindWalk == 1 then
            set s = ConcatAbility(s, "Wind Walk")
            call AddRoundAbility(WIND_WALK_ABILITY_ID)
        endif

        if RoundCreepChanceBerserk == 1 then
            set s = ConcatAbility(s, "Berserk")
            call AddRoundAbility(BERSERK_ABILITY_ID)
        endif

        if RoundCreepChanceFlameStrike == 1 then
            set s = ConcatAbility(s, "|cffff00ffFlame Strike")
            call AddRoundAbility(FLAME_STRIKE_ABILITY_ID)
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

        if RoundCreepChanceAbsoluteDark == 1 then
            call UnitAddAbility(u, ABSOLUTE_DARK_ABILITY_ID)
            call SetUnitAbilityLevel(u, ABSOLUTE_DARK_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceAbsolutePoison == 1 then
            call UnitAddAbility(u, ABSOLUTE_POISON_ABILITY_ID)
            call SetUnitAbilityLevel(u, ABSOLUTE_POISON_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceAbsoluteLight == 1 then
            call UnitAddAbility(u, ABSOLUTE_LIGHT_ABILITY_ID)
            call SetUnitAbilityLevel(u, ABSOLUTE_LIGHT_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceAbsoluteWind == 1 then
            call UnitAddAbility(u, ABSOLUTE_WIND_ABILITY_ID)
            call SetUnitAbilityLevel(u, ABSOLUTE_WIND_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceAbsoluteEarth == 1 then
            call UnitAddAbility(u, ABSOLUTE_EARTH_ABILITY_ID)
            call SetUnitAbilityLevel(u, ABSOLUTE_EARTH_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceAbsoluteWater == 1 then
            call UnitAddAbility(u, ABSOLUTE_WATER_ABILITY_ID)
            call SetUnitAbilityLevel(u, ABSOLUTE_WATER_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceAbsoluteCold == 1 then
            call UnitAddAbility(u, ABSOLUTE_COLD_ABILITY_ID)
            call SetUnitAbilityLevel(u, ABSOLUTE_COLD_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceAbsoluteArcane == 1 then
            call UnitAddAbility(u, ABSOLUTE_ARCANE_ABILITY_ID)
            call SetUnitAbilityLevel(u, ABSOLUTE_ARCANE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceAbsoluteFire == 1 then
            call UnitAddAbility(u, ABSOLUTE_FIRE_ABILITY_ID)
            call SetUnitAbilityLevel(u, ABSOLUTE_FIRE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceAbsoluteBlood == 1 then
            call UnitAddAbility(u, ABSOLUTE_BLOOD_ABILITY_ID)
            call SetUnitAbilityLevel(u, ABSOLUTE_BLOOD_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceAbsoluteWild == 1 then
            call UnitAddAbility(u, ABSOLUTE_WILD_ABILITY_ID)
            call SetUnitAbilityLevel(u, ABSOLUTE_WILD_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceAcidSpray == 1 then
            call UnitAddAbility(u, ACID_SPRAY_ABILITY_ID)
            call SetUnitAbilityLevel(u, ACID_SPRAY_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif
    
        if RoundCreepChanceAerialShackles == 1 then
            call UnitAddAbility(u, AERIALSHACKLES_CREEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, AERIALSHACKLES_CREEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceArcaneAssault == 1 then
            call UnitAddAbility(u, ARCANE_ASSAULT_ABILITY_ID)
            call SetUnitAbilityLevel(u, ARCANE_ASSAULT_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
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

        if RoundCreepChanceVulnerabilityAura == 1 then
            call UnitAddAbility(u, AURA_OF_VULNERABILITY_ABILITY_ID)
            call SetUnitAbilityLevel(u, AURA_OF_VULNERABILITY_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
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

        if RoundCreepChanceBlinkStrike == 1 then
            call UnitAddAbility(u, BLINK_STRIKE_ABILITY_ID)
            call SetUnitAbilityLevel(u, BLINK_STRIKE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceBlizzard == 1 then
            call UnitAddAbility(u, BLIZZARD_ABILITY_ID)
            call SetUnitAbilityLevel(u, BLIZZARD_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceBloodlust == 1 then
            call UnitAddAbility(u, BLOODLUST_CREEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, BLOODLUST_CREEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceBrillianceAura == 1 then
            call UnitAddAbility(u, BRILLIANCE_AURA_ABILITY_ID)
            call SetUnitAbilityLevel(u, BRILLIANCE_AURA_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
            call AddUnitCustomState(u, BONUS_MAGICPOW, RoundNumber * 0.6)
            call AddUnitCustomState(u, BONUS_MANA_REGEN, RoundNumber * 6)
        endif

        if RoundCreepChanceCarrionSwarm == 1 then
            call UnitAddAbility(u, CARRION_SWARM_ABILITY_ID)
            call SetUnitAbilityLevel(u, CARRION_SWARM_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.4), 30))
        endif

        if RoundCreepChanceChainLightning == 1 then
            call UnitAddAbility(u, CHAINLIGHTNING_CREEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, CHAINLIGHTNING_CREEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.4), 30))
        endif

        if RoundCreepChanceCharm == 1 then
            call UnitAddAbility(u, CHARM_ABILITY_ID)
            call SetUnitAbilityLevel(u, CHARM_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceColdWind == 1 then
            call UnitAddAbility(u, COLD_WIND_ABILITY_ID)
            call SetUnitAbilityLevel(u, COLD_WIND_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.2), 30))
        endif

        if RoundCreepChanceCommandAura == 1 then
            call UnitAddAbility(u, COMMAND_AURA_ABILITY_ID)
            call SetUnitAbilityLevel(u, COMMAND_AURA_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceCorrosiveSkin == 1 then
            call UnitAddAbility(u, CORROSIVE_SKIN_ABILITY_ID)
            call SetUnitAbilityLevel(u, CORROSIVE_SKIN_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.4), 30))
        endif

        if RoundCreepChanceCripple == 1 then
            call UnitAddAbility(u, CRIPPLE_CREEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, CRIPPLE_CREEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceCritStrike == 1 and DamageSourceTypeId != SLUDGE_MINION_CREEP_UNIT_ID and DamageSourceTypeId != DRAENEI_MAGE_CREEP_UNIT_ID and DamageSourceTypeId != WIND_SERPENT_CREEP_UNIT_ID and RoundCreepTypeId != WRAITH_CREEP_UNIT_ID then
            call SetUnitAbilityLevel(u, CRITICAL_STRIKE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.4), 30))
        endif

        if RoundCreepChanceCruelty == 1 and DamageSourceTypeId != SLUDGE_MINION_CREEP_UNIT_ID and DamageSourceTypeId != DRAENEI_MAGE_CREEP_UNIT_ID and DamageSourceTypeId != WIND_SERPENT_CREEP_UNIT_ID and RoundCreepTypeId != WRAITH_CREEP_UNIT_ID then
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

        if RoundCreepChanceCutting == 1 and DamageSourceTypeId != SLUDGE_MINION_CREEP_UNIT_ID and DamageSourceTypeId != DRAENEI_MAGE_CREEP_UNIT_ID and DamageSourceTypeId != WIND_SERPENT_CREEP_UNIT_ID and RoundCreepTypeId != WRAITH_CREEP_UNIT_ID then
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

        if RoundCreepChanceDemolish == 1 then
            call UnitAddAbility(u, DEMOLISH_CREEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, DEMOLISH_CREEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
            call AddUnitCustomState(u, BONUS_PHYSPOW, RoundNumber * 1.8)
        endif
 
        if RoundCreepChanceDemonsCurse == 1 then
            call UnitAddAbility(u, DEMONS_CURSE_ABILITY_ID)
            call SetUnitAbilityLevel(u, DEMONS_CURSE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceDestruction == 1 and DamageSourceTypeId != SLUDGE_MINION_CREEP_UNIT_ID and DamageSourceTypeId != DRAENEI_MAGE_CREEP_UNIT_ID and DamageSourceTypeId != WIND_SERPENT_CREEP_UNIT_ID and RoundCreepTypeId != WRAITH_CREEP_UNIT_ID then
            call UnitAddAbility(u, DESTRUCTION_ABILITY_ID)
            call SetUnitAbilityLevel(u, DESTRUCTION_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.2), 30))
        endif

        if RoundCreepChanceDevastatingBlow == 1 then
            call UnitAddAbility(u, DEVASTATING_BLOW_ABILITY_ID)
            call SetUnitAbilityLevel(u, DEVASTATING_BLOW_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.3), 30))
        endif

        if RoundCreepChanceDevotionAura == 1 then
            call UnitAddAbility(u, DEVOTION_AURA_ABILITY_ID)
            call SetUnitAbilityLevel(u, DEVOTION_AURA_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
            call AddUnitCustomState(u, BONUS_MAGICRES, (RoundNumber * 0.6))
        endif

        if RoundCreepChanceDivineBubble == 1 then
            call UnitAddAbility(u, DIVINE_BUBBLE_ABILITY_ID)
            call SetUnitAbilityLevel(u, DIVINE_BUBBLE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceDivineShield == 1 then
            call UnitAddAbility(u, DIVINE_SHIELD_CREEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, DIVINE_SHIELD_CREEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceDousingHex == 1 then
            call UnitAddAbility(u, DOUSING_HEX_ABILITY_ID)
            call SetUnitAbilityLevel(u, DOUSING_HEX_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceDrunkMaster == 1 and DamageSourceTypeId != SLUDGE_MINION_CREEP_UNIT_ID and DamageSourceTypeId != DRAENEI_MAGE_CREEP_UNIT_ID and DamageSourceTypeId != WIND_SERPENT_CREEP_UNIT_ID and RoundCreepTypeId != WRAITH_CREEP_UNIT_ID then
            call UnitAddAbility(u, DRUNKEN_MASTER_ABILITY_ID)
            call FuncEditParam(DRUNKEN_MASTER_ABILITY_ID, u)
            call SetUnitAbilityLevel(u, DRUNKEN_MASTER_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.3), 30))
            call AddUnitCustomState(u, BONUS_EVASION, RoundNumber * 0.9)
        endif

        if RoundCreepChanceEnduranceAura == 1 then
            call UnitAddAbility(u, ENDURANCE_AURA_ABILITY_ID)
            call SetUnitAbilityLevel(u, ENDURANCE_AURA_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
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

        if RoundCreepChanceEnvenomedWeapons == 1 and DamageSourceTypeId != SLUDGE_MINION_CREEP_UNIT_ID and DamageSourceTypeId != DRAENEI_MAGE_CREEP_UNIT_ID and DamageSourceTypeId != WIND_SERPENT_CREEP_UNIT_ID and RoundCreepTypeId != WRAITH_CREEP_UNIT_ID then
            call UnitAddAbility(u, ENVENOMED_WEAPONS_ABILITY_ID)
            call SetUnitAbilityLevel(u, ENVENOMED_WEAPONS_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.1), 30))
        endif

        if RoundCreepChanceEvasion == 1 then
            call UnitAddAbility(u, EVASION_ABILITY_ID)
            call SetUnitAbilityLevel(u, EVASION_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
            call AddUnitCustomState(u, BONUS_EVASION, RoundNumber * 1.2)
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

        if RoundCreepChanceFireShield == 1 then
            call UnitAddAbility(u, FIRE_SHIELD_ABILITY_ID)
            call SetUnitAbilityLevel(u, FIRE_SHIELD_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
            call AddUnitCustomState(u, BONUS_MAGICRES, RoundNumber * 0.6 * 3)
        endif

        if RoundCreepChanceForkedLightning == 1 then
            call UnitAddAbility(u, FORKED_LIGHTNING_ABILITY_ID)
            call SetUnitAbilityLevel(u, FORKED_LIGHTNING_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.40), 30))
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
            call AddUnitCustomState(u, BONUS_BLOCK, (RoundNumber * 0.3) * 50)
        endif

        if RoundCreepChanceHealingWave == 1 then
            call UnitAddAbility(u, HEALING_WAVE_ABILITY_ID)
            call SetUnitAbilityLevel(u, HEALING_WAVE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceHeavyBlow == 1 then
            call UnitAddAbility(u, HEAVY_BLOW_ABILITY_ID)
            call SetUnitAbilityLevel(u, HEAVY_BLOW_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
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

        if RoundCreepChanceIncinerate == 1 and DamageSourceTypeId != SLUDGE_MINION_CREEP_UNIT_ID and DamageSourceTypeId != DRAENEI_MAGE_CREEP_UNIT_ID and DamageSourceTypeId != WIND_SERPENT_CREEP_UNIT_ID and RoundCreepTypeId != WRAITH_CREEP_UNIT_ID then
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

        if RoundCreepChanceLuckyTrigger == 1 then
            call UnitAddAbility(u, LUCKY_TRIGGER_ABILITY_ID)
            call SetUnitAbilityLevel(u, LUCKY_TRIGGER_ABILITY_ID, IMinBJ(R2I(RoundNumber * 1.0), 30))
            call AddUnitCustomState(u, BONUS_LUCK, RMinBJ(I2R(RoundNumber) * 0.005, 0.15))
        endif

        if RoundCreepChanceMagicCriticalHit == 1 then
            call UnitAddAbility(u, MAGIC_CRITICAL_HIT_ABILITY_ID)
            call SetUnitAbilityLevel(u, MAGIC_CRITICAL_HIT_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceMegaLuck == 1 then
            call UnitAddAbility(u, MEGA_LUCK_ABILITY_ID)
            call SetUnitAbilityLevel(u, MEGA_LUCK_ABILITY_ID, IMinBJ(R2I(RoundNumber * 1.0), 30))
            call AddUnitCustomState(u, BONUS_LUCK, RMinBJ(I2R(RoundNumber) * 0.015, 0.45))
        endif

        if RoundCreepChanceMirrorImage == 1 then
            call UnitAddAbility(u, MIRROR_IMAGE_ABILITY_ID)
            call SetUnitAbilityLevel(u, MIRROR_IMAGE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceMulticast == 1 then
            call UnitAddAbility(u, MULTICAST_ABILITY_ID)
            call SetUnitAbilityLevel(u, MULTICAST_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceMultishot == 1 then
            call UnitAddAbility(u, MULTISHOT_ABILITY_ID)
            call SetUnitAbilityLevel(u, MULTISHOT_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChancePolymorph == 1 then
            call UnitAddAbility(u, POLYMORPH_CREEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, POLYMORPH_CREEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChancePurge == 1 then
            call UnitAddAbility(u, PURGE_ABILITY_ID)
            call SetUnitAbilityLevel(u, PURGE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChancePulverize == 1 and DamageSourceTypeId != SLUDGE_MINION_CREEP_UNIT_ID and DamageSourceTypeId != DRAENEI_MAGE_CREEP_UNIT_ID and DamageSourceTypeId != WIND_SERPENT_CREEP_UNIT_ID and RoundCreepTypeId != WRAITH_CREEP_UNIT_ID then
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

        if RoundCreepChanceReaction == 1 then
            call UnitAddAbility(u, REACTION_ABILITY_ID)
            call SetUnitAbilityLevel(u, REACTION_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

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

        if RoundCreepChanceSlowPoison == 1 then
            call UnitAddAbility(u, SLOW_POISON_ABILITY_ID)
            call SetUnitAbilityLevel(u, SLOW_POISON_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceSoulBurn == 1 then
            call UnitAddAbility(u, SOUL_BURN_ABILITY_ID)
            call SetUnitAbilityLevel(u, SOUL_BURN_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceSpellImmunity == 1 then
            call UnitAddAbility(u, SPELL_IMMUNITY_CREEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, SPELL_IMMUNITY_CREEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceSpikedCarapace == 1 then
            call UnitAddAbility(u, SPIKED_CARAPACE_ABILITY_ID)
            call SetUnitAbilityLevel(u, SPIKED_CARAPACE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceStampede == 1 then
            call UnitAddAbility(u, STAMPEDE_ABILITY_ID)
            call SetUnitAbilityLevel(u, STAMPEDE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
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

        if RoundCreepChanceSummonCarrionBeetles == 1 then
            call UnitAddAbility(u, SUMMON_CARRION_BEETLES_ABILITY_ID)
            call SetUnitAbilityLevel(u, SUMMON_CARRION_BEETLES_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceSummonFeralSpirit == 1 then
            call UnitAddAbility(u, SUMMON_FERAL_SPIRIT_ABILITY_ID)
            call SetUnitAbilityLevel(u, SUMMON_FERAL_SPIRIT_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceSummonHawk == 1 then
            call UnitAddAbility(u, SUMMON_HAWK_ABILITY_ID)
            call SetUnitAbilityLevel(u, SUMMON_HAWK_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceSummonInferno == 1 then
            call UnitAddAbility(u, SUMMON_INFERNO_ABILITY_ID)
            call SetUnitAbilityLevel(u, SUMMON_INFERNO_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceSummonLavaSpawn == 1 then
            call UnitAddAbility(u, SUMMON_LAVA_SPAWN_ABILITY_ID)
            call SetUnitAbilityLevel(u, SUMMON_LAVA_SPAWN_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceSummonMountainGiant == 1 then
            call UnitAddAbility(u, SUMMON_MOUNTAIN_GIANT_ABILITY_ID)
            call SetUnitAbilityLevel(u, SUMMON_MOUNTAIN_GIANT_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceSummonPhoenix == 1 then
            call UnitAddAbility(u, SUMMON_PHOENIX_ABILITY_ID)
            call SetUnitAbilityLevel(u, SUMMON_PHOENIX_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceSummonPocketFactory == 1 then
            call UnitAddAbility(u, SUMMON_POCKET_FACTORY_ABILITY_ID)
            call SetUnitAbilityLevel(u, SUMMON_POCKET_FACTORY_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceSummonSerpentWard == 1 then
            call UnitAddAbility(u, SUMMON_SERPENT_WARD_ABILITY_ID)
            call SetUnitAbilityLevel(u, SUMMON_SERPENT_WARD_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceSummonQuilbeast == 1 then
            call UnitAddAbility(u, SUMMON_QUILBEAST_ABILITY_ID)
            call SetUnitAbilityLevel(u, SUMMON_QUILBEAST_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceSummonWaterElemental == 1 then
            call UnitAddAbility(u, SUMMON_WATER_ELEMENTAL_ABILITY_ID)
            call SetUnitAbilityLevel(u, SUMMON_WATER_ELEMENTAL_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceTranquility == 1 then
            call UnitAddAbility(u, TRANQUILITY_ABILITY_ID)
            call SetUnitAbilityLevel(u, TRANQUILITY_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceTrueShotAura == 1 then
            call UnitAddAbility(u, TRUESHOT_AURA_ABILITY_ID)
            call SetUnitAbilityLevel(u, TRUESHOT_AURA_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceUnholyAura == 1 then
            call UnitAddAbility(u, UNHOLY_AURA_ABILITY_ID)
            call SetUnitAbilityLevel(u, UNHOLY_AURA_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceUnholyFrenzy == 1 then
            call UnitAddAbility(u, UNHOLYFRENZY_CREEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, UNHOLYFRENZY_CREEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceUnlimitedAgony == 1 then
            call UnitAddAbility(u, UNLIMITED_AGON_ABILITY_ID)
            call SetUnitAbilityLevel(u, UNLIMITED_AGON_ABILITY_ID, 30)
        endif

        if RoundCreepChanceVampiricAura == 1 then
            call UnitAddAbility(u, VAMPIRIC_AURA_ABILITY_ID)
            call SetUnitAbilityLevel(u, VAMPIRIC_AURA_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceWarStomp == 1 then
            call UnitAddAbility(u, WAR_STOMP_ABILITY_ID)
            call SetUnitAbilityLevel(u, WAR_STOMP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceWizardbane == 1 then
            call UnitAddAbility(u, WIZARDBANE_AURA_ABILITY_ID)
            call SetUnitAbilityLevel(u, WIZARDBANE_AURA_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.4), 30))
        endif

        if RoundCreepChanceWhirlWind == 1 then
            call UnitAddAbility(u, WHIRLWIND_ABILITY_ID)
            call SetUnitAbilityLevel(u, WHIRLWIND_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceFinishingBlow == 1 then
            call UnitAddAbility(u, FINISHING_BLOW_ABILITY_ID)
            call SetUnitAbilityLevel(u, FINISHING_BLOW_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChancePlague == 1 then
            call UnitAddAbility(u, PLAGUE_ABILITY_ID)
            call SetUnitAbilityLevel(u, PLAGUE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceEnergyBombardment == 1 then
            call UnitAddAbility(u, ENERGY_BOMBARDMENT_ABILITY_ID)
            call SetUnitAbilityLevel(u, ENERGY_BOMBARDMENT_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceColdArrows == 1 then
            call UnitAddAbility(u, COLD_ARROWS_ABILITY_ID)
            call SetUnitAbilityLevel(u, COLD_ARROWS_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceSearingArrows == 1 then
            call UnitAddAbility(u, SEARING_ARROWS_ABILITY_ID)
            call SetUnitAbilityLevel(u, SEARING_ARROWS_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceSpiritShackle == 1 then
            call UnitAddAbility(u, SPIRIT_SHACKLE_ABILITY_ID)
            call SetUnitAbilityLevel(u, SPIRIT_SHACKLE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChancePowerOfIce == 1 then
            call UnitAddAbility(u, POWER_OF_ICE_ABILITY_ID)
            call SetUnitAbilityLevel(u, POWER_OF_ICE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceFireForce == 1 then
            call UnitAddAbility(u, FIRE_FORCE_ABILITY_ID)
            call SetUnitAbilityLevel(u, FIRE_FORCE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceArcaneStrike == 1 then
            call UnitAddAbility(u, ARCANE_STRIKE_ABILITY_ID)
            call SetUnitAbilityLevel(u, ARCANE_STRIKE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceCombustion == 1 then
            call UnitAddAbility(u, COMBUSTION_ABILITY_ID)
            call SetUnitAbilityLevel(u, COMBUSTION_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceDivineGift == 1 then
            call UnitAddAbility(u, DIVINE_GIFT_ABILITY_ID)
            call SetUnitAbilityLevel(u, DIVINE_GIFT_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceEarthquake == 1 then
            call UnitAddAbility(u, EARTHQUAKE_ABILITY_ID)
            call SetUnitAbilityLevel(u, EARTHQUAKE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceFatalFlaw == 1 then
            call UnitAddAbility(u, FATAL_FLAW_ABILITY_ID)
            call SetUnitAbilityLevel(u, FATAL_FLAW_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceFrostbiteOfTheSoul == 1 then
            call UnitAddAbility(u, FROSTBITE_OF_THE_SOUL_ABILITY_ID)
            call SetUnitAbilityLevel(u, FROSTBITE_OF_THE_SOUL_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceMartialRetribution == 1 then
            call UnitAddAbility(u, MARTIAL_RETRIBUTION_ABILITY_ID)
            call SetUnitAbilityLevel(u, MARTIAL_RETRIBUTION_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceMartialTheft == 1 then
            call UnitAddAbility(u, MARTIAL_THEFT_ABILITY_ID)
            call SetUnitAbilityLevel(u, MARTIAL_THEFT_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceMysteriousTalent == 1 then
            call UnitAddAbility(u, MYSTERIOUS_TALENT_ABILITY_ID)
            call SetUnitAbilityLevel(u, MYSTERIOUS_TALENT_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceOverload == 1 then
            call UnitAddAbility(u, OVERLOAD_ABILITY_ID)
            call SetUnitAbilityLevel(u, OVERLOAD_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChancePowerOfWater == 1 then
            call UnitAddAbility(u, POWER_OF_WATER_ABILITY_ID)
            call SetUnitAbilityLevel(u, POWER_OF_WATER_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceShadowDance == 1 then
            call UnitAddAbility(u, SHADOW_DANCE_ABILITY_ID)
            call SetUnitAbilityLevel(u, SHADOW_DANCE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceShadowStep == 1 then
            call UnitAddAbility(u, SHADOW_STEP_ABILITY_ID)
            call SetUnitAbilityLevel(u, SHADOW_STEP_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceThunderForce == 1 then
            call UnitAddAbility(u, THUNDER_FORCE_ABILITY_ID)
            call SetUnitAbilityLevel(u, THUNDER_FORCE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceTimeManipulation == 1 then
            call UnitAddAbility(u, TIME_MANIPULATION_ABILITY_ID)
            call SetUnitAbilityLevel(u, TIME_MANIPULATION_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceWildDefense == 1 then
            call UnitAddAbility(u, WILD_DEFENSE_ABILITY_ID)
            call SetUnitAbilityLevel(u, WILD_DEFENSE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceManaStarvation == 1 then
            call UnitAddAbility(u, MANA_STARVATION_ABILITY_ID)
            call SetUnitAbilityLevel(u, MANA_STARVATION_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceExtradimensionalCooperation == 1 then
            call UnitAddAbility(u, EXTRADIMENSIONAL_COOPERATION_ABILITY_ID)
            call SetUnitAbilityLevel(u, EXTRADIMENSIONAL_COOPERATION_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceHeroForce == 1 then
            call UnitAddAbility(u, HERO_FORCE_ABILITY_ID)
            call SetUnitAbilityLevel(u, HERO_FORCE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceTemporaryInvisibility == 1 then
            call UnitAddAbility(u, TEMPORARY_INVISIBILITY_ABILITY_ID)
            call SetUnitAbilityLevel(u, TEMPORARY_INVISIBILITY_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceTemporaryPower == 1 then
            call UnitAddAbility(u, TEMPORARY_POWER_ABILITY_ID)
            call SetUnitAbilityLevel(u, TEMPORARY_POWER_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceHeroBuff == 1 then
            call UnitAddAbility(u, HERO_BUFF_ABILITY_ID)
            call SetUnitAbilityLevel(u, HERO_BUFF_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceRapidRecovery == 1 then
            call UnitAddAbility(u, RAPID_RECOVERY_ABILITY_ID)
            call SetUnitAbilityLevel(u, RAPID_RECOVERY_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceNecromancersArmy == 1 then
            call UnitAddAbility(u, NECROMANCERS_ARMY_ABILITY_ID)
            call SetUnitAbilityLevel(u, NECROMANCERS_ARMY_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceBlackArrow == 1 then
            call UnitAddAbility(u, BLACK_ARROW_ABILITY_ID)
            call SetUnitAbilityLevel(u, BLACK_ARROW_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceManaBonus == 1 then
            call UnitAddAbility(u, MANA_BONUS_ABILITY_ID)
            call SetUnitAbilityLevel(u, MANA_BONUS_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
            call AddUnitCustomState(u, BONUS_MANA, I2R(R2I(RoundNumber * 0.6)) * 10000.0)
        endif

        if RoundCreepChanceMegaSpeed == 1 then
            call UnitAddAbility(u, MEGA_SPEED_ABILITY_ID)
            call SetUnitAbilityLevel(u, MEGA_SPEED_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceFearlessDefenders == 1 then
            call UnitAddAbility(u, FEARLESS_DEFENDERS_ABILITY_ID)
            call SetUnitAbilityLevel(u, FEARLESS_DEFENDERS_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceCheaterMagic == 1 then
            call UnitAddAbility(u, CHEATER_MAGIC_ABILITY_ID)
            call SetUnitAbilityLevel(u, CHEATER_MAGIC_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceChaosMagic == 1 then
            call UnitAddAbility(u, CHAOS_MAGIC_ABILITY_ID)
            call SetUnitAbilityLevel(u, CHAOS_MAGIC_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceBlessedProtection == 1 then
            call UnitAddAbility(u, BLESSED_PROTECTION_ABILITY_ID)
            call SetUnitAbilityLevel(u, BLESSED_PROTECTION_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceFog == 1 then
            call UnitAddAbility(u, FOG_ABILITY_ID)
            call SetUnitAbilityLevel(u, FOG_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceWindWalk == 1 then
            call UnitAddAbility(u, WIND_WALK_ABILITY_ID)
            call SetUnitAbilityLevel(u, WIND_WALK_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceBerserk == 1 then
            call UnitAddAbility(u, BERSERK_ABILITY_ID)
            call SetUnitAbilityLevel(u, BERSERK_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceFlameStrike == 1 then
            call UnitAddAbility(u, FLAME_STRIKE_ABILITY_ID)
            call SetUnitAbilityLevel(u, FLAME_STRIKE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
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
        local integer OgreLordWaveRoll = 0
        local real CreepScaleHitpoints = 0
        local real CreepScaleDamage = 0

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

        //generate creep type
        set RoundCreepTypeId = CreepUnitTypeIds[GetRandomInt(1, (MaxCreepUnitTypes - 4))]

        //set movement and attack speeds
        set RoundCreepMoveSpeed = GetRandomInt(GetRandomInt(150, 150 + RoundNumber * 2), 422 + RoundNumber * 2)
        set RoundCreepMaxAttackSpeed = GetRandomInt(1, RoundNumber)
        
        if RoundNumber > 25 then
            set newAbilChance = 20
        endif

        if RoundNumber > 40 then
            set oldAbilChance = 15
        endif

        //magic damage creeps
        if RoundNumber > 14 then
            set MagicWaveRoll = GetRandomInt(1, 50)
            if MagicWaveRoll == 1 then
                set RoundCreepTypeId = DRAENEI_MAGE_CREEP_UNIT_ID
            elseif MagicWaveRoll == 2 then
                set RoundCreepTypeId = SLUDGE_MINION_CREEP_UNIT_ID
            elseif MagicWaveRoll == 3 then
                set RoundCreepTypeId = WIND_SERPENT_CREEP_UNIT_ID  
            elseif MagicWaveRoll == 4 then
                set RoundCreepTypeId = WRAITH_CREEP_UNIT_ID  
            endif
        endif 

        if RoundNumber > 5 and not IsMagicCreep(RoundCreepTypeId) then
            set RoundCreepChanceBash = GetRandomInt(1, 20) 
        endif

        if RoundNumber > 25 and RoundNumber < 49 then
            set OgreLordWaveRoll = GetRandomInt(1, 50)
            if OgreLordWaveRoll == 1 then
                set RoundCreepTypeId = OGRE_LORD_CREEP_UNIT_ID
            endif 
        endif

        if RoundNumber > 5 then
            set RoundCreepChanceHurlBoulder = GetRandomInt(1, 20) 
            set RoundCreepChanceRejuv = GetRandomInt(1, 20) 
            set RoundCreepChanceSlow = GetRandomInt(1, oldAbilChance)
            set RoundCreepChanceSlowAura = GetRandomInt(1, newAbilChance) 
            set RoundCreepChanceImmortalAura = GetRandomInt(1, newAbilChance) 
        endif

        if ((RoundNumber + 1) > 1) then
            set RoundCreepChanceBigBadV = GetRandomInt(1, oldAbilChance) 
            set RoundCreepChanceBlink = GetRandomInt(1, oldAbilChance) 

            if not IsMagicCreep(RoundCreepTypeId) then
                set RoundCreepChanceCritStrike = GetRandomInt(1, oldAbilChance) 
                set RoundCreepChanceShockwave = GetRandomInt(1, oldAbilChance) 
                if RoundNumber > 5 then
                    set RoundCreepChanceThunderClap = GetRandomInt(1, oldAbilChance) 
                endif
            else
                set RoundCreepChanceCritStrike = 0
                set RoundCreepChanceShockwave = 0
                set RoundCreepChanceThunderClap = 0
            endif

            set RoundCreepChanceEvasion = GetRandomInt(1, oldAbilChance) 
            set RoundCreepChanceFaerieFire = GetRandomInt(1, oldAbilChance) 
            set RoundCreepChanceLifesteal = GetRandomInt(1, oldAbilChance) 
            set RoundCreepChanceManaBurn = GetRandomInt(1, oldAbilChance)

            if not IsRangedCreep(RoundCreepTypeId) or not IsMagicCreep(RoundCreepTypeId) then
                set RoundCreepChanceCleave = GetRandomInt(1, oldAbilChance)
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

        //Ranged physical attack abilities
        if (GameModeShort == true and RoundNumber >= 15) or (GameModeShort == false and RoundNumber >= 34) then
            if IsRangedCreep(RoundCreepTypeId) then
                set RoundCreepChanceMultishot           = GetRandomInt(1, 80)
            endif
        endif

        //Caster abilities - late game
        if (GameModeShort == true and RoundNumber >= 15) or (GameModeShort == false and RoundNumber >= 34) then
            if IsSpellcasterCreep(RoundCreepTypeId) then
                set RoundCreepChanceFrostNova           = GetRandomInt(1, 15) 
            endif
        endif

        //Caster abilities - early game
        if (GameModeShort == true and RoundNumber >= 8 and RoundNumber <= 15) or (GameModeShort == false and RoundNumber >= 15 and RoundNumber <= 37) then
            if IsSpellcasterCreep(RoundCreepTypeId) then
                set RoundCreepChanceDousingHex          = GetRandomInt(1, 25) 
                set RoundCreepChanceShadowStrike        = GetRandomInt(1, 15) 
                set RoundCreepChanceFingerOfDeath       = GetRandomInt(1, 10000) 
                set RoundCreepChanceChainLightning      = GetRandomInt(1, 80) 
                set RoundCreepChanceCurse               = GetRandomInt(1, 80)      
                set RoundCreepChanceDeathCoil           = GetRandomInt(1, 35) 
                set RoundCreepChanceFingerOfPain        = GetRandomInt(1, 80) 
                set RoundCreepChanceCripple             = GetRandomInt(1, 35) 
                set RoundCreepChanceSilence             = GetRandomInt(1, 35) 
                set RoundCreepChanceHowlOfTerror        = GetRandomInt(1, 35) 
                set RoundCreepChanceForkedLightning     = GetRandomInt(1, 80) 
                set RoundCreepChanceIcyBreath           = GetRandomInt(1, 35) 
                set RoundCreepChanceSoulBurn            = GetRandomInt(1, 35) 
                set RoundCreepChanceBlizzard            = GetRandomInt(1, 20) 
                set RoundCreepChanceRainOfFire          = GetRandomInt(1, 30) 
                set RoundCreepChanceWhirlWind           = GetRandomInt(1, 50)
            endif
        endif

        //Caster abilities - late game
        if (GameModeShort == true and RoundNumber >15) or (GameModeShort == false and RoundNumber >37) then
                set RoundCreepChanceDousingHex          = GetRandomInt(1, 25) 
                set RoundCreepChanceShadowStrike        = GetRandomInt(1, 15) 
                set RoundCreepChanceFingerOfDeath       = GetRandomInt(1, 10000) 
                set RoundCreepChanceChainLightning      = GetRandomInt(1, 80) 
                set RoundCreepChanceCurse               = GetRandomInt(1, 80)      
                set RoundCreepChanceDeathCoil           = GetRandomInt(1, 35) 
                set RoundCreepChanceFingerOfPain        = GetRandomInt(1, 80) 
                set RoundCreepChanceCripple             = GetRandomInt(1, 35) 
                set RoundCreepChanceSilence             = GetRandomInt(1, 35) 
                set RoundCreepChanceHowlOfTerror        = GetRandomInt(1, 35) 
                set RoundCreepChanceForkedLightning     = GetRandomInt(1, 80) 
                set RoundCreepChanceIcyBreath           = GetRandomInt(1, 35) 
                set RoundCreepChanceSoulBurn            = GetRandomInt(1, 35) 
                set RoundCreepChanceBlizzard            = GetRandomInt(1, 20) 
                set RoundCreepChanceRainOfFire          = GetRandomInt(1, 30) 
                set RoundCreepChanceAcidSpray           = GetRandomInt(1, 2000) 
        endif

        //Physical attacker abilities very early game
        if IsRangedCreep(RoundCreepTypeId) or IsMeleeCreep(RoundCreepTypeId) then 
            if (GameModeShort == true and RoundNumber >= 5) or (GameModeShort == false and RoundNumber >= 10) then
                set RoundCreepChanceDrunkMaster         = GetRandomInt(1, oldAbilChance) 
                set RoundCreepChancePulverize           = GetRandomInt(1, newAbilChance) 
                set RoundCreepChanceHeavyBlow           = GetRandomInt(1, 45) 
            endif
        endif

        //Physical attacker abilities early game
        if IsRangedCreep(RoundCreepTypeId) or IsMeleeCreep(RoundCreepTypeId) then
            if (GameModeShort == true and RoundNumber >= 8) or (GameModeShort == false and RoundNumber >= 15) then
                set RoundCreepChanceArcaneAssault       = GetRandomInt(1, 120) 
                set RoundCreepChanceBackStab            = GetRandomInt(1, 15) 
                set RoundCreepChanceBloodlust           = GetRandomInt(1, 15) 
                set RoundCreepChanceBlinkStrike         = GetRandomInt(1, 35) 
                set RoundCreepChanceDevastatingBlow     = GetRandomInt(1, 10000) 
                set RoundCreepChanceColdWind            = GetRandomInt(1, 25) 
                set RoundCreepChanceFrenzy              = GetRandomInt(1, 15) 
                set RoundCreepChanceUnholyFrenzy        = GetRandomInt(1, 25) 
                set RoundCreepChanceDemolish            = GetRandomInt(1, 25) 
                set RoundCreepChanceIncinerate          = GetRandomInt(1, 20) 
                set RoundCreepChanceCruelty             = GetRandomInt(1, 20) 
                set RoundCreepChanceCutting             = GetRandomInt(1, 15) 
                set RoundCreepChanceEnvenomedWeapons    = GetRandomInt(1, 65) 
                set RoundCreepChanceSlowPoison          = GetRandomInt(1, 100) 
            endif
        endif

        //Physical attacker abilities lategame
        if IsRangedCreep(RoundCreepTypeId) or IsMeleeCreep(RoundCreepTypeId) then
            if (GameModeShort == true and RoundNumber >= 15) or (GameModeShort == false and RoundNumber >= 34) then
                set RoundCreepChanceLiquidFire          = GetRandomInt(1, 80) 
                set RoundCreepChanceFearAura            = GetRandomInt(1, 20) 
                set RoundCreepChanceDestruction         = GetRandomInt(1, 20) 
                set RoundCreepChanceTrueShotAura        = GetRandomInt(1, 40) 
                set RoundCreepChanceEnduranceAura       = GetRandomInt(1, 40) 
                set RoundCreepChanceColdArrows          = GetRandomInt(1, 150) 
                set RoundCreepChanceSearingArrows       = GetRandomInt(1, 150) 
            endif
        endif

        //Magic attacker and caster abilities
        if IsMagicCreep(RoundCreepTypeId) or IsSpellcasterCreep(RoundCreepTypeId) then
            set RoundCreepChanceBrillianceAura          = GetRandomInt(1, 25)
            set RoundCreepChanceBanish                  = GetRandomInt(1, 3000) 
        endif

        //Neutral and universal abilities
        if (GameModeShort == true and RoundNumber >= 8) or (GameModeShort == false and RoundNumber >= 15) then
            //Neutral
            set RoundCreepChanceMirrorImage             = GetRandomInt(1, 8000)
            set RoundCreepChanceUnholyAura              = GetRandomInt(1, 50)
            set RoundCreepChanceVampiricAura            = GetRandomInt(1, 50)
            set RoundCreepChanceVulnerabilityAura       = GetRandomInt(1, 50)
            set RoundCreepChanceCharm                   = GetRandomInt(1, 1000)
            set RoundCreepChanceFinishingBlow           = GetRandomInt(1, 25) 

            //Return damage abilities
            set RoundCreepChanceSpikedCarapace          = GetRandomInt(1, 65) 
            set RoundCreepChanceCorrosiveSkin           = GetRandomInt(1, newAbilChance) 
            //set RoundCreepChanceFireForce = 1 //works but regular creeps don't have a str stat

            //Stun abilities
            set RoundCreepChanceEnsnare                 = GetRandomInt(1, 120) 
            set RoundCreepChanceEntanglingRoots         = GetRandomInt(1, 180) 
            set RoundCreepChanceStormBolt               = GetRandomInt(1, 80) 
            set RoundCreepChanceFirebolt                = GetRandomInt(1, 160) 
            set RoundCreepChanceAerialShackles          = GetRandomInt(1, 160) 
            set RoundCreepChanceWarStomp                = GetRandomInt(1, 160) 
            set RoundCreepChanceImpale                  = GetRandomInt(1, 160) 
            set RoundCreepChanceSleep                   = GetRandomInt(1, 800) 
            set RoundCreepChanceHex                     = GetRandomInt(1, 1800) 
            set RoundCreepChanceFrostBolt               = GetRandomInt(1, 120)
            set RoundCreepChancePolymorph               = GetRandomInt(1, 1800)

            //Defensive Abilities
            set RoundCreepChanceFireShield              = GetRandomInt(1, 45) 
            set RoundCreepChanceAntiMagicShell          = GetRandomInt(1, 35) 
            set RoundCreepChanceDivineShield            = GetRandomInt(1, 180)  
            set RoundCreepChanceStoneProt               = GetRandomInt(1, 50) 
            set RoundCreepChanceGuardianSpirit          = GetRandomInt(1, 10) 
            set RoundCreepChanceAvatar                  = GetRandomInt(1, 180) 
            set RoundCreepChanceHealingWave             = GetRandomInt(1, 25) 
            set RoundCreepChanceIceForce                = GetRandomInt(1, 15) 
            set RoundCreepChanceHolyLight               = GetRandomInt(1, 35) 
            set RoundCreepChanceTranquility             = GetRandomInt(1, 80) 
            set RoundCreepChanceFrostArmor              = GetRandomInt(1, 35) 
            set RoundCreepChanceSpellImmunity           = GetRandomInt(1, 10000) 
            set RoundCreepChanceReincarnation           = GetRandomInt(1, 80) 
            set RoundCreepChanceEnergyShield            = GetRandomInt(1, 35) 
            set RoundCreepChanceHardenedSkin            = GetRandomInt(1, 25) 
            set RoundCreepChanceDivineBubble            = GetRandomInt(1, 15) 
            set RoundCreepChanceReaction                = GetRandomInt(1, 50)  
            set RoundCreepChanceDevotionAura            = GetRandomInt(1, 25) 

            //Chaos magic works in principle, but had one round that froze until an invisible dummy could be killed with fire shield
            //set RoundCreepChanceChaosMagic          = GetRandomInt(1, 35) 

           // still unsure if work
           // set RoundCreepChanceCombustion              = GetRandomInt(1, 25) 
            //set RoundCreepChanceFatalFlaw               = GetRandomInt(1, 25) 

            //not tested yet
            /*
            set RoundCreepChancePlague = 1   
            set RoundCreepChanceSpiritShackle = 1
            set RoundCreepChanceArcaneStrike = 1
            set RoundCreepChanceDivineGift = 1
            set RoundCreepChanceFrostbiteOfTheSoul = 1
            set RoundCreepChanceMartialRetribution = 1
            set RoundCreepChanceMartialTheft = 1         
            set RoundCreepChanceOverload = 1
            set RoundCreepChancePowerOfWater = 1
            set RoundCreepChanceShadowDance = 1
            set RoundCreepChanceShadowStep = 1
            set RoundCreepChanceThunderForce = 1
            set RoundCreepChanceTimeManipulation = 1
            set RoundCreepChanceWildDefense = 1
            set RoundCreepChanceManaStarvation = 1
            set RoundCreepChanceExtradimensionalCooperation = 1
            set RoundCreepChanceHeroForce = 1
            set RoundCreepChanceNecromancersArmy = 1
            set RoundCreepChanceBlackArrow = 1
            set RoundCreepChanceCheaterMagic = 1
            set RoundCreepChanceWindWalk = 1
            set RoundCreepChanceBerserk = 1
            set RoundCreepChanceFlameStrike = 1*/

            //Summons (not active yet)
            //set RoundCreepChanceSummonCarrionBeetles = GetRandomInt(1, 4)
            //set RoundCreepChanceSummonFeralSpirit    = GetRandomInt(1, 4)
            //set RoundCreepChanceSummonHawk           = GetRandomInt(1, 4)
            //set RoundCreepChanceSummonInferno        = GetRandomInt(1, 1)
            //set RoundCreepChanceSummonLavaSpawn      = GetRandomInt(1, 4)
            //set RoundCreepChanceSummonMountainGiant  = GetRandomInt(1, 4)
            //set RoundCreepChanceSummonPhoenix        = GetRandomInt(1, 4)
            //set RoundCreepChanceSummonPocketFactory  = GetRandomInt(1, 1)
            //set RoundCreepChanceSummonSerpentWard    = GetRandomInt(1, 1)
            //set RoundCreepChanceSummonQuilbeast      = GetRandomInt(1, 4)
            //set RoundCreepChanceSummonWaterElemental = GetRandomInt(1, 4)
            
            //dees isnt workkin yet an need sum1 actually intrellagent to fix:
            /*//Absolute abilities (dont appear on the absolute skill bar at top left)
            set RoundCreepChanceAbsoluteDark   = GetRandomInt(1, 50)
            set RoundCreepChanceAbsolutePoison = GetRandomInt(1, 50)
            set RoundCreepChanceAbsoluteLight  = GetRandomInt(1, 50)
            set RoundCreepChanceAbsoluteWind   = GetRandomInt(1, 50)
            set RoundCreepChanceAbsoluteEarth  = GetRandomInt(1, 50)
            set RoundCreepChanceAbsoluteWater  = GetRandomInt(1, 50)
            set RoundCreepChanceAbsoluteCold   = GetRandomInt(1, 50)
            set RoundCreepChanceAbsoluteArcane = GetRandomInt(1, 50)
            set RoundCreepChanceAbsoluteFire   = GetRandomInt(1, 50)
            set RoundCreepChanceAbsoluteBlood  = GetRandomInt(1, 50)
            set RoundCreepChanceAbsoluteWild   = GetRandomInt(1, 50)

            //tested and either partly working or not at all
            set RoundCreepChanceFog = GetRandomInt(1, 2) 
            set RoundCreepChanceMartialTheft = GetRandomInt(1, 2) 
            set RoundCreepChanceManaBonus = GetRandomInt(1, 2) 
            set RoundCreepChanceMegaSpeed = GetRandomInt(1, 2) 
            set RoundCreepChanceFearlessDefenders = GetRandomInt(1, 2) 
            set RoundCreepChancePowerOfIce = GetRandomInt(1, 2) 
            set RoundCreepChanceOverload = GetRandomInt(1, 2) 
            set RoundCreepChanceMysteriousTalent = GetRandomInt(1, 2) 
            set RoundCreepChanceEarthquake = 1
            set RoundCreepChanceEnergyBombardment = 1
            set RoundCreepChanceTemporaryInvisibility = 1
            set RoundCreepChanceTemporaryPower = 1
            set RoundCreepChanceHeroBuff = 1
            set RoundCreepChanceRapidRecovery = 1
            set RoundCreepChanceBlessedProtection = 1
            set RoundCreepChanceMulticast               = 1
            set RoundCreepChanceBattleRoar            = GetRandomInt(1, 15) 
            set RoundCreepChanceStampede                = GetRandomInt(1, 1)
            set RoundCreepChanceFeedback                = GetRandomInt(1, 15) 
            set RoundCreepChanceStasisTrap              = GetRandomInt(1, 15) 
            set RoundCreepChanceInnerFire               = GetRandomInt(1, 15) 
            set RoundCreepChanceLightningShield         = GetRandomInt(1, 15) 
            set RoundCreepChancePurge                   = GetRandomInt(1, 15) 
            set RoundCreepChanceCrushingWave            = GetRandomInt(1, 15)        
            set RoundCreepChanceCommandAura       = 1
            set RoundCreepChanceDemonsCurse = 1
            set RoundCreepChanceCarrionSwarm            = GetRandomInt(1, 15) */
            //set RoundCreepChanceDeathAndDecay         = GetRandomInt(1, 15) <-- only jizzes once
            //set RoundCreepChanceRandomSpell           = GetRandomInt(1, 15) 
            //set RoundCreepChanceCyclone               = GetRandomInt(1, 1) < only jizzes once
        endif
    
        //Last Breaths Chance with anti-lag measure
        if (RoundNumber == 28 or RoundNumber == 38 or RoundNumber == 48) and GetRemainingPlayerCount() < 5 then
            set RoundCreepChanceLastBreath              = GetRandomInt(1, 2)
        elseif RoundNumber > 20 and GetRemainingPlayerCount() < 5 then
            set RoundCreepChanceLastBreath              = GetRandomInt(1, 50)
        else
            set RoundCreepChanceLastBreath = 2
        endif

        //Luck Abilities
        if (GameModeShort == true and RoundNumber >= 8) or (GameModeShort == false and RoundNumber >= 15) then
            if RoundCreepChanceDrunkMaster == 1 or RoundCreepChancePulverize == 1 or RoundCreepChanceMagicCriticalHit == 1 or RoundCreepChanceCorrosiveSkin == 1 or RoundCreepChanceDestruction == 1 or RoundCreepChanceBash == 1 or RoundCreepChanceCritStrike == 1 or RoundCreepChanceMagicCriticalHit == 1 then
                set RoundCreepChanceLuckyTrigger        = GetRandomInt(1, 6)
                set RoundCreepChanceMegaLuck            = GetRandomInt(1, 6) 
            endif  
        endif

        //Caster buff abilities
        if (GameModeShort == true and RoundNumber >= 8) or (GameModeShort == false and RoundNumber >= 15) then
            if RoundCreepChanceBloodlust == 1 or RoundCreepChanceDivineShield == 1 or RoundCreepChanceEnsnare == 1 or RoundCreepChanceGuardianSpirit == 1 or RoundCreepChanceAvatar == 1 or RoundCreepChanceHealingWave == 1 or RoundCreepChanceRainOfFire == 1 or RoundCreepChanceAntiMagicShell == 1 or RoundCreepChanceStoneProt == 1 or RoundCreepChanceDivineBubble == 1 or RoundCreepChanceIceForce == 1 or RoundCreepChanceBlizzard == 1 or RoundCreepChanceFrostNova == 1 or RoundCreepChanceEntanglingRoots == 1 or RoundCreepChanceStormBolt == 1 or RoundCreepChanceFingerOfDeath == 1 or RoundCreepChanceHex == 1 or RoundCreepChanceFirebolt == 1 or RoundCreepChanceSilence == 1 or RoundCreepChanceAerialShackles == 1 or RoundCreepChanceBanish == 1 or RoundCreepChanceHolyLight == 1 or RoundCreepChanceTranquility == 1 or RoundCreepChanceChainLightning == 1 or RoundCreepChanceWarStomp == 1 or RoundCreepChanceCripple == 1 or RoundCreepChanceFrostArmor == 1 or RoundCreepChanceImpale == 1 or RoundCreepChanceSleep == 1 or RoundCreepChanceCurse == 1 or RoundCreepChanceDevastatingBlow == 1 or RoundCreepChanceDeathCoil == 1 or RoundCreepChanceFingerOfPain == 1 or RoundCreepChanceHowlOfTerror == 1 or RoundCreepChanceCruelty == 1 or RoundCreepChanceSoulBurn == 1 or RoundCreepChanceColdWind == 1 or RoundCreepChanceForkedLightning == 1 or RoundCreepChanceFrostBolt == 1 or RoundCreepChanceCyclone == 1 or RoundCreepChanceIcyBreath == 1 or RoundCreepChanceBattleRoar == 1 or RoundCreepChanceStasisTrap == 1 or RoundCreepChanceInnerFire == 1 or RoundCreepChanceLightningShield == 1 or RoundCreepChancePurge == 1 or RoundCreepChanceCrushingWave == 1 or RoundCreepChanceCarrionSwarm == 1 or RoundCreepChanceDeathAndDecay == 1 or RoundCreepChanceHurlBoulder == 1 or RoundCreepChanceRejuv == 1 or RoundCreepChanceSlow == 1 or RoundCreepChanceBlink == 1 or RoundCreepChanceShockwave == 1 or RoundCreepChanceThunderClap == 1 or RoundCreepChanceFaerieFire == 1 or RoundCreepChanceManaBurn == 1 or RoundCreepChanceShadowStrike == 1 or RoundCreepChancePolymorph == 1 or RoundCreepChanceFrenzy == 1 or RoundCreepChanceUnholyFrenzy == 1 or RoundCreepChanceDousingHex == 1 or RoundCreepChanceBlinkStrike == 1 or RoundCreepChanceStampede == 1 or RoundCreepChanceMirrorImage == 1 or RoundCreepChanceHeavyBlow == 1 then
                set RoundCreepChanceFastMagic           = GetRandomInt(1, 5)
                set RoundCreepChanceAncientTeaching     = GetRandomInt(1, 5)
            endif
        endif

        //Boss Round
        if (GameModeShort == true and RoundNumber >= 24) or (GameModeShort == false and RoundNumber >= 49) then
            call PlaySoundBJ(rescuesound)
            call ResetRoundCreepChances()
            if GetRemainingPlayerCount() <= 4 then 
                set RoundSkillGroupRoll = GetRandomInt(4, 7)
                if RoundSkillGroupRoll == 4 then
                    set RoundCreepTypeId = BURNING_ARCHER_CREEP_UNIT_ID
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
                    set RoundCreepTypeId = HOLY_DEFENDER_CREEP_UNIT_ID
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
                    set RoundCreepTypeId = THUNDER_LIZARD_CREEP_UNIT_ID
                    set RoundCreepChanceChainLightning = 1
                    set RoundCreepChanceForkedLightning = 1
                    set RoundCreepChanceStormBolt = 1
                    set RoundCreepChanceThunderClap = 1
                    set RoundCreepChanceFastMagic = 1
                    set RoundCreepChanceAncientTeaching = 1
                    set RoundCreepChanceUnlimitedAgony = 1
                elseif RoundSkillGroupRoll == 7 then
                    set RoundCreepTypeId = GREEN_DRAGON_CREEP_UNIT_ID 
                    set RoundCreepChanceImpale = 1
                    set RoundCreepChanceEntanglingRoots = 1
                    set RoundCreepChanceWarStomp = 1 
                    set RoundCreepChanceHardenedSkin = 1
                    set RoundCreepChanceFastMagic = 1
                    set RoundCreepChanceAncientTeaching = 1
                    set RoundCreepChanceUnlimitedAgony = 1
                endif
            else 
                set RoundSkillGroupRoll = GetRandomInt(8, 11)
                if RoundSkillGroupRoll == 8 then
                    set RoundCreepTypeId = DRAGON_TURTLE_CREEP_UNIT_ID
                    set RoundCreepChanceThorns = 1
                    set RoundCreepChanceReflectAura = 1
                    set RoundCreepChanceWizardbane = 1
                    set RoundCreepChanceCorrosiveSkin = 1
                    set RoundCreepChanceUnlimitedAgony = 1
                elseif RoundSkillGroupRoll == 9 then
                    set RoundCreepTypeId = MAGNATAUR_CREEP_UNIT_ID
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
                elseif RoundSkillGroupRoll == 10 then
                    set RoundCreepTypeId = CHAOS_WARLORD_CREEP_UNIT_ID
                    set RoundCreepChanceBloodlust = 1
                    set RoundCreepChanceCleave = 1
                    set RoundCreepChanceCritStrike = 1
                    set RoundCreepChanceCruelty = 1
                    set RoundCreepChanceHowlOfTerror = 1
                    set RoundCreepChanceBackStab = 1
                    set RoundCreepChanceUnlimitedAgony = 1
                elseif RoundSkillGroupRoll == 11 then
                    set RoundCreepTypeId = BLACK_DRAGON_CREEP_UNIT_ID
                    set RoundCreepChanceHowlOfTerror = 1
                    set RoundCreepChanceFingerOfDeath = 1
                    set RoundCreepChanceUnlimitedAgony = 1
                endif
            endif
        endif
    
        //Creep counts based on remaining players
        if (GameModeShort == true and RoundNumber < 3) or (GameModeShort == false and RoundNumber < 5) then
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

        //Last breaths creepcount limiter
        if RoundNumber >= 45 then
            if RoundCreepChanceLastBreath == 1 then
                set RoundCreepNumber = GetRandomInt(2, 5)
            else
                // R45+ anti lag creep reduction
                if GetRemainingPlayerCount() >= 6 then
                    set RoundCreepNumber = GetRandomInt(2, 7)
                elseif GetRemainingPlayerCount() == 4 or GetRemainingPlayerCount() == 5 then
                    set RoundCreepNumber = GetRandomInt(2, 10)
                elseif GetRemainingPlayerCount() <= 3 then
                    set RoundCreepNumber = GetRandomInt(2, 25)
                endif
            endif
        endif

        // Mini boss Round - give random reward like +1 end of round, absolute slot, 10k glory or a random boss-only item
       /* if ((GameModeShort == true and RoundNumber <= 23) or (GameModeShort == false and RoundNumber <= 48)) then
            if GetRandomInt(1, 100) <= 5 then
                call PlaySoundBJ(rescuesound)
                call ResetRoundCreepChances()
                if GetRemainingPlayerCount() <= 4 then
                    set RoundSkillGroupRoll = GetRandomInt(1, 12)
                    if RoundSkillGroupRoll == 1 then
                        set RoundCreepTypeId = OGRE_LORD_CREEP_UNIT_ID
                        set RoundCreepNumber = 3
                        set RoundCreepChanceWarStomp     = 1
                        set RoundCreepChanceArcaneAssault = 1
                        set RoundCreepChancePulverize    = 1
                    elseif RoundSkillGroupRoll == 2 then
                        // Replace with your troll berserker unit ID constant
                        //set RoundCreepTypeId = TROLL_BERSERKER_CREEP_UNIT_ID
                        //set RoundCreepNumber = 3
                        //set RoundCreepChanceTrueShotAura = 1
                        //set RoundCreepChanceArcaneAssault = 1
                        //set RoundCreepChanceBash         = 1
                        //set RoundCreepChanceIncinerate   = 1
                        //set RoundCreepChanceSlowAura     = 1
                    elseif RoundSkillGroupRoll == 3 then
                        set RoundCreepTypeId = HARPY_QUEEN_CREEP_UNIT_ID
                        set RoundCreepNumber = 3
                    elseif RoundSkillGroupRoll == 4 then
                        set RoundCreepTypeId = ARCHMAGE_CREEP_UNIT_ID
                        set RoundCreepNumber = 3
                        set RoundCreepChanceWizardbane     = 1
                        set RoundCreepChanceArcaneAssault  = 1
                        set RoundCreepChanceTrueShotAura   = 1
                        set RoundCreepChanceEnduranceAura  = 1
                        set RoundCreepChanceLiquidFire     = 1
                    elseif RoundSkillGroupRoll == 5 then
                        // "stomp" is not valid code; pick a unit and abilities
                        //set RoundCreepTypeId = STOMPER_CREEP_UNIT_ID
                        set RoundCreepNumber = 3
                        set RoundCreepChanceWarStomp = 1
                    elseif RoundSkillGroupRoll == 6 then
                        // "grunt" placeholder; use an actual unit ID
                        //set RoundCreepTypeId = ORC_GRUNT_CREEP_UNIT_ID
                        set RoundCreepNumber = 3
                        // Add abilities for grunt

                    elseif RoundSkillGroupRoll == 7 then
                        // "invisible" placeholder; choose a stealth unit or set invis ability
                        //set RoundCreepTypeId = ROGUE_CREEP_UNIT_ID
                        set RoundCreepNumber = 3
                        //set RoundCreepChancePermanentInvisibility = 1

                    elseif RoundSkillGroupRoll == 8 then
                        //set RoundCreepTypeId = ABOMINATION_CREEP_UNIT_ID
                        set RoundCreepNumber = 3
                        // Add abomination abilities

                    elseif RoundSkillGroupRoll == 9 then
                        //set RoundCreepTypeId = DOOMGUARD_CREEP_UNIT_ID
                        set RoundCreepNumber = 3
                        // Add doomguard abilities

                    elseif RoundSkillGroupRoll == 10 then
                        //set RoundCreepTypeId = FLESH_GOLEM_CREEP_UNIT_ID
                        set RoundCreepNumber = 3
                        // Add flesh golem abilities

                    elseif RoundSkillGroupRoll == 11 then
                        //set RoundCreepTypeId = HELL_HOUND_CREEP_UNIT_ID
                        set RoundCreepNumber = 3
                        // Add hell hound abilities

                    elseif RoundSkillGroupRoll == 12 then
                        //set RoundCreepTypeId = NECROMANCER_CREEP_UNIT_ID
                        set RoundCreepNumber = 3
                        // Add necromancer abilities
                    endif
                endif
            endif
        endif*/

        //Creepwave fixed abilities
        if RoundNumber > 10 then
                //Caster creeps:
                if RoundCreepTypeId == SUCCUBUS_CREEP_UNIT_ID then
                    set RoundCreepChanceCharm                   = 1
                elseif RoundCreepTypeId == GNOLL_WARDEN_CREEP_UNIT_ID then
                    set RoundCreepChanceShadowStrike            = 1
                elseif RoundCreepTypeId == ORC_WARLOCK_CREEP_UNIT_ID then
                    set RoundCreepChanceFingerOfPain            = 1
                elseif RoundCreepTypeId == OGRE_MAGI_CREEP_UNIT_ID then
                    set RoundCreepChanceBlizzard                = 1
                elseif RoundCreepTypeId == BANDIT_MAGE_CREEP_UNIT_ID then
                    set RoundCreepChanceCripple                 = 1 
                elseif RoundCreepTypeId == DEMONESS_CREEP_UNIT_ID then
                    set RoundCreepChanceDeathCoil               = 1 
                elseif RoundCreepTypeId == VOID_WALKER_CREEP_UNIT_ID then
                    set RoundCreepChanceDousingHex              = 1
                elseif RoundCreepTypeId == SHAMAN_CREEP_UNIT_ID then
                    set RoundCreepChanceBloodlust               = 1
                elseif RoundCreepTypeId == CHAOS_WARLOCK_2_CREEP_UNIT_ID then
                    set RoundCreepChanceRainOfFire              = 1
                elseif RoundCreepTypeId == SASQUATCH_SHAMAN_CREEP_UNIT_ID then
                    set RoundCreepChanceIcyBreath               = 1
                elseif RoundCreepTypeId == WATCHER_CREEP_UNIT_ID then
                    set RoundCreepChanceThunderClap             = 1
                elseif RoundCreepTypeId == HARPY_WITCH_CREEP_UNIT_ID then
                    set RoundCreepChanceCurse                   = 1

                //melee auto attacker creeps:
                elseif RoundCreepTypeId == MURLOC_TIDERUNNER_CREEP_UNIT_ID then //max movespeed
                elseif RoundCreepTypeId == ACOLYTE_CREEP_UNIT_ID then
                elseif RoundCreepTypeId == BANDIT_CREEP_UNIT_ID then
                elseif RoundCreepTypeId == CENTAUR_CREEP_UNIT_ID then
                elseif RoundCreepTypeId == OGRE_CREEP_UNIT_ID then
                elseif RoundCreepTypeId == TREANT_CREEP_UNIT_ID then
                    set RoundCreepChanceEntanglingRoots = 1
                    set RoundCreepChanceStampede = 1
                    set RoundCreepNumber = GetRandomInt(4,7)
                elseif RoundCreepTypeId == QUILBOAR_CREEP_UNIT_ID then
                elseif RoundCreepTypeId == FOREST_TROLL_CREEP_UNIT_ID then
                elseif RoundCreepTypeId == GHOUL_CREEP_UNIT_ID then
                elseif RoundCreepTypeId == GNOLL_CREEP_UNIT_ID then
                elseif RoundCreepTypeId == KOBOLD_CREEP_UNIT_ID then
                elseif RoundCreepTypeId == MILITIA_CREEP_UNIT_ID then
                    set RoundCreepChanceCleave = 1
                elseif RoundCreepTypeId == PANDAREN_CREEP_UNIT_ID then
                    set RoundCreepChanceThunderClap = 1
                elseif RoundCreepTypeId == SPIDER_CRAB_CREEP_UNIT_ID then
                elseif RoundCreepTypeId == NIGHT_ELF_WARRIOR_CREEP_UNIT_ID then
                elseif RoundCreepTypeId == SATYR_CREEP_UNIT_ID then
                    set RoundCreepChanceEvasion = 1
                    set RoundCreepChanceReaction      = 1
                    set RoundCreepChanceDrunkMaster   = 1
                elseif RoundCreepTypeId == SASQUATCH_CREEP_UNIT_ID then
                elseif RoundCreepTypeId == FURBOLG_CREEP_UNIT_ID then
                elseif RoundCreepTypeId == DARK_TROLL_BERSERKER_CREEP_UNIT_ID then
                    set RoundCreepNumber = 25
                elseif RoundCreepTypeId == TUSKAR_CREEP_UNIT_ID then

                //ranged auto attacker creeps:
                elseif RoundCreepTypeId == HARPY_CREEP_UNIT_ID then
                    set RoundCreepChanceFaerieFire  = 1
                elseif RoundCreepTypeId == DRYAD_CREEP_UNIT_ID then
                elseif RoundCreepTypeId == BANDIT_SPEAR_THROWER_CREEP_UNIT_ID then
                elseif RoundCreepTypeId == CENTAUR_IMPALER_CREEP_UNIT_ID then
                elseif RoundCreepTypeId == SKELETON_ARCHER_CREEP_UNIT_ID then
                elseif RoundCreepTypeId == FOREST_SPIDER_CREEP_UNIT_ID then
                    set RoundCreepChanceSlowPoison = 1

                //magic creeps:
                elseif RoundCreepTypeId == DRAENEI_MAGE_CREEP_UNIT_ID then
                    set RoundCreepChanceHealingWave = 1
                elseif RoundCreepTypeId == SLUDGE_MINION_CREEP_UNIT_ID then
                    set RoundCreepChanceSlow                    = 1
                elseif RoundCreepTypeId == WIND_SERPENT_CREEP_UNIT_ID then
                    set RoundCreepChanceWhirlWind = 1
                    set RoundCreepChanceChainLightning = 1
                    set RoundCreepChanceForkedLightning = 1
                    set RoundCreepChanceColdWind = 1 
                elseif RoundCreepTypeId == WRAITH_CREEP_UNIT_ID then 
                    set RoundCreepChanceCurse                   = 1
                endif
        endif

        if RoundCreepChanceChaosMagic == 1 then
            set RoundCreepNumber = GetRandomInt(2, 7)
        endif
    
        //item buddy arrival
        if RoundNumber == 5 then
            call SetUpItemStocks(GetValidPlayerForce())
            call DisplayTimedTextToForce(GetPlayersAll(), 10.00, "|cffffcc00Item Buddy has arrived!|r You can use it to swap items using Shift + Q and Shift + W")
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

                if RoundGenCreepIndex > 7 then
                    set RoundCreepChanceCharm = 2
                endif
                
                if RoundGenCreepIndex > 4 then
                    set RoundCreepChanceBigBadV = 2
                    set RoundCreepChanceHealingWave = 2
                    set RoundCreepChanceFirebolt = 2
                    set RoundCreepChanceSilence = 2
                    set RoundCreepChanceHowlOfTerror = 2
                    set RoundCreepChanceAerialShackles = 2
                    set RoundCreepChanceWarStomp = 2   
                    set RoundCreepChanceCripple = 2
                    set RoundCreepChanceSleep = 2
                    set RoundCreepChanceSpellImmunity = 2
                    set RoundCreepChanceImpale = 2
                    set RoundCreepChanceEntanglingRoots = 2
                    set RoundCreepChanceStormBolt = 2
                    set RoundCreepChanceFrostBolt = 2
                    set RoundCreepChanceDevastatingBlow = 2
                    set RoundCreepChanceEnvenomedWeapons = 2
                    set RoundCreepChanceEnsnare                 = 2
                    set RoundCreepChanceHex                     = 2 
                    set RoundCreepChancePolymorph               = 2
                endif

                if RoundGenCreepIndex > 2 then
                    set RoundCreepChanceLiquidFire = 2
                endif

                if RoundNumber > 0 then
                    set ShowCreepAbilButton[playerId] = true
                endif
                
                //Creep upgrade bonuses
                //if DamageSourceTypeId != SLUDGE_MINION_CREEP_UNIT_ID and DamageSourceTypeId != DRAENEI_MAGE_CREEP_UNIT_ID and DamageSourceTypeId != WIND_SERPENT_CREEP_UNIT_ID and RoundCreepTypeId != WRAITH_CREEP_UNIT_ID then
                   // if GameModeShort then
                        //set magicPowerBonus = 2.5 * (BonusNeutral + BonusNeutralPlayer[playerId])
                        //set damageBonus = R2I(2.5 * ((BonusNeutral + BonusNeutralPlayer[playerId]) * RoundNumber))
                    //else
                        //set magicPowerBonus = 1 * (BonusNeutral + BonusNeutralPlayer[playerId])
                        //set damageBonus = ((BonusNeutral + BonusNeutralPlayer[playerId]) * RoundNumber)
                    //endif
                //else
                    //set magicPowerBonus = 0
                //endif

                //set magicDefBonus = 0.09 * (BonusNeutral + BonusNeutralPlayer[playerId])
                //set evasionBonus = 0.06 * (BonusNeutral + BonusNeutralPlayer[playerId])
                //set blockBonus = 0.12 * (BonusNeutral + BonusNeutralPlayer[playerId])

                //if GameModeShort == false and RoundNumber < 40 then
                    //set damageBonus = damageBonus / 2
                //endif
    
                if (GetPlayerSlotState(Player(playerId)) != PLAYER_SLOT_STATE_EMPTY and IsPlayerInForce(Player(playerId), DefeatedPlayers) != true) then
                    set unitSpawnOffset = OffsetLocation(PlayerArenaRectCenters[playerId], GetRandomReal(-750.00, 750.00), GetRandomReal(-750.00, 750.00))
                    set creep = CreateUnitAtLocSaveLast(Player(11), RoundCreepTypeId, unitSpawnOffset, GetRandomDirectionDeg())

                    call GroupAddUnit(g, creep)
                    call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0), 0)

                    if RoundNumber > 4 then
                        // Exponent chosen so that 2 creeps → 0.3x cooldown, 25 creeps → 1.0x cooldown
                        call BlzSetUnitAttackCooldown(creep, BlzGetUnitAttackCooldown(creep, 0) * (0.3 + 0.7 * (I2R(RoundCreepNumber) - 2.0) / 23.0), 0)
                    endif

                    if RoundCreepTypeId == STOMP_TREE_UNIT_ID then  
                        call UnitAddItemToSlotById(creep, BANNER_OF_MANY_ITEM_ID, 0)   
                        //call UnitAddItemToSlotById(creep, STAFF_OF_POWER_ITEM_ID, 1)  
                        call UnitAddItemToSlotById(creep, WILD_RUNESTONE_ITEM_ID, 2)  
                        call UnitAddItemToSlotById(creep, SPEED_BLADE_ITEM_ID, 3)  
                        call UnitAddItemToSlotById(creep, ARCANE_INFUSED_SWORD_ITEM_ID, 4)  
                        call UnitAddItemToSlotById(creep, PRETTY_BRIGHT_GEM_ITEM_ID, 5)  
                        call BlzSetUnitAttackCooldown(creep, 0.5, 0)
                    endif 

                    if RoundCreepTypeId == OGRE_LORD_CREEP_UNIT_ID then
                        call BlzSetUnitAttackCooldown(creep, 0.5, 0)
                        if (GameModeShort == true and RoundNumber < 2) then
                            call SetUnitCustomState(creep, BONUS_PHYSPOW, RoundNumber * 3)
                        else
                            call SetUnitCustomState(creep, BONUS_PHYSPOW, RoundNumber * 2)
                        endif
                    endif

                    //Control the hp/dmg of lower creep count waves
                    set CreepScaleHitpoints = 0.3
                    set CreepScaleDamage = 0.5

                    //call SetUnitCustomState(creep, BONUS_MAGICPOW, magicPowerBonus)
                    //call SetUnitCustomState(creep, BONUS_EVASION, evasionBonus)	
                    //call SetUnitCustomState(creep, BONUS_BLOCK, blockBonus + (1 * (RoundNumber)))

                    if wizardbaneDebug then
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, 5000)
                    endif

                    //Creepwave stats 25 Round Mode
                    if (GameModeShort == true and RoundNumber < 2) then
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) - 3, 0)
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * RoundNumber * 0.33) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, RoundNumber * RoundNumber)
                    elseif (GameModeShort == true and RoundNumber < 3) then
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 6, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 16)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * RoundNumber * 0.33) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, RoundNumber * RoundNumber)
                    elseif (GameModeShort == true and RoundNumber < 4) then
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 9, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 24)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * RoundNumber * 0.33) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, RoundNumber * RoundNumber)
                    elseif (GameModeShort == true and RoundNumber < 5) then
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 24, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(64.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * RoundNumber * 0.33) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, RoundNumber * RoundNumber)
                    elseif (GameModeShort == true and RoundNumber < 6) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + 10)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 40, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(120.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 1.8))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 1.8))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * RoundNumber * 0.33) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, RoundNumber * RoundNumber)
                    elseif (GameModeShort == true and RoundNumber < 7) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + 18)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 90, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(720.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * RoundNumber * 0.33) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, RoundNumber * RoundNumber)
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep)))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep)))
                    elseif (GameModeShort == true and RoundNumber < 8) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + 21)
                        call BlzSetUnitBaseDamage(creep,BlzGetUnitBaseDamage(creep, 0) + R2I(130.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(840.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * RoundNumber * 0.33) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * RoundNumber * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0)))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep)))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep)))
                    elseif (GameModeShort == true and RoundNumber < 9) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + 24)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(200.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(960.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * RoundNumber * 0.33) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * RoundNumber * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0)))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep)))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep)))
                    elseif (GameModeShort == true and RoundNumber < 10) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + 27)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(350.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(1080.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * RoundNumber * 0.33) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * RoundNumber * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0)))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep)))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep)))
                    elseif (GameModeShort == true and RoundNumber < 11) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + 90)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(600.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(1600.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * RoundNumber * 0.33) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * RoundNumber * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0)))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep)))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep)))
                    elseif (GameModeShort == true and RoundNumber < 12) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + 99) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(1200.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(1760.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * RoundNumber * 0.33) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * RoundNumber * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0)))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep)))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep)))
                    elseif (GameModeShort == true and RoundNumber < 13) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + 180) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(2351.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(2880.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * RoundNumber * 0.33) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * RoundNumber * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0)))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep)))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep)))
                    elseif (GameModeShort == true and RoundNumber < 14) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + 195) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(4356.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(3120.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * RoundNumber * 0.33) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * RoundNumber * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0)))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep)))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep)))
                    elseif (GameModeShort == true and RoundNumber < 15) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + 210) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(6547.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(3360.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * RoundNumber * 0.33) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * RoundNumber * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0)))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep)))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep)))
                    elseif (GameModeShort == true and RoundNumber < 16) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + 225) 
                        call BlzSetUnitBaseDamage(creep,BlzGetUnitBaseDamage(creep, 0) + R2I(10000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(3600.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * RoundNumber * 0.33) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * RoundNumber * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0)))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep)))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep)))
                    elseif (GameModeShort == true and RoundNumber < 17) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + 240) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(15800.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(3840.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * RoundNumber * 0.33) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * RoundNumber * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0)))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep)))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep)))
                    elseif (GameModeShort == true and RoundNumber < 18) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + 408) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(18000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(7650.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * RoundNumber * 0.33) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * RoundNumber * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0)))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep)))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep)))
                    elseif (GameModeShort == true and RoundNumber < 19) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + 432) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(20000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(8100.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * RoundNumber * 0.33) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * RoundNumber * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0)))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep)))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep)))
                    elseif (GameModeShort == true and RoundNumber < 20) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + 456) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(25000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(8550.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * RoundNumber * 0.33) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * RoundNumber * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0)))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep)))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep)))
                    elseif (GameModeShort == true and RoundNumber < 21) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + 480) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(37000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(12000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints))) 
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * RoundNumber * 0.33) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * RoundNumber * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0)))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep)))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep)))
                    elseif (GameModeShort == true and RoundNumber < 22) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + 630) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(40000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(19000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints))) 
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * RoundNumber * 0.33) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * RoundNumber * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0)))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep)))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep)))
                    elseif (GameModeShort == true and RoundNumber < 23) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + 660) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(50000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(19500.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints))) 
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * RoundNumber * 0.33) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * RoundNumber * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0)))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep)))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep)))
                    elseif (GameModeShort == true and RoundNumber < 24) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + 897) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(60000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(35000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * RoundNumber * 0.33) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * RoundNumber * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0)))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep)))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep)))
                    elseif (GameModeShort == true and RoundNumber < 25) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + 1152) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(75000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(50000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints))) 
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * RoundNumber * 0.33) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * RoundNumber * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0)))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep)))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep)))
                    else
                        if (GameModeShort == true and RoundNumber == 25) then
                            call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 72)
                            call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(95000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                            call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(100000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                            call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                            call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * RoundNumber * 0.33) 
                            call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * RoundNumber * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0)))
                            call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep)))
                            call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep)))
                        endif
                    endif

                    //Creepwave stats 50 Round Mode
                    if (GameModeShort == false and RoundNumber == 1) then
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) - 3, 0)
                    elseif (GameModeShort == false and RoundNumber == 2) then
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) - 3, 0)
                    elseif (GameModeShort == false and RoundNumber == 3) then
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 1 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 5 * RoundNumber)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (1 * (RoundNumber)))
                    elseif (GameModeShort == false and RoundNumber == 4) then
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 1 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 7 * RoundNumber)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (1 * (RoundNumber)))
                    elseif (GameModeShort == false and RoundNumber == 5) then
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 1 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 10 * RoundNumber)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (1 * (RoundNumber)))
                    elseif (GameModeShort == false and RoundNumber == 6) then
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 1 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(100.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (1 * (RoundNumber)))
                    elseif (GameModeShort == false and RoundNumber == 7) then
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 1 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(140.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (1 * (RoundNumber)))
                    elseif (GameModeShort == false and RoundNumber == 8) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 2 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(175.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.6))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.6))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (0.9 * (RoundNumber)))
                    elseif (GameModeShort == false and RoundNumber == 9) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 2 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(200.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.6))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.6))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 1) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 1))
                    elseif (GameModeShort == false and RoundNumber == 10) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 2 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(320.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.6))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.6))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 1) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 1))
                    elseif (GameModeShort == false and RoundNumber == 11) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 1.5)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(35.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(440.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 1) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 2))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 12) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 1.5)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(40.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(560.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 1) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 2 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 2))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 13) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 1.5)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(70.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(750.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 2) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 2 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 2))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 14) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 1.5)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(100.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(880.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 2) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 2 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 2))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 15) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 1.5)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(120.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(1090.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 2) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 2 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 3))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 16) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 1.5)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(150.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(1367.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 2) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 2 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 3))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 17) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 1.5)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(180.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(1500.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 2) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 2 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 3))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 18) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 1.5)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(220.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(2200.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 2) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 2 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 3))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 19) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 2.0)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(270.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(2400.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 2) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 2 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 3))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 20) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 2.5)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(370.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(2800.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 3) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 2 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 4))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 21) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 3.5)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(500.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(3300.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 3) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 2 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 4))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 22) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 4.5)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(600.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(3900.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 3) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 2 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 4))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 23) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 4.5)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(750.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(4800.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 3) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 2 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 4))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 24) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 5.5)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(850.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(5100.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 3) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 3 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 5))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 25) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 6.5)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(1100.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(5900.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 3) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 3 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 10))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 26) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 7.5)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(1400.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(6300.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 3) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 3 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 10))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 27) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 7.5)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(1600.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(6800.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 3) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 3 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 10))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 28) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 8.5)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(2000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(7200.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 3) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 3 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 10))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 29) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 9.5)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(2500.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(7600.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 3) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 3 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 10))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 30) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 10.5)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(3000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(8000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 3) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 3 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 10))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 31) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 11.5)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(4300.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(8200.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 3) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 4 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 10))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 32) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 11.5)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(5300.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(8600.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 3) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 4 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 10))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 33) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 11.5)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(6100.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(9000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 3) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 5 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 10))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 34) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 12)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(7500.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(11000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 3) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 5 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 10))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 35) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 12)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(10000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(13000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 4) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 5 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 10))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 36) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 13)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(13500.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(15000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 4) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 5 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 10))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 37) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 14)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(16000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(16000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 4) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 5 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 10))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 38) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 15)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(19000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(19000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 4) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 5 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 10))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 39) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 16)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(25000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(20000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 4) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 5 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 10))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 40) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 117)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(33000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(22500.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 4) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 5 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 10))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                    elseif (GameModeShort == false and RoundNumber == 41) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 18)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(37000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(25000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 4) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 5 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 10))
                    elseif (GameModeShort == false and RoundNumber == 42) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 19)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(40000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(27500.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 4) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 5 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 10))
                    elseif (GameModeShort == false and RoundNumber == 43) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 20)
                        call BlzSetUnitBaseDamage(creep,BlzGetUnitBaseDamage(creep, 0) + R2I(45000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(30000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 4) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 6 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 10))
                    elseif (GameModeShort == false and RoundNumber == 44) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 21)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(50000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(40000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 4) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 6 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 10))
                    elseif (GameModeShort == false and RoundNumber == 45) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 22)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(55000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(50000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 4) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 6.5 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 10))
                    elseif (GameModeShort == false and RoundNumber == 46) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 23)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(60000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(75000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 4) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 6.5 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 10))
                    elseif (GameModeShort == false and RoundNumber == 47) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 24)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(65000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(80000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 4) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 6.5 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 10))
                    elseif (GameModeShort == false and RoundNumber == 48) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 25)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(70000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(90000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 4) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 6.5 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 10))
                    elseif (GameModeShort == false and RoundNumber == 49) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 30)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(80000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(120000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 4) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 6.5 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 10))
                    elseif (GameModeShort == false and RoundNumber == 50) then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 36)
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + R2I(110000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleDamage)),0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + R2I(150000.0 * Pow(25.0 / I2R(RoundCreepNumber), CreepScaleHitpoints)))
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call BlzSetUnitMaxMana(creep, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitState(creep, UNIT_STATE_MANA, R2I(BlzGetUnitMaxHP(creep) * 0.5))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, RoundNumber * 4) 
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, R2I(RoundNumber * 6.5 * (1.0 + (25.0 - I2R(RoundCreepNumber)) / 23.0 * 1.5)))
                        call SetUnitCustomState(creep, BONUS_BLOCK, (RoundNumber * 10))
                    endif
    
                    call SetUnitScalePercent(creep, (85.00 + ((I2R(RoundNumber) - 1.00) * 0.50)), 100, 100)

                    if RoundCreepTypeId == OGRE_LORD_CREEP_UNIT_ID then
                        call SetUnitScale(creep, 2.0, 2.0, 2.0)
                    endif

                    if RoundCreepTypeId == ARCHMAGE_CREEP_UNIT_ID then
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, RoundNumber * 20)
                        call SetUnitCustomState(creep, BONUS_ARMOR, RoundNumber * 4)
                        call SetUnitCustomState(creep, BONUS_HEALTH, GetUnitState(creep, UNIT_STATE_LIFE) * 4)
                    endif

                    call UnitAddNewAbilities(creep)
                    call ConditionalTriggerExecute(ModifyCreepAbilitiesTrigger)
                    //call ConditionalTriggerExecute(CreepPowerAndHpTrigger)
                    call SetUnitMoveSpeed(creep, I2R(RoundCreepMoveSpeed))
                    //if GameModeShort == true then
                        //call SetUnitAbilityLevelSwapped('A0FU', creep, R2I(RoundCreepPower) / 2)// dis gibs more dmg n shiiiet thru a skill
                    //else
                        //call SetUnitAbilityLevelSwapped('A000', creep, R2I(RoundCreepPower) / 2)
                    //endif

                    call SetUnitAbilityLevelSwapped('A002', creep,RoundCreepMaxAttackSpeed)
                    call PauseUnitBJ(true, creep)
                    call SetUnitInvulnerable(creep, true)
                    call ShowUnitHide(creep)
    
                    if SantaHatOn then
                        call UnitAddAbility(creep, 'A0B1')
                    endif

                    // spiked carapace 40% hp
                    if RoundCreepChanceSpikedCarapace == 1 then
                        call BlzSetUnitMaxHP(creep, R2I(BlzGetUnitMaxHP(creep) * 0.4))
                        call SetUnitState(creep, UNIT_STATE_LIFE, I2R(BlzGetUnitMaxHP(creep)))
                    endif
                    
                    if IsMagicCreep(RoundCreepTypeId) then
                        call BlzSetUnitBaseDamage(creep, R2I(BlzGetUnitBaseDamage(creep, 0) * 0.5), 0)
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, 0)
                    endif

                    //call BJDebugMsg("rci: " + I2S(playerId))
                    if RoundCreepInfo[playerId] == "" then
                        //call BJDebugMsg("a")
                        if (GameModeShort == true and RoundNumber > 24) or (GameModeShort == false and RoundNumber > 49) then
                            set RoundCreepTitle = "|cffff0000Boss Round|r (+300% gold/xp|r): |cffdd9bf1" + I2S(RoundCreepNumber) + " |r|cff77d2fc" + GetObjectName(RoundCreepTypeId) + "|r"
                        else
                            set RoundCreepTitle = "|cffdd9bf1" + I2S(RoundCreepNumber) + " |r|cff77d2fc" + GetObjectName(RoundCreepTypeId) + "|r"
                        endif
                        set s = RoundCreepTitle + ": "
                        set RoundCreepInfo[playerId] = "|cff9babf1Hit points|r: " + I2S(BlzGetUnitMaxHP(creep)) + "|n"
                        //call BJDebugMsg("b")

                        if IsUnitType(creep, UNIT_TYPE_MELEE_ATTACKER) then
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9babf1Range|r: Melee |n"
                            set s = s + "|cff82f373Melee|r "
                        else
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9babf1Range|r: " + I2S(R2I(BlzGetUnitWeaponRealField(creep, UNIT_WEAPON_RF_ATTACK_RANGE, 0))) + "|n"
                            set s = s + "|cff82f373Ranged|r "
                        endif
                        //call BJDebugMsg("c")
                        if RoundCreepTypeId == SLUDGE_MINION_CREEP_UNIT_ID or RoundCreepTypeId == DRAENEI_MAGE_CREEP_UNIT_ID or RoundCreepTypeId == WIND_SERPENT_CREEP_UNIT_ID or RoundCreepTypeId == WRAITH_CREEP_UNIT_ID then
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9babf1Damage Type|r: |cffff00ffMagic|r |n"
                            set s = s + "|cffff00ffMagic Damage|r: "
                        else
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9babf1Damage Type|r: |cffff8080Physical|r |n"
                        endif
                        //call BJDebugMsg("d")

                        if RoundCreepTypeId == SUCCUBUS_CREEP_UNIT_ID or RoundCreepTypeId == ORC_WARLOCK_CREEP_UNIT_ID or RoundCreepTypeId == OGRE_MAGI_CREEP_UNIT_ID or RoundCreepTypeId == SASQUATCH_SHAMAN_CREEP_UNIT_ID or RoundCreepTypeId == WATCHER_CREEP_UNIT_ID then
                            set s = s + "|cff82f373Caster|r: "
                        endif

                        if RoundCreepTypeId == GNOLL_WARDEN_CREEP_UNIT_ID or RoundCreepTypeId == BANDIT_MAGE_CREEP_UNIT_ID or RoundCreepTypeId == DEMONESS_CREEP_UNIT_ID or RoundCreepTypeId == VOID_WALKER_CREEP_UNIT_ID or RoundCreepTypeId == SHAMAN_CREEP_UNIT_ID or RoundCreepTypeId == CHAOS_WARLOCK_2_CREEP_UNIT_ID or RoundCreepTypeId == HARPY_WITCH_CREEP_UNIT_ID then
                            set s = s + "|cff82f373Caster|r: "
                        endif

                        if RoundCreepTypeId == MURLOC_TIDERUNNER_CREEP_UNIT_ID or RoundCreepTypeId == ACOLYTE_CREEP_UNIT_ID or RoundCreepTypeId == BANDIT_CREEP_UNIT_ID or RoundCreepTypeId == CENTAUR_CREEP_UNIT_ID or RoundCreepTypeId == OGRE_CREEP_UNIT_ID or RoundCreepTypeId == TREANT_CREEP_UNIT_ID or RoundCreepTypeId == QUILBOAR_CREEP_UNIT_ID or RoundCreepTypeId == FOREST_TROLL_CREEP_UNIT_ID or RoundCreepTypeId == GHOUL_CREEP_UNIT_ID or RoundCreepTypeId == GNOLL_CREEP_UNIT_ID or RoundCreepTypeId == KOBOLD_CREEP_UNIT_ID or RoundCreepTypeId == MILITIA_CREEP_UNIT_ID or RoundCreepTypeId == PANDAREN_CREEP_UNIT_ID or RoundCreepTypeId == SPIDER_CRAB_CREEP_UNIT_ID or RoundCreepTypeId == NIGHT_ELF_WARRIOR_CREEP_UNIT_ID or RoundCreepTypeId == SATYR_CREEP_UNIT_ID or RoundCreepTypeId == SASQUATCH_CREEP_UNIT_ID or RoundCreepTypeId == FURBOLG_CREEP_UNIT_ID or RoundCreepTypeId == DARK_TROLL_BERSERKER_CREEP_UNIT_ID or RoundCreepTypeId == TUSKAR_CREEP_UNIT_ID or RoundCreepTypeId == HARPY_CREEP_UNIT_ID or RoundCreepTypeId == DRYAD_CREEP_UNIT_ID or RoundCreepTypeId == BANDIT_SPEAR_THROWER_CREEP_UNIT_ID or RoundCreepTypeId == CENTAUR_IMPALER_CREEP_UNIT_ID or RoundCreepTypeId == SKELETON_ARCHER_CREEP_UNIT_ID then  
                            set s = s + "|cff82f373Auto Attacker|r: "
                        endif

                        if RoundCreepTypeId == STOMP_TREE_UNIT_ID then
                            set s = s + "|cff82f373Auto Attacker|r: "
                            set s = s + "|cff82f373Summoner|r: "
                        endif

                        set creepDamage = BlzGetUnitBaseDamage(creep, 0) + BlzGetUnitDiceNumber(creep, 0)

                        if BonusNeutral == 0 and BonusNeutralPlayer[playerId] == 0 then
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9babf1Damage|r: " + I2S(creepDamage) + "|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9babf1Attack Cooldown|r: " + R2S(BlzGetUnitAttackCooldown(creep, 0)) + "s|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cffff8080Physical power|r: " + I2S(R2I(GetUnitCustomState(creep, BONUS_PHYSPOW))) + "|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cffff8080Armor|r: " + I2S(R2I(BlzGetUnitArmor(creep))) + "|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cffff00ffMagic power|r: " + I2S(R2I(GetUnitCustomState(creep, BONUS_MAGICPOW))) + "|n"  
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cffff00ffMagic protection|r: " + I2S(R2I(GetUnitCustomState(creep, BONUS_MAGICRES))) + "|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9babf1Block|r: " + I2S(R2I(GetUnitCustomState(creep, BONUS_BLOCK))) + "|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9babf1Evasion|r: " + I2S(R2I(GetUnitCustomState(creep, BONUS_EVASION))) + "|n"
                        else
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9babf1Damage|r: " + I2S(creepDamage) + "|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9babf1Attack Cooldown|r: " + R2S(BlzGetUnitAttackCooldown(creep, 0)) + "s|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cffff8080Physical power|r: " + I2S(R2I(GetUnitCustomState(creep, BONUS_PHYSPOW))) + "|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cffff8080Armor|r: " + I2S(R2I(BlzGetUnitArmor(creep))) + "|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cffff00ffMagic power|r: " + I2S(R2I(GetUnitCustomState(creep, BONUS_MAGICPOW) - magicPowerBonus)) + " + |cff9bc7f1" + I2S(R2I(magicPowerBonus)) + "|r|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cffff00ffMagic protection|r: " + I2S(R2I(GetUnitCustomState(creep, BONUS_MAGICRES) - magicDefBonus)) + " + |cff9bf1a9" + I2S(R2I(magicDefBonus)) + "|r|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9babf1Block|r: " + I2S(R2I(GetUnitCustomState(creep, BONUS_BLOCK) - blockBonus)) + " + |cff78729e" + I2S(R2I(blockBonus)) + "|r|n"   
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9babf1Evasion|r: " + I2S(R2I(GetUnitCustomState(creep, BONUS_EVASION) - evasionBonus)) + " + |cfff1cc9b" + I2S(R2I(evasionBonus)) + "|r |n"
                        endif

                        set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9babf1Movespeed|r: " + I2S(RoundCreepMoveSpeed)
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
