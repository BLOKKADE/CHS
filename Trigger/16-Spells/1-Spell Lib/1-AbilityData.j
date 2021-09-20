library AbilityData initializer init requires Table
    globals

        Table AbilityIndex
        HashTable ChaosDataEnemy
        HashTable ChaosDataAlly
        HashTable ChaosData
        HashTable AbilityData
        Table ItemData
        HashTable ElementData
        /*
        hashtable HT_AbilityData  = InitHashtable()
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
        integer Element_Divine = 12
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
        return ElementData[element].boolean[objectId]
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
    function GetAbilityTargetType takes integer abilId returns boolean
        return AbilityData[abilId].boolean[5]
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
        set ItemData[itemId] = abilId

        set AbilityData[abilId].integer[0] = itemId
        set AbilityData[abilId].integer[1] = OrderId(order)
        set AbilityData[abilId].integer[2] = typ
        set AbilityData[abilId].integer[3] = mono
        set AbilityData[abilId].boolean[5] = targetType == 1

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
                set index = ChaosData[typ].integer[0] + 1
                set ChaosData[typ].integer[index] = abilId
                set ChaosData[typ].integer[0] = index
            endif
        endif
    endfunction

    function SaveDummyAbilOrder takes integer abilId, string order returns nothing
        set AbilityData[abilId].integer[1] = OrderId(order)
    endfunction

    function SetObjectElement takes integer objectId, integer element returns nothing
        set ElementData[element].boolean[objectId] = true
    endfunction

    function InitDataA1 takes nothing returns nothing
        //1 - Bash 
        call SaveAbilData('A06S', 'I00L', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A06S', Element_Energy)

        //2 - Mana Shield 
        call SaveAbilData('ANms', 'I03F', false, 0, 0, false, Order_None, "manashieldon")
        call SetObjectElement('ANms', Element_Water)

        //3 - Carrion Swarm 
        call SaveAbilData('AUcs', 'I008', false, 0, 0, true, Order_Point, "carrionswarm")
        call SetObjectElement('AUcs', Element_Dark)

        //4 - Critical Strike 
        call SaveAbilData('AOcr', 'I00B', false, 0, 0, false, Order_None, null)
        call SetObjectElement('AOcr', Element_Blood)

        //5 - Devotion Aura 
        call SaveAbilData('AHad', 'I009', false, 0, 0, false, Order_None, null)
        call SetObjectElement('AHad', Element_Light)

        //6 - Endurance Aura 
        call SaveAbilData('AOae', 'I000', false, 0, 0, false, Order_None, null)

        //7 - Evasion 
        call SaveAbilData('AEev', 'I00A', false, 0, 0, false, Order_None, null)
        call SetObjectElement('AEev', Element_Wind)

        //8 - Fan of Knives 
        call SaveAbilData('AEfk', 'I003', false, 0, 0, true, Order_Instant, "fanofknives")

        //9 - Feral Spirit 
        call SaveAbilData('AOsf', 'I004', false, 0, 0, false, Order_Instant, "spiritwolf")
        call SetObjectElement('AOsf', Element_Spirit)

        //10 - Flame Strike 
        call SaveAbilData('AHfs', 'I005', false, 0, 0, true, Order_Point, "flamestrike")
        call SetObjectElement('AHfs', Element_Fire)

        //11 - Forked Lightning 
        call SaveAbilData('ANfl', 'I001', false, 0, 0, true, Order_Target, "forkedlightning")
        call SetObjectElement('ANfl', Element_Wind)

        //12 - Frost Nova 
        call SaveAbilData('AUfn', 'I00C', false, 0, 0, true, Order_Target, "frostnova")
        call SetObjectElement('AUfn', Element_Water)
        call SetObjectElement('AUfn', Element_Cold)

        //13 - Incinerate 
        call SaveAbilData('A06M', 'I045', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A06M', Element_Fire)

        //14 - Holy Light 
        call SaveAbilData('AHhb', 'I00D', false, 1, 0, true, Order_Target, "holybolt")
        call SetObjectElement('AHhb', Element_Light)

        //15 - Impale 
        call SaveAbilData('AUim', 'I006', false, 0, 0, true, Order_Point, "impale")
        call SetObjectElement('AUim', Element_Earth)
        call SetObjectElement('AUim', Element_Dark)

        //16 - Serpent Ward 
        call SaveAbilData('AOsw', 'I00E', false, 0, 0, false, Order_Point, "ward")
        call SetObjectElement('AOsw', Element_Spirit)

        //17 - Shadow Strike 
        call SaveAbilData('AEsh', 'I00F', false, 0, 0, true, Order_Target, "shadowstrike")
        call SetObjectElement('AEsh', Element_Poison)

        //18 - Thorns Aura 
        call SaveAbilData('A08F', 'I00H', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A08F', Element_Earth)
        call SetObjectElement('A08F', Element_Wild)

        //19 - Thunder Clap 
        call SaveAbilData('AHtc', 'I00I', false, 0, 0, true, Order_Instant, "thunderclap")
        call SetObjectElement('AHtc', Element_Wind)
        call SetObjectElement('AHtc', Element_Wind)
        call SetObjectElement('AHtc', Element_Earth)

        //20 - Unholy Aura 
        call SaveAbilData('AUau', 'I007', false, 0, 0, false, Order_None, null)
        call SetObjectElement('AUau', Element_Dark)

        //21 - Vampirism 
        call SaveAbilData('AUav', 'I00J', false, 0, 0, false, Order_None, null)
        call SetObjectElement('AUav', Element_Blood)

        //22 - War Stomp 
        call SaveAbilData('AOws', 'I00K', false, 0, 0, true, Order_Instant, "stomp")
        call SetObjectElement('AOws', Element_Earth)
        call SetObjectElement('AOws', Element_Energy)

        //23 - Life Drain 
        call SaveAbilData('ANdr', 'I00M', false, 0, 0, true, Order_Target, "drain")
        call SetObjectElement('ANdr', Element_Dark)

        //24 - Cleaving Attack 
        call SaveAbilData('ANca', 'I00N', false, 0, 0, false, Order_None, null)

        //25 - Spiked Carapace 
        call SaveAbilData('AUts', 'I00O', false, 0, 0, false, Order_None, null)
        call SetObjectElement('AUts', Element_Dark)

        //26 - Entangling Roots 
        call SaveAbilData('AEer', 'I00Q', false, 0, 1, true, Order_Target, "entanglingroots")
        call SetObjectElement('AEer', Element_Earth)
        call SetObjectElement('AEer', Element_Wild)

        //27 - Summon Water Elemental 
        call SaveAbilData('AHwe', 'I00S', false, 0, 0, false, Order_Instant, "waterelemental")
        call SetObjectElement('AHwe', Element_Water)

        //28 - Shockwave 
        call SaveAbilData('AOsh', 'I00R', false, 0, 0, true, Order_Point, "shockwave")
        call SetObjectElement('AOsh', Element_Earth)
        call SetObjectElement('AOsh', Element_Energy)

        //29 - Summon Lava Spawn 
        call SaveAbilData('ANlm', 'I00T', false, 0, 0, false, Order_Instant, "slimemonster")
        call SetObjectElement('ANlm', Element_Fire)

        //30 - Drain Aura 
        call SaveAbilData('A023', 'I04H', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A023', Element_Dark)
        call SetObjectElement('A023', Element_Blood)

        //31 - Trueshot Aura 
        call SaveAbilData('AEar', 'I00W', false, 0, 0, false, Order_None, null)

        //32 - Activate Immolation 
        call SaveAbilData('AEim', 'I00V', false, 0, 0, false, Order_None, "immolation")
        call SetObjectElement('AEim', Element_Fire)

        //33 - Storm Bolt 
        call SaveAbilData('AHtb', 'I00X', false, 0, 0, true, Order_Target, "thunderbolt")
        call SetObjectElement('AHtb', Element_Wind)
        call SetObjectElement('AHtb', Element_Energy)

        //34 - Mirror Image 
        call SaveAbilData('AOmi', 'I00Z', false, 0, 0, false, Order_None, "mirrorimage")
        call SetObjectElement('AOmi', Element_Spirit)

        //35 - Chain Lightning 
        call SaveAbilData('AOcl', 'I010', false, 0, 0, true, Order_Target, "chainlightning")
        call SetObjectElement('AOcl', Element_Wind)

        //36 - Tranquility 
        call SaveAbilData('A09Y', 'I042', false, 0, 0, true, Order_Instant, "tranquility")
        call SetObjectElement('A09Y', Element_Wild)
        call SetObjectElement('A09Y', Element_Light)
        call SaveDummyAbilOrder('AEtq', "tranquility")

        //37 - Cluster Rockets 
        call SaveAbilData('ANcs', 'I01A', false, 0, 0, true, Order_Point, "clusterrockets")

        //38 - Wind Walk 
        call SaveAbilData('AOwk', 'I01R', false, 0, 0, false, Order_None, "windwalk")
        call SetObjectElement('AOwk', Element_Wind)

        //39 - Drunken Haze 
        call SaveAbilData('ANdh', 'I01S', false, 0, 1, true, Order_Target, "drunkenhaze")
        call SetObjectElement('ANdh', Element_Poison)

        //40 - Breath of Fire 
        call SaveAbilData('ANbf', 'I01T', false, 0, 0, true, Order_Point, "breathoffire")
        call SetObjectElement('ANbf', Element_Fire)

        //41 - Whirlwind 
        call SaveAbilData('A025', 'I02B', false, 0, 0, true, Order_Instant, "creepthunderclap")
        call SetObjectElement('A025', Element_Wind)

        //42 - Reset Time 
        call SaveAbilData('A024', 'I04I', false, 0, 0, true, Order_Instant, "scout")
        call SetObjectElement('A024', Element_Time)

        //43 - Acid Bomb 
        call SaveAbilData('ANab', 'I01Z', false, 0, 1, true, Order_Target, "acidbomb")
        call SetObjectElement('ANab', Element_Poison)

        //44 - Starfall 
        call SaveAbilData('A0A1', 'I01Y', false, 0, 0, true, Order_Instant, "starfall")
        call SetObjectElement('A0A1', Element_Energy)
        call SaveDummyAbilOrder('AEsf', "starfall")

        //45 - Anti-magic shell
        call SaveAbilData('Aam2', 'I03S', false, 1, 1, true, Order_Target, "antimagicshell")
        call SetObjectElement('Aam2', Element_Dark)
        call SetObjectElement('Aam2', Element_Spirit)

        //46 - Frost Armor 
        call SaveAbilData('AUfu', 'I01W', false, 1, 1, true, Order_Target, "frostarmor")
        call SetObjectElement('AUfu', Element_Water)
        call SetObjectElement('AUfu', Element_Cold)

        //47 - Blizzard 
        call SaveAbilData('A09U', 'I024', false, 0, 0, true, Order_Point, "blizzard")
        call SetObjectElement('A09U', Element_Water)
        call SetObjectElement('A09U', Element_Cold)
        call SaveDummyAbilOrder('AHbz', "blizzard")

        //48 - Rain of Fire 
        call SaveAbilData('A09V', 'I025', false, 0, 0, true, Order_Point, "rainoffire")
        call SetObjectElement('A09V', Element_Fire)
        call SaveDummyAbilOrder('ANrf', "rainoffire")

        //49 - Stampede 
        call SaveAbilData('A09W', 'I026', false, 0, 0, true, Order_Point, "stampede")
        call SetObjectElement('A09W', Element_Wild)
        call SaveDummyAbilOrder('ANst', "stampede")

        //50 - Howl of Terror 
        call SaveAbilData('ANht', 'I040', false, 0, 0, true, Order_Instant, "howlofterror")
        call SetObjectElement('ANht', Element_Dark)
        call SetObjectElement('ANht', Element_Cold)

        //51 - Inferno 
        call SaveAbilData('AUin', 'I02A', false, 0, 0, false, Order_Point, "dreadlordinferno")
        call SetObjectElement('AUin', Element_Fire)
        call SetObjectElement('AUin', Element_Earth)
        call SetObjectElement('AUin', Element_Dark)

        //52 - Healing Wave 
        call SaveAbilData('AOhw', 'I029', false, 1, 0, true, Order_Target, "healingwave")
        call SetObjectElement('AOhw', Element_Light)

        //53 - Banish 
        call SaveAbilData('AHbn', 'I02C', false, 0, 1, true, Order_Target, "banish")
        call SetObjectElement('AHbn', Element_Spirit)

        //54 - Acid Spray 
        call SaveAbilData('ANhs', 'I028', false, 0, 0, true, Order_Point, "healingspray")
        call SetObjectElement('ANhs', Element_Poison)

        //55 - Activate Avatar 
        call SaveAbilData('AHav', 'I027', false, 0, 0, false, Order_None, "avatar")
        call SetObjectElement('AHav', Element_Earth)
        call SetObjectElement('AHav', Element_Energy)

        //56 - Battle Roar 
        call SaveAbilData('ANbr', 'I02D', false, 1, 0, true, Order_Instant, "battleroar")
        call SetObjectElement('ANbr', Element_Wild)

        //57 - Death And Decay 
        call SaveAbilData('AUdd', 'I02E', false, 0, 0, true, Order_Point, "deathanddecay")
        call SetObjectElement('AUdd', Element_Dark)

        //58 - Summon Mountain Giant 
        call SaveAbilData('AEsv', 'I03Y', false, 0, 0, false, Order_Instant, "spiritofvengeance")
        call SetObjectElement('AEsv', Element_Earth)
        call SetObjectElement('AEsv', Element_Wild)

        //59 - Bloodlust 
        call SaveAbilData('Ablo', 'I02F', false, 1, 1, true, Order_Target, "bloodlust")
        call SetObjectElement('Ablo', Element_Blood)

        //60 - Pocket Factory 
        call SaveAbilData('ANsy', 'I02G', false, 0, 0, false, Order_Point, "summonfactory")

        //61 - Pulverize 
        call SaveAbilData('Awar', 'I02H', false, 0, 0, false, Order_None, null)
        call SetObjectElement('Awar', Element_Earth)
        call SetObjectElement('Awar', Element_Energy)

        //62 - Corrosive Skin 
        call SaveAbilData('A00Q', 'I02I', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A00Q', Element_Poison)

        //63 - Carrion Beetles 
        call SaveAbilData('AUcb', 'I02M', false, 0, 0, false, Order_Instant, "carrionscarabsinstant")
        call SetObjectElement('AUcb', Element_Dark)

        //64 - War Drums 
        call SaveAbilData('Aakb', 'I002', false, 0, 0, false, Order_None, null)
        call SetObjectElement('Aakb', Element_Energy)

        //65 - Hardened Skin 
        call SaveAbilData('Assk', 'I02O', false, 0, 0, false, Order_None, null)
        call SetObjectElement('Assk', Element_Earth)

        //66 - Searing Arrows 
        call SaveAbilData('AHfa', 'I02P', false, 0, 0, false, Order_None, "flamingarrows")
        call SetObjectElement('AHfa', Element_Fire)

        //67 - Raise Dead 
        call SaveAbilData('Arai', 'I02Q', false, 0, 0, false, Order_Instant, "instant")
        call SetObjectElement('Arai', Element_Dark)

        //68 - Black Arrow 
        call SaveAbilData('ANba', 'I02R', false, 0, 0, false, Order_None, "blackarrow")
        call SetObjectElement('ANba', Element_Dark)

        //69 - Cold Arrows 
        call SaveAbilData('AHca', 'I02S', false, 0, 0, false, Order_None, "coldarrows")
        call SetObjectElement('AHca', Element_Water)
        call SetObjectElement('AHca', Element_Cold)

        //70 - Faerie Fire 
        call SaveAbilData('Afae', 'I02T', false, 0, 1, true, Order_Target, "faeriefire")
        call SetObjectElement('Afae', Element_Fire)
        call SetObjectElement('Afae', Element_Wild)

        //71 - Parasite 
        call SaveAbilData('ANpa', 'I02U', false, 0, 1, true, Order_Target, "parasite")
        call SetObjectElement('ANpa', Element_Poison)

        //72 - Curse 
        call SaveAbilData('Acrs', 'I02V', false, 0, 1, true, Order_Target, "curse")
        call SetObjectElement('Acrs', Element_Dark)

        //73 - Inner Fire 
        call SaveAbilData('Ainf', 'I02W', false, 1, 1, true, Order_Target, "innerfire")
        call SetObjectElement('Ainf', Element_Fire)
        call SetObjectElement('Ainf', Element_Light)

        //74 - Command Aura 
        call SaveAbilData('ACac', 'I02X', false, 0, 0, false, Order_None, null)
        call SetObjectElement('ACac', Element_Energy)

        //75 - Devastating Blow 
        call SaveAbilData('A050', 'I03X', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A050', Element_Fire)

        //76 - Summon Hawk 
        call SaveAbilData('ANsw', 'I02Z', false, 0, 0, false, Order_Instant, "summonwareagle")
        call SetObjectElement('ANsw', Element_Wild)

        //77 - Summon Bear 
        call SaveAbilData('ANsg', 'I030', false, 0, 0, false, Order_Instant, "summongrizzly")
        call SetObjectElement('ANsg', Element_Wild)

        //78 - Summon Quilbeast 
        call SaveAbilData('Arsq', 'I031', false, 0, 0, false, Order_Instant, "summonquillbeast")
        call SetObjectElement('Arsq', Element_Wild)

        //79 - Phoenix 
        call SaveAbilData('AHpx', 'I032', false, 0, 0, false, Order_Instant, "summonphoenix")
        call SetObjectElement('AHpx', Element_Fire)

        //80 - Healing Ward 
        call SaveAbilData('Ahwd', 'I033', false, 0, 0, true, Order_Point, "healingward")
        call SetObjectElement('Ahwd', Element_Light)

        //81 - Unholy Frenzy 
        call SaveAbilData('Auhf', 'I034', false, 0, 1, true, Order_Target, "unholyfrenzy")
        call SetObjectElement('Auhf', Element_Dark)

        //82 - Berserk 
        call SaveAbilData('Absk', 'I036', false, 0, 0, false, Order_None, "berserk")
        call SetObjectElement('Absk', Element_Blood)

        //83 - Rejuvenation 
        call SaveAbilData('Arej', 'I037', false, 1, 1, true, Order_Target, "rejuvination")
        call SetObjectElement('Arej', Element_Wild)
        call SetObjectElement('Arej', Element_Light)

        //84 - Lightning Shield 
        call SaveAbilData('ACls', 'I038', false, 0, 1, false, Order_None, "lightningshield")
        call SetObjectElement('ACls', Element_Wind)

        //85 - Volcano 
        call SaveAbilData('A09X', 'I039', false, 0, 0, true, Order_Point, "volcano")
        call SetObjectElement('A09X', Element_Fire)
        call SetObjectElement('A09X', Element_Earth)
        call SaveDummyAbilOrder('ANvc', "volcano")

        //86 - Ensnare 
        call SaveAbilData('ANen', 'I03A', false, 0, 1, true, Order_Target, "ensnare")

        //87 - Liquid Fire 
        call SaveAbilData('A06Q', 'I03B', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A06Q', Element_Fire)

        //88 - Plague 
        call SaveAbilData('A017', 'I03V', false, 0, 0, true, Order_Point, "channel")
        call SetObjectElement('A017', Element_Poison)

        //89 - Pillage 
        call SaveAbilData('Asal', 'I03D', false, 0, 0, false, Order_None, null)

        //90 - Envenomed Weapons 
        call SaveAbilData('A06O', 'I03E', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A06O', Element_Poison)

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
        call SetObjectElement('Afod', Element_Dark)

        //96 - Aura of immortality 
        call SaveAbilData('A02L', 'I04X', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A02L', Element_Light)
        call SetObjectElement('A02L', Element_Divine)

        //97 - Aura of Fear 
        call SaveAbilData('A02K', 'I04Y', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A02K', Element_Dark)
        call SetObjectElement('A02K', Element_Blood)

        //98 - Aura of Vulnerability 
        call SaveAbilData('A02M', 'I04Z', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A02M', Element_Dark)

        //99 - Finishing Blow 
        call SaveAbilData('A02N', 'I050', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A02N', Element_Blood)

        //100 - Mega Speed 
        call SaveAbilData('A02O', 'I051', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A02O', Element_Wind)

        //101 - Thunder Force 
        call SaveAbilData('A02S', 'I053', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A02S', Element_Wind)

        //102 - Air Force 
        call SaveAbilData('A02T', 'I054', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A02T', Element_Wind)

        //103 - Fire Force 
        call SaveAbilData('A02U', 'I055', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A02U', Element_Fire)

        //104 - Learnability 
        call SaveAbilData('A02W', 'I056', false, 0, 0, false, Order_None, null)

        //105 - Mana Bonus 
        call SaveAbilData('A02X', 'I057', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A02X', Element_Water)
        call SetObjectElement('A02X', Element_Energy)

        //106 - Power of Ice 
        call SaveAbilData('A02Z', 'I058', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A02Z', Element_Water)
        call SetObjectElement('A02Z', Element_Cold)

        //107 - Brilliance Aura 
        call SaveAbilData('AHab', 'I00U', false, 0, 0, false, Order_None, null)
        call SetObjectElement('AHab', Element_Water)
        call SetObjectElement('AHab', Element_Water)

        //108 - Fast Magic 
        call SaveAbilData('A03P', 'I05M', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A03P', Element_Arcane)

        //109 - Hero Buff 
        call SaveAbilData('A03Q', 'I05N', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A03Q', Element_Light)

        //110 - Temporary Invisibility 
        call SaveAbilData('A03U', 'I05O', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A03U', Element_Wind)

        //111 - Rapid Recovery 
        call SaveAbilData('A03X', 'I05P', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A03X', Element_Light)

        //112 - Сhronus Wizard 
        call SaveAbilData('A03Y', 'I05Q', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A03Y', Element_Arcane)
        call SetObjectElement('A03Y', Element_Time)

        //113 - Cheater Magic 
        call SaveAbilData('A040', 'I05R', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A040', Element_Energy)
        call SetObjectElement('A040', Element_Time)

        //114 - Fearless Defenders 
        call SaveAbilData('A041', 'I05S', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A041', Element_Light)

        //115 - Demon's Curse 
        call SaveAbilData('A042', 'I05T', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A042', Element_Dark)

        //116 - Blessed Protection
        call SaveAbilData('A045', 'I05V', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A045', Element_Light)
        call SetObjectElement('A045', Element_Divine)

        //117 - Reincarnation 
        call SaveAbilData('ANr2', 'I00Y', false, 0, 0, false, Order_None, null)
        call SetObjectElement('ANr2', Element_Energy)
        call SetObjectElement('ANr2', Element_Light)

        //118 - Drunken Master 
        call SaveAbilData('Acdb', 'I05W', false, 0, 0, false, Order_None, null)

        //119 - Demolish 
        call SaveAbilData('ANde', 'I05X', false, 0, 0, false, Order_None, null)

        //120 - Destruction
        call SaveAbilData('ACpv', 'I05Y', false, 0, 0, false, Order_None, null)
        call SetObjectElement('ACpv', Element_Energy)

        //122 - Divine Shield 
        call SaveAbilData('AHds', 'I011', false, 0, 0, false, Order_None, "divineshield")
        call SetObjectElement('AHds', Element_Light)

        //123 - Transmute 
        call SaveAbilData('ANtm', 'I00G', false, 0, 1, true, Order_Target, "transmute")

        //124 - Silence 
        call SaveAbilData('ANsi', 'I03C', false, 0, 1, true, Order_Point, "silence")
        call SetObjectElement('ANsi', Element_Dark)

        //125 - Stasis Trap 
        call SaveAbilData('Asta', 'I044', false, 0, 0, true, Order_Point, "stasistrap")
        call SetObjectElement('Asta', Element_Spirit)

        //126 - Death Pact 
        call SaveAbilData('AUdp', 'I01V', false, 0, 1, false, Order_Target, "deathpact")
        call SetObjectElement('AUdp', Element_Dark)

        //127 - Big Bad Voodoo 
        call SaveAbilData('AOvd', 'I03Z', false, 0, 0, false, Order_None, "voodoo")
        call SetObjectElement('AOvd', Element_Spirit)

        //128 - Icy Breath 
        call SaveAbilData('A046', 'I05Z', false, 0, 1, true, Order_Point, "breathoffrost")
        call SetObjectElement('A046', Element_Water)
        call SetObjectElement('A046', Element_Cold)

        //129 - Soul Burn 
        call SaveAbilData('ANso', 'I062', false, 0, 1, true, Order_Target, "soulburn")
        call SetObjectElement('ANso', Element_Fire)

        //130 - Fog 
        call SaveAbilData('A09Z', 'I063', false, 0, 1, true, Order_Point, "cloudoffog")
        call SetObjectElement('A09Z', Element_Water)
        call SetObjectElement('A09Z', Element_Wind)
        call SaveDummyAbilOrder('Aclf', "cloudoffog")

        //131 - Temporary Power 
        call SaveAbilData('A04E', 'I067', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A04E', Element_Light)
        call SetObjectElement('A04E', Element_Divine)

        //132 - Multicast 
        call SaveAbilData('A04F', 'I068', false, 0, 0, false, Order_None, null)

        //133 - Heavy Blow 
        call SaveAbilData('A04G', 'I069', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A04G', Element_Light)

        //134 - Combustion 
        call SaveAbilData('A04H', 'I06A', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A04H', Element_Fire)

        //135 - Holy Enlightenment 
        call SaveAbilData('A04K', 'I06C', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A04K', Element_Light)

        //136 - Chaos Magic 
        call SaveAbilData('A04L', 'I06D', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A04L', Element_Fire)
        call SetObjectElement('A04L', Element_Water)
        call SetObjectElement('A04L', Element_Wind)
        call SetObjectElement('A04L', Element_Earth)
        call SetObjectElement('A04L', Element_Wild)
        call SetObjectElement('A04L', Element_Energy)
        call SetObjectElement('A04L', Element_Dark)
        call SetObjectElement('A04L', Element_Light)
        call SetObjectElement('A04L', Element_Cold)
        call SetObjectElement('A04L', Element_Poison)
        call SetObjectElement('A04L', Element_Blood)
        call SetObjectElement('A04L', Element_Divine)
        call SetObjectElement('A04L', Element_Arcane)
        call SetObjectElement('A04L', Element_Time)

        //137 - Monsoon 
        call SaveAbilData('A0A0', 'I06G', false, 0, 0, true, Order_Point, "monsoon")
        call SetObjectElement('A0A0', Element_Water)
        call SetObjectElement('A0A0', Element_Wind)
        call SaveDummyAbilOrder('ANmo', "monsoon")

        //138 - Ice Armor 
        call SaveAbilData('A053', 'I06L', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A053', Element_Water)
        call SetObjectElement('A053', Element_Cold)

        //139 - Last Breath 
        call SaveAbilData('A05R', 'I07J', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A05R', Element_Dark)
        call SetObjectElement('A05R', Element_Light)

        //140 - Fire Shield 
        call SaveAbilData('A05S', 'I07L', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A05S', Element_Fire)

        //141 - Ancient Teaching 
        call SaveAbilData('A05U', 'I07N', false, 0, 0, false, Order_None, null)

        //142 - Cyclone 
        call SaveAbilData('A05X', 'I07Q', false, 0, 0, true, Order_Point, "creepanimatedead")
        call SetObjectElement('A05X', Element_Wind)

        //143 - Mysterious Talent 
        call SaveAbilData('A05Z', 'I07R', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A05Z', Element_Energy)
        call SetObjectElement('A05Z', Element_Arcane)

        //144 - Stone Protection 
        call SaveAbilData('A060', 'I07S', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A060', Element_Earth)

        //145 - Cruelty 
        call SaveAbilData('A067', 'I07X', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A067', Element_Blood)

        //146 - Reaction 
        call SaveAbilData('A06C', 'I07Z', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A06C', Element_Wind)

        //147 - Magic Critical Hit 
        call SaveAbilData('A06U', 'I081', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A06U', Element_Energy)
        call SetObjectElement('A06U', Element_Arcane)

        //148 - Mega Luck 
        call SaveAbilData('A06V', 'I085', false, 0, 0, false, Order_None, null)

        //149 - Dousing Hex
        call SaveAbilData('A09I', 'I0AN', false, 0, 1, true, Order_Target, "ancestralspirittarget")
        call SetObjectElement('A09I', Element_Water)

        //150 - Ancient Runes 
        call SaveAbilData('A09O', 'I08K', false, 0, 0, false, Order_Instant, "animatedead")
        call SetObjectElement('A09O', Element_Arcane)

        //151 - Earthquake 
        call SaveAbilData('A07L', 'I094', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A07L', Element_Earth)

        //152 - Cold Wind 
        call SaveAbilData('A07N', 'I096', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A07N', Element_Wind)
        call SetObjectElement('A07N', Element_Cold)

        //153 - Random Spell 
        call SaveAbilData('A07U', 'I09C', false, 0, 0, true, Order_Target, "slow")
        call SetObjectElement('A07U', Element_Fire)
        call SetObjectElement('A07U', Element_Water)
        call SetObjectElement('A07U', Element_Wind)
        call SetObjectElement('A07U', Element_Earth)
        call SetObjectElement('A07U', Element_Wild)
        call SetObjectElement('A07U', Element_Energy)
        call SetObjectElement('A07U', Element_Dark)
        call SetObjectElement('A07U', Element_Light)
        call SetObjectElement('A07U', Element_Cold)
        call SetObjectElement('A07U', Element_Poison)
        call SetObjectElement('A07U', Element_Blood)
        call SetObjectElement('A07U', Element_Divine)
        call SetObjectElement('A07U', Element_Arcane)
        call SetObjectElement('A07U', Element_Time)

        //154 - Divine Bubble 
        call SaveAbilData('A07S', 'I09A', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A07S', Element_Divine)

        //155 - Ancient Blood 
        call SaveAbilData('A07T', 'I09B', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A07T', Element_Blood)

        //156 - Frost Bolt 
        call SaveAbilData('A07X', 'I09G', false, 0, 0, true, Order_Target, "slowon")
        call SetObjectElement('A07X', Element_Water)
        call SetObjectElement('A07X', Element_Dark)
        call SetObjectElement('A07X', Element_Cold)

        //157 - Frostbite of the Soul 
        call SaveAbilData('A080', 'I09H', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A080', Element_Cold)

        //158 - Cutting 
        call SaveAbilData('A081', 'I09I', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A081', Element_Blood)

        //159 - Divine Gift 
        call SaveAbilData('A082', 'I09J', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A082', Element_Light)
        call SetObjectElement('A082', Element_Divine)

        //160 - Sand of Time 
        call SaveAbilData('A083', 'I09K', false, 0, 0, true, Order_Instant, "slowoff")
        call SetObjectElement('A083', Element_Earth)
        call SetObjectElement('A083', Element_Arcane)
        call SetObjectElement('A083', Element_Time)

        //161 - Wizardbane Aura 
        call SaveAbilData('A088', 'I09M', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A088', Element_Energy)
        call SetObjectElement('A088', Element_Arcane)

        //162 - Martial Retribution 
        call SaveAbilData('A089', 'I09L', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A089', Element_Energy)

        //163 - Purge 
        call SaveAbilData('A08E', 'I09N', false, 0, 1, true, Order_Target, "purge")
        call SetObjectElement('A08E', Element_Spirit)
        call SetObjectElement('A08E', Element_Dark)

        //164 - Blink Strike 
        call SaveAbilData('A08J', 'I09P', false, 0, 0, true, Order_Instant, "acolyteharvest")
        call SetObjectElement('A08J', Element_Wind)
        call SetObjectElement('A08J', Element_Energy)
        call SetObjectElement('A08J', Element_Arcane)

        //165 - Extradimensional Co-operation
        call SaveAbilData('A08I', 'I09Q', false, 0, 0, true, Order_Instant, "absorb")
        call SetObjectElement('A08I', Element_Arcane)
        call SetObjectElement('A08I', Element_Time)
        call SetObjectElement('A08I', Element_Spirit)

        //166 - Reflection Aura
        call SaveAbilData('A093', 'I09S', false, 0, 0, false, Order_None, null)

        //167 - Arcane Assault
        call SaveAbilData('A098', 'I09Z', false, 0, 0, false, Order_None, null)
        call SetObjectElement('A098', Element_Arcane)

        //168 - Absolute Fire
        call SaveAbilData('A07B', 'I08T', true, 0, 0, false, Order_None, null)
        call SetObjectElement('A07B', Element_Fire)

        //169 - Absolute Water
        call SaveAbilData('A07C', 'I08U', true, 0, 0, false, Order_None, null)
        call SetObjectElement('A07C', Element_Water)

        //170 - Absolute Wind
        call SaveAbilData('A07E', 'I08W', true, 0, 0, false, Order_None, null)
        call SetObjectElement('A07E', Element_Wind)

        //171 - Absolute Earth
        call SaveAbilData('A07D', 'I08V', true, 0, 0, false, Order_None, null)
        call SetObjectElement('A07D', Element_Earth)

        //172 - Absolute Wild
        call SaveAbilData('A07K', 'I093', true, 0, 0, false, Order_None, null)
        call SetObjectElement('A07K', Element_Wild)

        //173 - Absolute Dark
        call SaveAbilData('A07Q', 'I098', true, 0, 0, false, Order_None, null)
        call SetObjectElement('A07Q', Element_Dark)

        //174 - Absolute Light
        call SaveAbilData('A07P', 'I097', true, 0, 0, false, Order_None, null)
        call SetObjectElement('A07P', Element_Light)

        //175 - Absolute Cold
        call SaveAbilData('A07V', 'I09F', true, 0, 0, false, Order_None, null)
        call SetObjectElement('A07V', Element_Cold)

        //176 - Absolute Blood
        call SaveAbilData('A07R', 'I099', true, 0, 0, false, Order_None, null)
        call SetObjectElement('A07R', Element_Blood)

        //177 - Mana Starvation
        call SaveAbilData('A09J', 'I0AO', false, 0, 1, true, Order_Target, "ancestralspirit")
        call SetObjectElement('A09J', Element_Dark)

        //Unit and item elements
        call SetObjectElement('H016', Element_Fire)
        call SetObjectElement('O005', Element_Fire)
        call SetObjectElement('O007', Element_Fire)
        call SetObjectElement('O006', Element_Water)
        call SetObjectElement('H018', Element_Water)
        call SetObjectElement('H003', Element_Water)
        call SetObjectElement('H001', Element_Water)
        call SetObjectElement('H008', Element_Wind)
        call SetObjectElement('O001', Element_Wind)
        call SetObjectElement('O00A', Element_Wind)
        call SetObjectElement('O00C', Element_Wind)
        call SetObjectElement('N00K', Element_Wind)
        call SetObjectElement('H01C', Element_Earth)
        call SetObjectElement('H017', Element_Earth)
        call SetObjectElement('H019', Element_Earth)
        call SetObjectElement('H00A', Element_Earth)
        call SetObjectElement('N00P', Element_Wild)
        call SetObjectElement('O008', Element_Wild)
        call SetObjectElement('H006', Element_Wild)
        call SetObjectElement('H01B', Element_Energy)
        call SetObjectElement('H01L', Element_Energy)
        call SetObjectElement('H01J', Element_Energy)
        call SetObjectElement('H000', Element_Energy)
        call SetObjectElement('H01G', Element_Energy)
        call SetObjectElement('O000', Element_Energy)
        call SetObjectElement('N00O', Element_Dark)
        call SetObjectElement('N00B', Element_Dark)
        call SetObjectElement('O003', Element_Dark)
        call SetObjectElement('H000', Element_Dark)
        call SetObjectElement('H005', Element_Dark)
        call SetObjectElement('O002', Element_Dark)
        call SetObjectElement('H018', Element_Dark)
        call SetObjectElement('N00I', Element_Dark)
        call SetObjectElement('H002', Element_Light)
        call SetObjectElement('E000', Element_Light)
        call SetObjectElement('H018', Element_Cold)
        call SetObjectElement('N02K', Element_Cold)
        call SetObjectElement('H007', Element_Blood)
        call SetObjectElement('N00C', Element_Blood)
        call SetObjectElement('O002', Element_Blood)
        call SetObjectElement('N024', Element_Blood)
        call SetObjectElement('H01H', Element_Blood)
        call SetObjectElement('N00Q', Element_Blood)
        call SetObjectElement('N00I', Element_Blood)
        call SetObjectElement('H01L', Element_Arcane)
        call SetObjectElement('H01E', Element_Arcane)
        call SetObjectElement('O004', Element_Arcane)
        call SetObjectElement('H01D', Element_Spirit)
        call SetObjectElement('H01I', Element_Spirit)
        call SetObjectElement('O003', Element_Spirit)


        /*
        call SaveAbilData('Aclf', 'I063')

        call SaveAbilData('A08E',"purge",1,1)
        call SaveAbilData('ANtm',"transmute",1,1)
        call SaveAbilData('Aclf',"cloudoffog",2,0)
        call SaveAbilData('AHtb',"thunderbolt",1,0)
        call SaveAbilData('AHbn',"banish",1,1)
        call SaveAbilData('AHfs',"flamestrike",2,0)
        call SaveAbilData('AHwe',"waterelemental",3,0)
        call SaveAbilData('AHtc',"thunderclap",3,0)
        call SaveAbilData('AHhb',"holybolt",1,0)
        call SaveAbilData('AHbz',"blizzard",2,0)   
        call SaveAbilData('AHpx',"summonphoenix",3,0)  
        call SaveAbilData('Ainf',"innerfire",1,1)
    
    
        call SaveAbilData('AOww',"whirlwind",3,0)
        call SaveAbilData('AOhw',"healingwave",1,0)
        call SaveAbilData('AOws',"stomp",3,0)
        call SaveAbilData('AOls',"Locustswarm",3,0)
        call SaveAbilData('AOsw',"ward",2,0)
        call SaveAbilData('AOhx',"hex",3,1)
        call SaveAbilData('AOvd',"voodoo",3,0)
        call SaveAbilData('AOwk',"windwalk",3,0)
        call SaveAbilData('AOsh',"shockwave",2,0)
        call SaveAbilData('AOcl',"chainlightning",1,0)
        call SaveAbilData('Absk',"berserk",3,0)
        call SaveAbilData('Aspl',"spiritlink",1,1)
        call SaveAbilData('Ablo',"bloodlust",1,1)
        call SaveAbilData('Ahwd',"healingward",2,0)
        call SaveAbilData('Asta',"stasistrap",2,0)   
        
        
        
        call SaveAbilData('AUfn',"frostnova",1,0)  
        call SaveAbilData('AUcb',"Carrionscarabs",3,0)
        call SaveAbilData('AUin',"dreadlordinferno",2,0)
        call SaveAbilData('AUfu',"frostarmor",1,1)
        call SaveAbilData('AUim',"impale",2,0)
        call SaveAbilData('AUdp',"deathpact",1,1)
        call SaveAbilData('AUdd',"deathanddecay",2,0)
        call SaveAbilData('AUcs',"carrionswarm",2,0)
        call SaveAbilData('Aam2',"antimagicshell",1,1)
        call SaveAbilData('Arai',"raisedead",3,0)
        call SaveAbilData('Auhf',"unholyfrenzy",1,1)
        call SaveAbilData('Acrs',"curse",1,1)
    
        
        
        call SaveAbilData('AEsv',"spiritofvengeance",3,0)       
        call SaveAbilData('AEfk',"fanofknives",3,0)
        call SaveAbilData('AEer',"entanglingroots",1,1)
        call SaveAbilData('AEsf',"starfall",3,0)
        call SaveAbilData('AEim',"immolation",3,0)
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
        call SaveAbilData('ANsy',"summonfactory",2,0)
        
        
        call SaveAbilData('Arsq',"summonquillbeast",3,0)    
        call SaveAbilData('ANsg',"summongrizzly",3,0)  
        call SaveAbilData('ANlm',"slimemonster",3,0)  
        call SaveAbilData('ANsw',"summonwareagle",3,0)  
        call SaveAbilData('ANfl',"forkedlightning",1,0)  
        call SaveAbilData('ANso',"soulburn",1,1)  
        call SaveAbilData('ACls',"lightningshield",1,0)  

        call SaveAbilData('ANdh',"drunkenhaze",1,1)    
        call SaveAbilData('A046',"breathoffrost",2,0)  
        call SaveAbilData('ANpa',"parasite",1,1)  
        call SaveAbilData('ANen',"ensnare",1,1)
        call SaveAbilData('ANht',"howlofterror",3,0)  

        call SaveAbilData('ANmo',"monsoon",2,0)
        call SaveAbilData('AOsf',"spiritwolf",3,0) 
        
        call SaveAbilData('A05X',"channel",2,0)
        call SaveAbilData('A017',"channel",2,0) 
        call SaveAbilData('ANsi',"silence",2,0) 
        */
    endfunction 

    function InitDataRA2 takes nothing returns nothing

    /*
    set AbilSpellRA1[0] = 'AHtb'
    set AbilSpellRA1[1] = 'AHbn'
    set AbilSpellRA1[2] = 'AOhx'
    set AbilSpellRA1[3] = 'AOcl'
    set AbilSpellRA1[4] = 'AUfn'
    set AbilSpellRA1[5] = 'Auhf'
    set AbilSpellRA1[6] = 'Acrs'
    set AbilSpellRA1[7] = 'AEsh'
    set AbilSpellRA1[8] = 'Afae'
    set AbilSpellRA1[9] = 'AEer'
    set AbilSpellRA1[10] = 'ANab'
    set AbilSpellRA1[11] = 'ANso'
    set AbilSpellRA1[12] = 'ANdh'
    set AbilSpellRA1[13] = 'ANfl'  
    set AbilSpellRA1[14] = 'ACls'  
    set AbilSpellRA1[15] = 'ANpa'  
    set AbilSpellRA1[16] = 'ANen' 
    set AbilSpellRA1[17] = 'ANtm'  
    set AbilSpellRA1[18] = 'A08E' 
    
    
    set AbilSRA1_count = 18
        

    set AbilSpellRA2[0] = 'AHfs'
    set AbilSpellRA2[1] = 'AHbz'
    set AbilSpellRA2[2] = 'AOsh'
    set AbilSpellRA2[3] = 'AUim'
    set AbilSpellRA2[4] = 'AUdd'
    set AbilSpellRA2[5] = 'AUcs'
    set AbilSpellRA2[6] = 'ANst'
    set AbilSpellRA2[7] = 'ANhs'
    set AbilSpellRA2[8] = 'ANcs'
    set AbilSpellRA2[9] = 'ANsi'
    set AbilSpellRA2[10] = 'ANrf'
    set AbilSpellRA2[11] = 'ANbf'
    set AbilSpellRA2[12] = 'A046'  
    set AbilSpellRA2[13] = 'Aclf'  
    set AbilSpellRA2[14] = 'Asta' 
    set AbilSpellRA2[15] = 'ANmo' 
    set AbilSpellRA2[16] = 'A05X' 
    set AbilSpellRA2[17] = 'A017'      
    set AbilSpellRA2[18] = 'A046'   
    
    set AbilSRA2_count = 18
    
    set AbilSpellRA3[0] = 'AHtc'  
    set AbilSpellRA3[1] = 'AOws'  
    set AbilSpellRA3[2] = 'AEsf' 
    set AbilSpellRA3[3] = 'AEfk'      
    set AbilSpellRA3[4] = 'ANht'      
    set AbilSRA3_count = 4  
    */
    
    
    
    
    
    
    
    

    endfunction

    /*private function PreloadAbilities takes nothing returns nothing
        local unit u = CreateUnit(Player(8), 'h014', 0, 0, 0)
        local integer i = 0
        local integer abilId = 0
        loop
            set abilId = GetAbilityFromIndex(i)
            call UnitAddAbility(u, abilId)
            call UnitRemoveAbility(u, abilId)
            set i = i + 1
            exitwhen i > GetAbilitycount()
        endloop
    endfunction*/

    private function init takes nothing returns nothing
        set ChaosData = HashTable.create()
        set ChaosDataEnemy = HashTable.create()
        set ChaosDataAlly = HashTable.create()
        set AbilityData = HashTable.create()
        set ElementData = HashTable.create()
        set ItemData = Table.create()
        set AbilityIndex = Table.create()
        call InitDataA1()
        //call PreloadAbilities()
    endfunction
endlibrary

