library DamageEngineConfig initializer init

    globals
        real udg_DamageEventArmorPierced = 0
        real udg_AfterDamageEvent = 0
        boolean udg_DamageEventOverride = false
        real udg_DamageEvent = 0
        real udg_DamageModifierEvent = 0
        real udg_DamageEventAmount = 0
        unit udg_DamageEventSource = null
        unit udg_DamageEventTarget = null
        real udg_DamageEventPrevAmt = 0
        real udg_LethalDamageEvent = 0
        real udg_LethalDamageHP = 0
        real udg_AOEDamageEvent = 0
        unit udg_AOEDamageSource = null
        integer udg_DamageEventAOE = 0
        group udg_DamageEventAOEGroup = null
        integer udg_DamageEventLevel = 0
        unit udg_EnhancedDamageTarget = null
        integer udg_DamageEventType = 0
        boolean udg_NextDamageIsAttack = false
        boolean udg_NextDamageIsRanged = false
        boolean udg_NextDamageIsMelee = false
        integer udg_NextDamageType = 0
        integer udg_NextDamageWeaponT = 0
        real udg_DamageScalingUser = 0
        real udg_DamageScalingWC3 = 0
        integer udg_DamageTypeBlocked = 0
        integer udg_DamageTypeCriticalStrike = 0
        integer udg_DamageTypeCode = 0
        integer udg_DamageTypeExplosive = 0
        integer udg_DamageTypeHeal = 0
        integer udg_DamageTypePure = 0
        integer udg_DamageTypePureExplosive = 0
        integer udg_DamageTypeReduced = 0
        trigger udg_DamageEventTrigger = null
        boolean udg_IsDamageAttack = false
        boolean udg_IsDamageMelee = false
        boolean udg_IsDamageRanged = false
        boolean udg_IsDamageSpell = false
        boolean udg_IsDamageCode = false
        unit udg_DamageFilterSource = null
        unit udg_DamageFilterTarget = null
        integer udg_DamageFilterAttackT = 0
        integer udg_DamageFilterDamageT = 0
        integer udg_DamageFilterSourceT = 0
        integer udg_DamageFilterTargetT = 0
        integer udg_DamageFilterSourceB = 0
        integer udg_DamageFilterTargetB = 0
        integer udg_DamageFilterType = 0
        real udg_DamageFilterMinAmount = 0
        integer udg_DamageEventArmorT = 0
        integer udg_ARMOR_TYPE_NONE = 0
        integer udg_ARMOR_TYPE_FLESH = 0
        integer udg_ARMOR_TYPE_METAL = 0
        integer udg_ARMOR_TYPE_WOOD = 0
        integer udg_ARMOR_TYPE_ETHEREAL = 0
        integer udg_ARMOR_TYPE_STONE = 0
        string array udg_ArmorTypeDebugStr
        attacktype array udg_CONVERTED_ATTACK_TYPE
        integer udg_DamageEventAttackT = 0
        integer udg_ATTACK_TYPE_SPELLS = 0
        integer udg_ATTACK_TYPE_NORMAL = 0
        integer udg_ATTACK_TYPE_PIERCE = 0
        integer udg_ATTACK_TYPE_SIEGE = 0
        integer udg_ATTACK_TYPE_MAGIC = 0
        integer udg_ATTACK_TYPE_CHAOS = 0
        integer udg_ATTACK_TYPE_HERO = 0
        string array udg_AttackTypeDebugStr
        damagetype array udg_CONVERTED_DAMAGE_TYPE
        integer udg_DamageEventDamageT = 0
        integer udg_DAMAGE_TYPE_UNKNOWN = 0
        integer udg_DAMAGE_TYPE_NORMAL = 0
        integer udg_DAMAGE_TYPE_ENHANCED = 0
        integer udg_DAMAGE_TYPE_FIRE = 0
        integer udg_DAMAGE_TYPE_COLD = 0
        integer udg_DAMAGE_TYPE_LIGHTNING = 0
        integer udg_DAMAGE_TYPE_POISON = 0
        integer udg_DAMAGE_TYPE_DISEASE = 0
        integer udg_DAMAGE_TYPE_DIVINE = 0
        integer udg_DAMAGE_TYPE_MAGIC = 0
        integer udg_DAMAGE_TYPE_SONIC = 0
        integer udg_DAMAGE_TYPE_ACID = 0
        integer udg_DAMAGE_TYPE_FORCE = 0
        integer udg_DAMAGE_TYPE_DEATH = 0
        integer udg_DAMAGE_TYPE_MIND = 0
        integer udg_DAMAGE_TYPE_PLANT = 0
        integer udg_DAMAGE_TYPE_DEFENSIVE = 0
        integer udg_DAMAGE_TYPE_DEMOLITION = 0
        integer udg_DAMAGE_TYPE_SLOW_POISON = 0
        integer udg_DAMAGE_TYPE_SPIRIT_LINK = 0
        integer udg_DAMAGE_TYPE_SHADOW_STRIKE = 0
        integer udg_DAMAGE_TYPE_UNIVERSAL = 0
        string array udg_DamageTypeDebugStr
        integer udg_DamageEventDefenseT = 0
        integer udg_DEFENSE_TYPE_LIGHT = 0
        integer udg_DEFENSE_TYPE_MEDIUM = 0
        integer udg_DEFENSE_TYPE_HEAVY = 0
        integer udg_DEFENSE_TYPE_FORTIFIED = 0
        integer udg_DEFENSE_TYPE_NORMAL = 0
        integer udg_DEFENSE_TYPE_HERO = 0
        integer udg_DEFENSE_TYPE_DIVINE = 0
        integer udg_DEFENSE_TYPE_UNARMORED = 0
        string array udg_DefenseTypeDebugStr
        string array udg_WeaponTypeDebugStr
        integer udg_WEAPON_TYPE_NONE = 0
        integer udg_WEAPON_TYPE_ML_CHOP = 0
        integer udg_WEAPON_TYPE_MM_CHOP = 0
        integer udg_WEAPON_TYPE_MH_CHOP = 0
        integer udg_WEAPON_TYPE_ML_SLICE = 0
        integer udg_WEAPON_TYPE_MM_SLICE = 0
        integer udg_WEAPON_TYPE_MH_SLICE = 0
        integer udg_WEAPON_TYPE_MM_BASH = 0
        integer udg_WEAPON_TYPE_MH_BASH = 0
        integer udg_WEAPON_TYPE_MM_STAB = 0
        integer udg_WEAPON_TYPE_MH_STAB = 0
        integer udg_WEAPON_TYPE_WL_SLICE = 0
        integer udg_WEAPON_TYPE_WM_SLICE = 0
        integer udg_WEAPON_TYPE_WH_SLICE = 0
        integer udg_WEAPON_TYPE_WL_BASH = 0
        integer udg_WEAPON_TYPE_WM_BASH = 0
        integer udg_WEAPON_TYPE_WH_BASH = 0
        integer udg_WEAPON_TYPE_WL_STAB = 0
        integer udg_WEAPON_TYPE_WM_STAB = 0
        integer udg_WEAPON_TYPE_CL_SLICE = 0
        integer udg_WEAPON_TYPE_CM_SLICE = 0
        integer udg_WEAPON_TYPE_CH_SLICE = 0
        integer udg_WEAPON_TYPE_AM_CHOP = 0
        integer udg_WEAPON_TYPE_RH_BASH = 0
        integer udg_DamageEventWeaponT = 0
    endglobals

    private function DebugStr takes nothing returns nothing
        local integer i                      = 0
        loop
            set udg_CONVERTED_ATTACK_TYPE[i] = ConvertAttackType(i)
            exitwhen i == 6
            set i                            = i + 1
        endloop
        set i                                = 0
        loop
            set udg_CONVERTED_DAMAGE_TYPE[i] = ConvertDamageType(i)
            exitwhen i == 26
            set i                            = i + 1
        endloop
        set udg_AttackTypeDebugStr[0]        = "SPELLS"   //ATTACK_TYPE_NORMAL in JASS
        set udg_AttackTypeDebugStr[1]        = "NORMAL"   //ATTACK_TYPE_MELEE in JASS
        set udg_AttackTypeDebugStr[2]        = "PIERCE"
        set udg_AttackTypeDebugStr[3]        = "SIEGE"
        set udg_AttackTypeDebugStr[4]        = "MAGIC"
        set udg_AttackTypeDebugStr[5]        = "CHAOS"
        set udg_AttackTypeDebugStr[6]        = "HERO"
        set udg_DamageTypeDebugStr[0]        = "UNKNOWN"
        set udg_DamageTypeDebugStr[4]        = "NORMAL"
        set udg_DamageTypeDebugStr[5]        = "ENHANCED"
        set udg_DamageTypeDebugStr[8]        = "FIRE"
        set udg_DamageTypeDebugStr[9]        = "COLD"
        set udg_DamageTypeDebugStr[10]       = "LIGHTNING"
        set udg_DamageTypeDebugStr[11]       = "POISON"
        set udg_DamageTypeDebugStr[12]       = "DISEASE"
        set udg_DamageTypeDebugStr[13]       = "DIVINE"
        set udg_DamageTypeDebugStr[14]       = "MAGIC"
        set udg_DamageTypeDebugStr[15]       = "SONIC"
        set udg_DamageTypeDebugStr[16]       = "ACID"
        set udg_DamageTypeDebugStr[17]       = "FORCE"
        set udg_DamageTypeDebugStr[18]       = "DEATH"
        set udg_DamageTypeDebugStr[19]       = "MIND"
        set udg_DamageTypeDebugStr[20]       = "PLANT"
        set udg_DamageTypeDebugStr[21]       = "DEFENSIVE"
        set udg_DamageTypeDebugStr[22]       = "DEMOLITION"
        set udg_DamageTypeDebugStr[23]       = "SLOW_POISON"
        set udg_DamageTypeDebugStr[24]       = "SPIRIT_LINK"
        set udg_DamageTypeDebugStr[25]       = "SHADOW_STRIKE"
        set udg_DamageTypeDebugStr[26]       = "UNIVERSAL"
        set udg_WeaponTypeDebugStr[0]        = "NONE"    //WEAPON_TYPE_WHOKNOWS in JASS
        set udg_WeaponTypeDebugStr[1]        = "METAL_LIGHT_CHOP"
        set udg_WeaponTypeDebugStr[2]        = "METAL_MEDIUM_CHOP"
        set udg_WeaponTypeDebugStr[3]        = "METAL_HEAVY_CHOP"
        set udg_WeaponTypeDebugStr[4]        = "METAL_LIGHT_SLICE"
        set udg_WeaponTypeDebugStr[5]        = "METAL_MEDIUM_SLICE"
        set udg_WeaponTypeDebugStr[6]        = "METAL_HEAVY_SLICE"
        set udg_WeaponTypeDebugStr[7]        = "METAL_MEDIUM_BASH"
        set udg_WeaponTypeDebugStr[8]        = "METAL_HEAVY_BASH"
        set udg_WeaponTypeDebugStr[9]        = "METAL_MEDIUM_STAB"
        set udg_WeaponTypeDebugStr[10]       = "METAL_HEAVY_STAB"
        set udg_WeaponTypeDebugStr[11]       = "WOOD_LIGHT_SLICE"
        set udg_WeaponTypeDebugStr[12]       = "WOOD_MEDIUM_SLICE"
        set udg_WeaponTypeDebugStr[13]       = "WOOD_HEAVY_SLICE"
        set udg_WeaponTypeDebugStr[14]       = "WOOD_LIGHT_BASH"
        set udg_WeaponTypeDebugStr[15]       = "WOOD_MEDIUM_BASH"
        set udg_WeaponTypeDebugStr[16]       = "WOOD_HEAVY_BASH"
        set udg_WeaponTypeDebugStr[17]       = "WOOD_LIGHT_STAB"
        set udg_WeaponTypeDebugStr[18]       = "WOOD_MEDIUM_STAB"
        set udg_WeaponTypeDebugStr[19]       = "CLAW_LIGHT_SLICE"
        set udg_WeaponTypeDebugStr[20]       = "CLAW_MEDIUM_SLICE"
        set udg_WeaponTypeDebugStr[21]       = "CLAW_HEAVY_SLICE"
        set udg_WeaponTypeDebugStr[22]       = "AXE_MEDIUM_CHOP"
        set udg_WeaponTypeDebugStr[23]       = "ROCK_HEAVY_BASH"
        set udg_DefenseTypeDebugStr[0]       = "LIGHT"
        set udg_DefenseTypeDebugStr[1]       = "MEDIUM"
        set udg_DefenseTypeDebugStr[2]       = "HEAVY"
        set udg_DefenseTypeDebugStr[3]       = "FORTIFIED"
        set udg_DefenseTypeDebugStr[4]       = "NORMAL"   //Typically deals flat damage to all armor types
        set udg_DefenseTypeDebugStr[5]       = "HERO"
        set udg_DefenseTypeDebugStr[6]       = "DIVINE"
        set udg_DefenseTypeDebugStr[7]       = "UNARMORED"
        set udg_ArmorTypeDebugStr[0]         = "NONE"      //ARMOR_TYPE_WHOKNOWS in JASS, added in 1.31
        set udg_ArmorTypeDebugStr[1]         = "FLESH"
        set udg_ArmorTypeDebugStr[2]         = "METAL"
        set udg_ArmorTypeDebugStr[3]         = "WOOD"
        set udg_ArmorTypeDebugStr[4]         = "ETHEREAL"
        set udg_ArmorTypeDebugStr[5]         = "STONE"
    endfunction

    private function init takes nothing returns nothing
        // -
        // New in Damage Engine 5.7 - you can use the below to automatically assign conditions
        // -
        // Equal to - Same as no conditions, works as it always has
        // Less than - Same as IsDamageAttack Equal to True
        // Less than or equal to - Same as IsDamageMelee Equal to True
        // Greater than or equal to - Same as IsDamageRanged Equal to True
        // Greater than - Same as IsDamageSpell Equal to True
        // Not Equal to - Same as IsDamageCode Equal to True
        // -
        // You can add extra classifications here if you want to differentiate between your triggered damage
        // Use DamageTypeExplosive (or any negative value damage type) if you want a unit killed by that damage to explode
        // -
        // The pre-defined type Code might be set by Damage Engine if Unit - Damage Target is detected and the user didn't define a type of their own.
        // "Pure" is especially important because it overrides both the Damage Engine as well as WarCraft 3 damage modification.
        // I therefore gave the user "Explosive Pure" in case one wants to combine the functionality of the two.
        // -
        set udg_DamageTypePureExplosive = -2
        set udg_DamageTypeExplosive = -1
        set udg_DamageTypeCode = 1
        set udg_DamageTypePure = 2
        // -
        set udg_DamageTypeHeal = 3
        set udg_DamageTypeBlocked = 4
        set udg_DamageTypeReduced = 5
        // -
        set udg_DamageTypeCriticalStrike = 6
        // -
        // Added 25 July 2017 to allow detection of things like Bash or Pulverize or AOE spread
        // -
        set udg_DamageEventAOE = 1
        set udg_DamageEventLevel = 1
        // -
        // In-game World Editor doesn't allow Attack Type and Damage Type comparisons. Therefore I need to code them as integers into GUI
        // -
        set udg_ATTACK_TYPE_SPELLS = 0
        set udg_ATTACK_TYPE_NORMAL = 1
        set udg_ATTACK_TYPE_PIERCE = 2
        set udg_ATTACK_TYPE_SIEGE = 3
        set udg_ATTACK_TYPE_MAGIC = 4
        set udg_ATTACK_TYPE_CHAOS = 5
        set udg_ATTACK_TYPE_HERO = 6
        // -
        set udg_DAMAGE_TYPE_UNKNOWN = 0
        set udg_DAMAGE_TYPE_NORMAL = 4
        set udg_DAMAGE_TYPE_ENHANCED = 5
        set udg_DAMAGE_TYPE_FIRE = 8
        set udg_DAMAGE_TYPE_COLD = 9
        set udg_DAMAGE_TYPE_LIGHTNING = 10
        set udg_DAMAGE_TYPE_POISON = 11
        set udg_DAMAGE_TYPE_DISEASE = 12
        set udg_DAMAGE_TYPE_DIVINE = 13
        set udg_DAMAGE_TYPE_MAGIC = 14
        set udg_DAMAGE_TYPE_SONIC = 15
        set udg_DAMAGE_TYPE_ACID = 16
        set udg_DAMAGE_TYPE_FORCE = 17
        set udg_DAMAGE_TYPE_DEATH = 18
        set udg_DAMAGE_TYPE_MIND = 19
        set udg_DAMAGE_TYPE_PLANT = 20
        set udg_DAMAGE_TYPE_DEFENSIVE = 21
        set udg_DAMAGE_TYPE_DEMOLITION = 22
        set udg_DAMAGE_TYPE_SLOW_POISON = 23
        set udg_DAMAGE_TYPE_SPIRIT_LINK = 24
        set udg_DAMAGE_TYPE_SHADOW_STRIKE = 25
        set udg_DAMAGE_TYPE_UNIVERSAL = 26
        // -
        // The below variables don't affect damage amount, but do affect the sound played
        // They also give important information about the type of attack used.
        // They can differentiate between ranged and melee for units who are both
        // -
        set udg_WEAPON_TYPE_NONE = 0
        // Metal Light/Medium/Heavy
        set udg_WEAPON_TYPE_ML_CHOP = 1
        set udg_WEAPON_TYPE_MM_CHOP = 2
        set udg_WEAPON_TYPE_MH_CHOP = 3
        set udg_WEAPON_TYPE_ML_SLICE = 4
        set udg_WEAPON_TYPE_MM_SLICE = 5
        set udg_WEAPON_TYPE_MH_SLICE = 6
        set udg_WEAPON_TYPE_MM_BASH = 7
        set udg_WEAPON_TYPE_MH_BASH = 8
        set udg_WEAPON_TYPE_MM_STAB = 9
        set udg_WEAPON_TYPE_MH_STAB = 10
        // Wood Light/Medium/Heavy
        set udg_WEAPON_TYPE_WL_SLICE = 11
        set udg_WEAPON_TYPE_WM_SLICE = 12
        set udg_WEAPON_TYPE_WH_SLICE = 13
        set udg_WEAPON_TYPE_WL_BASH = 14
        set udg_WEAPON_TYPE_WM_BASH = 15
        set udg_WEAPON_TYPE_WH_BASH = 16
        set udg_WEAPON_TYPE_WL_STAB = 17
        set udg_WEAPON_TYPE_WM_STAB = 18
        // Claw Light/Medium/Heavy
        set udg_WEAPON_TYPE_CL_SLICE = 19
        set udg_WEAPON_TYPE_CM_SLICE = 20
        set udg_WEAPON_TYPE_CH_SLICE = 21
        // Axe Medium
        set udg_WEAPON_TYPE_AM_CHOP = 22
        // Rock Heavy
        set udg_WEAPON_TYPE_RH_BASH = 23
        // -
        // Since GUI still doesn't provide Defense Type and Armor Types, I needed to include the below
        // -
        set udg_ARMOR_TYPE_NONE = 0
        set udg_ARMOR_TYPE_FLESH = 1
        set udg_ARMOR_TYPE_METAL = 2
        set udg_ARMOR_TYPE_WOOD = 3
        set udg_ARMOR_TYPE_ETHEREAL = 4
        set udg_ARMOR_TYPE_STONE = 5
        // -
        set udg_DEFENSE_TYPE_LIGHT = 0
        set udg_DEFENSE_TYPE_MEDIUM = 1
        set udg_DEFENSE_TYPE_HEAVY = 2
        set udg_DEFENSE_TYPE_FORTIFIED = 3
        set udg_DEFENSE_TYPE_NORMAL = 4
        set udg_DEFENSE_TYPE_HERO = 5
        set udg_DEFENSE_TYPE_DIVINE = 6
        set udg_DEFENSE_TYPE_UNARMORED = 7
        // -
        set udg_DamageFilterAttackT = -1
        set udg_DamageFilterDamageT = -1
        // -
        call DebugStr()
    endfunction

endlibrary