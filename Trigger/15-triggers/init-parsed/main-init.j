library OldInitialization initializer main3
    globals
        unit array CicrleUnit
        boolean ModeNoDeath = false
        integer MorePvp = 1 
        boolean duel
        integer IncomeMode = 0
        integer AbilityMode = 0
        integer array LumberGained
        dialog IncomeDialog
        Table roundAbilities
        string RoundCreepTitle
        string array RoundCreepInfo
        string RoundAbilities = ""
        integer ReflectionAuraChance = 0
        integer WizardbaneAuraChance = 0
        integer DrunkenMasterchance = 0
        integer SlowAuraChance = 0
        integer PulverizeChance = 0 
        integer LastBreathChance = 0
        integer FireshieldChance = 0
        integer CorrosiveSkinChance = 0 
        integer MulticastChance = 0
        integer FastMagicChance = 0
        boolean SuddenDeathEnabled = false
        boolean array RoundLiveLost
        player WinningPlayer
        boolean array DisableDeathTrigger

        //default variables
        //Todo set default values from initglobals2 and 3 here so those functions can be removed
        unit array udg_units01
        integer udg_integer01= 0
        integer array udg_integers01
        integer array udg_integers02
        integer udg_integer02= 0
        integer udg_integer03= 0
        integer udg_integer04= 0
        rect array udg_rects01
        integer udg_integer05= 0
        integer udg_integer06= 0
        integer udg_integer07= 0
        integer udg_integer08= 0
        real udg_real01= 0
        integer udg_integer09= 0
        integer udg_integer10= 0
        integer udg_integer11= 0
        integer udg_integer12= 0
        player udg_player01= null
        integer udg_integer13= 0
        unit array udg_units02
        boolean udg_boolean01= false
        force udg_force02= null
        group udg_group01= null
        unit array udg_units03
        integer udg_integer14= 0
        integer array udg_integers03
        integer array udg_integers04
        group udg_group02= null
        group udg_group03= null
        integer udg_integer15= 0
        integer udg_integer16= 0
        boolean array udg_booleans01
        boolean udg_boolean02= false
        integer array udg_integers05
        boolean array udg_booleans02
        integer udg_integer17= 0
        integer udg_integer18= 0
        item array udg_items01
        boolean array udg_booleans03
        force udg_force03= null
        location udg_location01= null
        integer udg_integer19= 0
        integer udg_integer20= 0
        real udg_real02= 0
        unit udg_unit01= null
        integer array udg_integers06
        dialog udg_dialog01= null
        button array udg_buttons01
        integer array udg_integers07
        integer udg_integer21= 0
        integer udg_integer22= 0
        integer udg_integer23= 0
        integer udg_integer24= 0
        integer udg_integer25= 0
        integer array udg_integers08
        integer array udg_integers09
        integer udg_integer26= 0
        integer udg_integer27= 0
        integer udg_integer28= 0
        group udg_group04= null
        integer udg_integer29= 0
        integer udg_integer30= 0
        boolean udg_boolean03= false
        boolean udg_boolean04= false
        dialog udg_dialog02= null
        integer udg_integer31= 0
        boolean udg_boolean05= false
        dialog udg_dialog03= null
        player udg_player02= null
        integer udg_integer32= 0
        integer udg_integer33= 0
        integer udg_integer34= 0
        boolean udg_boolean06= false
        location array udg_locations01
        integer udg_integer35= 0
        integer array udg_integers10
        integer udg_integer36= 0
        integer udg_integer37= 0
        dialog array udg_dialogs01
        button array udg_buttons02
        force udg_force04= null
        force udg_force05= null
        boolean array udg_booleans04
        boolean array udg_booleans05
        integer array udg_integers11
        string udg_string01
        integer udg_integer38= 0
        boolean udg_boolean07= false
        force udg_force06= null
        string array udg_strings01
        integer array udg_integers12
        boolean udg_boolean08= false
        integer udg_integer39= 0
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
        integer udg_integer48= 0
        integer udg_integer49= 0
        integer udg_integer50= 0
        integer udg_integer51= 0
        integer udg_integer52= 0
        integer array udg_integers13
        integer udg_integer53= 0
        effect array udg_effects01
        effect array udg_effects02
        group udg_group06= null
        integer udg_integer54= 0
        integer udg_integer55= 0
        integer udg_integer56= 0
        group udg_group07= null
        sound array udg_sounds01
        group udg_group08= null
        real udg_real03= 0
        unit udg_unit02= null
        integer array udg_integers14
        integer udg_integer57= 0
        integer udg_integer58= 0
        integer udg_integer59= 0
        integer udg_integer60= 0
        integer udg_integer61= 0
        dialog udg_dialog05= null
        boolean udg_boolean13= false
        boolean udg_boolean14= false
        dialog udg_dialog06= null
        button array udg_buttons04
        boolean udg_boolean15= false
        player udg_player03= null
        dialog udg_dialog07= null
        boolean udg_boolean16= false
        integer array udg_integers15
        integer array udg_integers16
        integer udg_integer62= 0
        real udg_real04= 0
        boolean udg_boolean17= false
        string array udg_strings02
        unit udg_unit03= null
        group udg_group09= null
        location udg_location02= null
        unit udg_unit04= null
        boolean udg_boolean18= false
        unit udg_unit05= null
        integer udg_integer63= 0
        rect udg_rect01= null
        rect udg_rect02= null
        rect udg_rect03= null
        rect udg_rect04= null
        rect udg_rect05= null
        rect udg_rect06= null
        rect udg_rect07= null
        rect udg_rect08= null
        rect udg_rect09= null
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
        trigger udg_trigger54= null
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
        trigger udg_trigger112= null
        trigger udg_trigger113= null
        trigger udg_trigger114= null
        trigger udg_trigger115= null
        trigger udg_trigger116= null
        trigger udg_trigger117= null
        trigger udg_trigger118= null
        trigger udg_trigger119= null
        trigger udg_trigger120= null
        trigger udg_trigger121= null
        trigger udg_trigger122= null
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
        trigger udg_trigger134= null
        trigger udg_trigger135= null
        trigger udg_trigger136= null
        trigger udg_trigger137= null
        trigger udg_trigger138= null
        trigger udg_trigger139= null
        trigger udg_trigger140= null
        trigger udg_trigger141= null
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
        set udg_integer01 = 0	
        set roundAbilities = Table.create()
        //call BJDebugMsg("ra create")
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_integers01[i]= 0
            set i = i + 1
        endloop
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_integers02[i]= 0
            set i = i + 1
        endloop
        set udg_integer02 = 0
        set udg_integer03 = 0
        set udg_integer04 = 0
        set udg_integer05 = 0
        set udg_integer06 = 0
        set udg_integer07 = 0
        set udg_integer08 = 0
        set udg_real01 = 0
        set udg_integer09 = 0
        set udg_integer10 = 0
        set udg_integer11 = 0
        set udg_integer12 = 0
        set udg_integer13 = 0
        set udg_force01 = CreateForce()
        set udg_boolean01 = false
        set udg_force02 = CreateForce()
        set udg_group01 = CreateGroup()
        set udg_integer14 = 0
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_integers03[i]= 0
            set i = i + 1
        endloop
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_integers04[i]= 0
            set i = i + 1
        endloop
        set udg_group02 = CreateGroup()
        set udg_group03 = CreateGroup()
        set udg_integer15 = 0
        set udg_integer16 = 0
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_booleans01[i]= false
            set i = i + 1
        endloop
        set udg_boolean02 = false
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_integers05[i]= 0
            set i = i + 1
        endloop
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_booleans02[i]= false
            set i = i + 1
        endloop
        set udg_integer17 = 0
        set udg_integer18 = 0
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_booleans03[i]= false
            set i = i + 1
        endloop
        set udg_force03 = CreateForce()
        set udg_integer19 = 0
        set udg_integer20 = 0
        set udg_real02 = 0
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_integers06[i]= 0
            set i = i + 1
        endloop
        set udg_dialog01 = DialogCreate()
        set IncomeDialog = DialogCreate()
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_integers07[i]= 0
            set i = i + 1
        endloop
        set udg_integer21 = 0
        set udg_integer22 = 0
        set udg_integer23 = 0
        set udg_integer24 = 0
        set udg_integer25 = 0
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_integers08[i]= 0
            set i = i + 1
        endloop
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_integers09[i]= 0
            set i = i + 1
        endloop
        set udg_integer26 = 0
        set udg_integer27 = 0
        set udg_integer28 = 0
        set udg_group04 = CreateGroup()
        set udg_integer29 = 0
        set udg_integer30 = 0
        set udg_boolean03 = false
        set udg_boolean04 = false
        set udg_dialog02 = DialogCreate()
        set udg_integer31 = 0
        set udg_boolean05 = false
        set udg_dialog03 = DialogCreate()
        set udg_integer32 = 0
        set udg_integer33 = 0
        set udg_integer34 = 0
        set udg_boolean06 = false
        set udg_integer35 = 0
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_integers10[i]= 0
            set i = i + 1
        endloop
        set udg_integer36 = 0
        set udg_integer37 = 0
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_dialogs01[i]= DialogCreate()
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
        set udg_boolean07 = false
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
        set udg_boolean08 = false
        set udg_integer39 = 0
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
        set udg_integer48 = 0
        set udg_integer49 = 0
        set udg_integer50 = 0
        set udg_integer51 = 0
        set udg_integer52 = 0
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_integers13[i]= 0
            set i = i + 1
        endloop
        set udg_integer53 = 0
        set udg_group06 = CreateGroup()
        set udg_integer54 = 0
        set udg_integer55 = 0
        set udg_integer56 = 0
        set udg_group07 = CreateGroup()
        set udg_group08 = CreateGroup()
        set udg_real03 = 0
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
        set udg_dialog05 = DialogCreate()
        set udg_boolean13 = false
        set udg_boolean14 = false
        set udg_dialog06 = DialogCreate()
        set udg_boolean15 = false
        set udg_dialog07 = DialogCreate()
        set udg_boolean16 = false
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
            set udg_strings02[i]= ""
            set i = i + 1
        endloop
        set udg_group09 = CreateGroup()
        set udg_boolean18 = false
        set udg_integer63 = 0
    endfunction
    function InitGlobals2 takes nothing returns nothing
        local integer i = 0
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_integers01[i]= 0
            set i = i + 1
        endloop
        set udg_integer02 = 0
        set udg_integer03 = 0
        set udg_integer05 = 0
        set udg_integer06 = 0
        set udg_integer07 = 0
        set udg_integer08 = 0
        set udg_real01 = 0
        set udg_integer09 = 0
        set udg_integer10 = 0
        set udg_integer11 = 0
        set udg_integer12 = 0
        set udg_integer13 = 0
        set udg_force01 = CreateForce()
        set udg_boolean01 = false
        set udg_force02 = CreateForce()
        set udg_group01 = CreateGroup()
        set udg_integer14 = 0
        set udg_group02 = CreateGroup()
        set udg_group03 = CreateGroup()
        set udg_integer16 = 0
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_booleans01[i]= false
            set i = i + 1
        endloop
        set udg_boolean02 = false
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_booleans02[i]= false
            set i = i + 1
        endloop
        set udg_integer17 = 0
        set udg_integer18 = 0
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_booleans03[i]= false
            set i = i + 1
        endloop
        set udg_force03 = CreateForce()
        set udg_integer19 = 0
        set udg_integer20 = 0
        set udg_real02 = 0
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_integers06[i]= 0
            set i = i + 1
        endloop
        set udg_dialog01 = DialogCreate()
        set i = 0
        loop
            exitwhen(i > 1)
            set udg_integers07[i]= 0
            set i = i + 1
        endloop
        set udg_integer21 = 0
        set udg_integer22 = 0
        set udg_integer23 = 0
        set udg_integer24 = 0
        set udg_integer25 = 0
        set udg_integer26 = 0
        set udg_integer27 = 0
        set udg_integer28 = 0
        set udg_group04 = CreateGroup()
        set udg_integer29 = 0
        set udg_integer30 = 0
        set udg_boolean03 = false
        set udg_boolean04 = false
        set udg_dialog02 = DialogCreate()
        set udg_integer31 = 0
        set udg_boolean05 = false
        set udg_dialog03 = DialogCreate()
        set udg_integer32 = 0
        set udg_integer33 = 0
        set udg_integer34 = 0
        set udg_boolean06 = false
        set udg_integer35 = 0
        set udg_integer36 = 0
        set udg_integer37 = 0
        set i = 0
        loop
            exitwhen(i > 4)
            set udg_dialogs01[i]= DialogCreate()
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
        set udg_boolean07 = false
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
        set udg_boolean08 = false
        set udg_integer39 = 0
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
        set udg_integer48 = 0
        set udg_integer49 = 0
        set udg_integer50 = 0
        set udg_integer51 = 0
        set udg_integer52 = 0
        set i = 0
        loop
            exitwhen(i > 8)
            set udg_integers13[i]= 10
            set i = i + 1
        endloop
        set udg_integer53 = 0
        set udg_group06 = CreateGroup()
        set udg_integer54 = 0
        set udg_integer55 = 0
        set udg_integer56 = 0
        set udg_group07 = CreateGroup()
        set udg_group08 = CreateGroup()
        set udg_real03 = 0
        set udg_integer57 = 0
        set udg_integer58 = 0
        set udg_integer59 = 0
        set udg_integer60 = 0
        set udg_integer61 = 0
        set udg_dialog05 = DialogCreate()
        set udg_boolean13 = false
        set udg_boolean14 = false
        set udg_dialog06 = DialogCreate()
        set udg_boolean15 = false
        set udg_dialog07 = DialogCreate()
        set udg_boolean16 = false
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
            set udg_strings02[i]= ""
            set i = i + 1
        endloop
        set udg_group09 = CreateGroup()
        set udg_boolean18 = false
        set udg_integer63 = 0
    endfunction
    function CreateUnitsForPlayer8 takes nothing returns nothing
        local player p = Player(8)
        local unit u
        local integer unitID
        local trigger t
        local real life
        set u = CreateUnit(p,'O000',768.0,- 253.6,270.000)
        set u = CreateUnit(p,'O008',0.6,- 1022.1,270.000)
        set u = CreateUnit(p,'O002',- 257.3,- 250.1,270.000)
        set u = CreateUnit(p,'O005',- 255.5,258.1,270.000)
        set u = CreateUnit(p,'H000',256.9,- 253.6,270.000)
        set u = CreateUnit(p,'H001',3.8,- 512.6,280.000)
        set u = CreateUnit(p,'H002',- 255.8,- 511.2,270.000)
        set u = CreateUnit(p,'H003',256.8,- 511.2,270.000)
        set u = CreateUnit(p,'N00B',256.8,3.6,270.000)
        set u = CreateUnit(p,'E000',- 257.6,- 1.0,270.000)
        set udg_unit35 = CreateUnit(p,'N00C',514.7,- 1.0,270.000)
        set u = CreateUnit(p,'O003',0.6,256.5,270.000)
        set u = CreateUnit(p,'H004',514.7,- 255.3,270.000)
        set u = CreateUnit(p,'U000',514.2,- 511.8,270.000)
        set u = CreateUnit(p,'H005',- 512.6,2.1,270.000)
        set u = CreateUnit(p,'O004',- 510.4,- 252.7,270.000)
        set u = CreateUnit(p,'N00I',- 511.3,- 507.4,270.000)
        set u = CreateUnit(p,'n00J',1.6,- 254.0,270.000)
        set u = CreateUnit(p,'N00L',- 767.3,- 255.3,270.000)
        set u = CreateUnit(p,'N00K',256.1,258.7,270.000)
        set u = CreateUnit(p,'H006',0.7,513.0,270.000)
        set u = CreateUnit(p,'N024',256.9,513.0,270.000)
        set u = CreateUnit(p,'H016',- 256.9,513.0,270.000)
        set u = CreateUnit(p,'H017',512,513.0,270.000)
        set u = CreateUnit(p,'N02K',- 512,513.0,270.000)
        set u = CreateUnit(p,'H018',- 768.0,- 768.0,270.000)    
        set u = CreateUnit(p,'H019',- 768.0,- 513.0,270.000)    
        set u = CreateUnit(p,'N02P',- 768.0,0.6,270.000)
        set u = CreateUnit(p,'H01B',- 768.0,256,270.000)
        set u = CreateUnit(p,'H01C',- 768.0,513,270.000)
        set u = CreateUnit(p,'H01D',768.0,- 507.4,270.000)
        set u = CreateUnit(p,'H01E',768.0,- 768.0,270.000)
        set u = CreateUnit(p,'O00A',768.0,513,270.000)
        set u = CreateUnit(p,'O00B',768.0,256,270.000)
        set u = CreateUnit(p,'O00C',768.0,0,270.000)
        set udg_unit36 = CreateUnit(p,'N00O',- 252.1,- 775.2,270.000)
        set udg_unit38 = CreateUnit(p,'N00Q',514.2,257.2,270.000)
        set u = CreateUnit(p,'H01F',- 252.1,- 1022.1,270.000)
        set u = CreateUnit(p,'H01G',252.1,- 1022.1,270.000)
        set u = CreateUnit(p,'H01H',512.1,- 1022.1,270.000)
        set u = CreateUnit(p,'H01I',- 512.1,- 1022.1,270.000)
        set u = CreateUnit(p,'H01J',- 768,- 1022.1,270.000)   
        set u = CreateUnit(p,'H01L',768,- 1022.1,270.000)   
        set u = CreateUnit(p,'H00A',1024,- 1022.1,270.000)      
        set u = CreateUnit(p,'N00P',1024,- 770.1,270.000)     
        set u = CreateUnit(p,'N00R',510.5,- 770.6,270.000)
        set u = CreateUnit(p,'H007',256.1,- 767.4,270.000)
        set u = CreateUnit(p,'O006',0.7,- 767.3,270.000)
        set udg_unit37 = CreateUnit(p,'H008',- 512.7,257.9,270.000)
        set u = CreateUnit(p,'O007',2.1,- 0.9,270.000)
        set u = CreateUnit(p,'O001',- 512.8,- 766.9,270.000)
    endfunction
    function CreateNeutralPassiveBuildings3 takes nothing returns nothing
        local player p = Player(PLAYER_NEUTRAL_PASSIVE)
        local unit u
        local integer unitID
        local trigger t
        local real life
        set udg_unit06 = CreateUnit(p,'ncop',0.0,- 256.0,270.000)
        set udg_unit07 = CreateUnit(p,'ncop',- 256.0,- 256.0,270.000)
        set udg_unit08 = CreateUnit(p,'ncop',- 256.0,0.0,270.000)
        set udg_unit09 = CreateUnit(p,'ncop',0.0,0.0,270.000)
        set udg_unit10 = CreateUnit(p,'ncop',256.0,0.0,270.000)
        set udg_unit11 = CreateUnit(p,'ncop',256.0,- 256.0,270.000)
        set udg_unit12 = CreateUnit(p,'ncop',256.0,- 512.0,270.000)
        set udg_unit13 = CreateUnit(p,'ncop',0.0,- 512.0,270.000)
        set udg_unit14 = CreateUnit(p,'ncop',- 256.0,- 512.0,270.000)
        set udg_unit15 = CreateUnit(p,'ncop',- 256.0,- 768.0,270.000)
        set udg_unit16 = CreateUnit(p,'ncop',0.0,- 768.0,270.000)
        set udg_unit17 = CreateUnit(p,'ncop',256.0,- 768.0,270.000)
        set udg_unit18 = CreateUnit(p,'ncop',512.0,- 768.0,270.000)
        set udg_unit19 = CreateUnit(p,'ncop',512.0,- 512.0,270.000)
        set udg_unit20 = CreateUnit(p,'ncop',512.0,- 256.0,270.000)
        set udg_unit21 = CreateUnit(p,'ncop',512.0,0.0,270.000)
        set udg_unit22 = CreateUnit(p,'ncop',256.0,256.0,270.000)
        set udg_unit23 = CreateUnit(p,'ncop',0.0,256.0,270.000)
        set udg_unit24 = CreateUnit(p,'ncop',- 256.0,256.0,270.000)
        set udg_unit25 = CreateUnit(p,'ncop',- 512.0,256.0,270.000)
        set udg_unit26 = CreateUnit(p,'ncop',- 512.0,0.0,270.000)
        set udg_unit27 = CreateUnit(p,'ncop',- 512.0,- 256.0,270.000)
        set udg_unit28 = CreateUnit(p,'ncop',- 512.0,- 512.0,270.000)
        set udg_unit29 = CreateUnit(p,'ncop',- 512.0,- 768.0,270.000)
        set udg_unit30 = CreateUnit(p,'ncop',0.0,- 1024.0,270.000)
        set udg_unit31 = CreateUnit(p,'ncop',- 768.0,- 256.0,270.000)
        set udg_unit32 = CreateUnit(p,'ncop',768.0,- 256.0,270.000)
        set udg_unit33 = CreateUnit(p,'ncop',0,512.0,270.000)
        set CicrleUnit[0]= CreateUnit(p,'ncop',256,512.0,270.000)
        set CicrleUnit[1]= CreateUnit(p,'ncop',- 256,512.0,270.000)
        set CicrleUnit[2]= CreateUnit(p,'ncop',512,512.0,270.000)
        set CicrleUnit[3]= CreateUnit(p,'ncop',- 512,512.0,270.000)
        set CicrleUnit[4]= CreateUnit(p,'ncop',- 768.0,- 768.0,270.000)
        set CicrleUnit[5]= CreateUnit(p,'ncop',- 768.0,- 512.0,270.000)
        set CicrleUnit[6]= CreateUnit(p,'ncop',- 768.3,0.6,270.000)
        set CicrleUnit[7]= CreateUnit(p,'ncop',- 768.3,256,270.000)
        set CicrleUnit[8]= CreateUnit(p,'ncop',- 768.3,513,270.000)
        set CicrleUnit[9]= CreateUnit(p,'ncop',768.0,- 512,270.000)
        set CicrleUnit[10]= CreateUnit(p,'ncop',768.0,- 768.0,270.000)
        set CicrleUnit[11]= CreateUnit(p,'ncop',768.0,513,270.000)
        set CicrleUnit[12]= CreateUnit(p,'ncop',768.0,256,270.000)	
        set CicrleUnit[13]= CreateUnit(p,'ncop',768.0,0,270.000)	
        set CicrleUnit[14]= CreateUnit(p,'ncop',- 256,- 1024.0,270.000)	
        set CicrleUnit[15]= CreateUnit(p,'ncop',256,- 1024.0,270.000)
        set CicrleUnit[16]= CreateUnit(p,'ncop',512,- 1024.0,270.000)
        set CicrleUnit[17]= CreateUnit(p,'ncop',- 512,- 1024.0,270.000)
        set CicrleUnit[18]= CreateUnit(p,'ncop',- 768,- 1024.0,270.000)	
        set CicrleUnit[19]= CreateUnit(p,'ncop',768,- 1024.0,270.000)	
        set CicrleUnit[20]= CreateUnit(p,'ncop',1024,- 1024.0,270.000)        
        set CicrleUnit[20]= CreateUnit(p,'ncop',1024,- 770.0,270.000)    		
        set udg_unit34 = CreateUnit(p,'ncop',512.0,256.0,270.000)
    endfunction
    function CreateRegions2 takes nothing returns nothing
        local weathereffect we
        set udg_rect01 = Rect(- 4384.0,2400.0,- 2784.0,4000.0)
        set udg_rect02 = Rect(- 800.0,2400.0,800.0,4000.0)
        set udg_rect03 = Rect(2784.0,2400.0,4384.0,4000.0)
        set udg_rect04 = Rect(2784.0,- 1056.0,4384.0,544.0)
        set udg_rect05 = Rect(2784.0,- 4512.0,4384.0,- 2912.0)
        set udg_rect06 = Rect(- 800.0,- 4512.0,800.0,- 2912.0)
        set udg_rect07 = Rect(- 4384.0,- 4512.0,- 2784.0,- 2912.0)
        set udg_rect08 = Rect(- 4384.0,- 1056.0,- 2784.0,544.0)
        set udg_rect09 = Rect(- 1696.0,- 1952.0,1696.0,1440.0)
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
        call CreateNeutralPassiveBuildings3()
        call CreateUnitsForPlayer8()
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
