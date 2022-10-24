library AbilityData initializer init requires Table, IdLibrary, Utility
    globals

        Table AbilityIndex
        HashTable ChaosDataEnemy
        HashTable ChaosDataAlly
        HashTable ChaosData
        HashTable AbilityData
        Table ItemData
        HashTable ElementData
        HashTable ElementCounts

        integer LastObject
        /*
        hashtable HT_AbilityData = InitHashtable()
        integer array AbilSpellRA1
        integer AbilSRA1_count = 0 
        integer array AbilSpellRA2
        integer AbilSRA2_count = 0 
        
        integer array AbilSpellRA3
        integer AbilSRA3_count = 0
        */

        integer Element_Any = -1
        integer Element_None = 0
        integer Element_Fire = 1
        integer Element_Water = 2
        integer Element_Wind = 3
        integer Element_Earth = 4
        integer Element_Wild = 5
        integer Element_Energy = 6
        integer Element_Dark = 7
        integer Element_Light = 8
        integer Element_Cold = 9
        integer Element_Poison = 10
        integer Element_Blood = 11
        integer Element_Summon = 12
        integer Element_Arcane = 13
        integer Element_Maximum = 13

        integer Order_None = 0
        integer Order_Target = 1
        integer Order_Point = 2
        integer Order_Instant = 3

        integer Target_Enemy = 0
        integer Target_Ally = 1
        integer Target_Any = 2
    endglobals

    //Gets the total amount of abilities in the map
    function GetAbilityCount takes nothing returns integer
        return AbilityIndex[0]
    endfunction

    //Gets an ability through an index value (eg index = GetRandomInt(1, GetAbilityCount()))
    function GetAbilityFromIndex takes integer index returns integer
        return AbilityIndex[index]
    endfunction

    //Gets the item associated with the ability
    function GetItemFromAbility takes integer abilId returns integer
        return AbilityData[abilId].integer[0]
    endfunction

    //Gets the ability associated with the item
    function GetAbilityFromItem takes integer itemId returns integer
        return ItemData[itemId]
    endfunction

    //Gets a random ability
    function GetRandomAbility takes nothing returns integer
        return AbilityIndex[GetRandomInt(1, AbilityIndex[0])]
    endfunction

    //Checks if the object (ability, item, unit) has an element
    function IsObjectElement takes integer objectId, integer element returns boolean
        return ElementData[element].integer[objectId] != 0
    endfunction

    //Checks if the object (ability, item, unit) has an element
    function GetObjectElementCount takes integer objectId, integer element returns integer
        return ElementData[element].integer[objectId]
    endfunction

    //Checks if the ability stacks with itself
    function IsAbilityMono takes integer abilId returns boolean
        return AbilityData[abilId].integer[3] == 1
    endfunction

    //Gets the ability orderid
    function GetAbilityOrder takes integer abilId returns integer
        return AbilityData[abilId].integer[1]
    endfunction

    //Gets the ability order type: none (passives), instant (thunderclap), target (bloodlust), point (rain of fire)
    function GetAbilityOrderType takes integer abilId returns integer
        return AbilityData[abilId].integer[2]
    endfunction

    //Checks if the ability is passive or not
    function IsAbilityCasteable takes integer abilId, boolean allowPlain returns boolean
        if allowPlain then
            //call BJDebugMsg("ap " + GetObjectName(abilId) + " casteable: " + B2S(AbilityData[abilId].boolean[4]))
            return AbilityData[abilId].boolean[4]
        else
            //call BJDebugMsg("nap " + GetObjectName(abilId) + " casteable: " + B2S(AbilityData[abilId].boolean[4] and not AbilityData[abilId].boolean[8]))
            return AbilityData[abilId].boolean[4] and not AbilityData[abilId].boolean[8]
        endif
    endfunction

    //Gets the ability target type: none, ally, enemy
    function GetAbilityTargetType takes integer abilId returns integer
        return AbilityData[abilId].integer[5]
    endfunction

    function IsAbilityReplaceable takes integer abilId returns boolean
        return AbilityData[abilId].boolean[6] == false
    endfunction

    //Checks if the ability can be cast by Manifold staff or not
    function IsAbilityManifoldable takes integer abilId returns boolean
        return AbilityData[abilId].boolean[7]
    endfunction

    //Gets a random ability that can be cast by chaos based on its order and target type
    function GetRandomChaosAbility takes integer typ, integer targetType returns integer
        if targetType == Target_Ally then
            return ChaosDataAlly[typ].integer[GetRandomInt(1, ChaosDataAlly[typ].integer[0])]
        elseif targetType == Target_Enemy then
            return ChaosDataEnemy[typ].integer[GetRandomInt(1, ChaosDataEnemy[typ].integer[0])]
        else
            return ChaosData[typ].integer[GetRandomInt(1, ChaosData[typ].integer[0])]
        endif
    endfunction

    //replaces Elem hashtable
    //replaces udg_integers08/09
    //replaces raabilitydata

    //abilId = ability Id
    //itemId = item id
    //mono = does not stack with itself
    //chaos = casteable by chaos magic
    //typ = order type (none target point instant)
    //element = ability element
    //order = ability order
    function SaveAbilData takes integer abilId, integer itemId, boolean absolute, integer targetType, integer mono, boolean chaos, integer typ, string order returns nothing
        local integer index = 0
        set LastObject = abilId
        set ItemData[itemId] = abilId

        set AbilityData[abilId].integer[0] = itemId
        set AbilityData[abilId].integer[2] = typ
        set AbilityData[abilId].integer[3] = mono
        set AbilityData[abilId].integer[5] = targetType

        if order != null then
            set AbilityData[abilId].boolean[4] = true
            set AbilityData[abilId].integer[1] = OrderId(order)
        endif

        if not absolute then
            set index = AbilityIndex[0] + 1
            set AbilityIndex[index] = abilId
            set AbilityIndex[0] = index
            
            if chaos and OrderId(order) != 0 then
                
                if targetType == 1 then
                    set index = ChaosDataAlly[typ].integer[0] + 1
                    set ChaosDataAlly[typ].integer[index] = abilId
                    set ChaosDataAlly[typ].integer[0] = index
                else
                    set index = ChaosDataEnemy[typ].integer[0] + 1
                    set ChaosDataEnemy[typ].integer[index] = abilId
                    set ChaosDataEnemy[typ].integer[0] = index
                endif

                //list of all chaos abilities
                set index = ChaosData[0].integer[0] + 1
                set ChaosData[0].integer[index] = abilId
                set ChaosData[0].integer[0] = index

                //list of chaos abilities per order type
                set index = ChaosData[typ].integer[0] + 1
                set ChaosData[typ].integer[index] = abilId
                set ChaosData[typ].integer[0] = index
            endif
        endif
    endfunction

    function SaveCreepAbilityData takes integer abilId, integer targetType, integer typ, string order returns nothing
        set AbilityData[abilId].integer[1] = OrderId(order)
        set AbilityData[abilId].integer[2] = typ
        set AbilityData[abilId].integer[5] = targetType

        if typ != Order_None then
            set AbilityData[abilId].boolean[4] = true
        endif
    endfunction

    function SaveDummyAbilOrder takes integer abilId, string order returns nothing
        set AbilityData[abilId].integer[1] = OrderId(order)
    endfunction

    function SetLastObjectElement takes integer element, integer count returns nothing
        set ElementData[element].integer[LastObject] = count
    endfunction

    function SetLastAbilityNotReplaceable takes nothing returns nothing
        set AbilityData[LastObject].boolean[6] = true
    endfunction

    function SetLastAbilityManifoldable takes nothing returns nothing
        set AbilityData[LastObject].boolean[7] = true
    endfunction

    function SetLastAbilityPlain takes nothing returns nothing
        set AbilityData[LastObject].boolean[8] = true
    endfunction

    function SetObjectElement takes integer objectId, integer element, integer count returns nothing
        set ElementData[element].integer[objectId] = count
    endfunction

    function InitAbilities takes nothing returns nothing
        //1 - Bash 
        call SaveAbilData(BASH_ABILITY_ID, BASH_ITEM_ID, false, 0, 0, false, Order_None, null)
        //call SetLastObjectElement(Element_Energy, 1)

        //2 - Mana Shield 
        call SaveAbilData(MANA_SHIELD_ABILITY_ID, MANA_SHIELD_ITEM_ID, false, 0, 0, false, Order_None, "manashieldon")
        call SetLastObjectElement(Element_Water, 1)
        call SetLastAbilityNotReplaceable()

        //3 - Carrion Swarm 
        call SaveAbilData(CARRION_SWARM_ABILITY_ID, CARRION_SWARM_ITEM_ID, false, 0, 0, true, Order_Point, "carrionswarm")
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastAbilityManifoldable()

        //4 - Critical Strike 
        call SaveAbilData(CRITICAL_STRIKE_ABILITY_ID, CRITICAL_STRIKE_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Blood, 1)

        //5 - Devotion Aura 
        call SaveAbilData(DEVOTION_AURA_ABILITY_ID, DEVOTION_AURA_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Light, 2)

        //6 - Endurance Aura 
        call SaveAbilData(ENDURANCE_AURA_ABILITY_ID, ENDURANCE_AURA_ITEM_ID, false, 0, 0, false, Order_None, null)

        //7 - Evasion 
        call SaveAbilData(EVASION_ABILITY_ID, EVASION_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Wind, 1)

        //8 - Fan of Knives 
        call SaveAbilData(FAN_OF_KNIVES_ABILITY_ID, FAN_OF_KNIVES_ITEM_ID, false, 0, 0, true, Order_Instant, "fanofknives")

        //9 - Feral Spirit 
        call SaveAbilData(FERAL_SPIRIT_ABILITY_ID, FERAL_SPIRIT_ITEM_ID, false, 0, 0, false, Order_Instant, "summonquillbeast")
        call SetLastObjectElement(Element_Arcane, 1)
        call SetLastObjectElement(Element_Wild, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //10 - Flame Strike 
        call SaveAbilData(FLAME_STRIKE_ABILITY_ID, FLAME_STRIKE_ITEM_ID, false, 0, 0, true, Order_Point, "flamestrike")
        call SetLastObjectElement(Element_Fire, 2)

        //11 - Forked Lightning 
        call SaveAbilData(FORKED_LIGHTNING_ABILITY_ID, FORKED_LIGHTNING_ITEM_ID, false, 0, 0, true, Order_Target, "forkedlightning")
        call SetLastObjectElement(Element_Wind, 1)

        //12 - Frost Nova 
        call SaveAbilData(FROST_NOVA_ABILITY_ID, FROST_NOVA_ITEM_ID, false, 0, 0, true, Order_Target, "frostnova")
        call SetLastObjectElement(Element_Water, 1)
        call SetLastObjectElement(Element_Cold, 1)

        //13 - Incinerate 
        call SaveAbilData(INCINERATE_ABILITY_ID, INCINERATE_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Fire, 1)

        //14 - Holy Light 
        call SaveAbilData(HOLY_LIGHT_ABILITY_ID, HOLY_LIGHT_ITEM_ID, false, Target_Any, 0, true, Order_Target, "holybolt")
        call SetLastObjectElement(Element_Light, 1)

        //15 - Impale 
        call SaveAbilData(IMPALE_ABILITY_ID, IMPALE_ITEM_ID, false, 0, 0, true, Order_Point, "impale")
        call SetLastObjectElement(Element_Earth, 1)
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastAbilityManifoldable()

        //16 - Serpent Ward 
        call SaveAbilData(SERPANT_WARD_ABILITY_ID, SERPANT_WARD_ITEM_ID, false, Target_Any, 0, false, Order_Point, "ward")
        call SetLastObjectElement(Element_Arcane, 1)
        call SetLastObjectElement(Element_Wild, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //17 - Shadow Strike 
        call SaveAbilData(SHADOW_STRIKE_ABILITY_ID, SHADOW_STRIKE_ITEM_ID, false, 0, 0, true, Order_Target, "shadowstrike")
        call SetLastObjectElement(Element_Poison, 1)

        //18 - Thorns Aura 
        call SaveAbilData(THORNS_AURA_ABILITY_ID, THORNS_AURA_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Earth, 1)
        call SetLastObjectElement(Element_Wild, 1)

        //19 - Thunder Clap 
        call SaveAbilData(THUNDER_CLAP_ABILITY_ID, THUNDER_CLAP_ITEM_ID, false, 0, 0, true, Order_Instant, "thunderclap")
        call SetLastObjectElement(Element_Wind, 1)
        call SetLastObjectElement(Element_Earth, 1)

        //20 - Unholy Aura 
        call SaveAbilData(UNHOLY_AURA_ABILITY_ID, UNHOLY_AURA_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Dark, 1)

        //21 - Vampirism 
        call SaveAbilData(VAMPIRISM_ABILITY_ID, VAMPIRISM_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Blood, 1)

        //22 - War Stomp 
        call SaveAbilData(WAR_STOMP_ABILITY_ID, WAR_STOMP_ITEM_ID, false, 0, 0, true, Order_Instant, "stomp")
        call SetLastObjectElement(Element_Earth, 1)
        //call SetLastObjectElement(Element_Energy, 1)

        //23 - Life Drain 
        call SaveAbilData(LIFE_DRAIN_ABILITY_ID, LIFE_DRAIN_ITEM_ID, false, 0, 0, true, Order_Target, "drain")
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastAbilityNotReplaceable()

        //25 - Spiked Carapace 
        call SaveAbilData(SPIKED_CARAPACE_ABILITY_ID, SPIKED_CARAPACE_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Dark, 1)

        //26 - Entangling Roots 
        call SaveAbilData(ENTAGLING_ROOTS_ABILITY_ID, ENTANGLING_ROOTS_ITEM_ID, false, Target_Enemy, 1, true, Order_Target, "entanglingroots")
        call SetLastObjectElement(Element_Earth, 1)
        call SetLastObjectElement(Element_Wild, 1)

        //27 - Summon Water Elemental 
        call SaveAbilData(SUMMON_WATER_ELEMENTAL_ABILITY_ID, SUMMON_WATER_ELEMENTAL_ITEM_ID, false, 0, 0, false, Order_Instant, "waterelemental")
        call SetLastObjectElement(Element_Water, 1)
        call SetLastObjectElement(Element_Wild, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //28 - Shockwave 
        call SaveAbilData(SHOCKWAVE_ABILITY_ID, SHOCKWAVE_ITEM_ID, false, 0, 0, true, Order_Point, "shockwave")
        call SetLastObjectElement(Element_Earth, 2)
        call SetLastObjectElement(Element_Light, 1)
        call SetLastAbilityManifoldable()

        //29 - Summon Lava Spawn 
        call SaveAbilData(SUMMON_LAVA_SPAWN_ABILITY_ID, SUMMON_LAVA_SPAWN_ITEM_ID, false, 0, 0, false, Order_Instant, "summonquillbeast")
        call SetLastObjectElement(Element_Fire, 1)
        call SetLastObjectElement(Element_Wild, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //30 - Drain Aura 
        call SaveAbilData(DRAIN_AURA_ABILITY_ID, DRAIN_AURA_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastObjectElement(Element_Blood, 1)

        //31 - Trueshot Aura 
        call SaveAbilData(TRUESHOT_AURA_ABILITY_ID, TRUESHOT_AURA_ITEM_ID, false, 0, 0, false, Order_None, null)

        //32 - Activate Immolation 
        call SaveAbilData(IMMOLATION_ABILITY_ID, IMMOLATION_ITEM_ID, false, 0, 0, false, Order_None, "immolation")
        call SetLastObjectElement(Element_Fire, 2)
        call SetLastAbilityPlain()

        //33 - Storm Bolt 
        call SaveAbilData(STORM_BOLT_ABILITY_ID, STORM_BOLT_ITEM_ID, false, 0, 0, true, Order_Target, "thunderbolt")
        call SetLastObjectElement(Element_Wind, 1)
        //call SetLastObjectElement(Element_Energy, 1)

        //34 - Mirror Image 
        call SaveAbilData(MIRROR_IMAGE_ABILITY_ID, MIRROR_IMAGE_ITEM_ID, false, 0, 0, false, Order_Instant, "mirrorimage")
        call SetLastObjectElement(Element_Arcane, 1)
        call SetLastAbilityPlain()
        call SetLastAbilityNotReplaceable()

        //35 - Chain Lightning 
        call SaveAbilData(CHAIN_LIGHTNING_ABILITY_ID, CHAIN_LIGHTNING_ITEM_ID, false, 0, 0, true, Order_Target, "chainlightning")
        call SetLastObjectElement(Element_Wind, 1)

        //36 - Tranquility 
        call SaveAbilData(TRANQUILITY_ABILITY_ID, TRANQUILITY_ITEM_ID, false, 0, 0, true, Order_Instant, "tranquility")
        call SetLastObjectElement(Element_Wild, 2)
        call SetLastObjectElement(Element_Light, 1)
        //call SaveDummyAbilOrder(TRANQUILITY_DUMMY_ABILITY_ID, "tranquility")

        //37 - Cluster Rockets 
        call SaveAbilData(CLUSTER_ROCKETS_ABILITY_ID, CLUSTER_ROCKETS_ITEM_ID, false, 0, 0, true, Order_Point, "clusterrockets")
        //call SaveDummyAbilOrder(CLUSTER_ROCKETS_DUMMY_ABILITY_ID, "clusterrockets")

        //38 - Wind Walk 
        call SaveAbilData(WIND_WALK_ABILITY_ID, WIND_WALK_ITEM_ID, false, 0, 0, false, Order_Instant, "windwalk")
        call SetLastObjectElement(Element_Wind, 1)
        call SetLastAbilityNotReplaceable()
        call SetLastAbilityPlain()

        //39 - Drunken Haze 
        call SaveAbilData(DRUNKEN_HAZE_ABILITY_ID, DRUNKEN_HAZE_ITEM_ID, false, 0, 1, true, Order_Target, "drunkenhaze")
        call SetLastObjectElement(Element_Poison, 2)

        //40 - Breath of Fire 
        call SaveAbilData(BREATH_OF_FIRE_ABILITY_ID, BREATH_OF_FIRE_ITEM_ID, false, 0, 0, true, Order_Point, "breathoffire")
        call SetLastObjectElement(Element_Fire, 1)
        call SetLastAbilityManifoldable()

        //41 - Whirlwind 
        call SaveAbilData(WHIRLWIND_ABILITY_ID, WHIRLWIND_ITEM_ID, false, 0, 0, true, Order_Instant, "creepthunderclap")
        call SetLastObjectElement(Element_Wind, 1)

        //42 - Reset Time 
        call SaveAbilData(RESET_TIME_ABILITY_ID, RESET_TIME_ITEM_ID, false, 0, 0, false, Order_Instant, "scout")
        call SetLastObjectElement(Element_Arcane, 1)

        //43 - Acid Bomb 
        call SaveAbilData(ACID_BOMB_ABILITY_ID, ACID_BOMB_ITEM_ID, false, 0, 1, true, Order_Target, "acidbomb")
        call SetLastObjectElement(Element_Poison, 1)

        //44 - Starfall 
        call SaveAbilData(STARFALL_ABILITY_ID, STARFALL_ITEM_ID, false, 0, 0, true, Order_Instant, "starfall")
        //call SetLastObjectElement(Element_Energy, 1)
        call SetLastObjectElement(Element_Arcane, 1)
        //call SaveDummyAbilOrder(STARFALL_DUMMY_ABILITY_ID, "starfall")

        //45 - Anti-magic shell
        call SaveAbilData(ANTI_MAGIC_SHEL_ABILITY_ID, ANTI_MAGIC_SHEL_ITEM_ID, false, 1, 1, true, Order_Target, "antimagicshell")
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastObjectElement(Element_Arcane, 1)

        //45 - SpiritLink
        call SaveAbilData(SPIRIT_LINK_ABILITY_ID, SPIRIT_LINK_ITEM_ID, false, 1, 1, true, Order_Target, "spirtlink")
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastObjectElement(Element_Arcane, 1)

        //46 - Frost Armor 
        call SaveAbilData(FROST_ARMOR_ABILITY_ID, FROST_ARMOR_ITEM_ID, false, 1, 1, true, Order_Target, "frostarmor")
        call SetLastObjectElement(Element_Water, 1)
        call SetLastObjectElement(Element_Cold, 1)

        //47 - Blizzard 
        call SaveAbilData(BLIZZARD_ABILITY_ID, BLIZZARD_ITEM_ID, false, 0, 0, true, Order_Point, "blizzard")
        call SetLastObjectElement(Element_Water, 2)
        call SetLastObjectElement(Element_Cold, 2)
        //call SaveDummyAbilOrder(BLIZZARD_DUMMY_ABILITY_ID, "blizzard")

        //48 - Rain of Fire 
        call SaveAbilData(RAIN_OF_FIRE_ABILITY_ID, RAIN_OF_FIRE_ITEM_ID, false, 0, 0, true, Order_Point, "rainoffire")
        call SetLastObjectElement(Element_Fire, 1)
        //call SaveDummyAbilOrder(RAIN_OF_FIRE_DUMMY_ABILITY_ID, "rainoffire")

        //49 - Stampede 
        call SaveAbilData(STAMPEDE_ABILITY_ID, STAMPEDE_ITEM_ID, false, 0, 0, true, Order_Point, "stampede")
        call SetLastObjectElement(Element_Wild, 1)
        //call SaveDummyAbilOrder(STAMPEDE_DUMMY_ABILITY_ID, "stampede")

        //50 - Howl of Terror 
        call SaveAbilData(HOWL_OF_TERROR_ABILITY_ID, HOWL_OF_TERROR_ITEM_ID, false, 0, 0, true, Order_Instant, "howlofterror")
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastObjectElement(Element_Cold, 1)

        //51 - Inferno 
        call SaveAbilData(INFERNO_ABILITY_ID, INFERNO_ITEM_ID, false, 0, 0, false, Order_Point, "dreadlordinferno")
        call SetLastObjectElement(Element_Fire, 1)
        call SetLastObjectElement(Element_Earth, 1)
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //52 - Healing Wave 
        call SaveAbilData(HEALING_WAVE_ABILITY_ID, HEALING_WAVE_ITEM_ID, false, 1, 0, true, Order_Target, "healingwave")
        call SetLastObjectElement(Element_Light, 1)

        //53 - Banish 
        call SaveAbilData(BANISH_ABILITY_ID, BANISH_ITEM_ID, false, 0, 1, true, Order_Target, "banish")
        call SetLastObjectElement(Element_Arcane, 1)
        call SetLastAbilityNotReplaceable()

        //54 - Acid Spray 
        call SaveAbilData(ACID_SPRAY_ABILITY_ID, ACID_SPRAY_ITEM_ID, false, 0, 0, true, Order_Point, "healingspray")
        call SetLastObjectElement(Element_Poison, 1)
        //call SaveDummyAbilOrder(ACID_SPRAY_DUMMY_ABILITY_ID, "healingspray")

        //55 - Activate Avatar 
        call SaveAbilData(ACTIVATE_AVATAR_ABILITY_ID, ACTIVATE_AVATAR_ITEM_ID, false, 0, 0, false, Order_Instant, "avatar")
        call SetLastObjectElement(Element_Earth, 1)
        //call SetLastObjectElement(Element_Energy, 1)
        call SetLastAbilityPlain()

        //56 - Battle Roar 
        call SaveAbilData(BATTLE_ROAR_ABILITY_ID, BATTLE_ROAR_ITEM_ID, false, 1, 0, true, Order_Instant, "battleroar")
        call SetLastObjectElement(Element_Wild, 1)

        //57 - Death And Decay 
        call SaveAbilData(DEATH_AND_DECAY_ABILITY_ID, DEATH_AND_DECAY_ITEM_ID, false, 0, 0, true, Order_Point, "deathanddecay")
        call SetLastObjectElement(Element_Dark, 1)

        //58 - Summon Mountain Giant 
        call SaveAbilData(SUMMON_MOUNTAIN_GIANT_ABILITY_ID, SUMMON_MOUNTAIN_GIANT_ITEM_ID, false, 0, 0, false, Order_Instant, "spiritofvengeance")
        call SetLastObjectElement(Element_Earth, 1)
        call SetLastObjectElement(Element_Wild, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //59 - Bloodlust 
        call SaveAbilData(BLOODLUST_ABILITY_ID, BLOODLUST_ITEM_ID, false, 1, 1, true, Order_Target, "bloodlust")
        call SetLastObjectElement(Element_Blood, 1)
        call SetLastAbilityNotReplaceable()

        //60 - Pocket Factory 
        call SaveAbilData(POCKET_FACTORY_ABILITY_ID, POCKET_FACTORY_ITEM_ID, false, Target_Any, 0, false, Order_Point, "summonfactory")
        call SetLastObjectElement(Element_Summon, 1)

        //61 - Pulverize 
        call SaveAbilData(PULVERIZE_ABILITY_ID, PULVERIZE_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Earth, 1)
        //call SetLastObjectElement(Element_Energy, 1)

        //62 - Corrosive Skin 
        call SaveAbilData(CORROSIVE_SKIN_ABILITY_ID, CORROSIVE_SKIN_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Poison, 1)

        //63 - Carrion Beetles 
        call SaveAbilData(CARRION_BEETLES_ABILITY_ID, CARRION_BEETLES_ITEM_ID, false, 0, 0, false, Order_Instant, "summonquillbeast")
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //65 - Hardened Skin 
        call SaveAbilData(HARDENED_SKIN_ABILITY_ID, HARDENED_SKIN_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Earth, 1)

        //66 - Searing Arrows 
        call SaveAbilData(SEARING_ARROWS_ABILITY_ID, SEARING_ARROWS_ITEM_ID, false, 0, 0, false, Order_None, "flamingarrows")
        call SetLastObjectElement(Element_Fire, 1)
        call SetLastAbilityPlain()

        //67 - Necromancer's Army 
        call SaveAbilData(NECROMANCERS_ARMY_ABILITY_ID, NECROMANCERS_ARMY_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //68 - Black Arrow 
        call SaveAbilData(BLACK_ARROW_PASSIVE_ABILITY_ID, BLACK_ARROW_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //69 - Cold Arrows 
        call SaveAbilData(COLD_ARROWS_ABILITY_ID, COLD_ARROWS_ITEM_ID, false, 0, 0, false, Order_None, "coldarrows")
        call SetLastObjectElement(Element_Cold, 1)
        call SetLastAbilityPlain()

        //70 - Faerie Fire 
        call SaveAbilData(FAERIE_FIRE_ABILITY_ID, FAERIE_FIRE_ITEM_ID, false, 0, 1, true, Order_Target, "faeriefire")
        call SetLastObjectElement(Element_Fire, 1)
        call SetLastObjectElement(Element_Wild, 1)
        call SetLastAbilityNotReplaceable()

        //71 - Parasite 
        call SaveAbilData(PARASITE_ABILITY_ID, PARASITE_ITEM_ID, false, 0, 1, true, Order_Target, "parasite")
        call SetLastObjectElement(Element_Poison, 1)
        call SetLastObjectElement(Element_Summon, 1)
        call SetLastAbilityNotReplaceable()

        //72 - Curse 
        call SaveAbilData(CURSE_ABILITY_ID, CURSE_ITEM_ID, false, 0, 1, true, Order_Target, "curse")
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastAbilityNotReplaceable()

        //73 - Inner Fire 
        call SaveAbilData(INNER_FIRE_ABILITY_ID, INNER_FIRE_ITEM_ID, false, 1, 1, true, Order_Target, "innerfire")
        call SetLastObjectElement(Element_Fire, 1)
        call SetLastObjectElement(Element_Light, 1)
        call SetLastAbilityNotReplaceable()

        //74 - Command Aura 
        call SaveAbilData(COMMAND_AURA_ABILITY_ID, COMMAND_AURA_ITEM_ID, false, 0, 0, false, Order_None, null)
        //call SetLastObjectElement(Element_Energy, 1)

        //75 - Devastating Blow 
        call SaveAbilData(DEVASTATING_BLOW_ABILITY_ID, DEVASTATING_BLOW_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Fire, 1)

        //76 - Summon Hawk 
        call SaveAbilData(SUMMON_HAWK_ABILITY_ID, SUMMON_HAWK_ITEM_ID, false, 0, 0, false, Order_Instant, "summonwareagle")
        call SetLastObjectElement(Element_Wild, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //77 - Summon Bear 
        call SaveAbilData(SUMMON_BEAR_ABILITY_ID, SUMMON_BEAR_ITEM_ID, false, 0, 0, false, Order_Instant, "summongrizzly")
        call SetLastObjectElement(Element_Wild, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //78 - Summon Quilbeast 
        call SaveAbilData(SUMMON_QUILBEAST_ABILITY_ID, SUMMON_QUILBEAST_ITEM_ID, false, 0, 0, false, Order_Instant, "summonquillbeast")
        call SetLastObjectElement(Element_Wild, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //79 - Phoenix 
        call SaveAbilData(PHEONIX_ABILITY_ID, PHOENIX_ITEM_ID, false, 0, 0, false, Order_Instant, "summonphoenix")
        call SetLastObjectElement(Element_Fire, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //81 - Unholy Frenzy 
        call SaveAbilData(UNHOLY_FRENZY_ABILITY_ID, UNHOLY_FRENZY_ITEM_ID, false, 0, 1, true, Order_Target, "unholyfrenzy")
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastAbilityNotReplaceable()

        //82 - Berserk 
        call SaveAbilData(BERSERK_ABILITY_ID, BERSERK_ITEM_ID, false, 0, 0, false, Order_Instant, "berserk")
        call SetLastObjectElement(Element_Blood, 1)
        call SetLastAbilityPlain()

        //83 - Rejuvenation 
        call SaveAbilData(REJUVENATION_ABILITY_ID, REJUVENATION_ITEM_ID, false, 1, 1, true, Order_Target, "rejuvination")
        call SetLastObjectElement(Element_Wild, 1)
        call SetLastObjectElement(Element_Light, 1)

        //84 - Lightning Shield 
        call SaveAbilData(LIGHTNING_SHIELD_ABILITY_ID, LIGHTNING_SHIELD_ITEM_ID, false, Target_Any, 1, false, Order_Target, "lightningshield")
        call SetLastObjectElement(Element_Wind, 2)
        call SetLastAbilityNotReplaceable()
        
        //86 - Ensnare 
        call SaveAbilData(ENSNARE_ABILITY_ID, ENSNARE_ITEM_ID, false, 0, 1, true, Order_Target, "ensnare")

        //87 - Liquid Fire 
        call SaveAbilData(LIQUID_FIRE_ABILITY_ID, LIQUID_FIRE_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Fire, 1)

        //88 - Plague 
        call SaveAbilData(PLAGUE_ABILITY_ID, PLAGUE_ITEM_ID, false, 0, 0, true, Order_Point, "channel")
        call SetLastObjectElement(Element_Poison, 2)

        //89 - Pillage 
        call SaveAbilData(PILLAGE_ABILITY_ID, PILLAGE_ITEM_ID, false, 0, 0, false, Order_None, null)

        //90 - Envenomed Weapons 
        call SaveAbilData(ENVENOMED_WEAPONS_ABILITY_ID, ENVENOMED_WEAPONS_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Poison, 1)

        //92 - Slow Aura 
        call SaveAbilData(SLOW_AURA_ABILITY_ID, SLOW_AURA_ITEM_ID, false, 0, 0, false, Order_None, null)

        //93 - Blink 
        call SaveAbilData(BLINK_ABILITY_ID, BLINK_ITEM_ID, false, 0, 0, false, Order_Point, "blink")
        call SetLastAbilityNotReplaceable()
        call SetLastAbilityPlain()

        //94 - Phase Shift 
        call SaveAbilData(PHASE_SHIFT_ABILITY_ID, PHASE_SHIFT_ITEM_ID, false, 0, 0, false, Order_Instant, "phaseshiftinstant")
        call SetLastAbilityPlain()

        //95 - Finger of Death 
        call SaveAbilData(FINGER_OF_DEATH_ABILITY_ID, FINGER_OF_DEATH_ITEM_ID, false, 0, 0, true, Order_Target, "fingerofdeath")
        call SetLastObjectElement(Element_Dark, 1)

        //96 - Aura of immortality 
        call SaveAbilData(AURA_OF_IMMORTALITY_ABILITY_ID, AURA_OF_IMMORTALITY_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Light, 1)

        //97 - Aura of Fear 
        call SaveAbilData(AURA_OF_FEAR_ABILITY_ID, AURA_OF_FEAR_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastObjectElement(Element_Blood, 1)

        //98 - Aura of Vulnerability 
        call SaveAbilData(AURA_OF_VULNERABILITY_ABILITY_ID, AURA_OF_VULNERABILITY_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Dark, 1)

        //99 - Finishing Blow 
        call SaveAbilData(FINISHING_BLOW_ABILITY_ID, FINISHING_BLOW_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Blood, 1)

        //100 - Mega Speed 
        call SaveAbilData(MEGA_SPEED_ABILITY_ID, MEGA_SPEED_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Wind, 1)

        //101 - Thunder Force 
        call SaveAbilData(THUNDER_FORCE_ABILITY_ID, THUNDER_FORCE_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Wind, 1)

        //102 - Air Force 
        call SaveAbilData(AIR_FORCE_ABILITY_ID, AIR_FORCE_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Wind, 1)

        //103 - Fire Force 
        call SaveAbilData(FIRE_FORCE_ABILITY_ID, FIRE_FORCE_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Fire, 1)

        //104 - Learnability 
        call SaveAbilData(LEARNABILITY_ABILITY_ID, LEARNABILITY_ITEM_ID, false, 0, 0, false, Order_None, null)

        //105 - Mana Bonus 
        call SaveAbilData(MANA_BONUS_ABILITY_ID, MANA_BONUS_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Water, 1)
        //call SetLastObjectElement(Element_Energy, 1)

        //106 - Power of Ice 
        call SaveAbilData(POWER_OF_ICE_ABILITY_ID, POWER_OF_ICE_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Water, 1)
        call SetLastObjectElement(Element_Cold, 1)

        //107 - Brilliance Aura 
        call SaveAbilData(BRILLIANCE_AURA_ABILITY_ID, BRILLIANCE_AURA_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Water, 1)

        //108 - Fast Magic 
        call SaveAbilData(FAST_MAGIC_ABILITY_ID, FAST_MAGIC_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Arcane, 1)

        //109 - Hero Buff 
        call SaveAbilData(HERO_BUFF_ABILITY_ID, HERO_BUFF_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Light, 1)

        //110 - Temporary Invisibility 
        call SaveAbilData(TEMPORARY_INVISIBILITY_ABILITY_ID, TEMPORARY_INVISIBILITY_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Wind, 1)

        //111 - Rapid Recovery 
        call SaveAbilData(RAPID_RECOVERY_ABILITY_ID, RAPID_RECOVERY_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Light, 1)

        //call SetLastObjectElement(Element_Time, 1)

        //113 - Cheater Magic 
        call SaveAbilData(CHEATER_MAGIC_ABILITY_ID, CHEATER_MAGIC_ITEM_ID, false, 0, 0, false, Order_None, null)
        //call SetLastObjectElement(Element_Energy, 1)
        call SetLastObjectElement(Element_Arcane, 1)
        //call SetLastObjectElement(Element_Time, 1)

        //114 - Fearless Defenders 
        call SaveAbilData(FEARLESS_DEFENDERS_ABILITY_ID, FEARLESS_DEFENDERS_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Light, 1)

        //115 - Demon's Curse 
        call SaveAbilData(DEMONS_CURSE_ABILITY_ID, DEMONS_CURSE_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Dark, 1)

        //116 - Blessed Protection
        call SaveAbilData(BLESSED_PROTECTIO_ABILITY_ID, BLESSED_PROTECTIO_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Light, 1)

        //117 - Reincarnation 
        call SaveAbilData(REINCARNATION_ABILITY_ID, REINCARNATION_ITEM_ID, false, 0, 0, false, Order_None, null)
        //call SetLastObjectElement(Element_Energy, 1)
        call SetLastObjectElement(Element_Light, 1)

        //118 - Drunken Master 
        call SaveAbilData(DRUNKEN_MASTER_ABILITY_ID, DRUNKEN_MASTER_ITEM_ID, false, 0, 0, false, Order_None, null)

        //119 - Demolish 
        call SaveAbilData(DEMOLISH_ABILITY_ID, DEMOLISH_ITEM_ID, false, 0, 0, false, Order_None, null)

        //120 - Destruction
        call SaveAbilData(DESTRUCTION_ABILITY_ID, DESTRUCTION_ITEM_ID, false, 0, 0, false, Order_None, null)
        //call SetLastObjectElement(Element_Energy, 1)

        //122 - Divine Shield 
        call SaveAbilData(DIVINE_SHIELD_ABILITY_ID, DIVINE_SHIELD_ITEM_ID, false, 0, 0, false, Order_Instant, "divineshield")
        call SetLastObjectElement(Element_Light, 1)
        call SetLastAbilityPlain()

        //123 - Midas Touch 
        call SaveAbilData(MIDAS_TOUCH_ABILITY_ID, MIDAS_TOUCH_ITEM_ID, false, 0, 1, true, Order_Target, "transmute")
        call SetLastAbilityNotReplaceable()

        //124 - Silence 
        call SaveAbilData(SILENCE_ABILITY_ID, SILENCE_ITEM_ID, false, 0, 1, true, Order_Point, "silence")
        call SetLastObjectElement(Element_Dark, 1)

        //125 - Stasis Trap 
        call SaveAbilData(STASIS_TRAP_ABILITY_ID, STASIS_TRAP_ITEM_ID, false, 0, 0, true, Order_Point, "stasistrap")
        call SetLastObjectElement(Element_Arcane, 1)
        call SetLastAbilityNotReplaceable()

        //126 - Death Pact 
        call SaveAbilData(DEATH_PACT_ABILITY_ID, DEATH_PACT_ITEM_ID, false, 0, 1, false, Order_Target, "deathpact")
        call SetLastObjectElement(Element_Dark, 2)
        call SetLastAbilityNotReplaceable()

        //127 - Big Bad Voodoo 
        call SaveAbilData(BIG_BAD_VOODOO_ABILITY_ID, BIG_BAD_VOODOO_ITEM_ID, false, 0, 0, false, Order_Instant, "voodoo")
        call SetLastObjectElement(Element_Arcane, 2)
        call SetLastObjectElement(Element_Dark, 2)
        call SetLastAbilityPlain()

        //128 - Icy Breath 
        call SaveAbilData(ICY_BREATH_ABILITY_ID, ICY_BREATH_ITEM_ID, false, 0, 1, true, Order_Point, "breathoffrost")
        call SetLastObjectElement(Element_Cold, 1)
        call SetLastAbilityManifoldable()

        //129 - Soul Burn 
        call SaveAbilData(SOUL_BURN_ABILITY_ID, SOUL_BURN_ITEM_ID, false, 0, 1, true, Order_Target, "soulburn")
        call SetLastObjectElement(Element_Fire, 1)

        //130 - Fog 
        call SaveAbilData(FOG_ABILITY_ID, FOG_ITEM_ID, false, 0, 1, true, Order_Point, "cloudoffog")
        call SetLastObjectElement(Element_Water, 1)
        call SetLastObjectElement(Element_Wind, 1)
        //call SaveDummyAbilOrder(CLOUD_DUMMY_ABILITY_ID, "cloudoffog")

        //131 - Temporary Power 
        call SaveAbilData(TEMPORARY_POWER_ABILITY_ID, TEMPORARY_POWER_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Light, 1)

        //132 - Multicast 
        call SaveAbilData(MULTICAST_ABILITY_ID, MULTICAST_ITEM_ID, false, 0, 0, false, Order_None, null)

        //133 - Heavy Blow 
        call SaveAbilData(HEAVY_BLOW_ABILITY_ID, HEAVY_BLOW_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Light, 1)

        //134 - Combustion 
        call SaveAbilData(COMBUSTION_ABILITY_ID, COMBUSTION_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Fire, 1)

        //135 - Holy Enlightenment 
        call SaveAbilData(HOLY_ENLIGHTENMENT_ABILITY_ID, HOLY_ENLIGHTENMENT_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Light, 1)

        //136 - Chaos Magic 
        call SaveAbilData(CHAOS_MAGIC_ABILITY_ID, CHAOS_MAGIC_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Fire, 1)
        call SetLastObjectElement(Element_Water, 1)
        call SetLastObjectElement(Element_Wind, 1)
        call SetLastObjectElement(Element_Earth, 1)
        call SetLastObjectElement(Element_Wild, 1)
        //call SetLastObjectElement(Element_Energy, 1)
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastObjectElement(Element_Light, 1)
        call SetLastObjectElement(Element_Cold, 1)
        call SetLastObjectElement(Element_Poison, 1)
        call SetLastObjectElement(Element_Blood, 1)
        call SetLastObjectElement(Element_Arcane, 1)
        //call SetLastObjectElement(Element_Time, 1)

        //137 - Monsoon 
        call SaveAbilData(MONSOON_ABILITY_ID, MONSOON_ITEM_ID, false, 0, 0, true, Order_Point, "monsoon")
        call SetLastObjectElement(Element_Water, 2)
        call SetLastObjectElement(Element_Wind, 2)
        //call SaveDummyAbilOrder(MONSOON_DUMMY_ABILITY_ID, "monsoon")

        //138 - Ice Armor 
        call SaveAbilData(ICE_ARMOR_ABILITY_ID, ICE_ARMOR_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Water, 1)
        call SetLastObjectElement(Element_Cold, 1)

        //139 - Last Breath 
        call SaveAbilData(LAST_BREATHS_ABILITY_ID, LAST_BREATHS_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastObjectElement(Element_Light, 1)

        //140 - Fire Shield 
        call SaveAbilData(FIRE_SHIELD_ABILITY_ID, FIRE_SHIELD_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Fire, 1)

        //141 - Ancient Teaching 
        call SaveAbilData(ANCIENT_TEACHING_ABILITY_ID, ANCIENT_TEACHING_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Arcane, 1)

        //142 - Cyclone 
        call SaveAbilData(CYCLONE_ABILITY_ID, CYCLONE_ITEM_ID, false, 0, 0, true, Order_Point, "creepanimatedead")
        call SetLastObjectElement(Element_Wind, 1)

        //143 - Mysterious Talent 
        call SaveAbilData(MYSTERIOUS_TALENT_ABILITY_ID, MYSTERIOUS_TALENT_ITEM_ID, false, 0, 0, false, Order_None, null)
        //call SetLastObjectElement(Element_Energy, 1)
        call SetLastObjectElement(Element_Arcane, 1)

        //144 - Stone Protection 
        call SaveAbilData(STONE_PROTECTION_ABILITY_ID, STONE_PROTECTION_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Earth, 1)

        //145 - Cruelty 
        call SaveAbilData(CRUELTY_ABILITY_ID, CRUELTY_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Blood, 1)

        //146 - Reaction 
        call SaveAbilData(REACTION_ABILITY_ID, REACTION_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Wind, 1)

        //147 - Magic Critical Hit 
        call SaveAbilData(MAGIC_CRITICAL_HIT_ABILITY_ID, MAGIC_CRITICAL_HIT_ITEM_ID, false, 0, 0, false, Order_None, null)
        //call SetLastObjectElement(Element_Energy, 1)
        call SetLastObjectElement(Element_Arcane, 1)

        //148 - Mega Luck 
        call SaveAbilData(MEGA_LUCK_ABILITY_ID, MEGA_LUCK_ITEM_ID, false, 0, 0, false, Order_None, null)

        //149 - Dousing Hex
        call SaveAbilData(DOUSING_HE_ABILITY_ID, DOUSING_HE_ITEM_ID, false, 0, 1, true, Order_Target, "ancestralspirittarget")
        call SetLastObjectElement(Element_Water, 1)

        //150 - Ancient Runes 
        call SaveAbilData(ANCIENT_RUNES_ABILITY_ID, ANCIENT_RUNES_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Arcane, 1)

        //151 - Earthquake 
        call SaveAbilData(EARTHQUAKE_ABILITY_ID, EARTHQUAKE_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Earth, 1)

        //152 - Cold Wind 
        call SaveAbilData(COLD_WIND_ABILITY_ID, COLD_WIND_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Wind, 1)
        call SetLastObjectElement(Element_Cold, 1)

        //153 - Random Spell 
        call SaveAbilData(RANDOM_SPELL_ABILITY_ID, RANDOM_SPELL_ITEM_ID, false, 0, 0, true, Order_Target, "slow")
        call SetLastObjectElement(Element_Fire, 1)
        call SetLastObjectElement(Element_Water, 1)
        call SetLastObjectElement(Element_Wind, 1)
        call SetLastObjectElement(Element_Earth, 1)
        call SetLastObjectElement(Element_Wild, 1)
        //call SetLastObjectElement(Element_Energy, 1)
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastObjectElement(Element_Light, 1)
        call SetLastObjectElement(Element_Cold, 1)
        call SetLastObjectElement(Element_Poison, 1)
        call SetLastObjectElement(Element_Blood, 1)
        call SetLastObjectElement(Element_Arcane, 1)
        call SetLastAbilityNotReplaceable()
        //call SetLastObjectElement(Element_Time, 1)

        //154 - Divine Bubble 
        call SaveAbilData(DIVINE_BUBBLE_ABILITY_ID, DIVINE_BUBBLE_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Light, 1)

        //155 - Ancient Element 
        call SaveAbilData(ANCIENT_ELEMENT_ABILITY_ID, ANCIENT_ELEMENT_ITEM_ID, false, 0, 0, false, Order_None, null)
        //elements are set in 

        //155 - Ancient Blood 
        call SaveAbilData(ANCIENT_BLOOD_ABILITY_ID, ANCIENT_BLOOD_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Blood, 1)
        call SetLastObjectElement(Element_Water, 1)
        call SetLastObjectElement(Element_Wind, 1)

        //156 - Frost Bolt 
        call SaveAbilData(FROST_BOLT_ABILITY_ID, FROST_BOLT_ITEM_ID, false, 0, 0, true, Order_Target, "slowon")
        call SetLastObjectElement(Element_Water, 1)
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastObjectElement(Element_Cold, 1)

        //157 - Frostbite of the Soul 
        call SaveAbilData(FROSTBITE_OF_THE_SOUL_ABILITY_ID, FROSTBITE_OF_THE_SOUL_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Cold, 1)
        call SetLastObjectElement(Element_Dark, 1)

        //158 - Cutting 
        call SaveAbilData(CUTTING_ABILITY_ID, CUTTING_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Blood, 1)

        //159 - Divine Gift 
        call SaveAbilData(DIVINE_GIFT_ABILITY_ID, DIVINE_GIFT_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Light, 1)

        //160 - Sand of Time 
        call SaveAbilData(SAND_OF_TIME_ABILITY_ID, SAND_OF_TIME_ITEM_ID, false, 0, 0, false, Order_Instant, "slowoff")
        call SetLastObjectElement(Element_Earth, 1)
        call SetLastObjectElement(Element_Arcane, 1)
        //call SetLastObjectElement(Element_Time, 1)

        //161 - Wizardbane Aura 
        call SaveAbilData(WIZARDBANE_AURA_ABILITY_ID, WIZARDBANE_AURA_ITEM_ID, false, 0, 0, false, Order_None, null)
        //call SetLastObjectElement(Element_Energy, 1)
        call SetLastObjectElement(Element_Arcane, 1)

        //162 - Martial Retribution 
        call SaveAbilData(MARTIAL_RETRIBUTION_ABILITY_ID, MARTIAL_RETRIBUTION_ITEM_ID, false, 0, 0, false, Order_None, null)
        //call SetLastObjectElement(Element_Energy, 1)

        //163 - Purge 
        call SaveAbilData(PURGE_ABILITY_ID, PURGE_ITEM_ID, false, 0, 1, true, Order_Target, "purge")
        //call SetLastObjectElement(Element_Spirit, 1)
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastAbilityNotReplaceable()

        //164 - Blink Strike 
        call SaveAbilData(BLINK_STRIKE_ABILITY_ID, BLINK_STRIKE_ITEM_ID, false, 0, 0, true, Order_Instant, "acolyteharvest")
        call SetLastObjectElement(Element_Wind, 1)
        call SetLastObjectElement(Element_Arcane, 1)

        //165 - Extradimensional Co-operation
        call SaveAbilData(EXTRADIMENSIONAL_CO_OPERATIO_ABILITY_ID, EXTRADIMENSIONAL_CO_OPERATIO_ITEM_ID, false, 0, 0, true, Order_Instant, "absorb")
        call SetLastObjectElement(Element_Arcane, 1)
        //call SetLastObjectElement(Element_Time, 1)
        //call SetLastObjectElement(Element_Spirit, 1)

        //166 - Reflection Aura
        call SaveAbilData(REFLECTION_AUR_ABILITY_ID, REFLECTION_AUR_ITEM_ID, false, 0, 0, false, Order_None, null)

        //167 - Arcane Assault
        call SaveAbilData(ARCANE_ASSAUL_ABILITY_ID, ARCANE_ASSAUL_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Arcane, 1)

        //168 - Absolute Fire
        call SaveAbilData(ABSOLUTE_FIRE_ABILITY_ID, ABSOLUTE_FIRE_ITEM_ID, true, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Fire, 1)

        //169 - Absolute Water
        call SaveAbilData(ABSOLUTE_WATER_ABILITY_ID, ABSOLUTE_WATER_ITEM_ID, true, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Water, 1)

        //170 - Absolute Wind
        call SaveAbilData(ABSOLUTE_WIND_ABILITY_ID, ABSOLUTE_WIND_ITEM_ID, true, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Wind, 1)

        //171 - Absolute Earth
        call SaveAbilData(ABSOLUTE_EARTH_ABILITY_ID, ABSOLUTE_EARTH_ITEM_ID, true, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Earth, 1)

        //172 - Absolute Wild
        call SaveAbilData(ABSOLUTE_WILD_ABILITY_ID, ABSOLUTE_WILD_ITEM_ID, true, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Wild, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //173 - Absolute Dark
        call SaveAbilData(ABSOLUTE_DARK_ABILITY_ID, ABSOLUTE_DARK_ITEM_ID, true, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Dark, 1)

        //174 - Absolute Light
        call SaveAbilData(ABSOLUTE_LIGHT_ABILITY_ID, ABSOLUTE_LIGHT_ITEM_ID, true, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Light, 1)

        //175 - Absolute Cold
        call SaveAbilData(ABSOLUTE_COLD_ABILITY_ID, ABSOLUTE_COLD_ITEM_ID, true, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Cold, 1)

        //176 - Absolute Blood
        call SaveAbilData(ABSOLUTE_BLOOD_ABILITY_ID, ABSOLUTE_BLOOD_ITEM_ID, true, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Blood, 1)

        //177 - Absolute Arcane 
        call SaveAbilData(ABSOLUTE_ARCANE_ABILITY_ID, ABSOLUTE_ARCANE_ITEM_ID, true, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Arcane, 1)

        //178 - Absolute Poison
        call SaveAbilData(ABSOLUTE_POISON_ABILITY_ID, ABSOLUTE_POISON_ITEM_ID, true, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Poison, 1)

        //179 - Mana Starvation
        call SaveAbilData(MANA_STARVATIO_ABILITY_ID, MANA_STARVATIO_ITEM_ID, false, 0, 0, true, Order_Target, "ancestralspirit")
        call SetLastObjectElement(Element_Water, 1)
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastAbilityNotReplaceable()

        //180 - Fatal Flaw
        call SaveAbilData(FATAL_FLA_ABILITY_ID, FATAL_FLA_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Arcane, 1)

        //181 - Retaliation Aura
        call SaveAbilData(RETALIATION_AUR_ABILITY_ID, RETALIATION_AUR_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Arcane, 1)

        //183 - Time Manipulation
        call SaveAbilData(TIME_MANIPULATION_ABILITY_ID, TIME_MANIPULATION_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Arcane, 1)
        call SetLastObjectElement(Element_Light, 1)

        //184 - Crushing Wave 
        call SaveAbilData(CRUSHING_WAVE_ABILITY_ID, CRUSHING_WAVE_ITEM_ID, false, 0, 0, true, Order_Point, "carrionswarm")
        //call SetLastObjectElement(Element_Energy, 1)
        call SetLastObjectElement(Element_Water, 1)
        call SetLastAbilityManifoldable()

        //185 - Energy Trap 
        call SaveAbilData(ENERGY_TRAP_ABILITY_ID, ENERGY_TRAP_ITEM_ID, false, 0, 0, true, Order_Point, "volcano")
        //call SetLastObjectElement(Element_Energy, 1)

        //186 - Magnetic Oscillation 
        call SaveAbilData(MAGNET_OSC_ABILITY_ID, MAGNET_OSC_ITEM_ID, false, 0, 0, true, Order_None, "hex")
        //call SetLastObjectElement(Element_Energy, 1)
        call SetLastObjectElement(Element_Earth, 1)
        call SetLastAbilityPlain()

        //187 - Martial Theft 
        call SaveAbilData(MARTIAL_THEFT_ABILITY_ID, MARTIAL_THEFT_ITEM_ID, false, 0, 0, false, Order_None, null)
        //call SetLastObjectElement(Element_Energy, 1)

        //188 - Destryction Block 
        call SaveAbilData(DESTRUCTION_BLOCK_ABILITY_ID, DESTRUCTION_BLOCK_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Dark, 1)

        //189 - Dark Seal
        call SaveAbilData(DARK_SEAL_ABILITY_ID, DARK_SEAL_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Dark, 1)

        //190 - Shadow Step
        call SaveAbilData(SHADOW_STEP_ABILITY_ID, SHADOW_STEP_ITEM_ID , false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Dark, 2)

        //191 - Energy Shield
        call SaveAbilData(ENERGY_SHIELD_ABILITY_ID, ENERGY_SHIELD_ITEM_ID , false, 0, 0, false, Order_None, null)

        //192 - Backstab
        call SaveAbilData(BACKSTAB_ABILITY_ID, BACKSTAB_ITEM_ID , false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Blood, 1)

        //193 - Shadow dance
         call SaveAbilData(SHADOW_DANCE_ABILITY_ID, SHADOW_DANCE_ITEM_ID , false, 0, 0, false, Order_None, null)
         call SetLastObjectElement(Element_Dark, 1)

        //194 - Power of water
        call SaveAbilData(POWER_OF_WATER_ABILITY_ID, POWER_OF_WATER_ITEM_ID , false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Water, 1)
        
        //195 - Arcane Strike
        call SaveAbilData(ARCANE_STRIKE_ABILITY_ID, ARCANE_STRIKE_ITEM_ID, false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Arcane, 1)

         //196 - Eruption
         call SaveAbilData(ERUPTION_ABILITY_ID, ERUPTION_ITEM_ID, false, 0, 0, true, Order_Point, "volcano")
         call SetLastObjectElement(Element_Fire, 1)
         call SetLastObjectElement(Element_Earth, 1)

    endfunction

    function InitHeroElements takes nothing returns nothing

        //Unit and item elements
        call SetObjectElement(DOOM_GUARD_UNIT_ID, Element_Fire, 1)
        call SetObjectElement(PYROMANCER_UNIT_ID, Element_Fire, 1)
        call SetObjectElement(PIT_LORD_UNIT_ID, Element_Fire, 1)
        call SetObjectElement(WITCH_DOCTOR_UNIT_ID, Element_Water, 1)
        call SetObjectElement(LICH_UNIT_ID, Element_Water, 1)
        call SetObjectElement(NAGA_SIREN_UNIT_ID, Element_Water, 1)
        call SetObjectElement(BLOOD_MAGE_UNIT_ID, Element_Water, 1)
        call SetObjectElement(SORCERER_UNIT_ID, Element_Wind, 1)
        call SetObjectElement(SORCERER_UNIT_ID, Element_Arcane, 1)
        call SetObjectElement(THUNDER_WITCH_UNIT_ID, Element_Wind, 1)
        call SetObjectElement(TROLL_BERSERKER_UNIT_ID, Element_Wind, 1)
        call SetObjectElement(SATYR_TRICKSTER_UNIT_ID, Element_Wind, 1)
        call SetObjectElement(BLADE_MASTER_UNIT_ID, Element_Wind, 1)
        call SetObjectElement(OGRE_WARRIOR_UNIT_ID, Element_Earth, 1)
        call SetObjectElement(ROCK_GOLEM_UNIT_ID, Element_Earth, 1)
        call SetObjectElement(GNOME_MASTER_UNIT_ID, Element_Earth, 1)
        call SetObjectElement(ARENA_MASTER_UNIT_ID, Element_Earth, 1)
        call SetObjectElement(BEAST_MASTER_UNIT_ID, Element_Wild, 1)
        call SetObjectElement(MYSTIC_UNIT_ID, Element_Wild, 1)
        call SetObjectElement(DRUID_OF_THE_CLAY_UNIT_ID, Element_Wild, 1)
        call SetObjectElement(SEER_UNIT_ID, Element_Arcane, 1)
        call SetObjectElement(MURLOC_WARRIOR_UNIT_ID, Element_Blood, 1)
        /*
        call SetObjectElement(CENTAUR_ARCHER_UNIT_ID, Element_Energy, 1)
        
        call SetObjectElement(GRUNT_UNIT_ID, Element_Energy, 1)
        call SetObjectElement(DARK_HUNTER_UNIT_ID, Element_Energy, 1)
        call SetObjectElement(MEDIVH_UNIT_ID, Element_Energy, 1)
        call SetObjectElement(TAUREN_UNIT_ID, Element_Energy, 1)
        */
        call SetObjectElement(SKELETON_BRUTE_UNIT_ID, Element_Dark, 1)
        call SetObjectElement(FALLEN_RANGER_UNIT_ID, Element_Dark, 1)
        call SetObjectElement(AVATAR_SPIRIT_UNIT_ID, Element_Dark, 1)
        call SetObjectElement(DARK_HUNTER_UNIT_ID, Element_Dark, 1)
        call SetObjectElement(ABOMINATION_UNIT_ID, Element_Dark, 1)
        call SetObjectElement(DEADLORD_UNIT_ID, Element_Dark, 1)
        call SetObjectElement(LICH_UNIT_ID, Element_Dark, 1)
        call SetObjectElement(TROLL_HEADHUNTER_UNIT_ID, Element_Dark, 1)
        call SetObjectElement(MAULER_UNIT_ID, Element_Light, 1)
        call SetObjectElement(LIEUTENANT_UNIT_ID, Element_Light, 1)
        call SetObjectElement(AVATAR_SPIRIT_UNIT_ID, Element_Light, 1)
        call SetObjectElement(LICH_UNIT_ID, Element_Cold, 1)
        call SetObjectElement(YETI_UNIT_ID, Element_Cold, 1)
        call SetObjectElement(COLD_KNIGHT_UNIT_ID, Element_Cold, 1)
        call SetObjectElement(RANGER_UNIT_ID, Element_Blood, 1)
        call SetObjectElement(WAR_GOLEM_UNIT_ID, Element_Blood, 1)
        call SetObjectElement(DEADLORD_UNIT_ID, Element_Blood, 1)
        call SetObjectElement(ORC_CHAMPION_UNIT_ID, Element_Blood, 1)
        call SetObjectElement(GHOUL_UNIT_ID, Element_Blood, 1)
        call SetObjectElement(URSA_WARRIOR_UNIT_ID, Element_Blood, 1)
        call SetObjectElement(TROLL_HEADHUNTER_UNIT_ID, Element_Blood, 1)
        call SetObjectElement(SEER_UNIT_ID, Element_Arcane, 1)
        call SetObjectElement(OGRE_MAGE_UNIT_ID, Element_Arcane, 1)
        call SetObjectElement(DEMON_HUNTER_UNIT_ID, Element_Arcane, 1)
        call SetObjectElement(TIME_WARRIOR_UNIT_ID, Element_Arcane, 1)
        call SetObjectElement(BANSHEE_UNIT_ID, Element_Arcane, 1)
        call SetObjectElement(BANSHEE_UNIT_ID, Element_Water, 1)
        call SetObjectElement(ABOMINATION_UNIT_ID, Element_Poison, 1)
    endfunction 

    function InitDummyAbilElements takes nothing returns nothing

        //Earth Rune
        call SetObjectElement('A074', Element_Earth, 1)

        //Fire Rune
        call SetObjectElement('A02V', Element_Fire, 1)

        //Fire Force
        call SetObjectElement('A0C0', Element_Fire, 1)

        //Wind Rune
        call SetObjectElement('A075', Element_Wind, 1)

        //Corrosive Skin
        call SetObjectElement('A00R', Element_Poison, 1)

        //Power of Ice
        call SetObjectElement('A02Y', Element_Water, 1)
        call SetObjectElement('A02Y', Element_Cold, 1)

        //Earthquake
        call SetObjectElement('A07M', Element_Earth, 1)

        //Bash
        //call SetObjectElement('A06T', Element_Energy, 1)

        //Thunder Force
        call SetObjectElement('A02R', Element_Wind, 1)

        //Lich Frost Nova
        call SetObjectElement('A03J', Element_Water, 1)
        call SetObjectElement('A03J', Element_Cold, 1)
        call SetObjectElement('A03J', Element_Dark, 1)

        //Ogre Warrior
        call SetObjectElement('A047', Element_Earth, 1)

        //Staff of Lightning
        call SetObjectElement('A03B', Element_Wind, 1)

        //Frost Bolt
        call SetObjectElement('A07Y', Element_Water, 1)
        call SetObjectElement('A07Y', Element_Cold, 1)
        call SetObjectElement('A07Y', Element_Dark, 1)

        //Absolute cold
        call SetObjectElement('A07W', Element_Cold, 1)

        //Stone Protection
        call SetObjectElement('A061', Element_Earth, 1)

        //Thunder Witch Thunderbolt
        call SetObjectElement('A036', Element_Wind, 1)

        //Gnome Gnome Stomp
        call SetObjectElement('A03Z', Element_Earth, 1)
    endfunction

    function InitCreepAbilities takes nothing returns nothing
        //Hurl Boulder
        call SaveCreepAbilityData(HURL_BOULDER_CREEP_ABILITY_ID, Target_Enemy, Order_Target, "creepthunderbolt")

        //Rejuvenation
        call SaveCreepAbilityData(REJUVENATION_CREEP_ABILITY_ID, Target_Ally, Order_Target, "rejuvination")

        //Faerie Fire
        call SaveCreepAbilityData(FAERIE_FIRE_CREEP_ABILITY_ID, Target_Enemy, Order_Target, "faeriefire")

        //Mana Burn
        call SaveCreepAbilityData(MANA_BURN_CREEP_ABILITY_ID, Target_Enemy, Order_Target, "manaburn")

        //Shockwave
        call SaveCreepAbilityData(SHOCKWAVE_CREEP_ABILITY_ID, Target_Enemy, Order_Point, "shockwave")

        //Thunder Clap
        call SaveCreepAbilityData(THUNDER_CLAP_CREEP_ABILITY_ID, Target_Enemy, Order_Instant, "thunderclap")
    endfunction

    private function init takes nothing returns nothing
        set ChaosData = HashTable.create()
        set ChaosDataEnemy = HashTable.create()
        set ChaosDataAlly = HashTable.create()
        set AbilityData = HashTable.create()
        set ElementData = HashTable.create()
        set ItemData = Table.create()
        set AbilityIndex = Table.create()
        call InitAbilities()
        call InitCreepAbilities()
        call InitDummyAbilElements()
        call InitHeroElements()
    endfunction
endlibrary

