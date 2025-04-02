library SaveCore initializer init

    globals
        integer array SaveUnitType
        integer array SaveItemType
        integer SaveUnitTypeMax= 0
        integer SaveItemTypeMax= 0
        integer SaveUnitMaxStat= 0
        integer SaveTempInt= 0
        integer array SaveAbilityType
        integer SaveAbilityTypeMax= 0
        integer HeroXPConstant= 0
        integer HeroXPLevelFactor= 0
        integer HeroXPPrevLevelFactor= 0
        integer HeroXPRequired= 0
        string MapName
        unit array SavePlayerHero
        string LocalFiles_WarningMessage
        boolean SaveShowCode= false
        unit SaveTempUnit= null
        integer array SaveValue
        integer SaveCount= 0
        integer array SaveMaxValue
        string SaveTempString
        real SaveLoadEvent= 0
        string SaveLoadEvent_Code
        player SaveLoadEvent_Player= null
        real SaveTempReal= 0
        boolean SaveLoad_HeroName= false
        boolean SaveHeroName= false
        integer SaveLoad_Slot= 0
        string array SaveNameList
        integer SaveNameMax= 0
        string SaveLoad_TriggerName
        integer SaveLoadMaxLength= 0
        boolean array SavePlayerLoading
        integer array SaveCurrentSlot
        boolean SaveUseGUI= false
        string SaveCodeColored
    endglobals

    private function init takes nothing returns nothing
        set SaveLoadMaxLength = 64
        set SaveUseGUI = true
        // -------------------
        // This will be the directory the save codes will be saved to.
        // -------------------
        set MapName = "CHS"
        // -------------------
        // This message will display to players who don't have local files enabled
        // -------------------
        set LocalFiles_WarningMessage = "|cffe53b3bYou need to enable local files to load your character from disk on patches prior to 1.30!"
        set LocalFiles_WarningMessage = LocalFiles_WarningMessage + "\n\n"
        // -------------------
        // Show the save code
        // -------------------
        set SaveShowCode = true
        // -------------------
        // Save hero name (only works with the save slots, not raw save codes)
        // Also make sure to set the object editor field "Text - Proper Names Used" to 999  for all of your heroes.
        // -------------------

        // This has a lot of functionality to save items/stats for a hero. We aren't really doing that.
        /*set SaveHeroName = true
        set SaveNameMax = 999
        // -------------------
        // Set these to the values they are in the Advanced -> Gameplay constants
        // Allows us to calculate how much XP a hero has
        // Note: You can also save EXP the easy way but it will generate a longer code.
        // -------------------
        set HeroXPConstant = 0
        set HeroXPLevelFactor = 100
        set HeroXPPrevLevelFactor = 1
        set HeroXPRequired = 200
        // -------------------
        // Max STR/AGI/INT
        // -------------------
        set SaveUnitMaxStat = 999
        // Note: Changing max values can cause a code wipe
        // -------------------
        // Store unit types that can be saved here
        // -------------------
        set SaveUnitType[0] = 0
        set SaveUnitType[1] = 'Otch'
        set SaveUnitType[2] = 'Ulic'
        set SaveUnitType[3] = 'Edem'
        set SaveUnitType[4] = 'Nngs'
        set SaveUnitType[5] = 'Nbst'
        set SaveUnitType[6] = 'Hblm'
        set SaveUnitType[7] = 'Edmm'
        set SaveUnitTypeMax = 99
        // Note: Changing max values can cause a code wipe
        // -------------------
        // Store item types that can be saved here
        // -------------------
        set SaveItemType[0] = GetItemTypeId(null)
        set SaveItemType[1] = 'ckng'
        set SaveItemType[2] = 'desc'
        set SaveItemType[3] = 'modt'
        set SaveItemType[4] = 'ofro'
        set SaveItemType[5] = 'rde4'
        set SaveItemType[6] = 'kybl'
        set SaveItemType[7] = 'ches'
        set SaveItemType[8] = 'ratf'
        set SaveItemTypeMax = 999
        // Note: Changing max values can cause a code wipe
        // -------------------
        // Store ability types that can be saved here
        // -------------------
        set SaveAbilityType[1] = ENDURANCE_AURA_ABILITY_ID
        set SaveAbilityType[2] = 'AOre'
        set SaveAbilityType[3] = WAR_STOMP_ABILITY_ID
        set SaveAbilityType[4] = FROST_NOVA_ABILITY_ID
        set SaveAbilityType[5] = FROST_ARMOR_ABILITY_ID
        set SaveAbilityType[6] = 'AUdr'
        set SaveAbilityType[7] = DEATH_AND_DECAY_ABILITY_ID
        set SaveAbilityType[8] = 'AEmb'
        set SaveAbilityType[9] = 'AEim'
        set SaveAbilityType[10] = EVASION_ABILITY_ID
        set SaveAbilityType[11] = 'AEme'
        set SaveAbilityType[12] = FORKED_LIGHTNING_ABILITY_ID
        set SaveAbilityType[13] = 'ANfa'
        set SaveAbilityType[14] = MANA_SHIELD_ABILITY_ID
        set SaveAbilityType[15] = 'ANto'
        set SaveAbilityType[16] = SUMMON_BEAR_ABILITY_ID
        set SaveAbilityType[17] = 'ANsq'
        set SaveAbilityType[18] = SUMMON_HAWK_ABILITY_ID
        set SaveAbilityType[19] = STAMPEDE_ABILITY_ID
        set SaveAbilityType[20] = FLAME_STRIKE_ABILITY_ID
        set SaveAbilityType[21] = BANISH_ABILITY_ID
        set SaveAbilityType[22] = 'AHdr'
        set SaveAbilityType[23] = PHEONIX_ABILITY_ID
        set SaveAbilityType[24] = SHOCKWAVE_ABILITY_ID
        set SaveAbilityTypeMax = 199*/
        // Note: Changing max values can cause a code wipe
        // -------------------
        // Automatically copy variables
        // -------------------
        set SavePlayerLoading[0] = false
        set SaveLoadEvent = -1.00
        set SaveCount = 0
        set SaveValue[0] = 0
        set SaveMaxValue[0] = 0
        set SaveTempInt = 0
        // set SavePlayerHero[0] = null
        set SaveCurrentSlot[0] = 0
        set SaveLoadEvent_Code = ""
        set SaveLoadEvent_Player = Player(0)
        set SaveNameList[0] = ""
        set SaveCodeColored = ""
        call SaveHelper.Init()
    endfunction

endlibrary