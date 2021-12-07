library AbilityData initializer init requires Table, IdLibrary
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
        integer Element_Time = 14
        integer Element_Spirit = 15

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
    function IsAbilityCasteable takes integer abilId returns boolean
        return AbilityData[abilId].boolean[4]
    endfunction

    //Gets the ability target type: none, ally, enemy
    function GetAbilityTargetType takes integer abilId returns integer
        return AbilityData[abilId].integer[5]
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
        set AbilityData[abilId].integer[1] = OrderId(order)
        set AbilityData[abilId].integer[2] = typ
        set AbilityData[abilId].integer[3] = mono
        set AbilityData[abilId].integer[5] = targetType

        if typ != Order_None then
            set AbilityData[abilId].boolean[4] = true
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

    function SetObjectElement takes integer objectId, integer element, integer count returns nothing
        set ElementData[element].integer[objectId] = count
    endfunction

    function InitAbilities takes nothing returns nothing
        //1 - Bash 
        call SaveAbilData('A06S', 'I00L', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Energy, 1)

        //2 - Mana Shield 
        call SaveAbilData('ANms', 'I03F', false, 0, 0, false, Order_None, "manashieldon")
        call SetLastObjectElement(Element_Water, 1)

        //3 - Carrion Swarm 
        call SaveAbilData('AUcs', 'I008', false, 0, 0, true, Order_Point, "carrionswarm")
        call SetLastObjectElement(Element_Dark, 1)

        //4 - Critical Strike 
        call SaveAbilData(CRITICAL_STRIKE_ABILITY_ID, 'I00B', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Blood, 1)

        //5 - Devotion Aura 
        call SaveAbilData('AHad', 'I009', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Light, 2)

        //6 - Endurance Aura 
        call SaveAbilData('AOae', 'I000', false, 0, 0, false, Order_None, null)

        //7 - Evasion 
        call SaveAbilData('AEev', 'I00A', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Wind, 1)

        //8 - Fan of Knives 
        call SaveAbilData('AEfk', 'I003', false, 0, 0, true, Order_Instant, "fanofknives")

        //9 - Feral Spirit 
        call SaveAbilData(FERAL_SPIRIT_ABILITY_ID, 'I004', false, 0, 0, false, Order_Instant, "spiritwolf")
        call SetLastObjectElement(Element_Arcane, 1)
        call SetLastObjectElement(Element_Wild, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //10 - Flame Strike 
        call SaveAbilData('AHfs', 'I005', false, 0, 0, true, Order_Point, "flamestrike")
        call SetLastObjectElement(Element_Fire, 2)

        //11 - Forked Lightning 
        call SaveAbilData('ANfl', 'I001', false, 0, 0, true, Order_Target, "forkedlightning")
        call SetLastObjectElement(Element_Wind, 1)

        //12 - Frost Nova 
        call SaveAbilData('AUfn', 'I00C', false, 0, 0, true, Order_Target, "frostnova")
        call SetLastObjectElement(Element_Water, 1)
        call SetLastObjectElement(Element_Cold, 1)

        //13 - Incinerate 
        call SaveAbilData('A06M', 'I045', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Fire, 1)

        //14 - Holy Light 
        call SaveAbilData('AHhb', 'I00D', false, 1, 0, true, Order_Target, "holybolt")
        call SetLastObjectElement(Element_Light, 1)

        //15 - Impale 
        call SaveAbilData('AUim', 'I006', false, 0, 0, true, Order_Point, "impale")
        call SetLastObjectElement(Element_Earth, 1)
        call SetLastObjectElement(Element_Dark, 1)

        //16 - Serpent Ward 
        call SaveAbilData(SERPANT_WARD_ABILITY_ID, 'I00E', false, 0, 0, false, Order_Point, "ward")
        call SetLastObjectElement(Element_Arcane, 1)
        call SetLastObjectElement(Element_Wild, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //17 - Shadow Strike 
        call SaveAbilData('AEsh', 'I00F', false, 0, 0, true, Order_Target, "shadowstrike")
        call SetLastObjectElement(Element_Poison, 1)

        //18 - Thorns Aura 
        call SaveAbilData('A08F', 'I00H', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Earth, 1)
        call SetLastObjectElement(Element_Wild, 1)

        //19 - Thunder Clap 
        call SaveAbilData('AHtc', 'I00I', false, 0, 0, true, Order_Instant, "thunderclap")
        call SetLastObjectElement(Element_Wind, 1)
        call SetLastObjectElement(Element_Earth, 1)

        //20 - Unholy Aura 
        call SaveAbilData('AUau', 'I007', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Dark, 1)

        //21 - Vampirism 
        call SaveAbilData('AUav', 'I00J', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Blood, 1)

        //22 - War Stomp 
        call SaveAbilData('AOws', 'I00K', false, 0, 0, true, Order_Instant, "stomp")
        call SetLastObjectElement(Element_Earth, 1)
        call SetLastObjectElement(Element_Energy, 1)

        //23 - Life Drain 
        call SaveAbilData(LIFE_DRAIN_ABILITY_ID, 'I00M', false, 0, 0, true, Order_Target, "drain")
        call SetLastObjectElement(Element_Dark, 1)

        //24 - Cleaving Attack 
        call SaveAbilData('ANca', 'I00N', false, 0, 0, false, Order_None, null)

        //25 - Spiked Carapace 
        call SaveAbilData('AUts', 'I00O', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Dark, 1)

        //26 - Entangling Roots 
        call SaveAbilData(ENTAGLING_ROOTS_ABILITY_ID, 'I00Q', false, 0, 1, true, Order_Target, "entanglingroots")
        call SetLastObjectElement(Element_Earth, 1)
        call SetLastObjectElement(Element_Wild, 1)

        //27 - Summon Water Elemental 
        call SaveAbilData(SUMMON_WATER_ELEMENTAL_ABILITY_ID, 'I00S', false, 0, 0, false, Order_Instant, "waterelemental")
        call SetLastObjectElement(Element_Water, 1)
        call SetLastObjectElement(Element_Wild, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //28 - Shockwave 
        call SaveAbilData(SHOCKWAVE_ABILITY_ID, 'I00R', false, 0, 0, true, Order_Point, "shockwave")
        call SetLastObjectElement(Element_Earth, 2)
        call SetLastObjectElement(Element_Light, 1)

        //29 - Summon Lava Spawn 
        call SaveAbilData(SUMMON_LAVA_SPAWN_ABILITY_ID, 'I00T', false, 0, 0, false, Order_Instant, "lavamonster")
        call SetLastObjectElement(Element_Fire, 1)
        call SetLastObjectElement(Element_Wild, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //30 - Drain Aura 
        call SaveAbilData('A023', 'I04H', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastObjectElement(Element_Blood, 1)

        //31 - Trueshot Aura 
        call SaveAbilData('AEar', 'I00W', false, 0, 0, false, Order_None, null)

        //32 - Activate Immolation 
        call SaveAbilData(IMMOLATION_ABILITY_ID, 'I00V', false, 0, 0, false, Order_None, "immolation")
        call SetLastObjectElement(Element_Fire, 2)

        //33 - Storm Bolt 
        call SaveAbilData(STORM_BOLT_ABILITY_ID, 'I00X', false, 0, 0, true, Order_Target, "thunderbolt")
        call SetLastObjectElement(Element_Wind, 1)
        call SetLastObjectElement(Element_Energy, 1)

        //34 - Mirror Image 
        call SaveAbilData(MIRROR_IMAGE_ABILITY_ID, 'I00Z', false, 0, 0, false, Order_None, "mirrorimage")
        call SetLastObjectElement(Element_Arcane, 1)

        //35 - Chain Lightning 
        call SaveAbilData('AOcl', 'I010', false, 0, 0, true, Order_Target, "chainlightning")
        call SetLastObjectElement(Element_Wind, 1)

        //36 - Tranquility 
        call SaveAbilData('A09Y', 'I042', false, 0, 0, true, Order_Instant, "tranquility")
        call SetLastObjectElement(Element_Wild, 2)
        call SetLastObjectElement(Element_Light, 1)
        call SaveDummyAbilOrder('AEtq', "tranquility")

        //37 - Cluster Rockets 
        call SaveAbilData(CLUSTER_ROCKETS_ABILITY_ID, 'I01A', false, 0, 0, true, Order_Point, "clusterrockets")
        call SaveDummyAbilOrder('ANcs', "clusterrockets")

        //38 - Wind Walk 
        call SaveAbilData('AOwk', 'I01R', false, 0, 0, false, Order_None, "windwalk")
        call SetLastObjectElement(Element_Wind, 1)

        //39 - Drunken Haze 
        call SaveAbilData('ANdh', 'I01S', false, 0, 1, true, Order_Target, "drunkenhaze")
        call SetLastObjectElement(Element_Poison, 2)

        //40 - Breath of Fire 
        call SaveAbilData('ANbf', 'I01T', false, 0, 0, true, Order_Point, "breathoffire")
        call SetLastObjectElement(Element_Fire, 1)

        //41 - Whirlwind 
        call SaveAbilData('A025', 'I02B', false, 0, 0, true, Order_Instant, "creepthunderclap")
        call SetLastObjectElement(Element_Wind, 1)

        //42 - Reset Time 
        call SaveAbilData('A024', 'I04I', false, 0, 0, false, Order_Instant, "scout")
        call SetLastObjectElement(Element_Arcane, 1)

        //43 - Acid Bomb 
        call SaveAbilData('ANab', 'I01Z', false, 0, 1, true, Order_Target, "acidbomb")
        call SetLastObjectElement(Element_Poison, 1)

        //44 - Starfall 
        call SaveAbilData('A0A1', 'I01Y', false, 0, 0, true, Order_Instant, "starfall")
        call SetLastObjectElement(Element_Energy, 1)
        call SetLastObjectElement(Element_Arcane, 1)
        call SaveDummyAbilOrder('AEsf', "starfall")

        //45 - Anti-magic shell
        call SaveAbilData('Aam2', 'I03S', false, 1, 1, true, Order_Target, "antimagicshell")
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastObjectElement(Element_Arcane, 1)

        //45 - SpiritLink
        call SaveAbilData(SPIRIT_LINK_ABILITY_ID, 'I035', false, 1, 1, true, Order_Target, "spirtlink")
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastObjectElement(Element_Arcane, 1)

        //46 - Frost Armor 
        call SaveAbilData('AUfu', 'I01W', false, 1, 1, true, Order_Target, "frostarmor")
        call SetLastObjectElement(Element_Water, 1)
        call SetLastObjectElement(Element_Cold, 1)

        //47 - Blizzard 
        call SaveAbilData('A09U', 'I024', false, 0, 0, true, Order_Point, "blizzard")
        call SetLastObjectElement(Element_Water, 2)
        call SetLastObjectElement(Element_Cold, 2)
        call SaveDummyAbilOrder('AHbz', "blizzard")

        //48 - Rain of Fire 
        call SaveAbilData('A09V', 'I025', false, 0, 0, true, Order_Point, "rainoffire")
        call SetLastObjectElement(Element_Fire, 1)
        call SaveDummyAbilOrder('ANrf', "rainoffire")

        //49 - Stampede 
        call SaveAbilData('A09W', 'I026', false, 0, 0, true, Order_Point, "uncorporealform")
        call SetLastObjectElement(Element_Wild, 1)
        call SaveDummyAbilOrder('ANst', "stampede")

        //50 - Howl of Terror 
        call SaveAbilData('ANht', 'I040', false, 0, 0, true, Order_Instant, "howlofterror")
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastObjectElement(Element_Cold, 1)

        //51 - Inferno 
        call SaveAbilData('AUin', 'I02A', false, 0, 0, false, Order_Point, "dreadlordinferno")
        call SetLastObjectElement(Element_Fire, 1)
        call SetLastObjectElement(Element_Earth, 1)
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //52 - Healing Wave 
        call SaveAbilData('AOhw', 'I029', false, 1, 0, true, Order_Target, "healingwave")
        call SetLastObjectElement(Element_Light, 1)

        //53 - Banish 
        call SaveAbilData('AHbn', 'I02C', false, 0, 1, true, Order_Target, "banish")
        call SetLastObjectElement(Element_Arcane, 1)

        //54 - Acid Spray 
        call SaveAbilData('A0B3', 'I028', false, 0, 0, true, Order_Point, "healingspray")
        call SetLastObjectElement(Element_Poison, 1)
        call SaveDummyAbilOrder('ANhs', "healingspray")

        //55 - Activate Avatar 
        call SaveAbilData('A0AE', 'I027', false, 0, 0, false, Order_None, "avatar")
        call SetLastObjectElement(Element_Earth, 1)
        call SetLastObjectElement(Element_Energy, 1)

        //56 - Battle Roar 
        call SaveAbilData('ANbr', 'I02D', false, 1, 0, true, Order_Instant, "battleroar")
        call SetLastObjectElement(Element_Wild, 1)

        //57 - Death And Decay 
        call SaveAbilData('AUdd', 'I02E', false, 0, 0, true, Order_Point, "deathanddecay")
        call SetLastObjectElement(Element_Dark, 1)

        //58 - Summon Mountain Giant 
        call SaveAbilData(SUMMON_MOUNTAIN_GIANT_ABILITY_ID, 'I03Y', false, 0, 0, false, Order_Instant, "spiritofvengeance")
        call SetLastObjectElement(Element_Earth, 1)
        call SetLastObjectElement(Element_Wild, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //59 - Bloodlust 
        call SaveAbilData('Ablo', 'I02F', false, 1, 1, true, Order_Target, "bloodlust")
        call SetLastObjectElement(Element_Blood, 1)

        //60 - Pocket Factory 
        call SaveAbilData(POCKET_FACTORY_ABILITY_ID, 'I02G', false, 0, 0, false, Order_Point, "summonfactory")
        call SetLastObjectElement(Element_Summon, 1)

        //61 - Pulverize 
        call SaveAbilData('Awar', 'I02H', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Earth, 1)
        call SetLastObjectElement(Element_Energy, 1)

        //62 - Corrosive Skin 
        call SaveAbilData('A00Q', 'I02I', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Poison, 1)

        //63 - Carrion Beetles 
        call SaveAbilData(CARRION_BEETLES_ABILITY_ID, 'I02M', false, 0, 0, false, Order_Instant, "carrionscarabsinstant")
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //64 - War Drums 
        call SaveAbilData('Aakb', 'I002', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Energy, 1)

        //65 - Hardened Skin 
        call SaveAbilData('Assk', 'I02O', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Earth, 1)

        //66 - Searing Arrows 
        call SaveAbilData('AHfa', 'I02P', false, 0, 0, false, Order_None, "flamingarrows")
        call SetLastObjectElement(Element_Fire, 1)

        //67 - Necromancer's Army 
        call SaveAbilData('A0B0', 'I02Q', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //68 - Black Arrow 
        call SaveAbilData(BLACK_ARROW_PASSIVE_ABILITY_ID, 'I02R', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //69 - Cold Arrows 
        call SaveAbilData('AHca', 'I02S', false, 0, 0, false, Order_None, "coldarrows")
        call SetLastObjectElement(Element_Cold, 1)

        //70 - Faerie Fire 
        call SaveAbilData('Afae', 'I02T', false, 0, 1, true, Order_Target, "faeriefire")
        call SetLastObjectElement(Element_Fire, 1)
        call SetLastObjectElement(Element_Wild, 1)

        //71 - Parasite 
        call SaveAbilData(PARASITE_ABILITY_ID, 'I02U', false, 0, 1, true, Order_Target, "parasite")
        call SetLastObjectElement(Element_Poison, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //72 - Curse 
        call SaveAbilData('Acrs', 'I02V', false, 0, 1, true, Order_Target, "curse")
        call SetLastObjectElement(Element_Dark, 1)

        //73 - Inner Fire 
        call SaveAbilData('Ainf', 'I02W', false, 1, 1, true, Order_Target, "innerfire")
        call SetLastObjectElement(Element_Fire, 1)
        call SetLastObjectElement(Element_Light, 1)

        //74 - Command Aura 
        call SaveAbilData('ACac', 'I02X', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Energy, 1)

        //75 - Devastating Blow 
        call SaveAbilData('A050', 'I03X', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Fire, 1)

        //76 - Summon Hawk 
        call SaveAbilData(SUMMON_HAWK_ABILITY_ID, 'I02Z', false, 0, 0, false, Order_Instant, "summonwareagle")
        call SetLastObjectElement(Element_Wild, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //77 - Summon Bear 
        call SaveAbilData(SUMMON_BEAR_ABILITY_ID, 'I030', false, 0, 0, false, Order_Instant, "summongrizzly")
        call SetLastObjectElement(Element_Wild, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //78 - Summon Quilbeast 
        call SaveAbilData(SUMMON_QUILBEAST_ABILITY_ID, 'I031', false, 0, 0, false, Order_Instant, "summonquillbeast")
        call SetLastObjectElement(Element_Wild, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //79 - Phoenix 
        call SaveAbilData(PHEONIX_ABILITY_ID, 'I032', false, 0, 0, false, Order_Instant, "summonphoenix")
        call SetLastObjectElement(Element_Fire, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //80 - Healing Ward 
        call SaveAbilData('Ahwd', 'I033', false, 0, 0, true, Order_Point, "healingward")
        call SetLastObjectElement(Element_Light, 2)

        //81 - Unholy Frenzy 
        call SaveAbilData(UNHOLY_FRENZY_ABILITY_ID, 'I034', false, 0, 1, true, Order_Target, "unholyfrenzy")
        call SetLastObjectElement(Element_Dark, 1)

        //82 - Berserk 
        call SaveAbilData('Absk', 'I036', false, 0, 0, false, Order_None, "berserk")
        call SetLastObjectElement(Element_Blood, 1)

        //83 - Rejuvenation 
        call SaveAbilData('Arej', 'I037', false, 1, 1, true, Order_Target, "rejuvination")
        call SetLastObjectElement(Element_Wild, 1)
        call SetLastObjectElement(Element_Light, 1)

        //84 - Lightning Shield 
        call SaveAbilData(LIGHTNING_SHIELD_ABILITY_ID, 'I038', false, 0, 1, false, Order_None, "lightningshield")
        call SetLastObjectElement(Element_Wind, 2)

        //85 - Volcano 
        call SaveAbilData(VOLCANO_ABILITY_ID, 'I039', false, 0, 0, true, Order_Point, "volcano")
        call SetLastObjectElement(Element_Fire, 1)
        call SetLastObjectElement(Element_Earth, 1)
        call SaveDummyAbilOrder('ANvc', "volcano")

        //86 - Ensnare 
        call SaveAbilData('ANen', 'I03A', false, 0, 1, true, Order_Target, "ensnare")

        //87 - Liquid Fire 
        call SaveAbilData('A06Q', 'I03B', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Fire, 1)

        //88 - Plague 
        call SaveAbilData(PLAGUE_ABILITY_ID, 'I03V', false, 0, 0, true, Order_Point, "channel")
        call SetLastObjectElement(Element_Poison, 2)

        //89 - Pillage 
        call SaveAbilData('Asal', 'I03D', false, 0, 0, false, Order_None, null)

        //90 - Envenomed Weapons 
        call SaveAbilData('A06O', 'I03E', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Poison, 1)

        //91 - Multishot 
        call SaveAbilData('Aroc', 'I03N', false, 0, 0, false, Order_None, null)

        //92 - Slow Aura 
        call SaveAbilData('AOr2', 'I03G', false, 0, 0, false, Order_None, null)

        //93 - Blink 
        call SaveAbilData('AEbl', 'I03M', false, 0, 0, false, Order_None, "blink")

        //94 - Phase Shift 
        call SaveAbilData('Apsh', 'I03U', false, 0, 0, false, Order_None, "phaseshiftinstant")

        //95 - Finger of Death 
        call SaveAbilData('Afod', 'I03Q', false, 0, 0, true, Order_Target, "fingerofdeath")
        call SetLastObjectElement(Element_Dark, 1)

        //96 - Aura of immortality 
        call SaveAbilData('A02L', 'I04X', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Light, 1)

        //97 - Aura of Fear 
        call SaveAbilData('A02K', 'I04Y', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastObjectElement(Element_Blood, 1)

        //98 - Aura of Vulnerability 
        call SaveAbilData('A02M', 'I04Z', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Dark, 1)

        //99 - Finishing Blow 
        call SaveAbilData('A02N', 'I050', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Blood, 1)

        //100 - Mega Speed 
        call SaveAbilData('A02O', 'I051', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Wind, 1)

        //101 - Thunder Force 
        call SaveAbilData('A02S', 'I053', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Wind, 1)

        //102 - Air Force 
        call SaveAbilData('A02T', 'I054', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Wind, 1)

        //103 - Fire Force 
        call SaveAbilData('A02U', 'I055', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Fire, 1)

        //104 - Learnability 
        call SaveAbilData('A02W', 'I056', false, 0, 0, false, Order_None, null)

        //105 - Mana Bonus 
        call SaveAbilData('A02X', 'I057', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Water, 1)
        call SetLastObjectElement(Element_Energy, 1)

        //106 - Power of Ice 
        call SaveAbilData('A02Z', 'I058', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Water, 1)
        call SetLastObjectElement(Element_Cold, 1)

        //107 - Brilliance Aura 
        call SaveAbilData('AHab', 'I00U', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Water, 1)

        //108 - Fast Magic 
        call SaveAbilData('A03P', 'I05M', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Arcane, 1)

        //109 - Hero Buff 
        call SaveAbilData('A03Q', 'I05N', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Light, 1)

        //110 - Temporary Invisibility 
        call SaveAbilData('A03U', 'I05O', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Wind, 1)

        //111 - Rapid Recovery 
        call SaveAbilData('A03X', 'I05P', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Light, 1)

        //112 - Сhronus Wizard 
        call SaveAbilData('A03Y', 'I05Q', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Arcane, 1)
        //call SetLastObjectElement(Element_Time, 1)

        //113 - Cheater Magic 
        call SaveAbilData('A040', 'I05R', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Energy, 1)
        call SetLastObjectElement(Element_Arcane, 1)
        //call SetLastObjectElement(Element_Time, 1)

        //114 - Fearless Defenders 
        call SaveAbilData('A041', 'I05S', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Light, 1)

        //115 - Demon's Curse 
        call SaveAbilData('A042', 'I05T', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Dark, 1)

        //116 - Blessed Protection
        call SaveAbilData('A045', 'I05V', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Light, 1)

        //117 - Reincarnation 
        call SaveAbilData('ANr2', 'I00Y', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Energy, 1)
        call SetLastObjectElement(Element_Light, 1)

        //118 - Drunken Master 
        call SaveAbilData('Acdb', 'I05W', false, 0, 0, false, Order_None, null)

        //119 - Demolish 
        call SaveAbilData('ANde', 'I05X', false, 0, 0, false, Order_None, null)

        //120 - Destruction
        call SaveAbilData('ACpv', 'I05Y', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Energy, 1)

        //122 - Divine Shield 
        call SaveAbilData('AHds', 'I011', false, 0, 0, false, Order_None, "divineshield")
        call SetLastObjectElement(Element_Light, 1)

        //123 - Midas Touch 
        call SaveAbilData('A0A2', 'I00G', false, 0, 1, true, Order_Target, "transmute")

        //124 - Silence 
        call SaveAbilData('ANsi', 'I03C', false, 0, 1, true, Order_Point, "silence")
        call SetLastObjectElement(Element_Dark, 1)

        //125 - Stasis Trap 
        call SaveAbilData('Asta', 'I044', false, 0, 0, true, Order_Point, "stasistrap")
        call SetLastObjectElement(Element_Arcane, 1)

        //126 - Death Pact 
        call SaveAbilData('A00M', 'I01V', false, 0, 1, false, Order_Target, "deathpact")
        call SetLastObjectElement(Element_Dark, 2)

        //127 - Big Bad Voodoo 
        call SaveAbilData('AOvd', 'I03Z', false, 0, 0, false, Order_None, "voodoo")
        call SetLastObjectElement(Element_Arcane, 2)
        call SetLastObjectElement(Element_Dark, 2)

        //128 - Icy Breath 
        call SaveAbilData('A046', 'I05Z', false, 0, 1, true, Order_Point, "breathoffrost")
        call SetLastObjectElement(Element_Cold, 1)

        //129 - Soul Burn 
        call SaveAbilData('ANso', 'I062', false, 0, 1, true, Order_Target, "soulburn")
        call SetLastObjectElement(Element_Fire, 1)

        //130 - Fog 
        call SaveAbilData('A09Z', 'I063', false, 0, 1, true, Order_Point, "cloudoffog")
        call SetLastObjectElement(Element_Water, 1)
        call SetLastObjectElement(Element_Wind, 1)
        call SaveDummyAbilOrder('Aclf', "cloudoffog")

        //131 - Temporary Power 
        call SaveAbilData('A04E', 'I067', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Light, 1)

        //132 - Multicast 
        call SaveAbilData('A04F', 'I068', false, 0, 0, false, Order_None, null)

        //133 - Heavy Blow 
        call SaveAbilData('A04G', 'I069', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Light, 1)

        //134 - Combustion 
        call SaveAbilData('A04H', 'I06A', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Fire, 1)

        //135 - Holy Enlightenment 
        call SaveAbilData('A04K', 'I06C', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Light, 1)

        //136 - Chaos Magic 
        call SaveAbilData('A04L', 'I06D', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Fire, 1)
        call SetLastObjectElement(Element_Water, 1)
        call SetLastObjectElement(Element_Wind, 1)
        call SetLastObjectElement(Element_Earth, 1)
        call SetLastObjectElement(Element_Wild, 1)
        call SetLastObjectElement(Element_Energy, 1)
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastObjectElement(Element_Light, 1)
        call SetLastObjectElement(Element_Cold, 1)
        call SetLastObjectElement(Element_Poison, 1)
        call SetLastObjectElement(Element_Blood, 1)
        call SetLastObjectElement(Element_Arcane, 1)
        //call SetLastObjectElement(Element_Time, 1)

        //137 - Monsoon 
        call SaveAbilData('A0A0', 'I06G', false, 0, 0, true, Order_Point, "monsoon")
        call SetLastObjectElement(Element_Water, 2)
        call SetLastObjectElement(Element_Wind, 2)
        call SaveDummyAbilOrder('ANmo', "monsoon")

        //138 - Ice Armor 
        call SaveAbilData(ICE_ARMOR_ABILITY_ID, 'I06L', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Water, 1)
        call SetLastObjectElement(Element_Cold, 1)

        //139 - Last Breath 
        call SaveAbilData(LAST_BREATHS_ABILITY_ID, 'I07J', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastObjectElement(Element_Light, 1)

        //140 - Fire Shield 
        call SaveAbilData('A05S', 'I07L', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Fire, 1)

        //141 - Ancient Teaching 
        call SaveAbilData('A05U', 'I07N', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Arcane, 1)

        //142 - Cyclone 
        call SaveAbilData('A05X', 'I07Q', false, 0, 0, true, Order_Point, "creepanimatedead")
        call SetLastObjectElement(Element_Wind, 1)

        //143 - Mysterious Talent 
        call SaveAbilData('A05Z', 'I07R', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Energy, 1)
        call SetLastObjectElement(Element_Arcane, 1)

        //144 - Stone Protection 
        call SaveAbilData('A060', 'I07S', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Earth, 1)

        //145 - Cruelty 
        call SaveAbilData('A067', 'I07X', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Blood, 1)

        //146 - Reaction 
        call SaveAbilData('A06C', 'I07Z', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Wind, 1)

        //147 - Magic Critical Hit 
        call SaveAbilData('A06U', 'I081', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Energy, 1)
        call SetLastObjectElement(Element_Arcane, 1)

        //148 - Mega Luck 
        call SaveAbilData('A06V', 'I085', false, 0, 0, false, Order_None, null)

        //149 - Dousing Hex
        call SaveAbilData('A09I', 'I0AN', false, 0, 1, true, Order_Target, "ancestralspirittarget")
        call SetLastObjectElement(Element_Water, 1)

        //150 - Ancient Runes 
        call SaveAbilData('A09O', 'I08K', false, 0, 0, false, Order_Instant, "animatedead")
        call SetLastObjectElement(Element_Arcane, 1)

        //151 - Earthquake 
        call SaveAbilData('A07L', 'I094', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Earth, 1)

        //152 - Cold Wind 
        call SaveAbilData('A07N', 'I096', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Wind, 1)
        call SetLastObjectElement(Element_Cold, 1)

        //153 - Random Spell 
        call SaveAbilData('A07U', 'I09C', false, 0, 0, true, Order_Target, "slow")
        call SetLastObjectElement(Element_Fire, 1)
        call SetLastObjectElement(Element_Water, 1)
        call SetLastObjectElement(Element_Wind, 1)
        call SetLastObjectElement(Element_Earth, 1)
        call SetLastObjectElement(Element_Wild, 1)
        call SetLastObjectElement(Element_Energy, 1)
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastObjectElement(Element_Light, 1)
        call SetLastObjectElement(Element_Cold, 1)
        call SetLastObjectElement(Element_Poison, 1)
        call SetLastObjectElement(Element_Blood, 1)
        call SetLastObjectElement(Element_Arcane, 1)
        //call SetLastObjectElement(Element_Time, 1)

        //154 - Divine Bubble 
        call SaveAbilData('A07S', 'I09A', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Light, 1)

        //155 - Ancient Blood 
        call SaveAbilData('A07T', 'I09B', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Blood, 1)

        //156 - Frost Bolt 
        call SaveAbilData('A07X', 'I09G', false, 0, 0, true, Order_Target, "slowon")
        call SetLastObjectElement(Element_Water, 1)
        call SetLastObjectElement(Element_Dark, 1)
        call SetLastObjectElement(Element_Cold, 1)

        //157 - Frostbite of the Soul 
        call SaveAbilData('A080', 'I09H', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Cold, 1)
        call SetLastObjectElement(Element_Dark, 1)

        //158 - Cutting 
        call SaveAbilData(CUTTING_ABILITY_ID, 'I09I', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Blood, 1)

        //159 - Divine Gift 
        call SaveAbilData('A082', 'I09J', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Light, 1)

        //160 - Sand of Time 
        call SaveAbilData('A083', 'I09K', false, 0, 0, false, Order_Instant, "slowoff")
        call SetLastObjectElement(Element_Earth, 1)
        call SetLastObjectElement(Element_Arcane, 1)
        //call SetLastObjectElement(Element_Time, 1)

        //161 - Wizardbane Aura 
        call SaveAbilData('A088', 'I09M', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Energy, 1)
        call SetLastObjectElement(Element_Arcane, 1)

        //162 - Martial Retribution 
        call SaveAbilData('A089', 'I09L', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Energy, 1)

        //163 - Purge 
        call SaveAbilData('A08E', 'I09N', false, 0, 1, true, Order_Target, "purge")
        //call SetLastObjectElement(Element_Spirit, 1)
        call SetLastObjectElement(Element_Dark, 1)

        //164 - Blink Strike 
        call SaveAbilData('A08J', 'I09P', false, 0, 0, true, Order_Instant, "acolyteharvest")
        call SetLastObjectElement(Element_Wind, 1)
        call SetLastObjectElement(Element_Arcane, 1)

        //165 - Extradimensional Co-operation
        call SaveAbilData('A08I', 'I09Q', false, 0, 0, true, Order_Instant, "absorb")
        call SetLastObjectElement(Element_Arcane, 1)
        //call SetLastObjectElement(Element_Time, 1)
        //call SetLastObjectElement(Element_Spirit, 1)

        //166 - Reflection Aura
        call SaveAbilData('A093', 'I09S', false, 0, 0, false, Order_None, null)

        //167 - Arcane Assault
        call SaveAbilData('A098', 'I09Z', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Arcane, 1)

        //168 - Absolute Fire
        call SaveAbilData(ABSOLUTE_FIRE_ABILITY_ID, 'I08T', true, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Fire, 1)

        //169 - Absolute Water
        call SaveAbilData('A07C', 'I08U', true, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Water, 1)

        //170 - Absolute Wind
        call SaveAbilData('A07E', 'I08W', true, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Wind, 1)

        //171 - Absolute Earth
        call SaveAbilData('A07D', 'I08V', true, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Earth, 1)

        //172 - Absolute Wild
        call SaveAbilData('A07K', 'I093', true, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Wild, 1)
        call SetLastObjectElement(Element_Summon, 1)

        //173 - Absolute Dark
        call SaveAbilData('A07Q', 'I098', true, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Dark, 1)

        //174 - Absolute Light
        call SaveAbilData('A07P', 'I097', true, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Light, 1)

        //175 - Absolute Cold
        call SaveAbilData('A07V', 'I09F', true, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Cold, 1)

        //176 - Absolute Blood
        call SaveAbilData('A07R', 'I099', true, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Blood, 1)

        //177 - Absolute Arcane
        call SaveAbilData('A0AB', 'I0B2', true, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Arcane, 1)

        //178 - Absolute Poison
        call SaveAbilData('A0AC', 'I0B3', true, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Poison, 1)

        //179 - Mana Starvation
        call SaveAbilData('A09J', 'I0AO', false, 0, 0, true, Order_Target, "ancestralspirit")
        call SetLastObjectElement(Element_Water, 1)
        call SetLastObjectElement(Element_Dark, 1)

        //180 - Fatal Flaw
        call SaveAbilData('A0AA', 'I0B0', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Arcane, 1)

        //181 - Retaliation Aura
        call SaveAbilData('A0A9', 'I0B1', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Arcane, 1)

        //182 - Unlimited Agony
        call SaveAbilData('A0AQ', 'I0BB', false, 0, 0, false, Order_None, null)

        //183 - Time Manipulation
        call SaveAbilData('A0AS', 'I0BA', false, 0, 0, false, Order_None, null)
        call SetLastObjectElement(Element_Arcane, 1)
        call SetLastObjectElement(Element_Light, 1)

        //Unit and item elements
        call SetObjectElement(DOOM_GUARD_UNIT_ID, Element_Fire, 1)
        call SetObjectElement(PYROMANCER_UNIT_ID, Element_Fire, 1)
        call SetObjectElement(PIT_LORD_UNIT_ID, Element_Fire, 1)
        call SetObjectElement(WITCH_DOCTOR_UNIT_ID, Element_Water, 1)
        call SetObjectElement(LICH_UNIT_ID, Element_Water, 1)
        call SetObjectElement(NAHA_SIREN_UNIT_ID, Element_Water, 1)
        call SetObjectElement(BLOOD_MAGE_UNIT_ID, Element_Water, 1)
        call SetObjectElement(SORCERER_UNIT_ID, Element_Wind, 1)
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
        call SetObjectElement(CENTAUR_ARCHER_UNIT_ID, Element_Energy, 1)
        call SetObjectElement(SEER_UNIT_ID, Element_Energy, 1)
        call SetObjectElement(GRUNT_UNIT_ID, Element_Energy, 1)
        call SetObjectElement(DARK_HUNTER_UNIT_ID, Element_Energy, 1)
        call SetObjectElement(MEDIVH_UNIT_ID, Element_Energy, 1)
        call SetObjectElement(TAUREN_UNIT_ID, Element_Energy, 1)
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
        call SetObjectElement(ABOMINATION_UNIT_ID, Element_Poison, 1)


        /*
        call SaveAbilData('Aclf', 'I063')

        call SaveAbilData('A08E',"purge",1,1)
        call SaveAbilData('ANtm',"transmute",1,1)
        call SaveAbilData('Aclf',"cloudoffog",2,0)
        call SaveAbilData(STORM_BOLT_ABILITY_ID,"thunderbolt",1,0)
        call SaveAbilData('AHbn',"banish",1,1)
        call SaveAbilData('AHfs',"flamestrike",2,0)
        call SaveAbilData(SUMMON_WATER_ELEMENTAL_ABILITY_ID,"waterelemental",3,0)
        call SaveAbilData('AHtc',"thunderclap",3,0)
        call SaveAbilData('AHhb',"holybolt",1,0)
        call SaveAbilData('AHbz',"blizzard",2,0)   
        call SaveAbilData(PHEONIX_ABILITY_ID,"summonphoenix",3,0)  
        call SaveAbilData('Ainf',"innerfire",1,1)
    
    
        call SaveAbilData('AOww',"whirlwind",3,0)
        call SaveAbilData('AOhw',"healingwave",1,0)
        call SaveAbilData('AOws',"stomp",3,0)
        call SaveAbilData('AOls',"Locustswarm",3,0)
        call SaveAbilData(SERPANT_WARD_ABILITY_ID,"ward",2,0)
        call SaveAbilData('AOhx',"hex",3,1)
        call SaveAbilData('AOvd',"voodoo",3,0)
        call SaveAbilData('AOwk',"windwalk",3,0)
        call SaveAbilData(SHOCKWAVE_ABILITY_ID,"shockwave",2,0)
        call SaveAbilData('AOcl',"chainlightning",1,0)
        call SaveAbilData('Absk',"berserk",3,0)
        call SaveAbilData('Aspl',"spiritlink",1,1)
        call SaveAbilData('Ablo',"bloodlust",1,1)
        call SaveAbilData('Ahwd',"healingward",2,0)
        call SaveAbilData('Asta',"stasistrap",2,0)   
        
        
        
        call SaveAbilData('AUfn',"frostnova",1,0)  
        call SaveAbilData(CARRION_BEETLES_ABILITY_ID,"Carrionscarabs",3,0)
        call SaveAbilData('AUin',"dreadlordinferno",2,0)
        call SaveAbilData('AUfu',"frostarmor",1,1)
        call SaveAbilData('AUim',"impale",2,0)
        call SaveAbilData('AUdp',"deathpact",1,1)
        call SaveAbilData('AUdd',"deathanddecay",2,0)
        call SaveAbilData('AUcs',"carrionswarm",2,0)
        call SaveAbilData('Aam2',"antimagicshell",1,1)
        call SaveAbilData(RAISE_DEAD_ABILITY_ID,"raisedead",3,0)
        call SaveAbilData(UNHOLY_FRENZY_ABILITY_ID,"unholyfrenzy",1,1)
        call SaveAbilData('Acrs',"curse",1,1)
    
        
        
        call SaveAbilData(SUMMON_MOUNTAIN_GIANT_ABILITY_ID,"spiritofvengeance",3,0)       
        call SaveAbilData('AEfk',"fanofknives",3,0)
        call SaveAbilData(ENTAGLING_ROOTS_ABILITY_ID,"entanglingroots",1,1)
        call SaveAbilData('AEsf',"starfall",3,0)
        call SaveAbilData(IMMOLATION_ABILITY_ID,"immolation",3,0)
        call SaveAbilData('AHfa',"flamingarrows",1,0)
        call SaveAbilData('AEtq',"tranquility",3,0)   
        call SaveAbilData('AEsh',"shadowstrike",1,0)       
        call SaveAbilData('Afae',"faeriefire",1,1)
        call SaveAbilData('Arej',"rejuvination",1,1)
        
        
        
        call SaveAbilData('ANhs',"healingspray",2,0)
        call SaveAbilData('ANbr',"battleroar",3,0)
        call SaveAbilData('ANvc',"volcano",2,0)
        call SaveAbilData('ANst',"stampede",2,0) 
        call SaveAbilData('ANcs',"clusterrockets",2,0)       
        call SaveAbilData('ANab',"acidbomb",1,1)
        call SaveAbilData('ANsi',"silence",2,0)
        call SaveAbilData('ANrf',"rainoffire",2,0)
        call SaveAbilData('ANbf',"breathoffire",2,0)
        call SaveAbilData(POCKET_FACTORY_ABILITY_ID,"summonfactory",2,0)
        
        
        call SaveAbilData(SUMMON_QUILBEAST_ABILITY_ID,"summonquillbeast",3,0)    
        call SaveAbilData(SUMMON_BEAR_ABILITY_ID,"summongrizzly",3,0)  
        call SaveAbilData(SUMMON_LAVA_SPAWN_ABILITY_ID,"slimemonster",3,0)  
        call SaveAbilData(SUMMON_HAWK_ABILITY_ID,"summonwareagle",3,0)  
        call SaveAbilData('ANfl',"forkedlightning",1,0)  
        call SaveAbilData('ANso',"soulburn",1,1)  
        call SaveAbilData(LIGHTNING_SHIELD_ABILITY_ID,"lightningshield",1,0)  

        call SaveAbilData('ANdh',"drunkenhaze",1,1)    
        call SaveAbilData('A046',"breathoffrost",2,0)  
        call SaveAbilData(PARASITE_ABILITY_ID,"parasite",1,1)  
        call SaveAbilData('ANen',"ensnare",1,1)
        call SaveAbilData('ANht',"howlofterror",3,0)  

        call SaveAbilData('ANmo',"monsoon",2,0)
        call SaveAbilData(FERAL_SPIRIT_ABILITY_ID,"spiritwolf",3,0) 
        
        call SaveAbilData('A05X',"channel",2,0)
        call SaveAbilData(PLAGUE_ABILITY_ID,"channel",2,0) 
        call SaveAbilData('ANsi',"silence",2,0) 
        */
    endfunction 

    function InitCreepAbilities takes nothing returns nothing
        //Hurl Boulder
        call SaveCreepAbilityData('A00W', Target_Enemy, Order_Target, "creepthunderbolt")

        //Rejuvenation
        call SaveCreepAbilityData('A00X', Target_Ally, Order_Target, "rejuvination")

        //Faerie Fire
        call SaveCreepAbilityData('A016', Target_Enemy, Order_Target, "faeriefire")

        //Mana Burn
        call SaveCreepAbilityData('A00V', Target_Enemy, Order_Target, "manaburn")

        //Shockwave
        call SaveCreepAbilityData('A00U', Target_Enemy, Order_Point, "shockwave")

        //Thunder Clap
        call SaveCreepAbilityData('A01B', Target_Enemy, Order_Instant, "thunderclap")
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
endfunction
endlibrary

