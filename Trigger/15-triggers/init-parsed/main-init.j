library OldInitialization initializer main3
    globals
        unit array CicrleUnit
        boolean ModeNoDeath = false
        integer MorePvp = 1 
        boolean duel
        integer array LumberGained
        dialog IncomeModeDialog
        Table roundAbilities
        string RoundCreepTitle
        string array RoundCreepInfo
        string RoundAbilities = ""
        boolean SuddenDeathEnabled = false
        boolean array RoundLiveLost
        player WinningPlayer
        boolean array DisableDeathTrigger

        //default variables
        //Todo set default values from initglobals2 and 3 here so those functions can be removed
        unit array PlayerHeroes
        integer BoughtAbility= 0
        integer array HeroAbilityCount
        integer array CreepUnitTypeIds
        integer RoundNumber= 0
        integer RoundCreepNumber= 0
        integer RoundCreepTypeId= 0
        rect array PlayerArenaRects
        integer RoundCreepMaxAttackSpeed= 0
        integer PlayerCount= 0
        integer SpawnedHeroCount= 0
        integer RoundFinishedCount= 0
        real RoundCreepPower= 0
        integer RoundCreepMoveSpeed= 0
        integer RoundCreepChanceBash= 0
        integer RoundCreepChanceCritStrike= 0
        integer RoundCreepChanceEvasion= 0
        player SingleplayerPlayer= null
        integer InitialPlayerCount= 0
        unit array ChooseHeroSelection
        force DefeatedPlayers= null
        group PotentialDuelHeroes= null
        group DuelingHeroes= null
        integer RoundCreepAbilCastChance= 0
        integer array DuelHeroItemIds1
        integer array DuelHeroItemIds2
        group DuelingHeroGroup= null
        group DuelWinners= null
        integer PvpGoldWinAmount= 0
        integer BrPlayerCount= 0
        boolean array udg_booleans01
        boolean BrStarted= false
        integer array PlayerLastLearnedSpell
        boolean array udg_booleans02
        integer RoundCreepChanceCleave= 0
        integer RoundCreepChanceLifesteal= 0
        item array udg_items01
        boolean array PlayerHeroPicked
        //force udg_PlayersWithHero = null
        force RoundPlayersCompleted= null
        location udg_location01= null
        integer CountdownCount= 0
        integer RoundCreepChanceThorns= 0
        unit udg_unit01= null
        integer array Playtime
        dialog GameDurDialog= null
        button array udg_buttons01
        integer array ModeVotesCount
        integer RoundCreepChanceShockwave= 0
        integer MaxCreepUnitTypes= 0
        integer RoundCreepChanceManaBurn= 0
        integer RoundCreepChanceHurlBoulder= 0
        integer RoundCreepChanceRejuv= 0
        integer AntiStuckPlayerId= 0
        integer RoundGenCreepIndex= 0
        integer ElimPlayerCount= 0
        integer ElimDmHeroDeathFxIndex= 0
        boolean ElimPvpStarted= false
        boolean ElimModeEnabled= false
        dialog GameModeDialog= null
        integer UnknownInteger01= 0
        boolean ArNotLearningAbil= false
        dialog AbilModeDialog= null
        player udg_player02= null
        integer PvpEndIndex= 0
        integer PvpStartIndex= 0
        integer udg_integer34= 0
        boolean ARLearningAbil= false
        location array udg_locations01
        integer HideShopsCount= 0
        integer array ShopIds
        integer HideShopsIndex= 0
        integer UnknownInteger02= 0
        dialog array Dialogs
        button array DialogButtons
        force udg_force04= null
        force udg_force05= null
        boolean array udg_booleans04
        boolean array udg_booleans05
        integer array udg_integers11
        string udg_string01
        integer udg_integer38= 0
        force udg_force06= null
        string array udg_strings01
        integer array udg_integers12
        boolean GameModeShort= false
        integer SuddenDeathTick= 0
        dialog udg_dialog04= null
        button array udg_buttons03
        group udg_group05= null
        integer udg_integer40= 0
        boolean udg_boolean09= false
        integer udg_integer41= 0
        boolean udg_boolean10= false
        boolean udg_boolean11= false
        integer udg_integer42= 0
        integer udg_integer43= 0
        integer udg_integer44= 0
        integer udg_integer45= 0
        integer udg_integer46= 0
        integer udg_integer47= 0
        force udg_force07= null
        boolean udg_boolean12= false
        integer RoundCreepChanceSlow= 0
        integer RoundCreepChanceBigBadV= 0
        integer RoundCreepChanceFaerieFire= 0
        integer udg_integer52= 0
        integer array udg_integers13
        integer udg_integer53= 0
        effect array udg_effects01
        effect array udg_effects02
        group udg_group06= null
        integer RoundCreepChanceBlink= 0
        integer RoundCreepChanceThunderClap= 0
        integer BettingPlayerCount= 0
        group udg_group07= null
        sound array udg_sounds01
        group GroupEmptyArenaCheck= null
        real SuddenDeathDamageMultiplier= 0
        unit udg_unit02= null
        integer array udg_integers14
        integer udg_integer57= 0
        integer udg_integer58= 0
        integer udg_integer59= 0
        integer udg_integer60= 0
        integer udg_integer61= 0
        dialog BettingModeDialog= null
        boolean BettingEnabled= false
        boolean udg_boolean14= false
        dialog udg_dialog06= null
        button array udg_buttons04
        boolean udg_boolean15= false
        player udg_player03= null
        dialog HeroModeDialog= null
        boolean RandomHeroMode= false
        integer array udg_integers15
        integer array udg_integers16
        integer udg_integer62= 0
        real udg_real04= 0
        boolean udg_boolean17= false
        string array ModeDescriptionBuilder
        unit udg_unit03= null
        group udg_group09= null
        location udg_location02= null
        unit udg_unit04= null
        boolean AllowBetSelection= false
        unit udg_unit05= null
        group DuelWinnerDisabled= null
        integer udg_integer63= 0
        rect RectP1Arena= null
        rect RectP2Arena= null
        rect RectP3Arena= null
        rect RectP4Arena= null
        rect RectP5Arena= null
        rect RectP6Arena= null
        rect RectP7Arena= null
        rect RectP8Arena= null
        rect RectMidArena= null
        camerasetup udg_camerasetup01= null
        sound udg_sound01= null
        sound udg_sound02= null
        sound udg_sound03= null
        sound udg_sound04= null
        sound udg_sound05= null
        sound udg_sound06= null
        sound udg_sound07= null
        sound udg_sound08= null
        sound udg_sound09= null
        sound udg_sound10= null
        sound udg_sound11= null
        sound udg_sound12= null
        sound udg_sound13= null
        sound udg_sound14= null
        sound udg_sound15= null
        sound udg_sound16= null
        sound udg_sound17= null
        sound udg_sound18= null
        sound udg_sound19= null
        sound udg_sound20= null
        sound udg_sound21= null
        sound udg_sound22= null
        sound udg_sound23= null
        sound udg_sound24= null
        sound udg_sound25= null
        trigger udg_trigger01= null
        trigger udg_trigger02= null
        trigger udg_trigger03= null
        trigger udg_trigger04= null
        trigger udg_trigger05= null
        trigger udg_trigger06= null
        trigger udg_trigger07= null
        trigger udg_trigger08= null
        trigger udg_trigger09= null
        trigger udg_trigger10= null
        trigger udg_trigger11= null
        trigger udg_trigger12= null
        trigger udg_trigger13= null
        trigger udg_trigger14= null
        trigger udg_trigger15= null
        trigger udg_trigger16= null
        trigger udg_trigger17= null
        trigger udg_trigger18= null
        trigger udg_trigger19= null
        trigger udg_trigger20= null
        trigger udg_trigger21= null
        trigger udg_trigger22= null
        trigger udg_trigger23= null
        trigger udg_trigger24= null
        trigger udg_trigger25= null
        trigger udg_trigger26= null
        trigger udg_trigger27= null
        trigger udg_trigger28= null
        trigger udg_trigger29= null
        trigger udg_trigger30= null
        trigger udg_trigger31= null
        trigger udg_trigger32= null
        trigger udg_trigger33= null
        trigger udg_trigger34= null
        trigger udg_trigger35= null
        trigger udg_trigger36= null
        trigger udg_trigger37= null
        trigger udg_trigger38= null
        trigger udg_trigger39= null
        trigger udg_trigger40= null
        trigger udg_trigger41= null
        trigger udg_trigger42= null
        trigger udg_trigger43= null
        trigger udg_trigger44= null
        trigger udg_trigger45= null
        trigger udg_trigger46= null
        trigger udg_trigger47= null
        trigger udg_trigger48= null
        trigger udg_trigger49= null
        trigger udg_trigger50= null
        trigger udg_trigger51= null
        trigger udg_trigger52= null
        trigger udg_trigger53= null
        trigger DistributeBetsTrigger= null
        trigger udg_trigger55= null
        trigger udg_trigger56= null
        trigger udg_trigger57= null
        trigger udg_trigger58= null
        trigger udg_trigger59= null
        trigger udg_trigger60= null
        trigger udg_trigger61= null
        trigger udg_trigger62= null
        trigger udg_trigger63= null
        trigger udg_trigger64= null
        trigger udg_trigger65= null
        trigger udg_trigger66= null
        trigger udg_trigger67= null
        trigger udg_trigger68= null
        trigger udg_trigger69= null
        trigger udg_trigger70= null
        trigger udg_trigger71= null
        trigger udg_trigger72= null
        trigger udg_trigger73= null
        trigger udg_trigger74= null
        trigger udg_trigger75= null
        trigger udg_trigger76= null
        trigger udg_trigger77= null
        trigger udg_trigger78= null
        trigger udg_trigger79= null
        trigger udg_trigger80= null
        trigger udg_trigger81= null
        trigger udg_trigger82= null
        trigger udg_trigger83= null
        trigger udg_trigger84= null
        trigger udg_trigger85= null
        trigger udg_trigger86= null
        trigger udg_trigger87= null
        trigger udg_trigger88= null
        trigger udg_trigger89= null
        trigger udg_trigger90= null
        trigger udg_trigger91= null
        trigger udg_trigger92= null
        trigger udg_trigger93= null
        trigger udg_trigger94= null
        trigger udg_trigger95= null
        trigger udg_trigger96= null
        trigger udg_trigger97= null
        trigger udg_trigger98= null
        trigger udg_trigger99= null
        trigger udg_trigger100= null
        trigger udg_trigger101= null
        trigger udg_trigger102= null
        trigger udg_trigger103= null
        trigger udg_trigger104= null
        trigger udg_trigger105= null
        trigger udg_trigger106= null
        trigger udg_trigger107= null
        trigger udg_trigger108= null
        trigger udg_trigger109= null
        trigger udg_trigger110= null
        trigger udg_trigger111= null
        trigger udg_trigger113= null
        trigger udg_trigger114= null
        trigger udg_trigger115= null
        trigger udg_trigger116= null
        trigger PvpCountdownTimerTrigger= null
        trigger udg_trigger118= null
        trigger udg_trigger119= null
        trigger udg_trigger120= null
        trigger udg_trigger121= null
        trigger EndGameTrigger= null
        trigger udg_trigger123= null
        trigger udg_trigger124= null
        trigger udg_trigger125= null
        trigger udg_trigger126= null
        trigger udg_trigger127= null
        trigger udg_trigger128= null
        trigger udg_trigger129= null
        trigger udg_trigger130= null
        trigger udg_trigger131= null
        trigger udg_trigger132= null
        trigger udg_trigger133= null
        trigger InitializeSingleDuelsTrigger= null
        trigger SinglePvpHeroDeathTrigger= null
        trigger SimultaneousPvpHeroDeathTrigger= null
        trigger StartSinglePvpDuelTrigger= null
        trigger StartSimultaneousPvpDuelTrigger= null
        trigger SinglePvpBetRewardTrigger= null
        trigger udg_trigger139= null
        trigger UpdatePvpSuddenDeathDamageTrigger= null
        trigger ApplyPvpSuddenDeathDamageTrigger= null
        trigger udg_trigger142= null
        trigger udg_trigger143= null
        trigger udg_trigger144= null
        trigger udg_trigger145= null
        trigger udg_trigger146= null
        trigger udg_trigger147= null
        trigger udg_trigger148= null
        trigger udg_trigger149= null
        trigger udg_trigger150= null
        trigger udg_trigger151= null
        trigger udg_trigger152= null
        trigger udg_trigger153= null
        trigger InitializeSimultaneousDuelsTrigger= null
        unit udg_unit06= null
        unit udg_unit07= null
        unit udg_unit08= null
        unit udg_unit09= null
        unit udg_unit10= null
        unit udg_unit11= null
        unit udg_unit12= null
        unit udg_unit13= null
        unit udg_unit14= null
        unit udg_unit15= null
        unit udg_unit16= null
        unit udg_unit17= null
        unit udg_unit18= null
        unit udg_unit19= null
        unit udg_unit20= null
        unit udg_unit21= null
        unit udg_unit22= null
        unit udg_unit23= null
        unit udg_unit24= null
        unit udg_unit25= null
        unit udg_unit26= null
        unit udg_unit27= null
        unit udg_unit28= null
        unit udg_unit29= null
        unit udg_unit30= null
        unit udg_unit31= null
        unit udg_unit32= null
        unit udg_unit33= null
        unit udg_unit34= null
        unit udg_unit35= null
        unit udg_unit36= null
        unit udg_unit37= null
        unit udg_unit38= null
        trigger udg_trigger154= null
        integer array udg_Skill
        string array udg_Description
        integer array udg_Items
        integer array udg_skills
        integer udg_Ingredients= 0
        integer array udg_RecipeFactor
        boolean array udg_FactorCleared
        integer udg_PlayerLumber= 0
        integer udg_WhirlwindDamage= 0
        integer udg_SaveSkillLevel= 0
        integer udg_MaxStr= 0
        integer udg_MaxInt= 0
        integer udg_MaxAgi= 0
        integer udg_BaseInt= 0
        integer udg_BaseStr= 0
        integer udg_BaseAgi= 0
        integer udg_MaxStat= 0
        integer udg_MaxBaseStat= 0
        integer udg_StatDifference= 0
        integer udg_WhirlwindLevel= 0
        integer udg_WhirlwindLevelMultiplier= 0
        integer udg_TrueshotMultiplier= 0
        integer udg_CommandMultiplier= 0
        integer udg_WarDrumsMultiplier= 0
        integer udg_WarDrumsDamage= 0
        integer udg_TrueShotDamage= 0
        integer udg_CommandDamage= 0
        integer udg_WhirlwindBaseDamage= 0
        unit udg_DrainAuraTarget= null
        integer udg_DrainDamage= 0
        unit udg_DrainAuraUser= null

    endglobals
    function InitGlobals3 takes nothing returns nothing
        local integer i = 0
        set BoughtAbility = 0	
        set roundAbilities = Table.create()
        //call BJDebugMsg("ra create")
        set i = 0
        loop
            exitwhen(i > 1)
            set HeroAbilityCount[i]= 0
            set i = i + 1
        endloop
        set i = 0
        loop
            exitwhen(i > 1)
            set CreepUnitTypeIds[i]= 0
            set i = i + 1
        endloop
        set RoundNumber = 0
        set RoundCreepNumber = 0
        set RoundCreepTypeId = 0
        set RoundCreepMaxAttackSpeed = 0
        set PlayerCount = 0
        set SpawnedHeroCount = 0
        set RoundFinishedCount = 0
        set RoundCreepPower = 0
        set RoundCreepMoveSpeed = 0
        set RoundCreepChanceBash = 0
        set RoundCreepChanceCritStrike = 0
        set RoundCreepChanceEvasion = 0
        set InitialPlayerCount = 0
        set udg_PlayersWithHero = CreateForce()
        
        set DefeatedPlayers = CreateForce()
        set PotentialDuelHeroes = CreateGroup()
        set DuelingHeroes = CreateGroup()
        set RoundCreepAbilCastChance = 0
        set i = 0
        loop
            exitwhen(i > 1)
            set DuelHeroItemIds1[i]= 0
            set i = i + 1
        endloop
        set i = 0
        loop
            exitwhen(i > 1)
            set DuelHeroItemIds2[i]= 0
            set i = i + 1
        endloop
        set DuelingHeroGroup = CreateGroup()
        set DuelWinners = CreateGroup()
        set DuelWinnerDisabled = CreateGroup()
        set PvpGoldWinAmount = 0
        set BrPlayerCount = 0
        set i = 0
        loop
            exitwhen(i > 1)
            
            set i = i + 1
        endloop
        set BrStarted = false
        set i = 0
        loop
            exitwhen(i > 1)
            set PlayerLastLearnedSpell[i]= 0
            set i = i + 1
        endloop
        set i = 0
        loop
            exitwhen(i > 1)
            
            set i = i + 1
        endloop
        set RoundCreepChanceCleave = 0
        set RoundCreepChanceLifesteal = 0
        set i = 0
        loop
            exitwhen(i > 1)
            set PlayerHeroPicked[i]= false
            set i = i + 1
        endloop
        set RoundPlayersCompleted = CreateForce()
        set CountdownCount = 0
        set RoundCreepChanceThorns = 0
        set i = 0
        loop
            exitwhen(i > 1)
            set Playtime[i]= 0
            set i = i + 1
        endloop
        set GameDurDialog = DialogCreate()
        set IncomeModeDialog = DialogCreate()
        set i = 0
        loop
            exitwhen(i > 1)
            set ModeVotesCount[i]= 0
            set i = i + 1
        endloop
        set RoundCreepChanceShockwave = 0
        set MaxCreepUnitTypes = 0
        set RoundCreepChanceManaBurn = 0
        set RoundCreepChanceHurlBoulder = 0
        set RoundCreepChanceRejuv = 0

        set AntiStuckPlayerId = 0
        set RoundGenCreepIndex = 0
        
        set ElimPlayerCount = 0
        set ElimDmHeroDeathFxIndex = 0
        set ElimPvpStarted = false
        set ElimModeEnabled = false
        set GameModeDialog = DialogCreate()
        set UnknownInteger01 = 0
        set ArNotLearningAbil = false
        set AbilModeDialog = DialogCreate()
        set PvpEndIndex = 0
        set PvpStartIndex = 0
        
        set ARLearningAbil = false
        set HideShopsCount = 0
        set i = 0
        loop
            exitwhen(i > 1)
            set ShopIds[i]= 0
            set i = i + 1
        endloop
        set HideShopsIndex = 0
        set UnknownInteger02 = 0
        set i = 0
        loop
            exitwhen(i > 1)
            set Dialogs[i]= DialogCreate()
            set i = i + 1
        endloop
        set udg_force04 = CreateForce()
        set udg_force05 = CreateForce()
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_booleans04[i]= false
            set i = i + 1
        endloop
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_booleans05[i]= false
            set i = i + 1
        endloop
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_integers11[i]= 0
            set i = i + 1
        endloop
        set udg_string01 = ""
        set udg_integer38 = 0
        set udg_force06 = CreateForce()
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_strings01[i]= ""
            set i = i + 1
        endloop
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_integers12[i]= 0
            set i = i + 1
        endloop
        set GameModeShort = false
        set SuddenDeathTick = 0
        set udg_dialog04 = DialogCreate()
        set udg_group05 = CreateGroup()
        set udg_integer40 = 0
        set udg_boolean09 = false
        set udg_integer41 = 0
        set udg_boolean10 = false
        set udg_boolean11 = false
        set udg_integer42 = 0
        set udg_integer43 = 0
        set udg_integer44 = 0
        set udg_integer45 = 0
        set udg_integer46 = 0
        set udg_integer47 = 0
        set udg_force07 = CreateForce()
        set udg_boolean12 = false
        set RoundCreepChanceSlow = 0
        set RoundCreepChanceBigBadV = 0
        set RoundCreepChanceFaerieFire = 0
        set udg_integer52 = 0
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_integers13[i]= 0
            set i = i + 1
        endloop
        set udg_integer53 = 0
        set udg_group06 = CreateGroup()
        set RoundCreepChanceBlink = 0
        set RoundCreepChanceThunderClap = 0
        set BettingPlayerCount = 0
        set udg_group07 = CreateGroup()
        set GroupEmptyArenaCheck = CreateGroup()
        set SuddenDeathDamageMultiplier = 0
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_integers14[i]= 0
            set i = i + 1
        endloop
        set udg_integer57 = 0
        set udg_integer58 = 0
        set udg_integer59 = 0
        set udg_integer60 = 0
        set udg_integer61 = 0
        set BettingModeDialog = DialogCreate()
        set BettingEnabled = false
        set udg_boolean14 = false
        set udg_dialog06 = DialogCreate()
        set udg_boolean15 = false
        set HeroModeDialog = DialogCreate()
        set RandomHeroMode = false
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_integers15[i]= 0
            set i = i + 1
        endloop
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_integers16[i]= 0
            set i = i + 1
        endloop
        set udg_integer62 = 0
        set udg_real04 = 0
        set udg_boolean17 = false
        set i = 0
        loop
            exitwhen(i > 1)
            set ModeDescriptionBuilder[i]= ""
            set i = i + 1
        endloop
        set udg_group09 = CreateGroup()
        set AllowBetSelection = false
        set udg_integer63 = 0
    endfunction
    function InitGlobals2 takes nothing returns nothing
        local integer i = 0
        set i = 0
        loop
            exitwhen(i > 1)
            set HeroAbilityCount[i]= 0
            set i = i + 1
        endloop
        set RoundNumber = 0
        set RoundCreepNumber = 0
        set RoundCreepMaxAttackSpeed = 0
        set PlayerCount = 0
        set SpawnedHeroCount = 0
        set RoundFinishedCount = 0
        set RoundCreepPower = 0
        set RoundCreepMoveSpeed = 0
        set RoundCreepChanceBash = 0
        set RoundCreepChanceCritStrike = 0
        set RoundCreepChanceEvasion = 0
        set InitialPlayerCount = 0
        set udg_PlayersWithHero = CreateForce()
        
        set DefeatedPlayers = CreateForce()
        set PotentialDuelHeroes = CreateGroup()
        set DuelingHeroes = CreateGroup()
        set RoundCreepAbilCastChance = 0
        set DuelingHeroGroup = CreateGroup()
        set DuelWinners = CreateGroup()
        set DuelWinnerDisabled = CreateGroup()
        set BrPlayerCount = 0

        set BrStarted = false
        set RoundCreepChanceCleave = 0
        set RoundCreepChanceLifesteal = 0
        set i = 0
        loop
            exitwhen(i > 1)
            set PlayerHeroPicked[i]= false
            set i = i + 1
        endloop
        set RoundPlayersCompleted = CreateForce()
        set CountdownCount = 0
        set RoundCreepChanceThorns = 0
        set i = 0
        loop
            exitwhen(i > 1)
            set Playtime[i]= 0
            set i = i + 1
        endloop
        set GameDurDialog = DialogCreate()
        set i = 0
        loop
            exitwhen(i > 1)
            set ModeVotesCount[i]= 0
            set i = i + 1
        endloop
        set RoundCreepChanceShockwave = 0
        set MaxCreepUnitTypes = 0
        set RoundCreepChanceManaBurn = 0
        set RoundCreepChanceHurlBoulder = 0
        set RoundCreepChanceRejuv = 0
        
        set AntiStuckPlayerId = 0
        set RoundGenCreepIndex = 0
        
        set ElimPlayerCount = 0
        set ElimDmHeroDeathFxIndex = 0
        set ElimPvpStarted = false
        set ElimModeEnabled = false
        set GameModeDialog = DialogCreate()
        set UnknownInteger01 = 0
        set ArNotLearningAbil = false
        set AbilModeDialog = DialogCreate()
        set PvpEndIndex = 0
        set PvpStartIndex = 0
        
        set ARLearningAbil = false
        set HideShopsCount = 0
        set HideShopsIndex = 0
        set UnknownInteger02 = 0
        set i = 0
        loop
            exitwhen(i > 4)
            set Dialogs[i]= DialogCreate()
            set i = i + 1
        endloop
        set udg_force04 = CreateForce()
        set udg_force05 = CreateForce()
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_booleans04[i]= false
            set i = i + 1
        endloop
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_booleans05[i]= false
            set i = i + 1
        endloop
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_integers11[i]= 0
            set i = i + 1
        endloop
        set udg_string01 = ""
        set udg_integer38 = 0
        set udg_force06 = CreateForce()
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_strings01[i]= ""
            set i = i + 1
        endloop
        set i = 0
        loop
            exitwhen(i > 3)
            set udg_integers12[i]= 0
            set i = i + 1
        endloop
        set GameModeShort = false
        set SuddenDeathTick = 0
        set udg_dialog04 = DialogCreate()
        set udg_group05 = CreateGroup()
        set udg_integer40 = 0
        set udg_boolean09 = false
        set udg_integer41 = 0
        set udg_boolean10 = false
        set udg_boolean11 = false
        set udg_integer42 = 0
        set udg_integer43 = 0
        set udg_integer44 = 0
        set udg_integer45 = 0
        set udg_integer46 = 0
        set udg_integer47 = 0
        set udg_force07 = CreateForce()
        set udg_boolean12 = false
        set RoundCreepChanceSlow = 0
        set RoundCreepChanceBigBadV = 0
        set RoundCreepChanceFaerieFire = 0
        set udg_integer52 = 0
        set i = 0
        loop
            exitwhen(i > 8)
            set udg_integers13[i]= 10
            set i = i + 1
        endloop
        set udg_integer53 = 0
        set udg_group06 = CreateGroup()
        set RoundCreepChanceBlink = 0
        set RoundCreepChanceThunderClap = 0
        set BettingPlayerCount = 0
        set udg_group07 = CreateGroup()
        set GroupEmptyArenaCheck = CreateGroup()
        set SuddenDeathDamageMultiplier = 0
        set udg_integer57 = 0
        set udg_integer58 = 0
        set udg_integer59 = 0
        set udg_integer60 = 0
        set udg_integer61 = 0
        set BettingModeDialog = DialogCreate()
        set BettingEnabled = false
        set udg_boolean14 = false
        set udg_dialog06 = DialogCreate()
        set udg_boolean15 = false
        set HeroModeDialog = DialogCreate()
        set RandomHeroMode = false
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_integers15[i]= 0
            set i = i + 1
        endloop
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_integers16[i]= 0
            set i = i + 1
        endloop
        set udg_integer62 = 0
        set udg_real04 = 10.00
        set udg_boolean17 = false
        set i = 0
        loop
            exitwhen(i > 1)
            set ModeDescriptionBuilder[i]= ""
            set i = i + 1
        endloop
        set udg_group09 = CreateGroup()
        set AllowBetSelection = false
        set udg_integer63 = 0
    endfunction

    function CreateRegions2 takes nothing returns nothing
        local weathereffect we
        set RectP1Arena = Rect(- 4384.0,2400.0,- 2784.0,4000.0)
        set RectP2Arena = Rect(- 800.0,2400.0,800.0,4000.0)
        set RectP3Arena = Rect(2784.0,2400.0,4384.0,4000.0)
        set RectP4Arena = Rect(2784.0,- 1056.0,4384.0,544.0)
        set RectP5Arena = Rect(2784.0,- 4512.0,4384.0,- 2912.0)
        set RectP6Arena = Rect(- 800.0,- 4512.0,800.0,- 2912.0)
        set RectP7Arena = Rect(- 4384.0,- 4512.0,- 2784.0,- 2912.0)
        set RectP8Arena = Rect(- 4384.0,- 1056.0,- 2784.0,544.0)
        set RectMidArena = Rect(- 1696.0,- 1952.0,1696.0,1440.0)
    endfunction

    function Trig_Pulverize_Func001C takes nothing returns boolean
        if(not(GetUnitAbilityLevelSwapped('Awar',GetEventDamageSource())> 0))then
            return false
        endif
        if(not(IsUnitAliveBJ(GetEventDamageSource())==true))then
            return false
        endif
        if(not(IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetEventDamageSource()))==true))then
            return false
        endif
        return true
    endfunction
    function Trig_Pulverize_Conditions takes nothing returns boolean
        if(not Trig_Pulverize_Func001C())then
            return false
        endif
        return true
    endfunction
    function Trig_Pulverize_Func003Func004001003001001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    function Trig_Pulverize_Func003Func004001003001002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_GROUND)==true)
    endfunction
    function Trig_Pulverize_Func003Func004001003001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Pulverize_Func003Func004001003001001(),Trig_Pulverize_Func003Func004001003001002())
    endfunction
    function Trig_Pulverize_Func003Func004001003002001 takes nothing returns boolean
        return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetEventDamageSource()))==true)
    endfunction
    function Trig_Pulverize_Func003Func004001003002002 takes nothing returns boolean
        return(UnitHasBuffBJ(GetFilterUnit(),'BOvd')!=true)
    endfunction
    function Trig_Pulverize_Func003Func004001003002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Pulverize_Func003Func004001003002001(),Trig_Pulverize_Func003Func004001003002002())
    endfunction
    function Trig_Pulverize_Func003Func004001003 takes nothing returns boolean
        return GetBooleanAnd(Trig_Pulverize_Func003Func004001003001(),Trig_Pulverize_Func003Func004001003002())
    endfunction
    function Trig_Pulverize_Func003Func004A takes nothing returns nothing
        call UnitDamageTargetBJ(GetEventDamageSource(),GetEnumUnit(),(30.00 * I2R(GetUnitAbilityLevelSwapped('Awar',GetEventDamageSource()))),ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC)
    endfunction
    function Trig_Pulverize_Func003Func005001003001001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    function Trig_Pulverize_Func003Func005001003001002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_GROUND)==true)
    endfunction
    function Trig_Pulverize_Func003Func005001003001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Pulverize_Func003Func005001003001001(),Trig_Pulverize_Func003Func005001003001002())
    endfunction
    function Trig_Pulverize_Func003Func005001003002001 takes nothing returns boolean
        return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetEventDamageSource()))==true)
    endfunction
    function Trig_Pulverize_Func003Func005001003002002 takes nothing returns boolean
        return(UnitHasBuffBJ(GetFilterUnit(),'BOvd')!=true)
    endfunction
    function Trig_Pulverize_Func003Func005001003002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Pulverize_Func003Func005001003002001(),Trig_Pulverize_Func003Func005001003002002())
    endfunction
    function Trig_Pulverize_Func003Func005001003 takes nothing returns boolean
        return GetBooleanAnd(Trig_Pulverize_Func003Func005001003001(),Trig_Pulverize_Func003Func005001003002())
    endfunction

    function main2 takes nothing returns nothing
        local trigger trg
        call SetCameraBounds(- 5376.0 + GetCameraMargin(CAMERA_MARGIN_LEFT),- 5632.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM),5376.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT),5120.0 - GetCameraMargin(CAMERA_MARGIN_TOP),- 5376.0 + GetCameraMargin(CAMERA_MARGIN_LEFT),5120.0 - GetCameraMargin(CAMERA_MARGIN_TOP),5376.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT),- 5632.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
        call SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl","Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
        call NewSoundEnvironment("Default")
        call SetAmbientDaySound("SunkenRuinsDay")
        call SetAmbientNightSound("SunkenRuinsNight")
        call SetMapMusic("Music",true,0)
        set udg_sound01 = CreateSound("Sound\\Interface\\QuestNew.wav",false,false,false,10,10,"")
        call SetSoundParamsFromLabel(udg_sound01,"QuestNew")
        call SetSoundDuration(udg_sound01,3750)
        set udg_sound02 = CreateSound("Sound\\Interface\\QuestCompleted.wav",false,false,false,10,10,"")
        call SetSoundParamsFromLabel(udg_sound02,"QuestCompleted")
        call SetSoundDuration(udg_sound02,5154)
        set udg_sound03 = CreateSound("Sound\\Interface\\QuestActivateWhat1.wav",false,false,false,10,10,"")
        call SetSoundParamsFromLabel(udg_sound03,"QuestLogModified")
        call SetSoundDuration(udg_sound03,539)
        set udg_sound04 = CreateSound("Sound\\Interface\\UpkeepRing.wav",false,false,false,10,10,"")
        call SetSoundParamsFromLabel(udg_sound04,"UpkeepLevel")
        call SetSoundDuration(udg_sound04,1578)
        set udg_sound05 = CreateSound("Sound\\Music\\mp3Music\\HeroicVictory.mp3",false,false,false,10,10,"")
        call SetSoundDuration(udg_sound05,53472)
        call SetSoundChannel(udg_sound05,0)
        call SetSoundVolume(udg_sound05,127)
        call SetSoundPitch(udg_sound05,1.0)
        set udg_sound06 = CreateSound("Sound\\Music\\mp3Music\\TragicConfrontation.mp3",false,false,false,10,10,"")
        call SetSoundDuration(udg_sound06,72254)
        call SetSoundChannel(udg_sound06,0)
        call SetSoundVolume(udg_sound06,127)
        call SetSoundPitch(udg_sound06,1.0)
        set udg_sound07 = CreateSound("Sound\\Interface\\ItemReceived.wav",false,false,false,10,10,"")
        call SetSoundParamsFromLabel(udg_sound07,"ItemReward")
        call SetSoundDuration(udg_sound07,1483)
        set udg_sound08 = CreateSound("Sound\\Interface\\ClanInvitation.wav",false,false,false,10,10,"")
        call SetSoundParamsFromLabel(udg_sound08,"ClanInvitation")
        call SetSoundDuration(udg_sound08,4295)
        set udg_sound09 = CreateSound("Sound\\Interface\\BattleNetTick.wav",false,false,false,10,10,"")
        call SetSoundParamsFromLabel(udg_sound09,"ChatroomTimerTick")
        call SetSoundDuration(udg_sound09,476)
        set udg_sound10 = CreateSound("Sound\\Interface\\NewTournament.wav",false,false,false,10,10,"")
        call SetSoundParamsFromLabel(udg_sound10,"NewTournament")
        call SetSoundDuration(udg_sound10,7987)
        set udg_sound11 = CreateSound("Sound\\Interface\\Rescue.wav",false,false,false,10,10,"")
        call SetSoundParamsFromLabel(udg_sound11,"Rescue")
        call SetSoundDuration(udg_sound11,3796)
        set udg_sound12 = CreateSound("Sound\\Dialogue\\GenericWarnings\\GenericWarningHeroFallen1.mp3",false,false,false,10,10,"DefaultEAXON")
        call SetSoundParamsFromLabel(udg_sound12,"HeroDiesGeneric")
        call SetSoundDuration(udg_sound12,1593)
        call SetSoundVolume(udg_sound12,127)
        call SetSoundPitch(udg_sound12,0.9)
        set udg_sound13 = CreateSound("Units\\Undead\\Varimathras\\VarimathrasPissed8.wav",false,false,true,10,10,"HeroAcksEAX")
        call SetSoundParamsFromLabel(udg_sound13,"VarimathrasPissed")
        call SetSoundDuration(udg_sound13,8906)
        set udg_sound14 = CreateSound("Sound\\Interface\\SecretFound.wav",false,false,false,10,10,"")
        call SetSoundParamsFromLabel(udg_sound14,"SecretFound")
        call SetSoundDuration(udg_sound14,2525)
        set udg_sound15 = CreateSound("Sound\\Interface\\ArrangedTeamInvitation.wav",false,false,false,10,10,"")
        call SetSoundParamsFromLabel(udg_sound15,"ArrangedTeamInvitation")
        call SetSoundDuration(udg_sound15,2914)
        set udg_sound16 = CreateSound("Sound\\Music\\mp3Music\\Tension.mp3",false,false,false,10,10,"")
        call SetSoundDuration(udg_sound16,19565)
        call SetSoundChannel(udg_sound16,0)
        call SetSoundVolume(udg_sound16,127)
        call SetSoundPitch(udg_sound16,1.0)
        set udg_sound17 = CreateSound("Units\\Creeps\\PandarenBrewmaster\\BrewMasterDeath1.wav",false,true,true,10,10,"DefaultEAXON")
        call SetSoundParamsFromLabel(udg_sound17,"PandarenBrewmasterDeath")
        call SetSoundDuration(udg_sound17,2699)
        set udg_sound18 = CreateSound("Units\\Creeps\\PandarenBrewmaster\\BrewMasterDeath1.wav",false,true,true,10,10,"DefaultEAXON")
        call SetSoundParamsFromLabel(udg_sound18,"PandarenBrewmasterDeath")
        call SetSoundDuration(udg_sound18,2699)
        set udg_sound19 = CreateSound("Units\\Creeps\\PandarenBrewmaster\\BrewMasterDeath1.wav",false,true,true,10,10,"DefaultEAXON")
        call SetSoundParamsFromLabel(udg_sound19,"PandarenBrewmasterDeath")
        call SetSoundDuration(udg_sound19,2699)
        set udg_sound20 = CreateSound("Units\\Creeps\\PandarenBrewmaster\\BrewMasterDeath1.wav",false,true,true,10,10,"DefaultEAXON")
        call SetSoundParamsFromLabel(udg_sound20,"PandarenBrewmasterDeath")
        call SetSoundDuration(udg_sound20,2699)
        set udg_sound21 = CreateSound("Units\\Creeps\\PandarenBrewmaster\\BrewMasterDeath1.wav",false,true,true,10,10,"DefaultEAXON")
        call SetSoundParamsFromLabel(udg_sound21,"PandarenBrewmasterDeath")
        call SetSoundDuration(udg_sound21,2699)
        set udg_sound22 = CreateSound("Units\\Creeps\\PandarenBrewmaster\\BrewMasterDeath1.wav",false,true,true,10,10,"DefaultEAXON")
        call SetSoundParamsFromLabel(udg_sound22,"PandarenBrewmasterDeath")
        call SetSoundDuration(udg_sound22,2699)
        set udg_sound23 = CreateSound("Units\\Creeps\\PandarenBrewmaster\\BrewMasterDeath1.wav",false,true,true,10,10,"DefaultEAXON")
        call SetSoundParamsFromLabel(udg_sound23,"PandarenBrewmasterDeath")
        call SetSoundDuration(udg_sound23,2699)
        set udg_sound24 = CreateSound("Units\\Creeps\\PandarenBrewmaster\\BrewMasterDeath1.wav",false,true,true,10,10,"DefaultEAXON")
        call SetSoundParamsFromLabel(udg_sound24,"PandarenBrewmasterDeath")
        call SetSoundDuration(udg_sound24,2699)
        set udg_sound25 = CreateSound("Sound\\Interface\\QuestLog.wav",false,false,false,10,10,"")
        call SetSoundParamsFromLabel(udg_sound25,"QuestUpdate")
        call SetSoundDuration(udg_sound25,2275)
        call CreateRegions2()
        set udg_camerasetup01 = CreateCameraSetup()
        call CameraSetupSetField(udg_camerasetup01,CAMERA_FIELD_ZOFFSET,0.0,0.0)
        call CameraSetupSetField(udg_camerasetup01,CAMERA_FIELD_ROTATION,90.0,0.0)
        call CameraSetupSetField(udg_camerasetup01,CAMERA_FIELD_ANGLE_OF_ATTACK,305.0,0.0)
        call CameraSetupSetField(udg_camerasetup01,CAMERA_FIELD_TARGET_DISTANCE,2855.0,0.0)
        call CameraSetupSetField(udg_camerasetup01,CAMERA_FIELD_ROLL,0.0,0.0)
        call CameraSetupSetField(udg_camerasetup01,CAMERA_FIELD_FIELD_OF_VIEW,70.0,0.0)
        call CameraSetupSetField(udg_camerasetup01,CAMERA_FIELD_FARZ,10000.0,0.0)
        call CameraSetupSetDestPosition(udg_camerasetup01,0.0,- 320.0,0.0)
        call InitGlobals2()
        set trg = null
    endfunction
    function main3 takes nothing returns nothing
        call SetCameraBounds(- 5376.0 + GetCameraMargin(CAMERA_MARGIN_LEFT),- 5632.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM),5376.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT),5120.0 - GetCameraMargin(CAMERA_MARGIN_TOP),- 5376.0 + GetCameraMargin(CAMERA_MARGIN_LEFT),5120.0 - GetCameraMargin(CAMERA_MARGIN_TOP),5376.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT),- 5632.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
        call SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl","Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
        call NewSoundEnvironment("Default")
        call SetAmbientDaySound("SunkenRuinsDay")
        call SetAmbientNightSound("SunkenRuinsNight")
        call SetMapMusic("Music",true,0)
        call InitGlobals3()
        call ExecuteFunc("main2")
    endfunction
endlibrary

library OldCodeInit 
    public function start takes nothing returns nothing
        call ConditionalTriggerExecute(udg_trigger89)
        call ConditionalTriggerExecute(udg_trigger91)
        call ConditionalTriggerExecute(udg_trigger92)
        call ConditionalTriggerExecute(udg_trigger103)
    endfunction                                                 
endlibrary
