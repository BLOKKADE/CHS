globals
    unit array CicrleUnit
    boolean ModeNoDeath = false
    integer MorePvp = 1 
    boolean duel
    integer IncomeMode = 0
    integer AbilityMode = 0
    integer array LumberGained
    dialog IncomeModeDialog
    Table roundAbilities
    string RoundCreepTitle
    string array RoundCreepInfo
    string RoundAbilities = ""
    integer RoundCreepChanceReflectAura = 0
    integer RoundCreepChanceWizardbane = 0
    integer RoundCreepChanceDrunkMaster = 0
    integer RoundCreepChanceSlowAura = 0
    integer RoundCreepChancePulverize = 0 
    integer RoundCreepChanceLastBreath = 0
    integer FireshieldChance = 0
    integer RoundCreepChanceCorrosiveSkin = 0 
    integer RoundCreepChanceMulticast = 0
    integer RoundCreepChanceFastMagic = 0
    boolean SuddenDeathEnabled = false
    boolean array RoundLiveLost
    player WinningPlayer
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
    set udg_integer15 = 0
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
    set udg_real02 = 0
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
    set RoundClearXpBonus = 0
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
    set BettingModeDialog = DialogCreate()
    set udg_boolean13 = false
    set udg_boolean14 = false
    set udg_dialog06 = DialogCreate()
    set udg_boolean15 = false
    set HeroModeDialog = DialogCreate()
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
    set RoundCreepAbilCastChance = 0
    set DuelingHeroGroup = CreateGroup()
    set DuelWinners = CreateGroup()
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
    set udg_real02 = 0
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
    set RoundClearXpBonus = 0
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
    set udg_real03 = 0
    set udg_integer57 = 0
    set udg_integer58 = 0
    set udg_integer59 = 0
    set udg_integer60 = 0
    set udg_integer61 = 0
    set BettingModeDialog = DialogCreate()
    set udg_boolean13 = false
    set udg_boolean14 = false
    set udg_dialog06 = DialogCreate()
    set udg_boolean15 = false
    set HeroModeDialog = DialogCreate()
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

    set u = CreateUnit(p,MURLOC_WARRIOR_UNIT_ID,- 252.1,- 1022.1,270.000)
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

function Trig_Untitled_Trigger_001_Func001A takes nothing returns nothing
    call DeleteUnit( GetEnumUnit() )
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

function CreateNeutralPassiveBuildings2 takes nothing returns nothing
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
    set CicrleUnit[0]= CreateUnit(p,'ncop',256,512.0,270.000)
    set CicrleUnit[1]= CreateUnit(p,'ncop',- 256,512.0,270.000)
    set CicrleUnit[2]= CreateUnit(p,'ncop',512,512.0,270.000)
    set CicrleUnit[3]= CreateUnit(p,'ncop',- 512,512.0,270.000)
    set CicrleUnit[4]= CreateUnit(p,'ncop',- 768.0,- 768.0,270.000)
    set CicrleUnit[5]= CreateUnit(p,'ncop',- 768.0,- 512.0,270.000)
    set CicrleUnit[6]= CreateUnit(p,'ncop',- 768.0,0.6,270.000)
    set CicrleUnit[7]= CreateUnit(p,'ncop',- 768.3,256,270.000)
    set CicrleUnit[8]= CreateUnit(p,'ncop',- 768.3,513,270.000)
    set CicrleUnit[9]= CreateUnit(p,'ncop',768.0,- 512.4,270.000)
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
    set udg_unit33 = CreateUnit(p,'ncop',0.0,512.0,270.000)
    set udg_unit34 = CreateUnit(p,'ncop',512.0,256.0,270.000)
    //	set u=CreateUnit(p,'n00A',-960.0,-604.0,270.000)
    //	set u=CreateUnit(p,'n00M',960.0,-604.0,270.000)
    if(ArNotLearningAbil==false) and AbilityMode == 1 then




        //	 set u=CreateUnit(p,'n012',-124,707,270.000)
        //	 set u=CreateUnit(p,'n014',-372,707,270.000)
        //	 set u=CreateUnit(p,'n003',-620,707,270.000)     
        //	 set u=CreateUnit(p,'n00U',-868,707,270.000)   

        //	 set u=CreateUnit(p,'n001',124,707,270.000)
        //	 set u=CreateUnit(p,'n013',372,707,270.000)
        //	 set u=CreateUnit(p,'n00D',620,707,270.000)     
        //  set u=CreateUnit(p,'n00Y',868,707,270.000)  
        //  set u=CreateUnit(p,'n00S',1116,707,270.000)           


        set u = CreateUnit(p,'n00Y',- 124,707,270.000)
        set u = CreateUnit(p,'n00U',- 372,707,270.000)
        set u = CreateUnit(p,'n003',- 620,707,270.000) 
        set u = CreateUnit(p,'n033',- 620,707 + 248,270.000) 
        set u = CreateUnit(p,'n00D',- 868,707,270.000)   
        set u = CreateUnit(p,'n02O',- 868,707 + 248,270.000)     	 	 
        set u = CreateUnit(p,'n02M',- 1116,707,270.000) 


        set u = CreateUnit(p,'n013',124,707,270.000)
        set u = CreateUnit(p,'n014',372,707,270.000)
        set u = CreateUnit(p,'n001',620,707,270.000)     
        set u = CreateUnit(p,'n012',868,707,270.000)  
        set u = CreateUnit(p,'n00S',1116,707,270.000)  
        set u = CreateUnit(p,'n02N',1116,707 + 248,270.000)  
        set u = CreateUnit(p,'n032',372,707 + 248,270.000)  
        set u = CreateUnit(p,'n02X',868,707 + 248,270.000) 
        set u = CreateUnit(p,'n031',620,707 + 248,270.000) 


        //		set u=CreateUnit(p,'n001',384.0,576.0,270.000)
        //		set u=CreateUnit(p,'n003',960.0,0.0,270.000)
        //		set u=CreateUnit(p,'n00D',-960.0,0.0,270.000)
        //		set u=CreateUnit(p,'n012',-384.0,576.0,270.000)
        //		set u=CreateUnit(p,'n004',000.0,650.0,270.000)
        //		set u=CreateUnit(p,'n00Y',384.0,-1024.0,270.000)
        //	set u=CreateUnit(p,'n00U',-384.0,-1024.0,270.000)
        //		set u=CreateUnit(p,'n013',640.0,320.0,270.000)
        //	set u=CreateUnit(p,'n014',-640.0,320.0,270.000)

        //		set u=CreateUnit(p,'n00S',0,-1160,270.000)
    else
        set u = CreateUnit(p, 'n031', 0, 750, 270) 
        //	set u=CreateUnit(p,'n004',0.0,640.0,270.000)
        //	set u=CreateUnit(p,'n016',-960.0,-256.0,270.000)
        //	set u=CreateUnit(p,'n016',0.0,-1152.0,270.000)
        //	set u=CreateUnit(p,'n016',960.0,-256.0,270.000)
    endif

    set u = CreateUnit(p,'n02H',- 868,- 1152,270.000) 
    set u = CreateUnit(p,'n00Z',- 620,- 1152,270.000) 
    set u = CreateUnit(p,'n01D',- 372,- 1152,270.000) 
    set u = CreateUnit(p,'n02V',- 124,- 1152,270.000) 
    set u = CreateUnit(p,'n02W',- 124,- 1152 - 256,270.000)
    set u = CreateUnit(p,'n02I',124,- 1152,270.000) 
    set u = CreateUnit(p,'n02Z',124,- 1152 - 256,270.000) 
    set u = CreateUnit(p,'n02J',372,- 1152,270.000) 
    set u = CreateUnit(p,'n030',372,- 1152 - 256,270.000) 
    set u = CreateUnit(p,'n02Q',620,- 1152,270.000) 
    set u = CreateUnit(p,'n02Y',868,- 1152,270.000)
    call ForGroupBJ( GetUnitsOfTypeIdAll('ncop'), function Trig_Untitled_Trigger_001_Func001A )
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

function Trig_Antimagic_Shell_Func001001002 takes nothing returns boolean
    return(UnitHasBuffBJ(GetFilterUnit(),'Bam2')==true)
endfunction

function Trig_Antimagic_Shell_Func001A takes nothing returns nothing
    call UnitRemoveBuffBJ('BUim',GetEnumUnit())
    call UnitRemoveBuffBJ('BSTN',GetEnumUnit())
    call UnitRemoveBuffBJ('BPSE',GetEnumUnit())
endfunction

function Trig_Antimagic_Shell_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_Antimagic_Shell_Func001001002)),function Trig_Antimagic_Shell_Func001A)
endfunction

function Trig_Black_Arrow_Conditions takes nothing returns boolean
    if(not(GetUnitTypeId(GetTriggerUnit())=='n015'))then
        return false
    endif
    return true
endfunction

function Trig_Black_Arrow_Actions takes nothing returns nothing
    set udg_real02 =(I2R(GetUnitAbilityLevelSwapped('ANba',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))* 1.50)
    call SetUnitScalePercent(GetTriggerUnit(),(100.00 + udg_real02),(100.00 + udg_real02),(100.00 + udg_real02))
    call SetUnitVertexColorBJ(GetTriggerUnit(),100,(100.00 - udg_real02),(100.00 - udg_real02),0)
    call SetUnitAbilityLevelSwapped('A000',GetTriggerUnit(),(GetUnitAbilityLevelSwapped('ANba',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])/ 1))
    set bj_forLoopBIndex = 1
    set bj_forLoopBIndexEnd =(GetUnitAbilityLevelSwapped('ANba',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])- 1)
    loop
        exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
        call UnitAddItemByIdSwapped('I02L',GetTriggerUnit())
        set bj_forLoopBIndex = bj_forLoopBIndex + 1
    endloop
endfunction

function Trig_Carrion_Beetles_Conditions takes nothing returns boolean
    if(not(GetUnitTypeId(GetTriggerUnit())=='u001'))then
        return false
    endif
    return true
endfunction

function Trig_Carrion_Beetles_Actions takes nothing returns nothing
    set udg_real02 =(I2R(GetUnitAbilityLevelSwapped('AUcb',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))* 1.50)
    call SetUnitScalePercent(GetTriggerUnit(),(100.00 + udg_real02),(100.00 + udg_real02),(100.00 + udg_real02))
    call SetUnitVertexColorBJ(GetTriggerUnit(),100,(100.00 - udg_real02),(100.00 - udg_real02),0)
    call SetUnitAbilityLevelSwapped('A000',GetTriggerUnit(),(GetUnitAbilityLevelSwapped('AUcb',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])/ 2))
    set bj_forLoopBIndex = 1
    set bj_forLoopBIndexEnd =(GetUnitAbilityLevelSwapped('AUcb',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])- 1)
    loop
        exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
        call UnitAddItemByIdSwapped('I01B',GetTriggerUnit())
        set bj_forLoopBIndex = bj_forLoopBIndex + 1
    endloop
endfunction

function Trig_Clockwerk_Goblin_Conditions takes nothing returns boolean
    if(not(GetUnitTypeId(GetTriggerUnit())=='n011'))then
        return false
    endif
    return true
endfunction

function Trig_Clockwerk_Goblin_Actions takes nothing returns nothing
    set udg_real02 =(I2R(GetUnitAbilityLevelSwapped('ANsy',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))* 1.50)
    call SetUnitScalePercent(GetTriggerUnit(),(100.00 + udg_real02),(100.00 + udg_real02),(100.00 + udg_real02))
    call SetUnitAbilityLevelSwapped('A00P',GetTriggerUnit(),GetUnitAbilityLevelSwapped('ANsy',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
    call SetUnitAbilityLevelSwapped('A000',GetTriggerUnit(),(GetUnitAbilityLevelSwapped('ANsy',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])/ 1))
    set bj_forLoopBIndex = 1
    set bj_forLoopBIndexEnd =(GetUnitAbilityLevelSwapped('ANsy',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])/ 1)
    loop
        exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
        call UnitAddItemByIdSwapped('I02L',GetTriggerUnit())
        set bj_forLoopBIndex = bj_forLoopBIndex + 1
    endloop
endfunction

function Trig_Corrosive_Skin_Conditions takes nothing returns boolean
    if(not(GetUnitAbilityLevelSwapped('A00Q',GetAttackedUnitBJ())> 0))then
        return false
    endif
    return true
endfunction



function Trig_Corrosive_Skin_Actions takes nothing returns nothing
    local real luck = GetUnitLuck(GetTriggerUnit())
    local real bonus
    if GetRandomReal(0,100) <= 35 * luck then
        set bonus = PoisonBonus[GetHandleId(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetAttackedUnitBJ()))])]
        if bonus == 0 then
            set bonus = 1
        endif
        call DummyOrder.create(GetAttackedUnitBJ(), GetUnitX(GetAttackedUnitBJ()), GetUnitY(GetAttackedUnitBJ()), GetUnitFacing(GetAttackedUnitBJ()), 4).addActiveAbility('A00R', 1, 852231).setAbilityRealField('A00R', ABILITY_RLF_DAMAGE_HTB1, (80 * GetUnitAbilityLevel(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetAttackedUnitBJ()))], 'A00Q')) * bonus).target(GetAttacker()).activate()
        call PoisonSpellCast(GetAttackedUnitBJ(), GetAttacker())
    endif
endfunction




function Trig_Dark_Ritual_Conditions takes nothing returns boolean
    if(not(GetSpellAbilityId()=='A00N'))then
        return false
    endif
    return true
endfunction

function Trig_Dark_Ritual_Actions takes nothing returns nothing
    set udg_real02 =((0.33 * I2R(GetUnitAbilityLevelSwapped(GetSpellAbilityId(),GetTriggerUnit())))* GetUnitStateSwap(UNIT_STATE_LIFE,GetSpellTargetUnit()))
    call KillUnit(GetSpellTargetUnit())
    call TriggerSleepAction(0.00)
    call SetUnitManaBJ(GetTriggerUnit(),(GetUnitStateSwap(UNIT_STATE_MANA,GetTriggerUnit())+ udg_real02))
endfunction

function Trig_Death_Pact_Conditions takes nothing returns boolean
    if(not(GetSpellAbilityId()=='A00M'))then
        return false
    endif
    return true
endfunction

function Trig_Death_Pact_Actions takes nothing returns nothing
    set udg_real02 =(I2R(GetUnitAbilityLevelSwapped(GetSpellAbilityId(),GetTriggerUnit()))* GetUnitStateSwap(UNIT_STATE_LIFE,GetSpellTargetUnit()))
    call KillUnit(GetSpellTargetUnit())
    call TriggerSleepAction(0.00)
    call SetUnitLifeBJ(GetTriggerUnit(),(GetUnitStateSwap(UNIT_STATE_LIFE,GetTriggerUnit())+ udg_real02))
endfunction

function Trig_Devastating_Blow_Conditions takes nothing returns boolean
    if(not(GetUnitAbilityLevelSwapped('A050',GetEventDamageSource())> 0))then
        return false
    endif

    if(not(   BlzGetUnitAbilityCooldownRemaining(GetEventDamageSource(),'A050')<= 0 ))then
        return false
    endif
    if(not(IsUnitAliveBJ(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetEventDamageSource()))])==true))then
        return false
    endif
    return true
endfunction

function Trig_Devastating_Blow_Actions takes nothing returns nothing
    if GetUnitAbilityLevel(GetTriggerUnit(), 'B01D') == 0 and GetEventDamageSource() != GetTriggerUnit() then
        call DestroyEffectBJ(udg_effects01[GetConvertedPlayerId(GetOwningPlayer(GetEventDamageSource()))])
        call DestroyEffectBJ(udg_effects02[GetConvertedPlayerId(GetOwningPlayer(GetEventDamageSource()))])
        set udg_effects01[GetConvertedPlayerId(GetOwningPlayer(GetEventDamageSource()))] = null
        set udg_effects02[GetConvertedPlayerId(GetOwningPlayer(GetEventDamageSource()))] = null
        call AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()),"Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
        call AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()),"Abilities\\Spells\\Other\\Volcano\\VolcanoDeath.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
        call AddSpecialEffectTargetUnitBJ("chest",GetTriggerUnit(),"Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
        call AddSpecialEffectTargetUnitBJ("chest",GetTriggerUnit(),"Objects\\Spawnmodels\\Critters\\Albatross\\CritterBloodAlbatross.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
        //	call UnitDamageTargetBJ(GetEventDamageSource(),GetTriggerUnit(),(50.00*I2R(GetUnitAbilityLevelSwapped('Aimp',GetEventDamageSource()))),ATTACK_TYPE_HERO,DAMAGE_TYPE_NORMAL)
        call AbilStartCD(GetEventDamageSource(),'A050',5)
        call DisableTrigger(udg_trigger11)
        call UnitDamageTargetBJ(GetEventDamageSource(),GetTriggerUnit(),(0.08 * GetUnitStateSwap(UNIT_STATE_MAX_LIFE,GetTriggerUnit())) + (50.00 * I2R(GetUnitAbilityLevelSwapped('A050',GetEventDamageSource())))   ,ATTACK_TYPE_MAGIC,DAMAGE_TYPE_MAGIC)
        call EnableTrigger(udg_trigger11) 
    endif
endfunction




function Trig_Devastating_Blow_Ennhance_Actions takes nothing returns nothing
    set udg_integer53 = 1
    loop
        exitwhen udg_integer53 > 8

        if GetUnitAbilityLevel(PlayerHeroes[udg_integer53],'A050') > 0 and BlzGetUnitAbilityCooldownRemaining(PlayerHeroes[udg_integer53],'A050')<= 0 and udg_effects01[udg_integer53] == null then
            call DestroyEffectBJ(udg_effects01[udg_integer53])
            call AddSpecialEffectTargetUnitBJ("hand left",PlayerHeroes[udg_integer53],"Abilities\\Weapons\\LavaSpawnMissile\\LavaSpawnMissile.mdl")
            set udg_effects01[udg_integer53]= GetLastCreatedEffectBJ()
            call DestroyEffectBJ(udg_effects02[udg_integer53])
            call AddSpecialEffectTargetUnitBJ("hand right",PlayerHeroes[udg_integer53],"Abilities\\Weapons\\LavaSpawnMissile\\LavaSpawnMissile.mdl")
            set udg_effects02[udg_integer53]= GetLastCreatedEffectBJ()
        endif

        set udg_integer53 = udg_integer53 + 1
    endloop
endfunction

function Trig_Devastating_Blow_Add_Conditions takes nothing returns boolean
    if(not(IsUnitInGroup(GetTriggerUnit(),udg_group06)!=true))then
        return false
    endif
    return true
endfunction

function Trig_Devastating_Blow_Add_Actions takes nothing returns nothing
    call GroupAddUnitSimple(GetTriggerUnit(),udg_group06)
    call TriggerRegisterUnitEvent(udg_trigger11,GetTriggerUnit(),EVENT_UNIT_DAMAGED)
endfunction

function Trig_Dreadlords_Thirst_Conditions takes nothing returns boolean
    if(not(GetUnitTypeId(GetKillingUnitBJ())=='O002'))then
        return false
    endif
    return true
endfunction

function Trig_Dreadlords_Thirst_Actions takes nothing returns nothing
    call SetUnitLifeBJ(GetKillingUnitBJ(),(GetUnitStateSwap(UNIT_STATE_LIFE,GetKillingUnitBJ())+(GetUnitStateSwap(UNIT_STATE_MAX_LIFE,GetKillingUnitBJ())/ 10.00)))
    call AddSpecialEffectTargetUnitBJ("hand right",GetKillingUnitBJ(),"Abilities\\Weapons\\HydraliskImpact\\HydraliskImpact.mdl")
    call DestroyEffectBJ(GetLastCreatedEffectBJ())
    call AddSpecialEffectTargetUnitBJ("hand left",GetKillingUnitBJ(),"Abilities\\Weapons\\HydraliskImpact\\HydraliskImpact.mdl")
    call DestroyEffectBJ(GetLastCreatedEffectBJ())
    call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl")
    call DestroyEffectBJ(GetLastCreatedEffectBJ())
endfunction
/*
function Trig_Faerie_Dragon_Func001Func001Func002C takes nothing returns boolean
    if(not(DistanceBetweenPoints(GetUnitLoc(GetEnumUnit()),GetUnitLoc(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]))>= 900.00))then
        return false
    endif
    return true
endfunction

function Trig_Faerie_Dragon_Func001Func001Func003C takes nothing returns boolean
    if(not(GetUnitStateSwap(UNIT_STATE_MANA,GetEnumUnit())==GetUnitStateSwap(UNIT_STATE_MAX_MANA,GetEnumUnit())))then
        return false
    endif
    return true
endfunction

function Trig_Faerie_Dragon_Func001Func001C takes nothing returns boolean
    if(not(GetOwningPlayer(GetEnumUnit())==GetOwningPlayer(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))])))then
        return false
    endif
    return true
endfunction

globals
    unit array MysticFaerie
endglobals

function Trig_Faerie_Dragon_Func001A takes nothing returns nothing
    if(Trig_Faerie_Dragon_Func001Func001C())then
        if(Trig_Faerie_Dragon_Func001Func001Func002C())then
            call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
            call SetUnitPositionLoc(GetEnumUnit(),GetUnitLoc(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]))
            call IssueImmediateOrderBJ(GetEnumUnit(),"stop")
            call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
        endif
        if(Trig_Faerie_Dragon_Func001Func001Func003C())then
            set MysticFaerie[GetPlayerId(GetOwningPlayer(GetEnumUnit()))] = GetEnumUnit()
            call BlzSetUnitAttackCooldown(GetEnumUnit(), BlzGetUnitAttackCooldown(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))], 0), 0)
            call SetUnitAbilityLevelSwapped('A000',GetEnumUnit(),R2I(GetHeroLevel(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))])/ 3))
            call UnitSetAttackSpeed(GetEnumUnit(), GetHeroLevel(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]) * 0.03)
            call IssuePointOrderLocBJ(GetEnumUnit(),"attack",OffsetLocation(GetUnitLoc(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]),GetRandomReal(- 300.00,300.00),GetRandomReal(- 300.00,300.00)))
            call SetUnitManaBJ(GetEnumUnit(),GetRandomReal(0,1.00))
        endif
    endif
endfunction

function Trig_Faerie_Dragon_Actions takes nothing returns nothing
    local group GRP = GetUnitsOfTypeIdAll('e001')
    call ForGroupBJ(GRP,function Trig_Faerie_Dragon_Func001A)
    call DestroyGroup(GRP)
    set GRP = null
endfunction*/

function Trig_Faerie_Dragon_or_Wisp_Dies_Func002C takes nothing returns boolean
    /*if((GetUnitTypeId(GetTriggerUnit())=='e001'))then
        return true
    endif*/
    if((GetUnitTypeId(GetTriggerUnit())=='e003'))then
        return true
    endif
    return false
endfunction

function Trig_Faerie_Dragon_or_Wisp_Dies_Conditions takes nothing returns boolean
    if(not Trig_Faerie_Dragon_or_Wisp_Dies_Func002C())then
        return false
    endif
    return true
endfunction

function Trig_Faerie_Dragon_or_Wisp_Dies_Actions takes nothing returns nothing
    call CreateNUnitsAtLoc(1,GetUnitTypeId(GetTriggerUnit()),GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(GetTriggerUnit()),GetUnitFacing(GetTriggerUnit()))
endfunction

function Trig_Healing_Ward_Conditions takes nothing returns boolean
    if(not(GetUnitTypeId(GetTriggerUnit())=='ohwd'))then
        return false
    endif
    return true
endfunction

function Trig_Healing_Ward_Actions takes nothing returns nothing
    call SetUnitAbilityLevelSwapped('Aoar',GetTriggerUnit(),GetUnitAbilityLevelSwapped('Ahwd',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
endfunction

function Trig_Inferno_Conditions takes nothing returns boolean
    if(not(GetUnitTypeId(GetTriggerUnit())=='n005'))then
        return false
    endif
    return true
endfunction

function Trig_Inferno_Actions takes nothing returns nothing
    call SetUnitAbilityLevelSwapped('ANpi',GetTriggerUnit(),GetUnitAbilityLevelSwapped('AUin',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
    call SetUnitAbilityLevelSwapped('A000',GetTriggerUnit(),(GetUnitAbilityLevelSwapped('AUin',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])))
    set bj_forLoopBIndex = 1
    set bj_forLoopBIndexEnd =(GetUnitAbilityLevelSwapped('AUin',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])* 2)
    loop
        exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
        call UnitAddItemByIdSwapped('I022',GetTriggerUnit())
        call UnitAddItemByIdSwapped('I022',GetTriggerUnit())
        set bj_forLoopBIndex = bj_forLoopBIndex + 1
    endloop
endfunction

function Trig_Mountain_Giant_Conditions takes nothing returns boolean
    if(not(GetUnitTypeId(GetTriggerUnit())=='e002'))then
        return false
    endif
    return true
endfunction

function Trig_Mountain_Giant_Actions takes nothing returns nothing
    call SetUnitAbilityLevelSwapped('ANpi',GetTriggerUnit(),GetUnitAbilityLevelSwapped('AEsv',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
    call SetUnitAbilityLevelSwapped('A000',GetTriggerUnit(),(GetUnitAbilityLevelSwapped('AEsv',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])* 1))
    set bj_forLoopBIndex = 1
    set bj_forLoopBIndexEnd =(GetUnitAbilityLevelSwapped('AEsv',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])* 6)
    loop
        exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
        call UnitAddItemByIdSwapped('I02K',GetTriggerUnit())
        call UnitAddItemByIdSwapped('I02K',GetTriggerUnit())
        set bj_forLoopBIndex = bj_forLoopBIndex + 1
    endloop
endfunction

function Trig_Parasite_Conditions takes nothing returns boolean
    if(not(GetUnitTypeId(GetTriggerUnit())=='ncfs'))then
        return false
    endif
    return true
endfunction

function Trig_Parasite_Actions takes nothing returns nothing
    set udg_real02 =(I2R(GetUnitAbilityLevelSwapped('ANpa',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))* 1.50)
    call SetUnitScalePercent(GetTriggerUnit(),(100.00 + udg_real02),(100.00 + udg_real02),(100.00 + udg_real02))
    call SetUnitVertexColorBJ(GetTriggerUnit(),100,(100.00 - udg_real02),(100.00 - udg_real02),0)
    call SetUnitAbilityLevelSwapped('A000',GetTriggerUnit(),(GetUnitAbilityLevelSwapped('ANpa',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])- 2))
endfunction

function Trig_Phoenix_Conditions takes nothing returns boolean
    if(not(GetUnitTypeId(GetTriggerUnit())=='hphx'))then
        return false
    endif
    return true
endfunction

function Trig_Phoenix_Actions takes nothing returns nothing
    call SetUnitAbilityLevelSwapped('A000',GetTriggerUnit(),(GetUnitAbilityLevelSwapped('AHpx',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])* 1))
    set bj_forLoopBIndex = 1
    set bj_forLoopBIndexEnd =(GetUnitAbilityLevelSwapped('AHpx',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])* 2)
    loop
        exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
        call UnitAddItemByIdSwapped('I022',GetTriggerUnit())
        set bj_forLoopBIndex = bj_forLoopBIndex + 1
    endloop
endfunction


library Pillage requires RandomShit
    function Trig_Pillage_Conditions takes nothing returns boolean
        /*local integer GG_d1 = 0
        local integer PilageBonus = 0
        local integer RingBonus = 0
        local integer RemBon = 0
        local integer expBounty = 0
        local integer goldBounty = 0
        local unit Gku = PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]
        local player OwningUnit = GetOwningPlayer(Gku)     
        local integer pid = GetPlayerId(OwningUnit)
        local real luck = GetUnitLuck(Gku)
        local integer itemCount = 0


        set expBounty = expBounty + BonusNeutral + BonusNeutralPlayer[pid] 

        //Greedy Goblin
        if GetUnitTypeId(Gku) == 'N02P' then
            set goldBounty = goldBounty + (((21 + GetHeroLevel(Gku)* 3)* 70)/(70 + GetUnitAbilityLevel(Gku,'Asal')))
            set expBounty = expBounty + (((20 + GetHeroLevel(Gku)* 4)* 70)/(70 + GetUnitAbilityLevel(Gku,'Asal')))
            set RemBon = 20
            call AdjustPlayerStateBJ(goldBounty,OwningUnit,PLAYER_STATE_RESOURCE_GOLD)
        endif

        if MidasTouchGold[GetHandleId(GetDyingUnit())] > 0 then
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\Other\\Transmute\\GoldBottleMissile.mdl", GetUnitX(GetTriggerUnit()), GetUnitX(GetTriggerUnit())))
            call AdjustPlayerStateBJ(MidasTouchGold[GetHandleId(GetDyingUnit())],OwningUnit,PLAYER_STATE_RESOURCE_GOLD)
            set MidasTouchGold[GetHandleId(GetDyingUnit())] = 0
        endif


        set udg_integer60 = 0


        if    (IsUnitIllusionBJ(GetTriggerUnit())!=true) and (GetUnitTypeId(GetTriggerUnit())!='n00T') and (GetUnitAbilityLevelSwapped('Asal',Gku)> 0) and  (IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(Gku))) then


            if GetRandomReal(0,100) <= 65 * luck then
                set PilageBonus = PilageBonus +(((GetUnitAbilityLevelSwapped('Asal',Gku)* 18)* 70)/(70 + RemBon + GetUnitAbilityLevelSwapped('A02W',Gku))  )
                call AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()),"Abilities\\Spells\\Other\\Transmute\\PileofGold.mdl")
                call DestroyEffectBJ(GetLastCreatedEffectBJ())
            else
            endif	

        endif


        if (IsUnitIllusionBJ(GetTriggerUnit())!=true) and (GetUnitTypeId(GetTriggerUnit())!='n00T') and (GetUnitAbilityLevelSwapped('A02W',Gku)> 0) and  (IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(Gku))) then
            set expBounty = expBounty +    ( 35 * GetUnitAbilityLevel(Gku,'A02W') * 70 )/(70 + RemBon + GetUnitAbilityLevel(Gku,'Asal')   )	
        endif	

        set itemCount = UnitHasItemI(Gku, 'I04R')
        if itemCount > 0 then
            set RingBonus = RingBonus + 10 * itemCount
        endif

        //fixPilage? < idk why that comment is there

        if RingBonus > PilageBonus then
            set udg_integer60 = RingBonus
            call AdjustPlayerStateBJ(RingBonus,GetOwningPlayer(Gku),PLAYER_STATE_RESOURCE_GOLD)
        else
            set udg_integer60 = PilageBonus
            call AdjustPlayerStateBJ(PilageBonus,GetOwningPlayer(Gku),PLAYER_STATE_RESOURCE_GOLD)
        endif  

        set itemCount = UnitHasItemI(Gku, 'I05U')
        if itemCount > 0 then
            if PilageBonus == 0 then
                set GG_d1 = GG_d1 +  (2 * GetHeroLevel(Gku)) * itemCount
            else
                set GG_d1 = GG_d1 +  (GetHeroLevel(Gku)) * itemCount 
            endif
        endif

        set itemCount = UnitHasItemI(Gku, 'I05A')
        if itemCount > 0 then
            set udg_integer60 = udg_integer60 + (50 * itemCount)
            set GG_d1 = GG_d1 + (50 * itemCount)
            call AdjustPlayerStateBJ(50 * itemCount,GetOwningPlayer(Gku),PLAYER_STATE_RESOURCE_GOLD)
        endif


        call ResourseRefresh(GetOwningPlayer(Gku))
        set udg_integer60 = udg_integer60 + goldBounty 
        call AddHeroXP (Gku, GG_d1 + expBounty,true)
        */
        return false
    endfunction
endlibrary




function Trig_Pillage_Actions takes nothing returns nothing

endfunction

function Trig_Plague_Func002Func001Func001C takes nothing returns boolean
    if((BrStarted==true))then
        return true
    endif
    if((ElimPvpStarted==true))then
        return true
    endif
    return false
endfunction

function Trig_Plague_Func002Func001C takes nothing returns boolean
    if(not Trig_Plague_Func002Func001Func001C())then
        return false
    endif
    if(not(RectContainsUnit(RectMidArena,GetTriggerUnit())==true))then
        return false
    endif
    return true
endfunction

function Trig_Plague_Func002Func002C takes nothing returns boolean
    if(not(BrStarted==false))then
        return false
    endif
    if(not(ElimPvpStarted==false))then
        return false
    endif
    if(not(RectContainsUnit(RectMidArena,GetTriggerUnit())!=true))then
        return false
    endif
    return true
endfunction

function Trig_Plague_Func002C takes nothing returns boolean
    if(Trig_Plague_Func002Func001C())then
        return true
    endif
    if(Trig_Plague_Func002Func002C())then
        return true
    endif
    return false
endfunction

function Trig_Plague_Conditions takes nothing returns boolean
    if(not(GetSpellAbilityId()=='A017'))then
        return false
    endif
    if(not Trig_Plague_Func002C())then
        return false
    endif
    return true
endfunction

function Trig_Plague_Actions takes nothing returns nothing
    local real bonus = 1
    local integer corpseLimit = 4
    local unit caster = GetTriggerUnit()
    local real x
    local real y
    local effect fx
    set udg_integer52 = 1
    if PoisonBonus.real[GetHandleId(caster)] != 0 then
        set bonus = PoisonBonus.real[GetHandleId(caster)]
    endif
    loop
        exitwhen udg_integer52 > 10
        call CreateNUnitsAtLoc(1,'n01L',GetOwningPlayer(caster),OffsetLocation(GetSpellTargetLoc(),GetRandomReal(- 300.00,300.00),GetRandomReal(- 300.00,300.00)),GetRandomDirectionDeg())
        set x = GetUnitX(GetLastCreatedUnit())
        set y = GetUnitY(GetLastCreatedUnit())
        call UnitApplyTimedLifeBJ(14.00,'BTLF',GetLastCreatedUnit())
        call UnitAddAbility(GetLastCreatedUnit(), 'A0AG')
        call IncUnitAbilityLevel(GetLastCreatedUnit(), 'A0AG')
        call BlzSetAbilityRealLevelField(BlzGetUnitAbility(GetLastCreatedUnit(), 'A0AG'), ABILITY_RLF_DAMAGE_PER_INTERVAL, 0, (60 * GetUnitAbilityLevel(caster, 'A017')) * bonus)
        call DecUnitAbilityLevel(GetLastCreatedUnit(), 'A0AG')
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0AG', false)
        call SetPlayerAbilityAvailable(GetOwningPlayer(caster), 'A0AG', true)
        call SetUnitTimeScalePercent(GetLastCreatedUnit(),50.00)
        if udg_integer52 <= corpseLimit then
            call CreateCorpseLocBJ(ChooseRandomCreepBJ(- 1),GetOwningPlayer(GetTriggerUnit()),OffsetLocation(GetSpellTargetLoc(),GetRandomReal(- 300.00,300.00),GetRandomReal(- 300.00,300.00)))
            if GetUnitAbilityLevel(caster, 'A0AW') > 0 then
                call CastBlackArrow(caster, GetLastCreatedUnit(), GetUnitAbilityLevel(caster, 'A0AW'))
            endif
            if GetUnitAbilityLevel(caster, 'A0BA') > 0 then
                call SetUnitState(caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_LIFE) + ( (0.02 + (0.0005 * GetHeroLevel(caster))) * BlzGetUnitMaxHP(caster)))
                call AreaDamage(caster, x, y, 20 + (30 * GetHeroLevel(caster)), 400, false, 'N00O')
                set fx = AddSpecialEffect("war3mapImported\\Arcane Explosion.mdx", x, y)
                call BlzSetSpecialEffectTimeScale(fx, 2)
                call DestroyEffect(fx)
            endif
        endif
        set udg_integer52 = udg_integer52 + 1
    endloop

    set fx = null
    set caster = null
endfunction

function Trig_Plague_Remove_Conditions takes nothing returns boolean
    if(not(GetUnitTypeId(GetTriggerUnit())=='n01L'))then
        return false
    endif
    return true
endfunction

function Trig_Plague_Remove_Actions takes nothing returns nothing
    call TriggerSleepAction(0.94)
    call DeleteUnit(GetTriggerUnit())
endfunction

function Trig_Pocket_Factory_Conditions takes nothing returns boolean
    if(not(GetUnitTypeId(GetTriggerUnit())=='n010'))then
        return false
    endif
    return true
endfunction

function Trig_Pocket_Factory_Actions takes nothing returns nothing
    set udg_real02 =(I2R(GetUnitAbilityLevelSwapped('ANsy',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))* 1.0)
    call SetUnitScalePercent(GetTriggerUnit(),(90.00 + udg_real02),(90.00 + udg_real02),(90.00 + udg_real02))
    set bj_forLoopBIndex = 1
    set bj_forLoopBIndexEnd =(GetUnitAbilityLevelSwapped('ANsy',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
    loop
        exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
        call UnitAddItemByIdSwapped('I02L',GetTriggerUnit())
        set bj_forLoopBIndex = bj_forLoopBIndex + 1
    endloop
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

function Trig_Pulverize_Func003C takes nothing returns boolean
    if(not(RoundCreepAbilCastChance==1))then
        return false
    endif
    return true
endfunction

function Trig_Pulverize_Add_Func003C takes nothing returns boolean
    if(not(GetUnitTypeId(GetTriggerUnit())!='ohwd'))then
        return false
    endif
    if(not(GetUnitTypeId(GetTriggerUnit())!='osp1'))then
        return false
    endif
    if(not(GetUnitTypeId(GetTriggerUnit())!='osp2'))then
        return false
    endif
    if(not(GetUnitTypeId(GetTriggerUnit())!='osp3'))then
        return false
    endif
    return true
endfunction

function Trig_Pulverize_Add_Conditions takes nothing returns boolean
    if(not(IsUnitInGroup(GetTriggerUnit(),udg_group04)!=true))then
        return false
    endif
    if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_GROUND)==true))then
        return false
    endif
    if(not Trig_Pulverize_Add_Func003C())then
        return false
    endif
    return true
endfunction

function Trig_Pulverize_Add_Actions takes nothing returns nothing
    call GroupAddUnitSimple(GetTriggerUnit(),udg_group04)
    call TriggerRegisterUnitEvent(udg_trigger26,GetTriggerUnit(),EVENT_UNIT_DAMAGED)
endfunction

function Trig_Raise_Dead_Func001C takes nothing returns boolean
    if((GetUnitTypeId(GetTriggerUnit())=='uske'))then
        return true
    endif
    if((GetUnitTypeId(GetTriggerUnit())=='uskm'))then
        return true
    endif
    return false
endfunction

function Trig_Raise_Dead_Conditions takes nothing returns boolean
    if(not Trig_Raise_Dead_Func001C())then
        return false
    endif
    return true
endfunction

function Trig_Raise_Dead_Actions takes nothing returns nothing
    set udg_real02 =(I2R(GetUnitAbilityLevelSwapped('Arai',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))* 1.50)
    call SetUnitScalePercent(GetTriggerUnit(),(100.00 + udg_real02),(100.00 + udg_real02),(100.00 + udg_real02))
    call SetUnitVertexColorBJ(GetTriggerUnit(),100,(100.00 - udg_real02),(100.00 - udg_real02),0)
    call SetUnitAbilityLevelSwapped('A000',GetTriggerUnit(),(GetUnitAbilityLevelSwapped('Arai',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])/ 3))
    set bj_forLoopBIndex = 1
    set bj_forLoopBIndexEnd =(GetUnitAbilityLevelSwapped('Arai',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])- 1)
    loop
        exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
        call UnitAddItemByIdSwapped('I02L',GetTriggerUnit())
        set bj_forLoopBIndex = bj_forLoopBIndex + 1
    endloop
endfunction

/*
function Trig_Skeletal_Brute_Conditions takes nothing returns boolean
    if(not(GetKillingUnitBJ()!=null))then
        return false
    endif
    if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_GROUND)==true))then
        return false
    endif
    if(not(IsUnitIllusionBJ(GetTriggerUnit())!=true))then
        return false
    endif
    if(not(GetUnitTypeId(GetTriggerUnit())!='n00T'))then
        return false
    endif
    if(not(GetUnitTypeId(GetTriggerUnit())!=SUDDEN_DEATH_UNIT_ID))then
        return false
    endif
    if(not(GetUnitTypeId(GetTriggerUnit())!='h00V'))then
        return false
    endif
    if(not(GetUnitTypeId(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])=='N00O'))then
        return false
    endif
    if(not(IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))==true))then
        return false
    endif
    return true
endfunction

function Trig_Skeletal_Brute_Actions takes nothing returns nothing
    call CreateNUnitsAtLoc(1,'u002',GetOwningPlayer(GetKillingUnitBJ()),GetUnitLoc(GetTriggerUnit()),GetUnitFacing(GetTriggerUnit()))
    call UnitApplyTimedLifeBJ(12.00,'BTLF',GetLastCreatedUnit())
    call AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()),"Objects\\Spawnmodels\\NightElf\\NightElfLargeDeathExplode\\NightElfLargeDeathExplode.mdl")
    call DestroyEffectBJ(GetLastCreatedEffectBJ())
endfunction
*/
function Trig_Summon_Bear_Func001C takes nothing returns boolean
    if(not(GetUnitTypeId(GetTriggerUnit())=='ngz3'))then
        return false
    endif
    if(not(GetUnitAbilityLevelSwapped('ANsg',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])> 3))then
        return false
    endif
    return true
endfunction

function Trig_Summon_Bear_Conditions takes nothing returns boolean
    if(not Trig_Summon_Bear_Func001C())then
        return false
    endif
    return true
endfunction

function Trig_Summon_Bear_Actions takes nothing returns nothing
    call SetUnitAbilityLevelSwapped('A000',GetTriggerUnit(),(GetUnitAbilityLevelSwapped('ANsg',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])+ 2))
    set bj_forLoopBIndex = 1
    set bj_forLoopBIndexEnd =((GetUnitAbilityLevelSwapped('ANsg',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])- 4)* 2)
    loop
        exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
        call UnitAddItemByIdSwapped('I022',GetTriggerUnit())
        set bj_forLoopBIndex = bj_forLoopBIndex + 1
    endloop
endfunction

function Trig_Summon_Hawk_Conditions takes nothing returns boolean
    if(not(GetUnitTypeId(GetTriggerUnit())=='nwe3'))then
        return false
    endif
    return true
endfunction

function Trig_Summon_Hawk_Actions takes nothing returns nothing
    set udg_real02 =(I2R(GetUnitAbilityLevelSwapped('ANsw',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))* 1)
    call SetUnitScalePercent(GetTriggerUnit(),(100.00 + udg_real02),(100.00 + udg_real02),(100.00 + udg_real02))
    call SetUnitVertexColorBJ(GetTriggerUnit(),100,(100.00 - udg_real02),(100.00 - udg_real02),0)
    call SetUnitAbilityLevelSwapped('A000',GetTriggerUnit(),(GetUnitAbilityLevelSwapped('ANsw',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])/ 4))
    set bj_forLoopBIndex = 1
    set bj_forLoopBIndexEnd =(GetUnitAbilityLevelSwapped('ANsw',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])/ 2)
    loop
        exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
        call UnitAddItemByIdSwapped('I02L',GetTriggerUnit())
        set bj_forLoopBIndex = bj_forLoopBIndex + 1
    endloop
endfunction

function Trig_Summon_Quilbeast_Func001C takes nothing returns boolean
    if((GetUnitTypeId(GetTriggerUnit())=='nqb1'))then
        return true
    endif
    if((GetUnitTypeId(GetTriggerUnit())=='nqb2'))then
        return true
    endif
    if((GetUnitTypeId(GetTriggerUnit())=='nqb3'))then
        return true
    endif
    if((GetUnitTypeId(GetTriggerUnit())=='nqb4'))then
        return true
    endif
    return false
endfunction

function Trig_Summon_Quilbeast_Conditions takes nothing returns boolean
    if(not Trig_Summon_Quilbeast_Func001C())then
        return false
    endif
    return true
endfunction

function Trig_Summon_Quilbeast_Func003Func001C takes nothing returns boolean
    if(not(GetUnitTypeId(GetTriggerUnit())=='nqb4'))then
        return false
    endif
    if(not(GetUnitAbilityLevelSwapped('Arsq',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])> 4))then
        return false
    endif
    return true
endfunction

function Trig_Summon_Quilbeast_Func003C takes nothing returns boolean
    if(not Trig_Summon_Quilbeast_Func003Func001C())then
        return false
    endif
    return true
endfunction

function Trig_Summon_Quilbeast_Actions takes nothing returns nothing
    call SetUnitAbilityLevelSwapped('Aspo',GetTriggerUnit(),(GetUnitAbilityLevelSwapped('Arsq',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])+ 0))
    if(Trig_Summon_Quilbeast_Func003C())then
        call SetUnitAbilityLevelSwapped('A000',GetTriggerUnit(),(GetUnitAbilityLevelSwapped('Arsq',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])+ 2))
        set bj_forLoopBIndex = 1
        set bj_forLoopBIndexEnd =((GetUnitAbilityLevelSwapped('Arsq',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])- 4)* 1)
        loop
            exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
            call UnitAddItemByIdSwapped('I01B',GetTriggerUnit())
            set bj_forLoopBIndex = bj_forLoopBIndex + 1
        endloop
    else
    endif
endfunction

function Trig_Time_Wizard_Cooldown_Conditions takes nothing returns boolean
    if(not(GetUnitTypeId(GetTriggerUnit())=='O007'))then
        return false
    endif
    return true
endfunction

function Trig_Time_Wizard_Cooldown_Actions takes nothing returns nothing
    //	call TriggerSleepAction(0.00)
    //	call UnitResetCooldown(GetTriggerUnit())
    //	call TriggerSleepAction(0.01)
    //	call UnitResetCooldown(GetTriggerUnit())
endfunction

function Trig_Ward_Location_Func002C takes nothing returns boolean
    if((GetUnitTypeId(GetTriggerUnit())=='ohwd'))then
        return true
    endif
    if((GetUnitTypeId(GetTriggerUnit())=='osp1'))then
        return true
    endif
    if((GetUnitTypeId(GetTriggerUnit())=='osp2'))then
        return true
    endif
    if((GetUnitTypeId(GetTriggerUnit())=='osp3'))then
        return true
    endif
    if((GetUnitTypeId(GetTriggerUnit())=='osp4'))then
        return true
    endif
    return false
endfunction

function Trig_Ward_Location_Conditions takes nothing returns boolean
    if(not Trig_Ward_Location_Func002C())then
        return false
    endif
    return true
endfunction

function Trig_Ward_Location_Func001Func002Func003Func001001001002001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_Ward_Location_Func001Func002Func003Func001001001002002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
endfunction

function Trig_Ward_Location_Func001Func002Func003Func001001001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Ward_Location_Func001Func002Func003Func001001001002001(),Trig_Ward_Location_Func001Func002Func003Func001001001002002())
endfunction

function Trig_Ward_Location_Func001Func002Func003C takes nothing returns boolean
    if(not(CountUnitsInGroup(GetUnitsInRectMatching(PlayerArenaRects[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],Condition(function Trig_Ward_Location_Func001Func002Func003Func001001001002)))==0))then
        return false
    endif
    return true
endfunction

function Trig_Ward_Location_Func001Func002C takes nothing returns boolean
    if(not Trig_Ward_Location_Func001Func002Func003C())then
        return false
    endif
    return true
endfunction

function Trig_Ward_Location_Func001Func003C takes nothing returns boolean
    if((RectContainsUnit(PlayerArenaRects[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetTriggerUnit())==true))then
        return true
    endif
    if((RectContainsUnit(RectMidArena,GetTriggerUnit())==true))then
        return true
    endif
    return false
endfunction

function Trig_Ward_Location_Func001C takes nothing returns boolean
    if(not Trig_Ward_Location_Func001Func003C())then
        return false
    endif
    return true
endfunction

function Trig_Ward_Location_Actions takes nothing returns nothing
    if(Trig_Ward_Location_Func001C())then
        call DoNothing()
    else
        if(Trig_Ward_Location_Func001Func002C())then
            call DoNothing()
        else
            call SetUnitPositionLoc(GetTriggerUnit(),PolarProjectionBJ(GetRectCenter(PlayerArenaRects[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]),525.00,AngleBetweenPoints(GetRectCenter(PlayerArenaRects[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]),GetUnitLoc(GetTriggerUnit()))))
        endif
    endif
endfunction

function Trig_Wisp_Func001Func001Func002Func001C takes nothing returns boolean
    if(not(DistanceBetweenPoints(GetUnitLoc(GetEnumUnit()),GetUnitLoc(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]))<= 450.00))then
        return false
    endif
    return true
endfunction

function Trig_Wisp_Func001Func001Func002C takes nothing returns boolean
    if(not(DistanceBetweenPoints(GetUnitLoc(GetEnumUnit()),GetUnitLoc(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]))>= 800.00))then
        return false
    endif
    return true
endfunction

function Trig_Wisp_Func001Func001Func003Func001C takes nothing returns boolean
    if(not(DistanceBetweenPoints(GetUnitLoc(GetEnumUnit()),GetUnitLoc(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]))>= 200.00))then
        return false
    endif
    return true
endfunction

function Trig_Wisp_Func001Func001Func003C takes nothing returns boolean
    if(not(GetUnitStateSwap(UNIT_STATE_MANA,GetEnumUnit())==GetUnitStateSwap(UNIT_STATE_MAX_MANA,GetEnumUnit())))then
        return false
    endif
    return true
endfunction

function Trig_Wisp_Func001Func001C takes nothing returns boolean
    if(not(GetOwningPlayer(GetEnumUnit())==GetOwningPlayer(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))])))then
        return false
    endif
    return true
endfunction

function Trig_Wisp_Func001A takes nothing returns nothing
    if(Trig_Wisp_Func001Func001C())then
        if(Trig_Wisp_Func001Func001Func002C())then
            call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\NightElf\\FaerieDragonInvis\\FaerieDragon_Invis.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
            call SetUnitPositionLoc(GetEnumUnit(),GetUnitLoc(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]))
            call IssueImmediateOrderBJ(GetEnumUnit(),"stop")
            call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\NightElf\\FaerieDragonInvis\\FaerieDragon_Invis.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
        else
            if(Trig_Wisp_Func001Func001Func002Func001C())then
                call SetUnitAbilityLevelSwapped('A01H',GetEnumUnit(),(GetHeroLevel(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))])/ 2))
                call IssueTargetOrderBJ(GetEnumUnit(),"healingwave",PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))])
            else
            endif
        endif
        if(Trig_Wisp_Func001Func001Func003C())then
            call IssuePointOrderLocBJ(GetEnumUnit(),"move",OffsetLocation(GetUnitLoc(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]),GetRandomReal(- 150.00,150.00),GetRandomReal(- 150.00,150.00)))
            call SetUnitManaBJ(GetEnumUnit(),GetRandomReal(0,1.00))
        else
            if(Trig_Wisp_Func001Func001Func003Func001C())then
                call SetUnitMoveSpeed(GetEnumUnit(),(DistanceBetweenPoints(GetUnitLoc(GetEnumUnit()),GetUnitLoc(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]))/ 2.00))
                call IssuePointOrderLocBJ(GetEnumUnit(),"move",OffsetLocation(GetUnitLoc(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]),GetRandomReal(- 150.00,150.00),GetRandomReal(- 150.00,150.00)))
                call SetUnitManaBJ(GetEnumUnit(),GetRandomReal(0,1.00))
            else
                call SetUnitMoveSpeed(GetEnumUnit(),GetUnitDefaultMoveSpeed(GetEnumUnit()))
            endif
        endif
    else
    endif
endfunction

function Trig_Wisp_Actions takes nothing returns nothing
    local group GRP = GetUnitsOfTypeIdAll('e003')
    call ForGroupBJ(GRP,function Trig_Wisp_Func001A)
    call DestroyGroup(GRP)
    set GRP = null
endfunction

/*
function Trig_Disable_Abilities_Func001Func003Func003Func003C takes nothing returns boolean
    if(not(IsUnitInGroup(GetTriggerUnit(),DuelingHeroGroup)!=true))then
        return false
    endif
    if(not(IsPlayerInForce(GetOwningPlayer(GetTriggerUnit()),RoundPlayersCompleted)==true))then
        return false
    endif
    return true
endfunction

function Trig_Disable_Abilities_Func001Func003Func003C takes nothing returns boolean
    if((GetTriggerUnit()==udg_unit05))then
        return true
    endif
    if((RectContainsUnit(RectMidArena,GetTriggerUnit())==true))then
        return true
    endif
    if(Trig_Disable_Abilities_Func001Func003Func003Func003C())then
        return true
    endif
    return false
endfunction

function Trig_Disable_Abilities_Func001Func003C takes nothing returns boolean
    if(not(BrStarted==false))then
        return false
    endif
    if(not(ElimPvpStarted==false))then
        return false
    endif
    if(not Trig_Disable_Abilities_Func001Func003Func003C())then
        return false
    endif
    if(not(GetUnitTypeId(GetTriggerUnit())!=SUDDEN_DEATH_UNIT_ID))then
        return false
    endif
    if(not(GetUnitTypeId(GetTriggerUnit())!=PRIEST_1_UNIT_ID))then
        return false
    endif	
    if(not(GetUnitTypeId(GetTriggerUnit())!='h014'))then
        return false
    endif		
    return true
endfunction

function Trig_Disable_Abilities_Func001C takes nothing returns boolean
    if(not Trig_Disable_Abilities_Func001Func003C())then
        return false
    endif
    return true
endfunction
*/

function Trig_Disable_Abilities_Actions takes nothing returns nothing
    if(Trig_Disable_Abilities_Func001C(GetTriggerUnit()))then
        call IssueImmediateOrderBJ(GetTriggerUnit(),"stop")
        //call BJDebugMsg(GetUnitName(GetTriggerUnit()) +  "disable abilities stop")
    else
        //call ConditionalTriggerExecute(udg_trigger37)
    endif
endfunction

/*
function Trig_Cast_Channeling_Ability_Func001Func002C takes nothing returns boolean
    local integer abilId = GetSpellAbilityId()
    return abilId == 'AHbz' or abilId == 'ANrf' or abilId == 'ANst' or abilId == 'ANvc' or abilId == 'AEtq' or abilId == 'Aclf' or abilId == 'ANmo' or abilId == 'AEsf'
endfunction

function Trig_Cast_Channeling_Ability_Func001C takes nothing returns boolean
    if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
        return false
    endif
    if(not Trig_Cast_Channeling_Ability_Func001Func002C())then
        return false
    endif
    return true
endfunction

function Trig_Cast_Channeling_Ability_Conditions takes nothing returns boolean
    if(not Trig_Cast_Channeling_Ability_Func001C())then
        return false
    endif
    return true
endfunction

function Trig_Cast_Channeling_Ability_Func003C takes nothing returns boolean
    if(not(GetSpellAbilityId()!='AEtq'))then
        return false
    endif
    return true
endfunction

function Trig_Cast_Channeling_Ability_Func009Func001Func001Func001Func001C takes nothing returns boolean
    if(not(GetSpellAbilityId()=='AEtq'))then
        return false
    endif
    return true
endfunction

function Trig_Cast_Channeling_Ability_Func009Func001Func001Func001C takes nothing returns boolean
    if(not(GetSpellAbilityId()=='ANvc'))then
        return false
    endif
    return true
endfunction

function Trig_Cast_Channeling_Ability_Func009Func001Func001C takes nothing returns boolean
    if(not(GetSpellAbilityId()=='ANst'))then
        return false
    endif
    return true
endfunction

function Trig_Cast_Channeling_Ability_Func009Func001C takes nothing returns boolean
    if(not(GetSpellAbilityId()=='ANrf'))then
        return false
    endif
    return true
endfunction

function Trig_Cast_Channeling_Ability_Func009C takes nothing returns boolean
    if(not(GetSpellAbilityId()=='AHbz'))then
        return false
    endif
    return true
endfunction


function Trig_Cast_Channeling_Ability_Actions takes nothing returns nothing
    local integer order = GetUnitCurrentOrder(GetTriggerUnit())
    local location spellLoc = GetSpellTargetLoc()
    local integer abilId = GetSpellAbilityId()
    local real manaCost = BlzGetAbilityManaCost(abilId, GetUnitAbilityLevel(GetTriggerUnit(), abilId))
    if GetUnitState(GetTriggerUnit(), UNIT_STATE_MANA) - manaCost > 0 then
        if abilId != 'AEtq' and abilId != 'AEsf'then
            call CreateNUnitsAtLoc(1,PRIEST_1_UNIT_ID,GetOwningPlayer(GetTriggerUnit()),PolarProjectionBJ(GetSpellTargetLoc(),256.00,AngleBetweenPoints(GetSpellTargetLoc(),GetUnitLoc(GetTriggerUnit()))),bj_UNIT_FACING)
        else
            call CreateNUnitsAtLoc(1,PRIEST_1_UNIT_ID,GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(GetTriggerUnit()),bj_UNIT_FACING)
        endif

        call UnitApplyTimedLifeBJ(60.00,'BTLF',GetLastCreatedUnit())
        call UnitAddAbilityBJ(GetSpellAbilityId(),GetLastCreatedUnit())
        call SetUnitAbilityLevelSwapped(GetSpellAbilityId(),GetLastCreatedUnit(),GetUnitAbilityLevelSwapped(GetSpellAbilityId(),GetTriggerUnit()))

        if order == 852183 or order == 852184 then
            call IssueImmediateOrderById(GetLastCreatedUnit(), order)
        else
            call IssuePointOrderById(GetLastCreatedUnit(), order, GetLocationX(spellLoc), GetLocationY(spellLoc))
        endif
        /*
        if GetSpellAbilityId()=='ANmo' then
            call IssuePointOrderLocBJ(GetLastCreatedUnit(),"blizzard",GetSpellTargetLoc())
        elseif GetSpellAbilityId()=='ANmo' then
            call IssuePointOrderLocBJ(GetLastCreatedUnit(),"rainoffire",GetSpellTargetLoc())
        elseif GetSpellAbilityId()=='ANmo' then
            call IssuePointOrderLocBJ(GetLastCreatedUnit(),"stampede",GetSpellTargetLoc())
        elseif GetSpellAbilityId()=='ANmo' then
            call IssuePointOrderLocBJ(GetLastCreatedUnit(),"volcano",GetSpellTargetLoc())
        elseif GetSpellAbilityId()=='ANmo' then
            call IssueImmediateOrderBJ(GetLastCreatedUnit(),"tranquility")
        elseif GetSpellAbilityId()=='ANmo' then
            call IssuePointOrderLocBJ(GetLastCreatedUnit(),"cloudoffog",GetSpellTargetLoc())
        elseif GetSpellAbilityId()=='ANmo' then
            call IssuePointOrderLocBJ(GetLastCreatedUnit(),"monsoon",GetSpellTargetLoc())
        elseif 
        endif
        */
        call TriggerSleepAction(0.00)
        call IssueImmediateOrderBJ(GetTriggerUnit(),"stop")
        call SetUnitAnimation(GetTriggerUnit(),"spell")
        call QueueUnitAnimationBJ(GetTriggerUnit(),"stand")
        call SetUnitState(GetTriggerUnit(), UNIT_STATE_MANA, GetUnitState(GetTriggerUnit(), UNIT_STATE_MANA) - manaCost)
        call AbilStartCD(GetTriggerUnit(), abilId, BlzGetUnitAbilityCooldown(GetTriggerUnit(), abilId, GetUnitAbilityLevel(GetTriggerUnit(), abilId)))
    endif
    call RemoveLocation(spellLoc)
    set spellLoc = null
endfunction */

function Trig_Acquire_Item_Conditions takes nothing returns boolean
    if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
        return false
    endif
    return true
endfunction

function Trig_Acquire_Item_Actions takes nothing returns nothing
    call SetItemUserData(GetManipulatedItem(),GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit())))
endfunction

function Trig_Drop_Item_Func001C takes nothing returns boolean
    if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)!=true))then
        return false
    endif
    if(not(GetUnitTypeId(GetTriggerUnit())!=SUDDEN_DEATH_UNIT_ID))then
        return false
    endif
    if(not(GetUnitTypeId(GetTriggerUnit())!=PRIEST_1_UNIT_ID))then
        return false
    endif
    if(not(GetUnitTypeId(GetTriggerUnit())!='h014'))then
        return false
    endif
    if(not(GetItemType(GetManipulatedItem())!=ITEM_TYPE_POWERUP))then
        return false
    endif
    return true
endfunction

function Trig_Drop_Item_Conditions takes nothing returns boolean
    if(not Trig_Drop_Item_Func001C())then
        return false
    endif
    return true
endfunction

function Trig_Drop_Item_Func002C takes nothing returns boolean
    if(not(GetItemUserData(GetManipulatedItem())==0))then
        return false
    endif
    return true
endfunction

function Trig_Drop_Item_Actions takes nothing returns nothing
    if(Trig_Drop_Item_Func002C())then
        set udg_location02 = GetItemLoc(GetManipulatedItem())
        call UnitRemoveItemSwapped(GetManipulatedItem(),GetTriggerUnit())
        call SetItemPositionLoc(GetManipulatedItem(),udg_location02)
    else
        call UnitRemoveItemSwapped(GetManipulatedItem(),GetTriggerUnit())
    endif
endfunction

function Trig_Give_Item_Conditions takes nothing returns boolean
    if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
        return false
    endif
    return true
endfunction

function Trig_Give_Item_Func002C takes nothing returns boolean
    if(not(RectContainsItem(GetManipulatedItem(),GetPlayableMapRect())==true))then
        return false
    endif
    return true
endfunction

function Trig_Give_Item_Actions takes nothing returns nothing
    call TriggerSleepAction(0.00)
    if(Trig_Give_Item_Func002C())then
        call SetItemUserData(GetManipulatedItem(),0)
    else
    endif
endfunction

function Trig_Remove_Dummies_Conditions takes nothing returns boolean
    if(not(GetUnitTypeId(GetTriggerUnit())==SUDDEN_DEATH_UNIT_ID))then
        return false
    endif
    if(not(GetUnitTypeId(GetTriggerUnit())!=PRIEST_1_UNIT_ID))then
        return false
    endif
    if(not(GetUnitTypeId(GetTriggerUnit())!='h014'))then
        return false
    endif
    if(not(IsUnitInGroup(GetTriggerUnit(),GroupEmptyArenaCheck)!=true))then
        return false
    endif
    return true
endfunction

function Trig_Remove_Dummies_Actions takes nothing returns nothing
    call DeleteUnit(GetTriggerUnit())
endfunction

function Trig_Battle_Royal_Func015001002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)==true)
endfunction

function Trig_Battle_Royal_Func015A takes nothing returns nothing
    call DeleteUnit(GetEnumUnit())
endfunction

function Trig_Battle_Royal_Func016Func001001002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(8))
endfunction

function Trig_Battle_Royal_Func016Func001001002002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(11))
endfunction

function Trig_Battle_Royal_Func016Func001001002002002001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_Battle_Royal_Func016Func001001002002002002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
endfunction

function Trig_Battle_Royal_Func016Func001001002002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Battle_Royal_Func016Func001001002002002001(),Trig_Battle_Royal_Func016Func001001002002002002())
endfunction

function Trig_Battle_Royal_Func016Func001001002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Battle_Royal_Func016Func001001002002001(),Trig_Battle_Royal_Func016Func001001002002002())
endfunction

function Trig_Battle_Royal_Func016Func001001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Battle_Royal_Func016Func001001002001(),Trig_Battle_Royal_Func016Func001001002002())
endfunction

function Trig_Battle_Royal_Func016Func001A takes nothing returns nothing
    set BrPlayerCount =(BrPlayerCount + 1)
    call SetPlayerAllianceStateBJ(GetOwningPlayer(GetEnumUnit()),ConvertedPlayer(GetForLoopIndexA()),bj_ALLIANCE_UNALLIED)
endfunction

function Trig_Battle_Royal_Func017001002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(8))
endfunction

function Trig_Battle_Royal_Func017001002002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(11))
endfunction

function Trig_Battle_Royal_Func017001002002002001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_Battle_Royal_Func017001002002002002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
endfunction

function Trig_Battle_Royal_Func017001002002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Battle_Royal_Func017001002002002001(),Trig_Battle_Royal_Func017001002002002002())
endfunction

function Trig_Battle_Royal_Func017001002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Battle_Royal_Func017001002002001(),Trig_Battle_Royal_Func017001002002002())
endfunction

function Trig_Battle_Royal_Func017001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Battle_Royal_Func017001002001(),Trig_Battle_Royal_Func017001002002())
endfunction

function Trig_Battle_Royal_Func017A takes nothing returns nothing
    set udg_unit01 = GetEnumUnit()
    call ConditionalTriggerExecute(udg_trigger82)
    call SetUnitPositionLocFacingLocBJ(GetEnumUnit(),PolarProjectionBJ(GetRectCenter(GetPlayableMapRect()),750.00,(((I2R(GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit())))- 1)*- 45.00)- 225.00)),GetRectCenter(RectMidArena))
    call SelectUnitForPlayerSingle(GetEnumUnit(),GetOwningPlayer(GetEnumUnit()))
    call PanCameraToTimedLocForPlayer(GetOwningPlayer(GetEnumUnit()),GetUnitLoc(GetEnumUnit()),0.50)
endfunction

function Trig_Battle_Royal_Func018002 takes nothing returns nothing
    call KillUnit(GetEnumUnit())
endfunction

function Trig_Battle_Royal_Func019002 takes nothing returns nothing
    call KillUnit(GetEnumUnit())
endfunction

function Trig_Battle_Royal_Func020A takes nothing returns nothing
    call RemoveItem(GetEnumItem())
endfunction

function Trig_Battle_Royal_Func033001002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(8))
endfunction

function Trig_Battle_Royal_Func033001002002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(11))
endfunction

function Trig_Battle_Royal_Func033001002002002001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_Battle_Royal_Func033001002002002002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
endfunction

function Trig_Battle_Royal_Func033001002002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Battle_Royal_Func033001002002002001(),Trig_Battle_Royal_Func033001002002002002())
endfunction

function Trig_Battle_Royal_Func033001002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Battle_Royal_Func033001002002001(),Trig_Battle_Royal_Func033001002002002())
endfunction

function Trig_Battle_Royal_Func033001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Battle_Royal_Func033001002001(),Trig_Battle_Royal_Func033001002002())
endfunction

function Trig_Battle_Royal_Func033A takes nothing returns nothing
    call SetUnitInvulnerable(GetEnumUnit(),false)
    call StartFunctionSpell(GetEnumUnit(),1)
endfunction

function Trig_Battle_Royal_Func034C takes nothing returns boolean
    if(not(BrPlayerCount==1))then
        return false
    endif
    return true
endfunction

function ShowDraftBuildings takes boolean b returns nothing
    local integer i = 0
    if AbilityMode == 2 then
        loop
            call ShowUnit(circle1, b)
            call ShowUnit(circle2, b)
            call ShowUnit(udg_Draft_DraftBuildings[i], b)
            call ShowUnit(udg_Draft_UpgradeBuildings[i], b)
            call SetTextTagVisibility(FloatingTextBuy, b)
            call SetTextTagVisibility(FloatingTextUpgrade, b)
            set i = i + 1
            exitwhen i > 9
        endloop
    endif
endfunction

function Trig_Battle_Royal_Actions takes nothing returns nothing
    call DisableTrigger(udg_trigger149)
    call KillUnit(udg_unit03)
    call TriggerSleepAction(5.00)
    call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
    call CreateTimerDialogBJ(GetLastCreatedTimerBJ(),"Battle Royal")
    call StartTimerBJ(GetLastCreatedTimerBJ(),false,60.00)
    call DisplayTextToForce(GetPlayersAll(),"Hold |cffffcc00SHIFT|r while buying |cff7bff00glory buffs|r or |cff00ff37tomes|r to buy |cff00fff21000|r of them at once, provided you have the gold.")
    call TriggerSleepAction(60.00)
    set BrStarted = true
    
    call PlaySoundBJ(udg_sound10)
    call DisplayTextToForce(GetPlayersAll(),"|cffffcc00FINAL BATTLE - THE WINNER TAKES IT ALL")
    call PauseAllUnitsBJ(true)
    call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
    call ShowDraftBuildings(false)
    call ForGroupBJ(GetUnitsOfPlayerMatching(Player(PLAYER_NEUTRAL_PASSIVE),Condition(function Trig_Battle_Royal_Func015001002)),function Trig_Battle_Royal_Func015A)
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 8
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_Battle_Royal_Func016Func001001002)),function Trig_Battle_Royal_Func016Func001A)
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_Battle_Royal_Func017001002)),function Trig_Battle_Royal_Func017A)
    //call ForGroupBJ(GetUnitsOfTypeIdAll('e001'),function Trig_Battle_Royal_Func018002)
    call ForGroupBJ(GetUnitsOfTypeIdAll('e003'),function Trig_Battle_Royal_Func019002)
    call EnumItemsInRectBJ(GetPlayableMapRect(),function Trig_Battle_Royal_Func020A)
    call DisableTrigger(udg_trigger142)
    call DisableTrigger(udg_trigger145)
    call DisableTrigger(udg_trigger80)
    call DisableTrigger(udg_trigger81)
    call EnableTrigger(udg_trigger43)
    call TriggerSleepAction(2)
    set udg_location01 = OffsetLocation(GetRectCenter(GetPlayableMapRect()),- 40.00,- 50.00)
    set CountdownCount = 5
    call ConditionalTriggerExecute(udg_trigger117)
    call TriggerSleepAction(5.00)
    call PlaySoundBJ(udg_sound08)
    call DisplayTimedTextToForce(GetPlayersAll(),1.00,"|cffffcc00GO!!!|r")
    call SetAllCurrentlyFighting(true)
    call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_Battle_Royal_Func033001002)),function Trig_Battle_Royal_Func033A)
    if(Trig_Battle_Royal_Func034C())then
        set PlayerCount = 1
        call ConditionalTriggerExecute(udg_trigger122)
    else
    endif
    call PauseAllUnitsBJ(false)
endfunction

function Trig_Hero_Dies_Battle_Royal_Func007C takes nothing returns boolean
    if(not(BrStarted==true))then
        return false
    endif
    if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
        return false
    endif
    if(not(GetOwningPlayer(GetTriggerUnit())!=Player(8)))then
        return false
    endif
    if(not(GetOwningPlayer(GetTriggerUnit())!=Player(11)))then
        return false
    endif
    return true
endfunction

function Trig_Hero_Dies_Battle_Royal_Conditions takes nothing returns boolean
    if(not Trig_Hero_Dies_Battle_Royal_Func007C())then
        return false
    endif
    return true
endfunction

function Trig_Hero_Dies_Battle_Royal_Func004A takes nothing returns nothing
    local unit u = GetEnumUnit()

    if IsUnitType(u, UNIT_TYPE_HERO) then
        call RemoveItem(UnitItemInSlot(u, 0))
        call RemoveItem(UnitItemInSlot(u, 1))
        call RemoveItem(UnitItemInSlot(u, 2))
        call RemoveItem(UnitItemInSlot(u, 3))
        call RemoveItem(UnitItemInSlot(u, 4))
        call RemoveItem(UnitItemInSlot(u, 5))

        call RemoveHeroAbilities(u)
    endif

    call KillUnit(u)
    set u = null
endfunction

function Trig_Hero_Dies_Battle_Royal_Actions takes nothing returns nothing
    call ForceAddPlayerSimple(GetOwningPlayer(GetTriggerUnit()),DefeatedPlayers)
    set PlayerCount =(PlayerCount - 1)
    call DisplayTimedTextToForce(GetPlayersAll(),5.00,("|cffffcc00" + GetPlayerNameColour(GetOwningPlayer(GetTriggerUnit())) + " was defeated by |r" + GetPlayerNameColour(GetOwningPlayer(GetKillingUnit()))))
    call ForGroupBJ(GetUnitsOfPlayerAll(GetOwningPlayer(GetTriggerUnit())),function Trig_Hero_Dies_Battle_Royal_Func004A)
    set WinningPlayer = GetOwningPlayer(GetKillingUnit())
    call ConditionalTriggerExecute(udg_trigger122)
endfunction

function Trig_Betting_Initialization_Conditions takes nothing returns boolean
    if(not(udg_boolean13==true))then
        return false
    endif
    return true
endfunction

function Trig_Betting_Initialization_Actions takes nothing returns nothing
    call DialogSetMessageBJ(Dialogs[2],"Betting Menu")
    call DialogAddButtonBJ(Dialogs[2],"Gold")
    set DialogButtons[4]= GetLastCreatedButtonBJ()
    call DialogAddButtonBJ(Dialogs[2],"Lumber")
    set DialogButtons[5]= GetLastCreatedButtonBJ()
    call DialogAddButtonBJ(Dialogs[2],"Gold & Lumber")
    set DialogButtons[6]= GetLastCreatedButtonBJ()
    call DialogAddButtonBJ(Dialogs[2],"Cancel")
    set DialogButtons[7]= GetLastCreatedButtonBJ()
    call DialogSetMessageBJ(Dialogs[3],"Betting Menu")
    call DialogAddButtonBJ(Dialogs[3],"25%")
    set DialogButtons[8]= GetLastCreatedButtonBJ()
    call DialogAddButtonBJ(Dialogs[3],"50%")
    set DialogButtons[9]= GetLastCreatedButtonBJ()
    call DialogAddButtonBJ(Dialogs[3],"100%")
    set DialogButtons[10]= GetLastCreatedButtonBJ()
    call DialogAddButtonBJ(Dialogs[3],"Cancel")
    set DialogButtons[11]= GetLastCreatedButtonBJ()
endfunction

function Trig_Place_Bet_PvP1_Conditions takes nothing returns boolean
    if(not(GetClickedButtonBJ()==DialogButtons[1]))then
        return false
    endif
    return true
endfunction

function Trig_Place_Bet_PvP1_Actions takes nothing returns nothing
    call DialogSetMessageBJ(Dialogs[2],"Betting Menu")
    call DialogDisplayBJ(true,Dialogs[2],GetTriggerPlayer())
    call ForceAddPlayerSimple(GetTriggerPlayer(),udg_force04)
endfunction

function Trig_Place_Bet_PvP2_Conditions takes nothing returns boolean
    if(not(GetClickedButtonBJ()==DialogButtons[2]))then
        return false
    endif
    return true
endfunction

function Trig_Place_Bet_PvP2_Actions takes nothing returns nothing
    call DialogSetMessageBJ(Dialogs[2],"Betting Menu")
    call DialogDisplayBJ(true,Dialogs[2],GetTriggerPlayer())
    call ForceAddPlayerSimple(GetTriggerPlayer(),udg_force05)
endfunction

function Trig_Skip_Bet_Func004C takes nothing returns boolean
    if((GetClickedButtonBJ()==DialogButtons[3]))then
        return true
    endif
    if((GetClickedButtonBJ()==DialogButtons[7]))then
        return true
    endif
    if((GetClickedButtonBJ()==DialogButtons[11]))then
        return true
    endif
    return false
endfunction

function Trig_Skip_Bet_Conditions takes nothing returns boolean
    if(not Trig_Skip_Bet_Func004C())then
        return false
    endif
    return true
endfunction

function Trig_Skip_Bet_Actions takes nothing returns nothing
    call ForceRemovePlayerSimple(GetTriggerPlayer(),udg_force04)
    call ForceRemovePlayerSimple(GetTriggerPlayer(),udg_force05)
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 3
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call DialogDisplayBJ(false,Dialogs[GetForLoopIndexA()],GetTriggerPlayer())
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
endfunction

function Trig_Place_Bet_Gold_Func002C takes nothing returns boolean
    if(not(GetClickedButtonBJ()==DialogButtons[4]))then
        return false
    endif
    return true
endfunction

function Trig_Place_Bet_Gold_Conditions takes nothing returns boolean
    if(not Trig_Place_Bet_Gold_Func002C())then
        return false
    endif
    return true
endfunction

function Trig_Place_Bet_Gold_Func001Func001001 takes nothing returns boolean
    return(udg_boolean18!=true)
endfunction

function Trig_Place_Bet_Gold_Func001C takes nothing returns boolean
    if(not(GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)> 0))then
        return false
    endif
    return true
endfunction

function Trig_Place_Bet_Gold_Actions takes nothing returns nothing
    if(Trig_Place_Bet_Gold_Func001C())then
        call DialogSetMessageBJ(Dialogs[3],"Betting Menu")
        call DialogDisplayBJ(true,Dialogs[3],GetTriggerPlayer())
        set udg_booleans04[GetConvertedPlayerId(GetTriggerPlayer())]= true
        set udg_booleans05[GetConvertedPlayerId(GetTriggerPlayer())]= false
    else
        if(Trig_Place_Bet_Gold_Func001Func001001())then
            return
        else
            call DoNothing()
        endif
        call DialogDisplayBJ(true,Dialogs[2],GetTriggerPlayer())
    endif
endfunction

function Trig_Place_Bet_Lumber_Func002C takes nothing returns boolean
    if(not(GetClickedButtonBJ()==DialogButtons[5]))then
        return false
    endif
    return true
endfunction

function Trig_Place_Bet_Lumber_Conditions takes nothing returns boolean
    if(not Trig_Place_Bet_Lumber_Func002C())then
        return false
    endif
    return true
endfunction

function Trig_Place_Bet_Lumber_Func001Func001001 takes nothing returns boolean
    return(udg_boolean18!=true)
endfunction

function Trig_Place_Bet_Lumber_Func001C takes nothing returns boolean
    if(not(GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER)> 0))then
        return false
    endif
    return true
endfunction

function Trig_Place_Bet_Lumber_Actions takes nothing returns nothing
    if(Trig_Place_Bet_Lumber_Func001C())then
        call DialogSetMessageBJ(Dialogs[3],"Betting Menu")
        call DialogDisplayBJ(true,Dialogs[3],GetTriggerPlayer())
        set udg_booleans04[GetConvertedPlayerId(GetTriggerPlayer())]= false
        set udg_booleans05[GetConvertedPlayerId(GetTriggerPlayer())]= true
    else
        if(Trig_Place_Bet_Lumber_Func001Func001001())then
            return
        else
            call DoNothing()
        endif
        call DialogDisplayBJ(true,Dialogs[2],GetTriggerPlayer())
    endif
endfunction

function Trig_Place_Bet_GoldLumber_Func002C takes nothing returns boolean
    if(not(GetClickedButtonBJ()==DialogButtons[6]))then
        return false
    endif
    return true
endfunction

function Trig_Place_Bet_GoldLumber_Conditions takes nothing returns boolean
    if(not Trig_Place_Bet_GoldLumber_Func002C())then
        return false
    endif
    return true
endfunction

function Trig_Place_Bet_GoldLumber_Func001Func001001 takes nothing returns boolean
    return(udg_boolean18!=true)
endfunction

function Trig_Place_Bet_GoldLumber_Func001Func007C takes nothing returns boolean
    if(not(GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)> 0))then
        return false
    endif
    if(not(GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER)> 0))then
        return false
    endif
    return true
endfunction

function Trig_Place_Bet_GoldLumber_Func001C takes nothing returns boolean
    if(not Trig_Place_Bet_GoldLumber_Func001Func007C())then
        return false
    endif
    return true
endfunction

function Trig_Place_Bet_GoldLumber_Actions takes nothing returns nothing
    if(Trig_Place_Bet_GoldLumber_Func001C())then
        call DialogSetMessageBJ(Dialogs[3],"Betting Menu")
        call DialogDisplayBJ(true,Dialogs[3],GetTriggerPlayer())
        set udg_booleans04[GetConvertedPlayerId(GetTriggerPlayer())]= true
        set udg_booleans05[GetConvertedPlayerId(GetTriggerPlayer())]= true
    else
        if(Trig_Place_Bet_GoldLumber_Func001Func001001())then
            return
        else
            call DoNothing()
        endif
        call DialogDisplayBJ(true,Dialogs[2],GetTriggerPlayer())
    endif
endfunction

function Trig_Place_Bet_Func001C takes nothing returns boolean
    if((GetClickedButtonBJ()==DialogButtons[8]))then
        return true
    endif
    if((GetClickedButtonBJ()==DialogButtons[9]))then
        return true
    endif
    if((GetClickedButtonBJ()==DialogButtons[10]))then
        return true
    endif
    return false
endfunction

function Trig_Place_Bet_Conditions takes nothing returns boolean
    if(not Trig_Place_Bet_Func001C())then
        return false
    endif
    return true
endfunction

function Trig_Place_Bet_Func002Func001C takes nothing returns boolean
    if(not(GetClickedButtonBJ()==DialogButtons[9]))then
        return false
    endif
    return true
endfunction

function Trig_Place_Bet_Func002C takes nothing returns boolean
    if(not(GetClickedButtonBJ()==DialogButtons[8]))then
        return false
    endif
    return true
endfunction

function Trig_Place_Bet_Func004C takes nothing returns boolean
    if(not(udg_booleans04[GetConvertedPlayerId(GetTriggerPlayer())]==true))then
        return false
    endif
    return true
endfunction

function Trig_Place_Bet_Func005C takes nothing returns boolean
    if(not(udg_booleans05[GetConvertedPlayerId(GetTriggerPlayer())]==true))then
        return false
    endif
    return true
endfunction

function Trig_Place_Bet_Func007001 takes nothing returns boolean
    return(udg_boolean14==false)
endfunction

function Trig_Place_Bet_Func008C takes nothing returns boolean
    if(not(IsPlayerInForce(GetTriggerPlayer(),udg_force04)==true))then
        return false
    endif
    return true
endfunction

function Trig_Place_Bet_Actions takes nothing returns nothing
    if(Trig_Place_Bet_Func002C())then
        set udg_integers11[GetConvertedPlayerId(GetTriggerPlayer())]= 25
    else
        if(Trig_Place_Bet_Func002Func001C())then
            set udg_integers11[GetConvertedPlayerId(GetTriggerPlayer())]= 50
        else
            set udg_integers11[GetConvertedPlayerId(GetTriggerPlayer())]= 100
        endif
    endif
    if(Trig_Place_Bet_Func004C())then
        set udg_integer62 = udg_integers15[GetConvertedPlayerId(GetTriggerPlayer())]
        set udg_integer62 = R2I(((I2R(GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD))/ 100.00)* I2R(udg_integers11[GetConvertedPlayerId(GetTriggerPlayer())])))
        //call ConditionalTriggerExecute(udg_trigger52)
        call AdjustPlayerStateBJ((- 1 * udg_integer62),GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)
        call ResourseRefresh(   GetTriggerPlayer() )
        set udg_integers15[GetConvertedPlayerId(GetTriggerPlayer())]= udg_integer62
    else
    endif
    if(Trig_Place_Bet_Func005C())then
        set udg_integer62 = udg_integers16[GetConvertedPlayerId(GetTriggerPlayer())]
        set udg_integer62 = R2I(((I2R(GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER))/ 100.00)* I2R(udg_integers11[GetConvertedPlayerId(GetTriggerPlayer())])))
        //call ConditionalTriggerExecute(udg_trigger52)
        call AdjustPlayerStateBJ((- 1 * udg_integer62),GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER)
        call ResourseRefresh(   GetTriggerPlayer() )
        set udg_integers16[GetConvertedPlayerId(GetTriggerPlayer())]= udg_integer62
    else
    endif
    if(Trig_Place_Bet_Func007001())then
        return
    else
        call DoNothing()
    endif
    if(Trig_Place_Bet_Func008C())then
        call DisplayTimedTextToForce(GetPlayersAll(),2.00,("|c00F08000" +(GetPlayerNameColour(GetTriggerPlayer())+(" placed a bet on " +(GetPlayerNameColour(GetOwningPlayer(DuelingHeroes[1]))+ "!")))))
    else
        call DisplayTimedTextToForce(GetPlayersAll(),2.00,("|c00F08000" +(GetPlayerNameColour(GetTriggerPlayer())+(" placed a bet on " +(GetPlayerNameColour(GetOwningPlayer(DuelingHeroes[2]))+ "!")))))
    endif
endfunction

function Trig_Eligible_Amount_Func003C takes nothing returns boolean
    if(not((udg_integer62 - BettingPlayerCount)>((udg_integer62 - BettingPlayerCount)- 5)))then
        return false
    endif
    return true
endfunction

function Trig_Eligible_Amount_Actions takes nothing returns nothing
    set BettingPlayerCount = 5
    //call ConditionalTriggerExecute(udg_trigger53)
    if(Trig_Eligible_Amount_Func003C())then
        set udg_integer62 = BettingPlayerCount
    else
        set udg_integer62 =(BettingPlayerCount - 5)
    endif
endfunction

function Trig_Eligible_Amount_Loop_Conditions takes nothing returns boolean
    if(not(BettingPlayerCount < udg_integer62))then
        return false
    endif
    return true
endfunction

function Trig_Eligible_Amount_Loop_Actions takes nothing returns nothing
    set BettingPlayerCount =(BettingPlayerCount + 5)
    call ConditionalTriggerExecute(GetTriggeringTrigger())
endfunction

function Trig_Betting_Complete_Conditions takes nothing returns boolean
    if(not(udg_boolean13==true))then
        return false
    endif
    return true
endfunction

function Trig_Betting_Complete_Func002Func001Func001Func001Func001C takes nothing returns boolean
    if(not(DuelingHeroes[1]==udg_unit05))then
        return false
    endif
    if(not(IsPlayerInForce(GetEnumPlayer(),udg_force04)==true))then
        return false
    endif
    return true
endfunction

function Trig_Betting_Complete_Func002Func001Func001Func001Func002C takes nothing returns boolean
    if(not(DuelingHeroes[2]==udg_unit05))then
        return false
    endif
    if(not(IsPlayerInForce(GetEnumPlayer(),udg_force05)==true))then
        return false
    endif
    return true
endfunction

function Trig_Betting_Complete_Func002Func001Func001Func001C takes nothing returns boolean
    if(Trig_Betting_Complete_Func002Func001Func001Func001Func001C())then
        return true
    endif
    if(Trig_Betting_Complete_Func002Func001Func001Func001Func002C())then
        return true
    endif
    return false
endfunction

function Trig_Betting_Complete_Func002Func001Func001Func006Func003C takes nothing returns boolean
    if(not(udg_booleans05[GetConvertedPlayerId(GetEnumPlayer())]==true))then
        return false
    endif
    return true
endfunction

function Trig_Betting_Complete_Func002Func001Func001Func006C takes nothing returns boolean
    if(not(udg_booleans04[GetConvertedPlayerId(GetEnumPlayer())]==true))then
        return false
    endif
    return true
endfunction

function Trig_Betting_Complete_Func002Func001Func001Func007C takes nothing returns boolean
    if(not(udg_booleans05[GetConvertedPlayerId(GetEnumPlayer())]==true))then
        return false
    endif
    return true
endfunction

function Trig_Betting_Complete_Func002Func001Func001C takes nothing returns boolean
    if(not Trig_Betting_Complete_Func002Func001Func001Func001C())then
        return false
    endif
    return true
endfunction

function Trig_Betting_Complete_Func002Func001Func002C takes nothing returns boolean
    if((udg_integers15[GetConvertedPlayerId(GetEnumPlayer())]> 0))then
        return true
    endif
    if((udg_integers16[GetConvertedPlayerId(GetEnumPlayer())]> 0))then
        return true
    endif
    return false
endfunction

function Trig_Betting_Complete_Func002Func001C takes nothing returns boolean
    if(not Trig_Betting_Complete_Func002Func001Func002C())then
        return false
    endif
    return true
endfunction

function Trig_Betting_Complete_Func002A takes nothing returns nothing
    if(Trig_Betting_Complete_Func002Func001C())then
        if(Trig_Betting_Complete_Func002Func001Func001C())then
            set udg_string01 =(GetPlayerNameColour(GetEnumPlayer()))
            set udg_string01 =(udg_string01 + " won: ")
            call AddSpecialEffectTargetUnitBJ("origin",PlayerHeroes[GetConvertedPlayerId(GetEnumPlayer())],"Abilities\\Spells\\Other\\Transmute\\PileofGold.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
            if(Trig_Betting_Complete_Func002Func001Func001Func006C())then
                call AdjustPlayerStateBJ((udg_integers15[GetConvertedPlayerId(GetEnumPlayer())]* 2),GetEnumPlayer(),PLAYER_STATE_RESOURCE_GOLD)
                call ResourseRefresh(  GetEnumPlayer()    )
                set udg_string01 =(udg_string01 + I2S((udg_integers15[GetConvertedPlayerId(GetEnumPlayer())]* 2)))
                if(Trig_Betting_Complete_Func002Func001Func001Func006Func003C())then
                    set udg_string01 =(udg_string01 + " gold and ")
                else
                endif
            else
            endif
            if(Trig_Betting_Complete_Func002Func001Func001Func007C())then
                call AdjustPlayerStateBJ((udg_integers16[GetConvertedPlayerId(GetEnumPlayer())]* 2),GetEnumPlayer(),PLAYER_STATE_RESOURCE_LUMBER)
                call ResourseRefresh( GetEnumPlayer()   )
                set udg_string01 =(udg_string01 + I2S((udg_integers16[GetConvertedPlayerId(GetEnumPlayer())]* 2)))
                set udg_string01 =(udg_string01 + " lumber!")
            else
                set udg_string01 =(udg_string01 + " gold!")
            endif
            call DisplayTimedTextToForce(GetPlayersAll(),5.00,udg_string01)
        else
        endif
    else
    endif
    set udg_integers11[GetConvertedPlayerId(GetEnumPlayer())]= 0
    set udg_integers15[GetConvertedPlayerId(GetEnumPlayer())]= 0
    set udg_integers16[GetConvertedPlayerId(GetEnumPlayer())]= 0
    set udg_booleans04[GetConvertedPlayerId(GetEnumPlayer())]= false
    set udg_booleans05[GetConvertedPlayerId(GetEnumPlayer())]= false
endfunction

function Trig_Betting_Complete_Actions takes nothing returns nothing
    call ForForce(GetPlayersAll(),function Trig_Betting_Complete_Func002A)
    call ForceClear(udg_force04)
    call ForceClear(udg_force05)
endfunction

function Trig_Dialog_Initialization_Func047Func001Func001C takes nothing returns boolean
    if(not(udg_boolean15==true))then
        return false
    endif
    return true
endfunction

function Trig_Dialog_Initialization_Func047Func001C takes nothing returns boolean
    if(not(InitialPlayerCount > 1))then
        return false
    endif
    return true
endfunction

function Trig_Dialog_Initialization_Func047A takes nothing returns nothing
    if(Trig_Dialog_Initialization_Func047Func001C())then
        if(Trig_Dialog_Initialization_Func047Func001Func001C())then
            call DialogDisplayBJ(true,GameModeDialog,GetEnumPlayer())
        else
            call DialogDisplayBJ(true,GameModeDialog,udg_player03)
        endif
    else
        call DialogDisplayBJ(true,AbilModeDialog,GetEnumPlayer())
    endif
endfunction

function Trig_Dialog_Initialization_Func049001 takes nothing returns boolean
    return(IsTriggerEnabled(udg_trigger77)!=true)
endfunction

function Trig_Dialog_Initialization_Func054001 takes nothing returns boolean
    return(IsTriggerEnabled(udg_trigger77)!=true)
endfunction

function Trig_Dialog_Initialization_Func055A takes nothing returns nothing
    call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
    call DialogDisplayBJ(false,GameDurDialog,GetEnumPlayer())
    call DialogDisplayBJ(false,IncomeModeDialog,GetEnumPlayer())
    call DialogDisplayBJ(false,GameModeDialog,GetEnumPlayer())
    call DialogDisplayBJ(false,AbilModeDialog,GetEnumPlayer())
    call DialogDisplayBJ(false,HeroModeDialog,GetEnumPlayer())
    call DialogDisplayBJ(false,BettingModeDialog,GetEnumPlayer())
    call DialogDisplayBJ(false,udg_dialog06,GetEnumPlayer())
endfunction

function Trig_Dialog_Initialization_Func056C takes nothing returns boolean
    if(not(IsTriggerEnabled(udg_trigger77)==true))then
        return false
    endif
    return true
endfunction

function Trig_Dialog_Initialization_Actions takes nothing returns nothing
    call EnableTrigger(GetTriggeringTrigger())

    //rounds
    call DialogSetMessageBJ(GameDurDialog,"Game Duration/Difficulty")
    call DialogAddButtonBJ(GameDurDialog,"Fast/Easy: 25 rounds, 45 min")
    set udg_buttons01[1]= GetLastCreatedButtonBJ()

    call DialogAddButtonBJ(GameDurDialog,"Long/Medium: 50 rounds, 90 min")
    set udg_buttons01[2]= GetLastCreatedButtonBJ()

    call DialogAddButtonBJ(GameDurDialog,"Doesn't Matter")
    set udg_buttons01[3]= GetLastCreatedButtonBJ()

    //game mode
    call DialogSetMessageBJ(GameModeDialog,"Game Mode")

    call DialogAddButtonBJ(GameModeDialog,"Normal (Recommended)")
    set udg_buttons01[4]= GetLastCreatedButtonBJ()	

    call DialogAddButtonBJ(GameModeDialog,"Immortal: easy mode")
    set udg_buttons01[18]= GetLastCreatedButtonBJ()

    call DialogAddButtonBJ(GameModeDialog,"Death Match")
    set udg_buttons01[10]= GetLastCreatedButtonBJ()

    call DialogAddButtonBJ(GameModeDialog,"Elimination")	
    set udg_buttons01[5]= GetLastCreatedButtonBJ()

    call DialogAddButtonBJ(GameModeDialog,"Doesn't Matter")
    set udg_buttons01[6]= GetLastCreatedButtonBJ()

    //abilities
    call DialogSetMessageBJ(AbilModeDialog,"Ability Options")

    call DialogAddButtonBJ(AbilModeDialog,"Pick Abilities (Recommended)")
    set udg_buttons01[7]= GetLastCreatedButtonBJ()

    call DialogAddButtonBJ(AbilModeDialog,"Random Abilities")
    set udg_buttons01[8]= GetLastCreatedButtonBJ()

    call DialogAddButtonBJ(AbilModeDialog,"Draft Abilities")
    set udg_buttons01[22]= GetLastCreatedButtonBJ()

    call DialogAddButtonBJ(AbilModeDialog,"Doesn't Matter")
    set udg_buttons01[9]= GetLastCreatedButtonBJ()

    //heroes
    call DialogSetMessageBJ(HeroModeDialog,"Hero Options")

    call DialogAddButtonBJ(HeroModeDialog,"Pick Hero (Recommended)")
    set udg_buttons01[15]= GetLastCreatedButtonBJ()

    call DialogAddButtonBJ(HeroModeDialog,"Random Hero")
    set udg_buttons01[16]= GetLastCreatedButtonBJ()

    call DialogAddButtonBJ(HeroModeDialog,"Doesn't Matter")
    set udg_buttons01[17]= GetLastCreatedButtonBJ()

    //income
    call DialogSetMessageBJ(IncomeModeDialog,"Creep Upgrade Options")

    call DialogAddButtonBJ(IncomeModeDialog,"Global")
    set udg_buttons01[19]= GetLastCreatedButtonBJ()

    call DialogAddButtonBJ(IncomeModeDialog,"Individual (Recommended)")
    set udg_buttons01[20]= GetLastCreatedButtonBJ()

    call DialogAddButtonBJ(IncomeModeDialog,"Disabled")
    set udg_buttons01[21]= GetLastCreatedButtonBJ()

    //betting
    call DialogSetMessageBJ(BettingModeDialog,"Betting Options")

    call DialogAddButtonBJ(BettingModeDialog,"Enable: Show votes")
    set udg_buttons01[11]= GetLastCreatedButtonBJ()

    call DialogAddButtonBJ(BettingModeDialog,"Enable: Hide votes")
    set udg_buttons01[12]= GetLastCreatedButtonBJ()

    call DialogAddButtonBJ(BettingModeDialog,"Disabled (Recommended)")
    set udg_buttons01[13]= GetLastCreatedButtonBJ()

    call DialogAddButtonBJ(BettingModeDialog,"Doesn't Matter")
    set udg_buttons01[14]= GetLastCreatedButtonBJ()

    call ForForce(GetPlayersAll(),function Trig_Dialog_Initialization_Func047A)
    if(Trig_Dialog_Initialization_Func049001())then
        return
    else
        call DoNothing()
    endif
    call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
    call CreateTimerDialogBJ(GetLastCreatedTimerBJ(),"Mode Selection")
    call StartTimerBJ(GetLastCreatedTimerBJ(),false,30.00)
    call TriggerSleepAction(30.00)
    if(Trig_Dialog_Initialization_Func054001())then
        return
    else
        call DoNothing()
    endif
    call ForForce(GetPlayersAll(),function Trig_Dialog_Initialization_Func055A)
    if(Trig_Dialog_Initialization_Func056C())then
        call TriggerExecute(udg_trigger77)
    else
    endif
endfunction

function Trig_Voting_Rights_Initialization_Func003C takes nothing returns boolean
    if(not(InitialPlayerCount==1))then
        return false
    endif
    return true
endfunction

function Trig_Voting_Rights_Initialization_Func007Func001C takes nothing returns boolean
    if(not(GetPlayerController(ConvertedPlayer(GetForLoopIndexA()))==MAP_CONTROL_USER))then
        return false
    endif
    if(not(GetPlayerSlotState(ConvertedPlayer(GetForLoopIndexA()))==PLAYER_SLOT_STATE_PLAYING))then
        return false
    endif
    return true
endfunction

function Trig_Voting_Rights_Initialization_Func016C takes nothing returns boolean
    if(not(IsTriggerEnabled(udg_trigger55)!=true))then
        return false
    endif
    return true
endfunction

function Trig_Voting_Rights_Initialization_Actions takes nothing returns nothing
    call ConditionalTriggerExecute(udg_trigger131)
    if(Trig_Voting_Rights_Initialization_Func003C())then
        call TriggerExecute(udg_trigger57)
        return
    else
    endif
    call DialogSetMessageBJ(udg_dialog06,"Voting Rights")
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 8
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if(Trig_Voting_Rights_Initialization_Func007Func001C())then
            call DialogAddButtonBJ(udg_dialog06,GetPlayerNameColour(ConvertedPlayer(GetForLoopIndexA())))
            set udg_buttons04[GetForLoopIndexA()]= GetLastCreatedButtonBJ()
            exitwhen true
        else
        endif
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    call DialogAddButtonBJ(udg_dialog06,"Everyone")
    set udg_buttons04[0]= GetLastCreatedButtonBJ()
    call DialogDisplayBJ(true,udg_dialog06,udg_player03)
    call CreateTimerDialogBJ(GetLastCreatedTimerBJ(),"Please wait!")
    call StartTimerBJ(GetLastCreatedTimerBJ(),false,5.00)
    call TriggerSleepAction(5.00)
    if(Trig_Voting_Rights_Initialization_Func016C())then
        call DialogDisplayBJ(false,udg_dialog06,udg_player03)
        call TriggerExecute(udg_trigger58)
    else
    endif
endfunction

function Trig_Game_Master_Selects_Conditions takes nothing returns boolean
    if(not(GetClickedButtonBJ()!=udg_buttons04[0]))then
        return false
    endif
    return true
endfunction

function Trig_Game_Master_Selects_Func001Func001C takes nothing returns boolean
    if(not(GetClickedButtonBJ()==udg_buttons04[GetForLoopIndexA()]))then
        return false
    endif
    return true
endfunction

function Trig_Game_Master_Selects_Func005001 takes nothing returns boolean
    return(InitialPlayerCount==1)
endfunction

function Trig_Game_Master_Selects_Func007001001 takes nothing returns boolean
    return(GetFilterPlayer()!=udg_player03)
endfunction

function Trig_Game_Master_Selects_Actions takes nothing returns nothing
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 8
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if(Trig_Game_Master_Selects_Func001Func001C())then
            set udg_player03 = ConvertedPlayer(GetForLoopIndexA())
            exitwhen true
        else
        endif
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    set udg_boolean15 = false
    call ConditionalTriggerExecute(udg_trigger55)
    if(Trig_Game_Master_Selects_Func005001())then
        return
    else
        call DoNothing()
    endif
    call DisplayTimedTextToForce(GetPlayersMatching(Condition(function Trig_Game_Master_Selects_Func007001001)),8.00,"|cffffcc00Please wait! The host is choosing a game mode.")
    call PlaySoundBJ(udg_sound25)
endfunction

function Trig_Everyone_Votes_Conditions takes nothing returns boolean
    if(not(GetClickedButtonBJ()==udg_buttons04[0]))then
        return false
    endif
    return true
endfunction

function Trig_Everyone_Votes_Actions takes nothing returns nothing
    set udg_boolean15 = true
    call ConditionalTriggerExecute(udg_trigger55)
endfunction

function Trig_Dialog_25_Conditions takes nothing returns boolean
    if(not(GetClickedButtonBJ()==udg_buttons01[1]))then
        return false
    endif
    return true
endfunction

function Trig_Dialog_25_Actions takes nothing returns nothing
    set ModeVotesCount[1]=(ModeVotesCount[1]+ 1)
    call DialogDisplayBJ(true,IncomeModeDialog,GetTriggerPlayer())
endfunction

function Trig_Dialog_50_Conditions takes nothing returns boolean
    if(not(GetClickedButtonBJ()==udg_buttons01[2]))then
        return false
    endif
    return true
endfunction

function Trig_Dialog_50_Actions takes nothing returns nothing
    set ModeVotesCount[2]=(ModeVotesCount[2]+ 1)
    call DialogDisplayBJ(true,IncomeModeDialog,GetTriggerPlayer())
endfunction

function Trig_Doesnt_Matter_Conditions takes nothing returns boolean
    if(not(GetClickedButtonBJ()==udg_buttons01[3]))then
        return false
    endif
    return true
endfunction

function Trig_Doesnt_Matter_Actions takes nothing returns nothing
    set ModeVotesCount[3]=(ModeVotesCount[3]+ 1)
    call DialogDisplayBJ(true,IncomeModeDialog,GetTriggerPlayer())
endfunction

function Trig_Skip_Betting_Menu_Func001Func003Func002C takes nothing returns boolean
    if(not(ModeVotesCount[5]> ModeVotesCount[4]))then
        return false
    endif
    if(not(ModeVotesCount[5]> ModeVotesCount[8]))then
        return false
    endif
    if(not(udg_boolean15==false))then
        return false
    endif
    return true
endfunction

function Trig_Skip_Betting_Menu_Func001Func003C takes nothing returns boolean
    if((InitialPlayerCount <= 2))then
        return true
    endif
    if(Trig_Skip_Betting_Menu_Func001Func003Func002C())then
        return true
    endif
    return false
endfunction

function Trig_Skip_Betting_Menu_Func001C takes nothing returns boolean
    if(not Trig_Skip_Betting_Menu_Func001Func003C())then
        return false
    endif
    return true
endfunction

function Trig_Skip_Betting_Menu_Actions takes nothing returns nothing
    if(Trig_Skip_Betting_Menu_Func001C())then
        set udg_integer63 =(udg_integer63 + 1)
        call ConditionalTriggerExecute(udg_trigger77)
    else
        call DialogDisplayBJ(true,BettingModeDialog,GetTriggerPlayer())
    endif
endfunction

function Trig_Normal_Mode_Conditions takes nothing returns boolean
    if (GetClickedButtonBJ()==udg_buttons01[4])  then

        set ModeVotesCount[4]=(ModeVotesCount[4]+ 1)
        return true

    elseif GetClickedButtonBJ()==udg_buttons01[18] then
        set ModeNoDeath = true
        set ModeVotesCount[4]=(ModeVotesCount[4]+ 1)
        set ModeVotesCount[18]=(ModeVotesCount[18]+ 1)
        return true	

    endif


    return false
endfunction

function Trig_Normal_Mode_Actions takes nothing returns nothing

    //	set ModeVotesCount[4]=(ModeVotesCount[4]+1)
    call DialogDisplayBJ(true,AbilModeDialog,GetTriggerPlayer())
endfunction

function Trig_Elimination_Mode_Conditions takes nothing returns boolean
    if(not(GetClickedButtonBJ()==udg_buttons01[5]))then
        return false
    endif
    return true
endfunction

function Trig_Elimination_Mode_Actions takes nothing returns nothing
    set ModeVotesCount[5]=(ModeVotesCount[5]+ 1)
    call DialogDisplayBJ(true,AbilModeDialog,GetTriggerPlayer())
endfunction

function Trig_Death_Match_Mode_Conditions takes nothing returns boolean
    if(not(GetClickedButtonBJ()==udg_buttons01[10]))then
        return false
    endif
    return true
endfunction

function Trig_Death_Match_Mode_Actions takes nothing returns nothing
    set ModeVotesCount[8]=(ModeVotesCount[8]+ 1)
    call DialogDisplayBJ(true,AbilModeDialog,GetTriggerPlayer())
endfunction

function Trig_Doesnt_Matter_Mode_Conditions takes nothing returns boolean
    if(not(GetClickedButtonBJ()==udg_buttons01[6]))then
        return false
    endif
    return true
endfunction

function Trig_Doesnt_Matter_Mode_Actions takes nothing returns nothing
    call DialogDisplayBJ(true,AbilModeDialog,GetTriggerPlayer())
endfunction

function Trig_Pick_Abilities_Conditions takes nothing returns boolean
    if(not(GetClickedButtonBJ()==udg_buttons01[7]))then
        return false
    endif
    return true
endfunction

function Trig_Pick_Abilities_Actions takes nothing returns nothing
    set ModeVotesCount[6]=(ModeVotesCount[6]+ 1)
    call DialogDisplayBJ(true,HeroModeDialog,GetTriggerPlayer())
endfunction

function Trig_Random_Abilities_Conditions takes nothing returns boolean
    if(not(GetClickedButtonBJ()==udg_buttons01[8]))then
        return false
    endif
    return true
endfunction

function Trig_Random_Abilities_Actions takes nothing returns nothing
    set ModeVotesCount[7]=(ModeVotesCount[7]+ 1)
    call DialogDisplayBJ(true,HeroModeDialog,GetTriggerPlayer())
endfunction

function Trig_Draft_Abilities_Conditions takes nothing returns boolean
    if(not(GetClickedButtonBJ()==udg_buttons01[22]))then
        return false
    endif
    return true
endfunction

function Trig_Draft_Abilities_Actions takes nothing returns nothing
    set ModeVotesCount[19]=(ModeVotesCount[19]+ 1)
    call DialogDisplayBJ(true,HeroModeDialog,GetTriggerPlayer())
endfunction

function Trig_Doesnt_Matter_Abilities_Conditions takes nothing returns boolean
    if(not(GetClickedButtonBJ()==udg_buttons01[9]))then
        return false
    endif
    return true
endfunction

function Trig_Doesnt_Matter_Abilities_Actions takes nothing returns nothing
    call DialogDisplayBJ(true,HeroModeDialog,GetTriggerPlayer())
endfunction

//income

function Trig_Income_Conditions takes nothing returns boolean
    if(not(GetClickedButtonBJ()==udg_buttons01[19]))then
        return false
    endif
    return true
endfunction

function Trig_Income_Actions takes nothing returns nothing
    set ModeVotesCount[15] = ModeVotesCount[15] + 1
    call ConditionalTriggerExecute(udg_trigger62)
endfunction

function Trig_Individual_Income_Conditions takes nothing returns boolean
    if(not(GetClickedButtonBJ()==udg_buttons01[20]))then
        return false
    endif
    return true
endfunction

function Trig_Individual_Income_Actions takes nothing returns nothing
    set ModeVotesCount[16] = ModeVotesCount[16] + 1
    call ConditionalTriggerExecute(udg_trigger62)
endfunction

function Trig_No_Income_Conditions takes nothing returns boolean
    if(not(GetClickedButtonBJ()==udg_buttons01[21]))then
        return false
    endif
    return true
endfunction

function Trig_No_Income_Actions takes nothing returns nothing
    set ModeVotesCount[17] = ModeVotesCount[17] + 1
    call ConditionalTriggerExecute(udg_trigger62)
endfunction


function Trig_Pick_Hero_Conditions takes nothing returns boolean
    if(not(GetClickedButtonBJ()==udg_buttons01[15]))then
        return false
    endif
    return true
endfunction

function Trig_Pick_Hero_Actions takes nothing returns nothing
    set ModeVotesCount[13]=(ModeVotesCount[13]+ 1)
    call DialogDisplayBJ(true,GameDurDialog,GetTriggerPlayer())
endfunction

function Trig_Random_Hero_Conditions takes nothing returns boolean
    if(not(GetClickedButtonBJ()==udg_buttons01[16]))then
        return false
    endif
    return true
endfunction

function Trig_Random_Hero_Actions takes nothing returns nothing
    set ModeVotesCount[14]=(ModeVotesCount[14]+ 1)
    call DialogDisplayBJ(true,GameDurDialog,GetTriggerPlayer())
endfunction

function Trig_Doesnt_Matter_Hero_Conditions takes nothing returns boolean
    if(not(GetClickedButtonBJ()==udg_buttons01[17]))then
        return false
    endif
    return true
endfunction

function Trig_Doesnt_Matter_Hero_Actions takes nothing returns nothing
    call DialogDisplayBJ(true,GameDurDialog,GetTriggerPlayer())
endfunction

function Trig_Show_Betting_Menu_Conditions takes nothing returns boolean
    if(not(GetClickedButtonBJ()==udg_buttons01[11]))then
        return false
    endif
    return true
endfunction

function Trig_Show_Betting_Menu_Actions takes nothing returns nothing
    set ModeVotesCount[9]=(ModeVotesCount[9]+ 1)
    set udg_integer63 =(udg_integer63 + 1)
    call ConditionalTriggerExecute(udg_trigger77)
endfunction

function Trig_Hide_Betting_Menu_Conditions takes nothing returns boolean
    if(not(GetClickedButtonBJ()==udg_buttons01[12]))then
        return false
    endif
    return true
endfunction

function Trig_Hide_Betting_Menu_Actions takes nothing returns nothing
    set ModeVotesCount[10]=(ModeVotesCount[10]+ 1)
    set udg_integer63 =(udg_integer63 + 1)
    call ConditionalTriggerExecute(udg_trigger77)
endfunction

function Trig_Disable_Betting_Menu_Conditions takes nothing returns boolean
    if(not(GetClickedButtonBJ()==udg_buttons01[13]))then
        return false
    endif
    return true
endfunction

function Trig_Disable_Betting_Menu_Actions takes nothing returns nothing
    set ModeVotesCount[11]=(ModeVotesCount[11]+ 1)
    set udg_integer63 =(udg_integer63 + 1)
    call ConditionalTriggerExecute(udg_trigger77)
endfunction

function Trig_Doesnt_Matter_Betting_Menu_Conditions takes nothing returns boolean
    if(not(GetClickedButtonBJ()==udg_buttons01[14]))then
        return false
    endif
    return true
endfunction

function Trig_Doesnt_Matter_Betting_Menu_Actions takes nothing returns nothing
    set ModeVotesCount[12]=(ModeVotesCount[12]+ 1)
    set udg_integer63 =(udg_integer63 + 1)
    call ConditionalTriggerExecute(udg_trigger77)
endfunction

function Trig_Dialog_Complete_Func026C takes nothing returns boolean
    if((udg_boolean15==false))then
        return true
    endif
    if((udg_integer63==PlayerCount))then
        return true
    endif
    return false
endfunction

function Trig_Dialog_Complete_Conditions takes nothing returns boolean
    if(not(IsTriggerEnabled(GetTriggeringTrigger())==true))then
        return false
    endif
    if(not Trig_Dialog_Complete_Func026C())then
        return false
    endif
    return true
endfunction

function Trig_Dialog_Complete_Func006Func001C takes nothing returns boolean
    if(not(ModeVotesCount[5]> ModeVotesCount[4]))then
        return false
    endif
    if(not(ModeVotesCount[5]> ModeVotesCount[8]))then
        return false
    endif
    return true
endfunction

function Trig_Dialog_Complete_Func006Func004Func005Func006001 takes nothing returns boolean
    return(InitialPlayerCount==1)
endfunction

function Trig_Dialog_Complete_Func006Func004Func005Func008001 takes nothing returns boolean
    return(PlayerCount==1)
endfunction

function Trig_Dialog_Complete_Func006Func004Func005Func009001 takes nothing returns boolean
    return(PlayerCount==2)
endfunction

function Trig_Dialog_Complete_Func006Func004Func005Func010001 takes nothing returns boolean
    return(PlayerCount==3)
endfunction

function Trig_Dialog_Complete_Func006Func004Func005Func011001 takes nothing returns boolean
    return(PlayerCount==4)
endfunction

function Trig_Dialog_Complete_Func006Func004Func005Func012001 takes nothing returns boolean
    return(PlayerCount==5)
endfunction

function Trig_Dialog_Complete_Func006Func004Func005Func013001 takes nothing returns boolean
    return(PlayerCount==6)
endfunction

function Trig_Dialog_Complete_Func006Func004Func005Func014001 takes nothing returns boolean
    return(PlayerCount==7)
endfunction

function Trig_Dialog_Complete_Func006Func004Func005Func015001 takes nothing returns boolean
    return(PlayerCount==8)
endfunction

function Trig_Dialog_Complete_Func006Func004Func005Func020001 takes nothing returns boolean
    return(InitialPlayerCount==1)
endfunction

function Trig_Dialog_Complete_Func006Func004Func005Func022001 takes nothing returns boolean
    return(PlayerCount==1)
endfunction

function Trig_Dialog_Complete_Func006Func004Func005Func023001 takes nothing returns boolean
    return(PlayerCount==2)
endfunction

function Trig_Dialog_Complete_Func006Func004Func005Func024001 takes nothing returns boolean
    return(PlayerCount==3)
endfunction

function Trig_Dialog_Complete_Func006Func004Func005Func025001 takes nothing returns boolean
    return(PlayerCount==4)
endfunction

function Trig_Dialog_Complete_Func006Func004Func005Func026001 takes nothing returns boolean
    return(PlayerCount==5)
endfunction

function Trig_Dialog_Complete_Func006Func004Func005Func027001 takes nothing returns boolean
    return(PlayerCount==6)
endfunction

function Trig_Dialog_Complete_Func006Func004Func005Func028001 takes nothing returns boolean
    return(PlayerCount==7)
endfunction

function Trig_Dialog_Complete_Func006Func004Func005Func029001 takes nothing returns boolean
    return(PlayerCount==8)
endfunction

function Trig_Dialog_Complete_Func006Func004Func005C takes nothing returns boolean
    if(not(ModeVotesCount[1]>= ModeVotesCount[2]))then
        return false
    endif
    return true
endfunction

function Trig_Dialog_Complete_Func006Func004Func006001001001001 takes nothing returns boolean
    return(GetFilterPlayer()!=Player(8))
endfunction

function Trig_Dialog_Complete_Func006Func004Func006001001001002 takes nothing returns boolean
    return(GetFilterPlayer()!=Player(11))
endfunction

function Trig_Dialog_Complete_Func006Func004Func006001001001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Dialog_Complete_Func006Func004Func006001001001001(),Trig_Dialog_Complete_Func006Func004Func006001001001002())
endfunction

function Trig_Dialog_Complete_Func006Func004Func006001001002 takes nothing returns boolean
    return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
endfunction

function Trig_Dialog_Complete_Func006Func004Func006001001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Dialog_Complete_Func006Func004Func006001001001(),Trig_Dialog_Complete_Func006Func004Func006001001002())
endfunction

function Trig_Dialog_Complete_Func006Func004Func006A takes nothing returns nothing
    call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_RESOURCE_FOOD_CAP,UnknownInteger01)
    call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_FOOD_CAP_CEILING,UnknownInteger01)
    call ResourseRefresh(GetEnumPlayer()) 
endfunction

function Trig_Dialog_Complete_Func006Func004C takes nothing returns boolean
    if(not(ModeVotesCount[8]> ModeVotesCount[4]))then
        return false
    endif
    return true
endfunction

function Trig_Dialog_Complete_Func006Func008Func006001 takes nothing returns boolean
    return(InitialPlayerCount==1)
endfunction

function Trig_Dialog_Complete_Func006Func008Func011001 takes nothing returns boolean
    return(InitialPlayerCount==1)
endfunction

function Trig_Dialog_Complete_Func006Func008C takes nothing returns boolean
    if(not(ModeVotesCount[1]>= ModeVotesCount[2]))then
        return false
    endif
    return true
endfunction

function Trig_Dialog_Complete_Func006Func009001001001001 takes nothing returns boolean
    return(GetFilterPlayer()!=Player(8))
endfunction

function Trig_Dialog_Complete_Func006Func009001001001002 takes nothing returns boolean
    return(GetFilterPlayer()!=Player(11))
endfunction

function Trig_Dialog_Complete_Func006Func009001001001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Dialog_Complete_Func006Func009001001001001(),Trig_Dialog_Complete_Func006Func009001001001002())
endfunction

function Trig_Dialog_Complete_Func006Func009001001002 takes nothing returns boolean
    return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
endfunction

function Trig_Dialog_Complete_Func006Func009001001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Dialog_Complete_Func006Func009001001001(),Trig_Dialog_Complete_Func006Func009001001002())
endfunction

function Trig_Dialog_Complete_Func006Func009A takes nothing returns nothing
    call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_RESOURCE_FOOD_CAP,UnknownInteger01)
    call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_FOOD_CAP_CEILING,UnknownInteger01)
    call ResourseRefresh(GetEnumPlayer()) 
endfunction

function Trig_Dialog_Complete_Func006C takes nothing returns boolean
    if(not Trig_Dialog_Complete_Func006Func001C())then
        return false
    endif
    return true
endfunction

function Trig_Dialog_Complete_Func008Func001C takes nothing returns boolean
    if(not(ElimModeEnabled==false))then
        return false
    endif
    if(not(udg_boolean07==false))then
        return false
    endif
    return true
endfunction

function Trig_Dialog_Complete_Func008Func002C takes nothing returns boolean
    if(not(ModeVotesCount[1]>= ModeVotesCount[2]))then
        return false
    endif
    return true
endfunction

function Trig_Dialog_Complete_Func008Func003Func006001 takes nothing returns boolean
    return(InitialPlayerCount==1)
endfunction

function Trig_Dialog_Complete_Func008Func003Func008001001001001 takes nothing returns boolean
    return(GetFilterPlayer()!=Player(8))
endfunction

function Trig_Dialog_Complete_Func008Func003Func008001001001002 takes nothing returns boolean
    return(GetFilterPlayer()!=Player(11))
endfunction

function Trig_Dialog_Complete_Func008Func003Func008001001001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Dialog_Complete_Func008Func003Func008001001001001(),Trig_Dialog_Complete_Func008Func003Func008001001001002())
endfunction

function Trig_Dialog_Complete_Func008Func003Func008001001002 takes nothing returns boolean
    return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
endfunction

function Trig_Dialog_Complete_Func008Func003Func008001001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Dialog_Complete_Func008Func003Func008001001001(),Trig_Dialog_Complete_Func008Func003Func008001001002())
endfunction

function Trig_Dialog_Complete_Func008Func003Func008A takes nothing returns nothing
    call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_RESOURCE_FOOD_CAP,50)
    call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_FOOD_CAP_CEILING,50)
    call ResourseRefresh(GetEnumPlayer()) 
endfunction

function Trig_Dialog_Complete_Func008Func003Func012001 takes nothing returns boolean
    return(InitialPlayerCount==1)
endfunction

function Trig_Dialog_Complete_Func008Func003Func014001001001001 takes nothing returns boolean
    return(GetFilterPlayer()!=Player(8))
endfunction

function Trig_Dialog_Complete_Func008Func003Func014001001001002 takes nothing returns boolean
    return(GetFilterPlayer()!=Player(11))
endfunction

function Trig_Dialog_Complete_Func008Func003Func014001001001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Dialog_Complete_Func008Func003Func014001001001001(),Trig_Dialog_Complete_Func008Func003Func014001001001002())
endfunction

function Trig_Dialog_Complete_Func008Func003Func014001001002 takes nothing returns boolean
    return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
endfunction

function Trig_Dialog_Complete_Func008Func003Func014001001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Dialog_Complete_Func008Func003Func014001001001(),Trig_Dialog_Complete_Func008Func003Func014001001002())
endfunction

function Trig_Dialog_Complete_Func008Func003Func014A takes nothing returns nothing
    call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_RESOURCE_FOOD_CAP,25)
    call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_FOOD_CAP_CEILING,25)
    call ResourseRefresh(GetEnumPlayer()) 
endfunction

function Trig_Dialog_Complete_Func008Func003C takes nothing returns boolean
    if(not(GameModeShort==true))then
        return false
    endif
    return true
endfunction

function Trig_Dialog_Complete_Func008C takes nothing returns boolean
    if(not Trig_Dialog_Complete_Func008Func001C())then
        return false
    endif
    return true
endfunction

function Trig_Dialog_Complete_Func010Func004A takes nothing returns nothing
    call DeleteUnit(GetEnumUnit())
endfunction

function CheckAbilityVotes takes nothing returns nothing
    //random
    if ModeVotesCount[7] > ModeVotesCount[6] and ModeVotesCount[7] > ModeVotesCount[19] then
        set AbilityMode = 0

        //pick
    elseif ModeVotesCount[6] > ModeVotesCount[7] and ModeVotesCount[6] > ModeVotesCount[19] then
        set AbilityMode = 1

        //draft
    elseif ModeVotesCount[19] > ModeVotesCount[6] and ModeVotesCount[19] > ModeVotesCount[7] then
        set AbilityMode = 2

        //if tie just do ap
    else
        set AbilityMode = 1
    endif
endfunction

function Trig_Dialog_Complete_Func012C takes nothing returns boolean
    if(not(ModeVotesCount[14]> ModeVotesCount[13]))then
        return false
    endif
    return true
endfunction

function Trig_Dialog_Complete_Func014Func001Func003C takes nothing returns boolean
    if(not(ModeVotesCount[11]> ModeVotesCount[9]))then
        return false
    endif
    if(not(ModeVotesCount[11]> ModeVotesCount[10]))then
        return false
    endif
    return true
endfunction

function Trig_Dialog_Complete_Func014Func001C takes nothing returns boolean
    if((ElimModeEnabled==true))then
        return true
    endif
    if((InitialPlayerCount <= 2))then
        return true
    endif
    if(Trig_Dialog_Complete_Func014Func001Func003C())then
        return true
    endif
    return false
endfunction

function Trig_Dialog_Complete_Func014Func007Func011C takes nothing returns boolean
    if(not(ModeVotesCount[10]> ModeVotesCount[9]))then
        return false
    endif
    if(not(ModeVotesCount[10]> ModeVotesCount[11]))then
        return false
    endif
    return true
endfunction

function Trig_Dialog_Complete_Func014Func007C takes nothing returns boolean
    if(not Trig_Dialog_Complete_Func014Func007Func011C())then
        return false
    endif
    return true
endfunction

function Trig_Dialog_Complete_Func014C takes nothing returns boolean
    if(not Trig_Dialog_Complete_Func014Func001C())then
        return false
    endif
    return true
endfunction

function Trig_Dialog_Complete_Func023001 takes nothing returns boolean
    return(udg_boolean16==false)
endfunction

function Trig_Dialog_Complete_Func025001001001001 takes nothing returns boolean
    return(GetFilterPlayer()!=Player(8))
endfunction

function Trig_Dialog_Complete_Func025001001001002 takes nothing returns boolean
    return(GetFilterPlayer()!=Player(11))
endfunction

function Trig_Dialog_Complete_Func025001001001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Dialog_Complete_Func025001001001001(),Trig_Dialog_Complete_Func025001001001002())
endfunction

function Trig_Dialog_Complete_Func025001001002001001 takes nothing returns boolean
    return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
endfunction

function Trig_Dialog_Complete_Func025001001002001002 takes nothing returns boolean
    return(IsPlayerInForce(GetFilterPlayer(),udg_force07)==true)
endfunction

function Trig_Dialog_Complete_Func025001001002001 takes nothing returns boolean
    return GetBooleanOr(Trig_Dialog_Complete_Func025001001002001001(),Trig_Dialog_Complete_Func025001001002001002())
endfunction

function Trig_Dialog_Complete_Func025001001002002 takes nothing returns boolean
    return(IsPlayerInForce(GetFilterPlayer(),udg_PlayersWithHero)!=true)
endfunction

function Trig_Dialog_Complete_Func025001001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Dialog_Complete_Func025001001002001(),Trig_Dialog_Complete_Func025001001002002())
endfunction

function Trig_Dialog_Complete_Func025001001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Dialog_Complete_Func025001001001(),Trig_Dialog_Complete_Func025001001002())
endfunction

function Trig_Dialog_Complete_Func025A takes nothing returns nothing
    set udg_player02 = GetEnumPlayer()
    call ConditionalTriggerExecute(udg_trigger79)
endfunction

function SetIncomeMode takes nothing returns nothing
    if IncomeMode == 1 then
        call ReplaceUnitBJ(gg_unit_n02L_0012,'n035',bj_UNIT_STATE_METHOD_RELATIVE)
    elseif IncomeMode == 2 then
        call ReplaceUnitBJ(gg_unit_n02L_0012,'n034',bj_UNIT_STATE_METHOD_RELATIVE)		
    endif
endfunction

function CheckIncomeVotes takes nothing returns nothing
    if ModeVotesCount[15] > ModeVotesCount[16] and ModeVotesCount[15] > ModeVotesCount[17] then
        set IncomeMode = 0
    elseif ModeVotesCount[16] > ModeVotesCount[15] and ModeVotesCount[16] > ModeVotesCount[17] then
        set IncomeMode = 1
    else
        set IncomeMode = 2	
    endif
endfunction

function Trig_Dialog_Complete_Actions takes nothing returns nothing
    call DisableTrigger(GetTriggeringTrigger())
    set udg_strings02[0]= ""
    call ClearTextMessagesBJ(GetPlayersAll())
    if(Trig_Dialog_Complete_Func006C())then
        call DisableTrigger(GetTriggeringTrigger())
        set ElimModeEnabled = true
        set UnknownInteger01 =(PlayerCount * 5)
        set UnknownInteger01 =(UnknownInteger01 - 5)
        if(Trig_Dialog_Complete_Func006Func008C())then
            set udg_strings02[1]= "Mode: Elimination (Hard)|r"
            call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
            set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
            set udg_strings02[1]= "PvP: Every 5th Level|r"
            if(Trig_Dialog_Complete_Func006Func008Func011001())then
                set udg_strings02[1]= "PvP: None|r"
            else
                call DoNothing()
            endif
            call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
        else
            set udg_strings02[1]= "Mode: Elimination (Normal)|r"
            call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
            set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
            set udg_strings02[1]= "PvP: Every 5th Level|r"
            if(Trig_Dialog_Complete_Func006Func008Func006001())then
                set udg_strings02[1]= "PvP: None|r"
            else
                call DoNothing()
            endif
            call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
        endif
        call DisplayTimedTextToForce(GetPlayersAll(),15,"|c00ff2c2cElimination mode will likely be removed in the future! Let us know on discord if you disagree.|r")
        call ForForce(GetPlayersMatching(Condition(function Trig_Dialog_Complete_Func006Func009001001)),function Trig_Dialog_Complete_Func006Func009A)
    else
        set ElimModeEnabled = false
        if(Trig_Dialog_Complete_Func006Func004C())then
            call DisableTrigger(GetTriggeringTrigger())
            set udg_boolean07 = true
            if(Trig_Dialog_Complete_Func006Func004Func005C())then
                set udg_strings02[1]= "Mode: Death Match (Hard)|r"
                call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
                set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
                set udg_strings02[1]= "PvP: Every 5th Level|r"
                if(Trig_Dialog_Complete_Func006Func004Func005Func020001())then
                    set udg_strings02[1]= "PvP: None|r"
                else
                    call DoNothing()
                endif
                call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
                if(Trig_Dialog_Complete_Func006Func004Func005Func022001())then
                    set UnknownInteger01 = 0
                else
                    call DoNothing()
                endif
                if(Trig_Dialog_Complete_Func006Func004Func005Func023001())then
                    set UnknownInteger01 = 5
                else
                    call DoNothing()
                endif
                if(Trig_Dialog_Complete_Func006Func004Func005Func024001())then
                    set UnknownInteger01 = 5
                else
                    call DoNothing()
                endif
                if(Trig_Dialog_Complete_Func006Func004Func005Func025001())then
                    set UnknownInteger01 = 10
                else
                    call DoNothing()
                endif
                if(Trig_Dialog_Complete_Func006Func004Func005Func026001())then
                    set UnknownInteger01 = 10
                else
                    call DoNothing()
                endif
                if(Trig_Dialog_Complete_Func006Func004Func005Func027001())then
                    set UnknownInteger01 = 10
                else
                    call DoNothing()
                endif
                if(Trig_Dialog_Complete_Func006Func004Func005Func028001())then
                    set UnknownInteger01 = 10
                else
                    call DoNothing()
                endif
                if(Trig_Dialog_Complete_Func006Func004Func005Func029001())then
                    set UnknownInteger01 = 15
                else
                    call DoNothing()
                endif
                set GameModeShort = true
            else
                set udg_strings02[1]= "Mode: Death Match (Normal)|r"
                call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
                set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
                set udg_strings02[1]= "PvP: Every 10th Level|r"
                if(Trig_Dialog_Complete_Func006Func004Func005Func006001())then
                    set udg_strings02[1]= "PvP: None|r"
                else
                    call DoNothing()
                endif
                call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
                if(Trig_Dialog_Complete_Func006Func004Func005Func008001())then
                    set UnknownInteger01 = 0
                else
                    call DoNothing()
                endif
                if(Trig_Dialog_Complete_Func006Func004Func005Func009001())then
                    set UnknownInteger01 = 10
                else
                    call DoNothing()
                endif
                if(Trig_Dialog_Complete_Func006Func004Func005Func010001())then
                    set UnknownInteger01 = 10
                else
                    call DoNothing()
                endif
                if(Trig_Dialog_Complete_Func006Func004Func005Func011001())then
                    set UnknownInteger01 = 20
                else
                    call DoNothing()
                endif
                if(Trig_Dialog_Complete_Func006Func004Func005Func012001())then
                    set UnknownInteger01 = 20
                else
                    call DoNothing()
                endif
                if(Trig_Dialog_Complete_Func006Func004Func005Func013001())then
                    set UnknownInteger01 = 20
                else
                    call DoNothing()
                endif
                if(Trig_Dialog_Complete_Func006Func004Func005Func014001())then
                    set UnknownInteger01 = 20
                else
                    call DoNothing()
                endif
                if(Trig_Dialog_Complete_Func006Func004Func005Func015001())then
                    set UnknownInteger01 = 30
                else
                    call DoNothing()
                endif
                set GameModeShort = false
            endif
            call DisplayTimedTextToForce(GetPlayersAll(),15,"|c00ff2c2cDeath Match mode will likely be removed in the future! Let us know on discord if you disagree.|r")
            call ForForce(GetPlayersMatching(Condition(function Trig_Dialog_Complete_Func006Func004Func006001001)),function Trig_Dialog_Complete_Func006Func004Func006A)
        else
            set udg_boolean07 = false
        endif
    endif
    if(Trig_Dialog_Complete_Func008C())then
        if(Trig_Dialog_Complete_Func008Func002C())then
            call DisableTrigger(GetTriggeringTrigger())
            set GameModeShort = true
        else
            call DisableTrigger(GetTriggeringTrigger())
            set GameModeShort = false
        endif

        //boolean08
        if(Trig_Dialog_Complete_Func008Func003C())then
            set udg_strings02[1]= "Mode: Normal (25 Levels)|r"
            call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
            call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,"You have an extra life")
            set Lives[0] = 1
            set Lives[1] = 1
            set Lives[2] = 1
            set Lives[3] = 1
            set Lives[4] = 1
            set Lives[5] = 1
            set Lives[6] = 1
            set Lives[7] = 1
            set Lives[8] = 1
            set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
            set udg_strings02[1]= "PvP: Every 5th Level|r"
            if(Trig_Dialog_Complete_Func008Func003Func012001())then
                set udg_strings02[1]= "PvP: None|r"
            else
                call DoNothing()
            endif
            call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
            call ForForce(GetPlayersMatching(Condition(function Trig_Dialog_Complete_Func008Func003Func014001001)),function Trig_Dialog_Complete_Func008Func003Func014A)
        else
            set udg_strings02[1]= "Mode: Normal (50 Levels)|r"
            call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
            call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,"You have an extra life")
            set Lives[0] = 1
            set Lives[1] = 1
            set Lives[2] = 1
            set Lives[3] = 1
            set Lives[4] = 1
            set Lives[5] = 1
            set Lives[6] = 1
            set Lives[7] = 1
            set Lives[8] = 1	       	
            set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
            set udg_strings02[1]= "PvP: Every 5th Level|r"
            if(Trig_Dialog_Complete_Func008Func003Func006001())then
                set udg_strings02[1]= "PvP: None|r"
            else
                call DoNothing()
            endif
            call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
            call ForForce(GetPlayersMatching(Condition(function Trig_Dialog_Complete_Func008Func003Func008001001)),function Trig_Dialog_Complete_Func008Func003Func008A)
        endif
    else
    endif
    call CheckIncomeVotes()
    if IncomeMode == 0 then
        set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
        set udg_strings02[1]= "Creep Upgrades: Enabled"
    elseif IncomeMode == 1 then
        set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
        set udg_strings02[1]= "Creep Upgrades: Individual"
    else
        set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
        set udg_strings02[1]= "Creep Upgrades: Disabled"
    endif
    call CheckAbilityVotes()
    if AbilityMode == 0 then
        set ArNotLearningAbil = true
        set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
        set udg_strings02[1]= "Type: Random Abilities"
    elseif AbilityMode == 1 then
        set ArNotLearningAbil = false
        set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
        set udg_strings02[1]= "Type: Pick Abilities"
        call ForGroupBJ(GetUnitsOfTypeIdAll('n016'),function Trig_Dialog_Complete_Func010Func004A)

        //Draft mode
    elseif AbilityMode == 2 then
        set ArNotLearningAbil = false
        set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
        set udg_strings02[1]= "Type: Draft Abilities"
        call ForGroupBJ(GetUnitsOfTypeIdAll('n016'),function Trig_Dialog_Complete_Func010Func004A)
    endif
    if(Trig_Dialog_Complete_Func012C())then
        set udg_boolean16 = true
        set udg_strings02[1]=(udg_strings02[1]+ ", Random Hero|r")
        call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
    else
        set udg_boolean16 = false
        set udg_strings02[1]=(udg_strings02[1]+ ", Pick Hero|r")
        call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
    endif
    if(Trig_Dialog_Complete_Func014C())then
        set udg_boolean13 = false
        set udg_boolean14 = false
        set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
        set udg_strings02[1]= "Betting: Disabled|r"
        call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
    else
        if(Trig_Dialog_Complete_Func014Func007C())then
            set udg_boolean13 = true
            set udg_boolean14 = false
            set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
            set udg_strings02[1]= "Betting: Enabled (Hidden)|r"
            call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
        else
            set udg_boolean13 = true
            set udg_boolean14 = true
            set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
            set udg_strings02[1]= "Betting: Enabled (Show)|r"
            call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
        endif
    endif
    call PlaySoundBJ(udg_sound03)
    call ConditionalTriggerExecute(udg_trigger90)
    set udg_strings02[0]=(udg_strings02[0]+ udg_strings02[1])
    call QuestSetDescriptionBJ(GetLastCreatedQuestBJ(),udg_strings02[0])
    call QuestSetDiscoveredBJ(GetLastCreatedQuestBJ(),true)
    if(Trig_Dialog_Complete_Func023001())then
        return
    else
        call DoNothing()
    endif
    call TriggerSleepAction(0.00)
    call ForForce(GetPlayersMatching(Condition(function Trig_Dialog_Complete_Func025001001)),function Trig_Dialog_Complete_Func025A)
endfunction

function Trig_Choose_Hero_Func002Func004C takes nothing returns boolean
    if((IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
        return true
    endif
    if((GetUnitTypeId(GetTriggerUnit())=='n00J'))then
        return true
    endif
    return false
endfunction

function Trig_Choose_Hero_Func002C takes nothing returns boolean
    if(not(PlayerHeroPicked[GetConvertedPlayerId(GetTriggerPlayer())]==false))then
        return false
    endif
    if(not(GetOwningPlayer(GetTriggerUnit())==Player(8)))then
        return false
    endif
    if(not(udg_boolean16==false))then
        return false
    endif
    if(not Trig_Choose_Hero_Func002Func004C())then
        return false
    endif
    return true
endfunction

function Trig_Choose_Hero_Conditions takes nothing returns boolean
    if(not Trig_Choose_Hero_Func002C())then
        return false
    endif
    return true
endfunction

function Trig_Choose_Hero_Func001Func002A takes nothing returns nothing
    call DeleteUnit(GetEnumUnit())
endfunction

function Trig_Choose_Hero_Func001Func011A takes nothing returns nothing
    call DeleteUnit(GetEnumUnit())
endfunction

function Trig_Choose_Hero_Func001C takes nothing returns boolean
    if(not(GetTriggerUnit()==ChooseHeroSelection[GetConvertedPlayerId(GetTriggerPlayer())]))then
        return false
    endif
    return true
endfunction

function Trig_Choose_Hero_Actions takes nothing returns nothing
    local string ToolTipS = ""
    if(Trig_Choose_Hero_Func001C())then

        if GetLocalPlayer() == GetTriggerPlayer() then
            call ClearTextMessages()
        endif
        call ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(),'n00E'),function Trig_Choose_Hero_Func001Func002A)
        call AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()),"Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
        set udg_player02 = GetTriggerPlayer()
        call ConditionalTriggerExecute(udg_trigger79)
    else

        /*
        set ToolTipS = "|cffff0000" + GetObjectName(GetUnitTypeId( GetTriggerUnit() )) + "|r\n" + GetClassification(GetUnitTypeId( GetTriggerUnit() ))  + "\n" + LoadStr(HT_data,GetUnitTypeId( GetTriggerUnit() ),2 )   + "\n"
        set ToolTipS = ToolTipS + "|cff0000ffHero attributes|r  \n"
        set ToolTipS = ToolTipS + "Str per level - " + R2S(BlzGetUnitRealField( GetTriggerUnit(),ConvertUnitRealField('ustp')))+ "\n"
        set ToolTipS = ToolTipS + "Agi per level - " + R2S(BlzGetUnitRealField( GetTriggerUnit(),ConvertUnitRealField('uagp')))+ "\n"
        set ToolTipS = ToolTipS + "Int per level - " + R2S(BlzGetUnitRealField( GetTriggerUnit(),ConvertUnitRealField('uinp')))+ "\n"      
        set ToolTipS = ToolTipS + "Regeneration - " + R2S(BlzGetUnitRealField( GetTriggerUnit(),ConvertUnitRealField('uhpr')))+ "\n"
        set ToolTipS = ToolTipS + "Mana Regeneration - " + R2S(BlzGetUnitRealField(GetTriggerUnit(),ConvertUnitRealField('umpr')))+ "\n" 
        call DisplayTextToPlayer(GetTriggerPlayer(), 0,0, ToolTipS)
        */


        call SetUnitAnimation(GetTriggerUnit(),"attack")
        call SetUnitAnimation(GetTriggerUnit(),"slam")
        call SetUnitAnimation(GetTriggerUnit(),"victory")
        call QueueUnitAnimationBJ(GetTriggerUnit(),"stand")
        call ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(),'n00E'),function Trig_Choose_Hero_Func001Func011A)
        call CreateNUnitsAtLoc(1,'n00E',GetTriggerPlayer(),GetUnitLoc(GetTriggerUnit()),bj_UNIT_FACING)
        set ChooseHeroSelection[GetConvertedPlayerId(GetTriggerPlayer())]= GetTriggerUnit()
    endif
    set ToolTipS = null
endfunction

function Trig_Spawn_Hero_Func005Func001002001001002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
endfunction

function Trig_Spawn_Hero_Func005C takes nothing returns boolean
    if(not(udg_boolean16==false))then
        return false
    endif
    if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
        return false
    endif
    return true
endfunction

function Trig_Spawn_Hero_Func013001 takes nothing returns boolean
    return(GetUnitTypeId(PlayerHeroes[GetConvertedPlayerId(udg_player02)])=='O008')
endfunction

function Trig_Spawn_Hero_Func014Func001001 takes nothing returns boolean
    return(GetUnitTypeId(PlayerHeroes[GetConvertedPlayerId(udg_player02)])=='H008')
endfunction

function Trig_Spawn_Hero_Func014Func002001 takes nothing returns boolean
    return(GetUnitTypeId(PlayerHeroes[GetConvertedPlayerId(udg_player02)])=='H008')
endfunction

function Trig_Spawn_Hero_Func015001 takes nothing returns boolean
    return(PlayerCount==1)
endfunction

function Trig_Spawn_Hero_Func016A takes nothing returns nothing
    call DeleteUnit(GetEnumUnit())
endfunction

function Trig_Spawn_Hero_Func017Func008C takes nothing returns boolean
    if(not(RoundNumber==1))then
        return false
    endif
    if(not(SpawnedHeroCount >= PlayerCount))then
        return false
    endif
    return true
endfunction

function Trig_Spawn_Hero_Func017C takes nothing returns boolean
    if(not Trig_Spawn_Hero_Func017Func008C())then
        return false
    endif
    return true
endfunction

function Trig_Spawn_Hero_Func019Func001C takes nothing returns boolean
    if(not(RoundNumber==1))then
        return false
    endif
    if(not(SpawnedHeroCount >= PlayerCount))then
        return false
    endif
    return true
endfunction

function Trig_Spawn_Hero_Func019C takes nothing returns boolean
    if(not Trig_Spawn_Hero_Func019Func001C())then
        return false
    endif
    return true
endfunction

function Trig_Spawn_Hero_Actions takes nothing returns nothing
    call ForceAddPlayerSimple(udg_player02,udg_PlayersWithHero)
    set PlayerHeroPicked[GetConvertedPlayerId(udg_player02)]= true
    set SpawnedHeroCount =(SpawnedHeroCount + 1)

    if(Trig_Spawn_Hero_Func005C())then
        call CreateNUnitsAtLoc(1,GetUnitTypeId(GetTriggerUnit()),GetTriggerPlayer(),GetRectCenter(PlayerArenaRects[GetConvertedPlayerId(GetTriggerPlayer())]),bj_UNIT_FACING)
        call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(GetTriggerPlayer())+(" |cffffcc00has selected " +(GetUnitName(GetLastCreatedUnit())+ "!")))))
        call AdjustPlayerStateBJ(600,udg_player02,PLAYER_STATE_RESOURCE_GOLD)
        call ResourseRefresh( udg_player02   )

    else
        call CreateNUnitsAtLoc(1,GetUnitTypeId(GroupPickRandomUnit(GetUnitsOfPlayerMatching(Player(8),Condition(function Trig_Spawn_Hero_Func005Func001002001001002)))),udg_player02,GetRectCenter(PlayerArenaRects[GetConvertedPlayerId(udg_player02)]),bj_UNIT_FACING)
        call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(udg_player02)+(" |cffffcc00has randomed " +(GetUnitName(GetLastCreatedUnit())+ "! (+300 bonus gold)")))))
        call AdjustPlayerStateBJ(900,udg_player02,PLAYER_STATE_RESOURCE_GOLD)
        call ResourseRefresh( udg_player02   )
    endif



                

    if GetLocalPlayer() == GetOwningPlayer(GetLastCreatedUnit()) then
        call BlzFrameSetVisible(SpellUP[0] ,true )
        call BlzFrameSetTexture(SpellFR[0], LoadStr(HT_data,GetUnitTypeId(GetLastCreatedUnit()) ,1 )  , 0, true)

    endif



    call BlzUnitHideAbility(GetLastCreatedUnit(),'A030',true)
    call BlzUnitHideAbility(GetLastCreatedUnit(),'A031',true)
    call BlzUnitHideAbility(GetLastCreatedUnit(),'A032',true)
    call BlzUnitHideAbility(GetLastCreatedUnit(),'A033',true)
    call BlzUnitHideAbility(GetLastCreatedUnit(),'A034',true)
    call BlzUnitHideAbility(GetLastCreatedUnit(),'A03H',true)    

    call FunctionStartUnit(GetLastCreatedUnit()) 

    call BlzSetHeroProperName( GetLastCreatedUnit(), GetPlayerNameNoTag( GetPlayerName(GetOwningPlayer(GetLastCreatedUnit())   )))
    call ConditionalTriggerExecute(udg_trigger130)
    set PlayerHeroes[GetConvertedPlayerId(udg_player02)]= GetLastCreatedUnit()
    call UnitAddItemByIdSwapped('ankh',GetLastCreatedUnit())
    call UnitAddItemByIdSwapped('pghe',GetLastCreatedUnit())
    call UnitAddItemByIdSwapped('I04R',GetLastCreatedUnit())
    call ResetToGameCameraForPlayer(udg_player02,0)
    call PanCameraToTimedLocForPlayer(udg_player02,GetRectCenter(PlayerArenaRects[GetConvertedPlayerId(udg_player02)]),0.00)
    call SelectUnitForPlayerSingle(GetLastCreatedUnit(),udg_player02)
    /*if(Trig_Spawn_Hero_Func013001())then
        call CreateNUnitsAtLoc(1,'e001',udg_player02,OffsetLocation(GetUnitLoc(PlayerHeroes[GetConvertedPlayerId(udg_player02)]),100.00,50.00),bj_UNIT_FACING)
    else
        call DoNothing()
    endif*/
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 3
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if(Trig_Spawn_Hero_Func014Func001001())then
            call CreateNUnitsAtLoc(1,'e003',udg_player02,PolarProjectionBJ(GetUnitLoc(PlayerHeroes[GetConvertedPlayerId(udg_player02)]),50.00,(45.00 * I2R(GetForLoopIndexA()))),bj_UNIT_FACING)
        else
            call DoNothing()
        endif
        if(Trig_Spawn_Hero_Func014Func002001())then
            call SetUnitManaBJ(GetLastCreatedUnit(),GetRandomReal(0,GetUnitStateSwap(UNIT_STATE_MAX_MANA,GetLastCreatedUnit())))
        else
            call DoNothing()
        endif
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    if(Trig_Spawn_Hero_Func015001())then
        set SingleplayerPlayer = GetOwningPlayer(GetLastCreatedUnit())
    else
        call DoNothing()
    endif
    call ForGroupBJ(GetUnitsOfPlayerAndTypeId(udg_player02,'n00E'),function Trig_Spawn_Hero_Func016A)
    if(Trig_Spawn_Hero_Func017C())then
        set udg_boolean10 = true
        set udg_boolean09 = true
        call PlaySoundBJ(udg_sound11)
        call DisplayTextToForce(GetPlayersAll(),"|c000070C0Get Ready!|r")
        call TriggerSleepAction(0.00)
        call ConditionalTriggerExecute(udg_trigger148)
        call ConditionalTriggerExecute(udg_trigger143)
        if AbilityMode == 2 and DraftInitialised == false then
            call ConditionalTriggerExecute( gg_trg_DraftInit )
        endif
        call CreateNeutralPassiveBuildings2()
    else
    endif
    call TriggerSleepAction(2)
    if(Trig_Spawn_Hero_Func019C())then
        call TriggerExecute(udg_trigger109)
    else
    endif
endfunction

function Trig_Hero_Dies_Func026C takes nothing returns boolean
    if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
        return false
    endif
    if(not(GetOwningPlayer(GetTriggerUnit())!=Player(8)))then
        return false
    endif
    if(not(GetOwningPlayer(GetTriggerUnit())!=Player(11)))then
        return false
    endif
    if(not(IsUnitInGroup(GetTriggerUnit(),DuelingHeroGroup)!=true))then
        return false
    endif
    return true
endfunction




function Trig_Hero_Dies_Func024Func001Func001A111a takes nothing returns nothing



    //	call DisableTrigger(udg_trigger107)
    //	call KillUnit(GetEnumUnit())
    //	call EnableTrigger(udg_trigger107)

endfunction


function Trig_Hero_Dies_Func024Func001Func0010010025551 takes nothing returns boolean

    call KillUnit(GetFilterUnit())
    return false
endfunction

globals
    boolean array DisableDeathTrigger
endglobals

function EnableDeathTrigger takes nothing returns nothing
    local integer pid = GetTimerData(GetExpiredTimer())
    set DeathReviveInvul.boolean[pid] = false
    set DisableDeathTrigger[pid] = false
    call ReleaseTimer(GetExpiredTimer())
endfunction

function Trig_Hero_Dies_Conditions takes nothing returns boolean
    local integer pid = GetPlayerId(GetOwningPlayer(GetDyingUnit()))
    if(not Trig_Hero_Dies_Func026C()) or DisableDeathTrigger[pid] then
        return false
    endif
    //udg_boolean07
    if ModeNoDeath == true and udg_boolean07 == false and BrStarted == false and GetPlayerSlotState(GetOwningPlayer(GetDyingUnit())) != PLAYER_SLOT_STATE_LEFT then
        call ReviveHeroLoc(GetDyingUnit(),GetRectCenter(RectMidArena),true)
        call FixDeath(GetDyingUnit())
        call PanCameraToForPlayer(GetOwningPlayer(GetDyingUnit()),GetUnitX(GetDyingUnit()),GetUnitY(GetDyingUnit()))

        call ForGroupBJ(GetUnitsInRectMatching(PlayerArenaRects[pid + 1],Condition( function Trig_Hero_Dies_Func024Func001Func0010010025551) ),function Trig_Hero_Dies_Func024Func001Func001A111a)

        return false
    endif

    if Lives[GetPlayerId(GetOwningPlayer(GetDyingUnit()))] > 0 and udg_boolean07 == false and BrStarted == false and GetPlayerSlotState(GetOwningPlayer(GetDyingUnit())) != PLAYER_SLOT_STATE_LEFT then
        set DisableDeathTrigger[pid] = true
        call TimerStart(NewTimerEx(pid), 1, false, function EnableDeathTrigger)
        set RoundLiveLost[pid] = true

        set DeathReviveInvul.boolean[pid] = true
        call ReviveHeroLoc(GetDyingUnit(),GetRectCenter(RectMidArena),true)
        call FixDeath(GetDyingUnit())
        call PanCameraToForPlayer(GetOwningPlayer(GetDyingUnit()),GetUnitX(GetDyingUnit()),GetUnitY(GetDyingUnit()))
        call ForGroupBJ(GetUnitsInRectMatching(PlayerArenaRects[pid + 1],Condition( function Trig_Hero_Dies_Func024Func001Func0010010025551) ),function Trig_Hero_Dies_Func024Func001Func001A111a)

        set Lives[pid] = Lives[pid] - 1
        call DisplayTextToPlayer(GetOwningPlayer(GetDyingUnit()) ,0,0,"You have " + I2S(Lives[pid]) + " lives left")

        return false
    endif


    return true
endfunction

function Trig_Hero_Dies_Func008A takes nothing returns nothing
    call KillUnit(GetEnumUnit())
endfunction

function Trig_Hero_Dies_Func011C takes nothing returns boolean
    if(not(GetPlayerController(GetOwningPlayer(GetTriggerUnit()))==MAP_CONTROL_USER))then
        return false
    endif
    return true
endfunction

function Trig_Hero_Dies_Func013Func001001 takes nothing returns boolean
    return((UnknownInteger01 - 5)>= RoundNumber)
endfunction

function Trig_Hero_Dies_Func013Func002001001001001 takes nothing returns boolean
    return(GetFilterPlayer()!=Player(8))
endfunction

function Trig_Hero_Dies_Func013Func002001001001002 takes nothing returns boolean
    return(GetFilterPlayer()!=Player(11))
endfunction

function Trig_Hero_Dies_Func013Func002001001001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Hero_Dies_Func013Func002001001001001(),Trig_Hero_Dies_Func013Func002001001001002())
endfunction

function Trig_Hero_Dies_Func013Func002001001002 takes nothing returns boolean
    return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
endfunction

function Trig_Hero_Dies_Func013Func002001001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Hero_Dies_Func013Func002001001001(),Trig_Hero_Dies_Func013Func002001001002())
endfunction

function Trig_Hero_Dies_Func013Func002A takes nothing returns nothing
    call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_RESOURCE_FOOD_CAP,UnknownInteger01)
    call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_FOOD_CAP_CEILING,UnknownInteger01)
    call ResourseRefresh(GetEnumPlayer()) 
endfunction

function Trig_Hero_Dies_Func013C takes nothing returns boolean
    if(not(ElimModeEnabled==true))then
        return false
    endif
    return true
endfunction

function Trig_Hero_Dies_Func014Func001Func001001001 takes nothing returns boolean
    return(PlayerCount==2)
endfunction

function Trig_Hero_Dies_Func014Func001Func001001002 takes nothing returns boolean
    return(PlayerCount==3)
endfunction

function Trig_Hero_Dies_Func014Func001Func001001 takes nothing returns boolean
    return GetBooleanOr(Trig_Hero_Dies_Func014Func001Func001001001(),Trig_Hero_Dies_Func014Func001Func001001002())
endfunction

function Trig_Hero_Dies_Func014Func001Func002001 takes nothing returns boolean
    return(PlayerCount >= 4)
endfunction

function Trig_Hero_Dies_Func014Func001Func003001001 takes nothing returns boolean
    return(PlayerCount==2)
endfunction

function Trig_Hero_Dies_Func014Func001Func003001002 takes nothing returns boolean
    return(PlayerCount==3)
endfunction

function Trig_Hero_Dies_Func014Func001Func003001 takes nothing returns boolean
    return GetBooleanOr(Trig_Hero_Dies_Func014Func001Func003001001(),Trig_Hero_Dies_Func014Func001Func003001002())
endfunction

function Trig_Hero_Dies_Func014Func001Func004001 takes nothing returns boolean
    return(PlayerCount >= 4)
endfunction

function Trig_Hero_Dies_Func014Func001C takes nothing returns boolean
    if(not(GameModeShort==true))then
        return false
    endif
    return true
endfunction

function Trig_Hero_Dies_Func014Func002001001001001 takes nothing returns boolean
    return(GetFilterPlayer()!=Player(8))
endfunction

function Trig_Hero_Dies_Func014Func002001001001002 takes nothing returns boolean
    return(GetFilterPlayer()!=Player(11))
endfunction

function Trig_Hero_Dies_Func014Func002001001001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Hero_Dies_Func014Func002001001001001(),Trig_Hero_Dies_Func014Func002001001001002())
endfunction

function Trig_Hero_Dies_Func014Func002001001002 takes nothing returns boolean
    return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
endfunction

function Trig_Hero_Dies_Func014Func002001001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Hero_Dies_Func014Func002001001001(),Trig_Hero_Dies_Func014Func002001001002())
endfunction

function Trig_Hero_Dies_Func014Func002A takes nothing returns nothing
    call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_RESOURCE_FOOD_CAP,UnknownInteger01)
    call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_FOOD_CAP_CEILING,UnknownInteger01)
    call ResourseRefresh(GetEnumPlayer()) 
endfunction

function Trig_Hero_Dies_Func014C takes nothing returns boolean
    if(not(udg_boolean07==true))then
        return false
    endif
    return true
endfunction

function Trig_Hero_Dies_Func016C takes nothing returns boolean
    if(not(BrStarted==true))then
        return false
    endif
    return true
endfunction

function Trig_Hero_Dies_Func024Func001Func001001002 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())==Player(11))
endfunction

function Trig_Hero_Dies_Func024Func001Func001A takes nothing returns nothing
    call DisableTrigger(udg_trigger107)
    call KillUnit(GetEnumUnit())
    call EnableTrigger(udg_trigger107)
endfunction

function Trig_Hero_Dies_Func024Func001C takes nothing returns boolean
    if(not(RectContainsUnit(PlayerArenaRects[udg_integer42],GetTriggerUnit())==true))then
        return false
    endif
    return true
endfunction

function Trig_Hero_Dies_Actions takes nothing returns nothing
    call StopSoundBJ(udg_sound13,false)
    call PlaySoundBJ(udg_sound13)
    call ForceAddPlayerSimple(GetOwningPlayer(GetTriggerUnit()),DefeatedPlayers)
    set PlayerCount =(PlayerCount - 1)
    call AllowSinglePlayerCommands()
    
    call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(GetOwningPlayer(GetTriggerUnit()))+ "|cffC60000 was defeated!|r")))
    call DisableTrigger(udg_trigger16)
    call ForGroupBJ(GetUnitsOfPlayerAll(GetOwningPlayer(GetTriggerUnit())),function Trig_Hero_Dies_Func008A)
    call EnableTrigger(udg_trigger16)

    if(Trig_Hero_Dies_Func011C())then
        call DialogSetMessageBJ(udg_dialog04,"Defeat!")
        call DialogDisplayBJ(true,udg_dialog04,GetOwningPlayer(GetTriggerUnit()))
    else
        call CustomDefeatBJ(GetOwningPlayer(GetTriggerUnit()),"Defeat!")
    endif

    if(Trig_Hero_Dies_Func013C())then
        if(Trig_Hero_Dies_Func013Func001001())then
            set UnknownInteger01 =(UnknownInteger01 - 5)
        else
            call DoNothing()
        endif
        call ForForce(GetPlayersMatching(Condition(function Trig_Hero_Dies_Func013Func002001001)),function Trig_Hero_Dies_Func013Func002A)
    endif

    if(Trig_Hero_Dies_Func014C())then
        if(Trig_Hero_Dies_Func014Func001C())then
            if(Trig_Hero_Dies_Func014Func001Func003001())then
                set UnknownInteger01 =(5 *(udg_integer41 + 1))
            else
                call DoNothing()
            endif
            if(Trig_Hero_Dies_Func014Func001Func004001())then
                set UnknownInteger01 =(5 *(udg_integer41 + 2))
            else
                call DoNothing()
            endif
        else
            if(Trig_Hero_Dies_Func014Func001Func001001())then
                set UnknownInteger01 =(10 *(udg_integer41 + 1))
            else
                call DoNothing()
            endif
            if(Trig_Hero_Dies_Func014Func001Func002001())then
                set UnknownInteger01 =(10 *(udg_integer41 + 2))
            else
                call DoNothing()
            endif
        endif
        call ForForce(GetPlayersMatching(Condition(function Trig_Hero_Dies_Func014Func002001001)),function Trig_Hero_Dies_Func014Func002A)
    endif

    if(Trig_Hero_Dies_Func016C())then
        call ConditionalTriggerExecute(udg_trigger122)
    endif

    call ConditionalTriggerExecute(udg_trigger118)
    call TriggerSleepAction(2)
    call StopSoundBJ(udg_sound13,true)
    call StopSoundBJ(udg_sound12,false)
    call PlaySoundBJ(udg_sound12)

    set udg_integer42 = 1
    loop
        exitwhen udg_integer42 > 8
        if(Trig_Hero_Dies_Func024Func001C())then
            call ForGroupBJ(GetUnitsInRectMatching(PlayerArenaRects[udg_integer42],Condition(function Trig_Hero_Dies_Func024Func001Func001001002)),function Trig_Hero_Dies_Func024Func001Func001A)
        endif
        set udg_integer42 = udg_integer42 + 1
    endloop

    call ConditionalTriggerExecute(udg_trigger108)
endfunction

function Trig_Hero_Dies_After_Victory_Func008C takes nothing returns boolean
    if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
        return false
    endif
    if(not(GetOwningPlayer(GetTriggerUnit())!=Player(8)))then
        return false
    endif
    if(not(GetOwningPlayer(GetTriggerUnit())!=Player(11)))then
        return false
    endif
    return true
endfunction

function Trig_Hero_Dies_After_Victory_Conditions takes nothing returns boolean
    if(not Trig_Hero_Dies_After_Victory_Func008C())then
        return false
    endif
    return true
endfunction

function Trig_Hero_Dies_After_Victory_Func004A takes nothing returns nothing
    call KillUnit(GetEnumUnit())
endfunction

function Trig_Hero_Dies_After_Victory_Func007Func006C takes nothing returns boolean
    if(not(InitialPlayerCount > 1))then
        return false
    endif
    return true
endfunction

function Trig_Hero_Dies_After_Victory_Func007Func007A takes nothing returns nothing
    call CustomDefeatBJ(GetEnumPlayer(),"Defeat!")
endfunction

function Trig_Hero_Dies_After_Victory_Func007C takes nothing returns boolean
    if(not(PlayerCount==0))then
        return false
    endif
    return true
endfunction

function Trig_Hero_Dies_After_Victory_Actions takes nothing returns nothing
    set PlayerCount =(PlayerCount - 1)
    call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(GetOwningPlayer(GetTriggerUnit()))+(" |cffffcc00has fallen at level " +(I2S(RoundNumber)+ "!|r")))))
    call DisableTrigger(udg_trigger16)
    call ForGroupBJ(GetUnitsOfPlayerAll(GetOwningPlayer(GetTriggerUnit())),function Trig_Hero_Dies_After_Victory_Func004A)
    call EnableTrigger(udg_trigger16)
    if(Trig_Hero_Dies_After_Victory_Func007C())then
        call DisableTrigger(udg_trigger116)
        call DisableTrigger(GetTriggeringTrigger())
        call DisableTrigger(udg_trigger107)
        call TriggerSleepAction(2)
        if(Trig_Hero_Dies_After_Victory_Func007Func006C())then
            call CustomVictoryBJ(SingleplayerPlayer,true,true)
        else
            call CustomDefeatBJ(SingleplayerPlayer,"Defeat!")
        endif
        call ForForce(DefeatedPlayers,function Trig_Hero_Dies_After_Victory_Func007Func007A)
    else
    endif
endfunction

function Trig_Hero_Refresh_Actions takes nothing returns nothing
    call SetUnitLifePercentBJ(udg_unit01,100)
    call SetUnitManaPercentBJ(udg_unit01,100)
    call UnitResetCooldown(udg_unit01)
    call UnitRemoveBuffBJ('Bvul',udg_unit01)
    call UnitRemoveBuffBJ('Bam2',udg_unit01)
    call UnitRemoveBuffBJ('BHav',udg_unit01)
    call UnitRemoveBuffBJ('BHbn',udg_unit01)
    call UnitRemoveBuffBJ('BNbr',udg_unit01)
    call UnitRemoveBuffBJ('Bbsk',udg_unit01)
    call UnitRemoveBuffBJ('Bapl',udg_unit01)
    call UnitRemoveBuffBJ('Bplg',udg_unit01)
    call UnitRemoveBuffBJ('Bena',udg_unit01)
    call UnitRemoveBuffBJ('Beng',udg_unit01)
    call UnitRemoveBuffBJ('BEer',udg_unit01)
    call UnitRemoveBuffBJ('Bfae',udg_unit01)
    call UnitRemoveBuffBJ('BUfa',udg_unit01)
    call UnitRemoveBuffBJ('Binf',udg_unit01)
    call UnitRemoveBuffBJ('Blsh',udg_unit01)
    call UnitRemoveBuffBJ('Bliq',udg_unit01)
    call UnitRemoveBuffBJ('Bpoi',udg_unit01)
    call UnitRemoveBuffBJ('Bpsd',udg_unit01)
    call UnitRemoveBuffBJ('Brej',udg_unit01)
    call UnitRemoveBuffBJ('Bdef',udg_unit01)
    call UnitRemoveBuffBJ('B002',udg_unit01)
    call UnitRemoveBuffBJ('Bslo',udg_unit01)
    call UnitRemoveBuffBJ('Bspl',udg_unit01)
    call UnitRemoveBuffBJ('BSTN',udg_unit01)
    call UnitRemoveBuffBJ('BPSE',udg_unit01)
    call UnitRemoveBuffBJ('BHtc',udg_unit01)
    call UnitRemoveBuffBJ('Buhf',udg_unit01)
    call RemoveDebuff(udg_unit01, 0)
endfunction

function Trig_DeathDialog_Initialization_Actions takes nothing returns nothing
    call DialogClearBJ(udg_dialog04)
    call DialogSetMessageBJ(udg_dialog04,"Defeat!")
    call DialogAddButtonBJ(udg_dialog04,"Spectate")
    set udg_buttons03[1]= GetLastCreatedButtonBJ()
    call DialogAddButtonBJ(udg_dialog04,"Leave")
    set udg_buttons03[2]= GetLastCreatedButtonBJ()
endfunction

function Trig_DeathDialog_Leave_Conditions takes nothing returns boolean
    if(not(GetClickedButtonBJ()==udg_buttons03[2]))then
        return false
    endif
    return true
endfunction

function Trig_DeathDialog_Leave_Actions takes nothing returns nothing
    call CustomDefeatBJ(GetTriggerPlayer(),"Defeat!")
endfunction

function Trig_Pandaren_Death_Sound_Initialization_Conditions takes nothing returns boolean
    if(not(IsTriggerEnabled(GetTriggeringTrigger())==true))then
        return false
    endif
    return true
endfunction

function Trig_Pandaren_Death_Sound_Initialization_Actions takes nothing returns nothing
    call DisableTrigger(GetTriggeringTrigger())
    set udg_sounds01[1]= udg_sound17
    set udg_sounds01[2]= udg_sound18
    set udg_sounds01[3]= udg_sound19
    set udg_sounds01[4]= udg_sound20
    set udg_sounds01[5]= udg_sound21
    set udg_sounds01[6]= udg_sound22
    set udg_sounds01[7]= udg_sound23
    set udg_sounds01[8]= udg_sound24
endfunction

function Trig_Pandaren_Dies_Func001Func001C takes nothing returns boolean
    if(not(IsUnitDeadBJ(GetTriggerUnit())==true))then
        return false
    endif
    if(not(IsUnitIllusionBJ(GetTriggerUnit())!=true))then
        return false
    endif
    if(not(GetUnitTypeId(GetTriggerUnit())=='N00R'))then
        return false
    endif
    return true
endfunction

function Trig_Pandaren_Dies_Func001Func002C takes nothing returns boolean
    if(not(IsUnitDeadBJ(GetTriggerUnit())==true))then
        return false
    endif
    if(not(IsUnitIllusionBJ(GetTriggerUnit())!=true))then
        return false
    endif
    if(not(GetUnitTypeId(GetTriggerUnit())=='N00R'))then
        return false
    endif
    if(not(GetItemTypeId(GetManipulatedItem())=='ankh'))then
        return false
    endif
    return true
endfunction

function Trig_Pandaren_Dies_Func001C takes nothing returns boolean
    if(Trig_Pandaren_Dies_Func001Func001C())then
        return true
    endif
    if(Trig_Pandaren_Dies_Func001Func002C())then
        return true
    endif
    return false
endfunction

function Trig_Pandaren_Dies_Conditions takes nothing returns boolean
    if(not Trig_Pandaren_Dies_Func001C())then
        return false
    endif
    return true
endfunction

function Trig_Pandaren_Dies_Actions takes nothing returns nothing
    call ConditionalTriggerExecute(udg_trigger85)
    call PlaySoundOnUnitBJ(udg_sounds01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],100,GetTriggerUnit())
endfunction

/*

function Trig_Display_Hint_Func001Func001Func001001001001 takes nothing returns boolean
    return(IsPlayerInForce(GetFilterPlayer(),udg_force06)!=true)
endfunction

function Trig_Display_Hint_Func001Func001Func001001001002001 takes nothing returns boolean
    return(IsPlayerInForce(GetFilterPlayer(),RoundPlayersCompleted)==true)
endfunction

function Trig_Display_Hint_Func001Func001Func001001001002002 takes nothing returns boolean
    return(IsUnitInGroup(PlayerHeroes[GetConvertedPlayerId(GetFilterPlayer())],DuelingHeroGroup)!=true)
endfunction

function Trig_Display_Hint_Func001Func001Func001001001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Display_Hint_Func001Func001Func001001001002001(),Trig_Display_Hint_Func001Func001Func001001001002002())
endfunction

function Trig_Display_Hint_Func001Func001Func001001001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Display_Hint_Func001Func001Func001001001001(),Trig_Display_Hint_Func001Func001Func001001001002())
endfunction

function Trig_Display_Hint_Func001Func001Func002001001001 takes nothing returns boolean
    return(IsPlayerInForce(GetFilterPlayer(),udg_force06)!=true)
endfunction

function Trig_Display_Hint_Func001Func001Func002001001002001 takes nothing returns boolean
    return(IsPlayerInForce(GetFilterPlayer(),RoundPlayersCompleted)==true)
endfunction

function Trig_Display_Hint_Func001Func001Func002001001002002 takes nothing returns boolean
    return(IsUnitInGroup(PlayerHeroes[GetConvertedPlayerId(GetFilterPlayer())],DuelingHeroGroup)!=true)
endfunction

function Trig_Display_Hint_Func001Func001Func002001001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Display_Hint_Func001Func001Func002001001002001(),Trig_Display_Hint_Func001Func001Func002001001002002())
endfunction

function Trig_Display_Hint_Func001Func001Func002001001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Display_Hint_Func001Func001Func002001001001(),Trig_Display_Hint_Func001Func001Func002001001002())
endfunction

function Trig_Display_Hint_Func001Func001C takes nothing returns boolean
    if(not(udg_boolean07==true))then
        return false
    endif
    return true
endfunction

function Trig_Display_Hint_Func001Func003001001001 takes nothing returns boolean
    return(IsPlayerInForce(GetFilterPlayer(),udg_force06)!=true)
endfunction

function Trig_Display_Hint_Func001Func003001001002001 takes nothing returns boolean
    return(IsPlayerInForce(GetFilterPlayer(),RoundPlayersCompleted)==true)
endfunction

function Trig_Display_Hint_Func001Func003001001002002 takes nothing returns boolean
    return(IsUnitInGroup(PlayerHeroes[GetConvertedPlayerId(GetFilterPlayer())],DuelingHeroGroup)!=true)
endfunction

function Trig_Display_Hint_Func001Func003001001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Display_Hint_Func001Func003001001002001(),Trig_Display_Hint_Func001Func003001001002002())
endfunction

function Trig_Display_Hint_Func001Func003001001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Display_Hint_Func001Func003001001001(),Trig_Display_Hint_Func001Func003001001002())
endfunction

function Trig_Display_Hint_Func001C takes nothing returns boolean
    if(not(ElimModeEnabled==true))then
        return false
    endif
    return true
endfunction

function Trig_Display_Hint_Actions takes nothing returns nothing
    if(Trig_Display_Hint_Func001C())then
        call DisplayTimedTextToForce(GetPlayersMatching(Condition(function Trig_Display_Hint_Func001Func003001001)),5.00,("|cff0080FFHint: " +(udg_strings01[GetRandomInt(1,udg_integers12[1])]+ "|r")))
    else
        if(Trig_Display_Hint_Func001Func001C())then
            call DisplayTimedTextToForce(GetPlayersMatching(Condition(function Trig_Display_Hint_Func001Func001Func002001001)),5.00,("|cff0080FFHint: " +(udg_strings01[GetRandomInt(1,udg_integers12[2])]+ "|r")))
        else
            call DisplayTimedTextToForce(GetPlayersMatching(Condition(function Trig_Display_Hint_Func001Func001Func001001001)),5.00,("|cff0080FFHint: " +(udg_strings01[GetRandomInt(1,udg_integers12[3])]+ "|r")))
        endif
    endif
endfunction

function Trig_Hint_Initialization_Func019C takes nothing returns boolean
    if(not(GameModeShort==true))then
        return false
    endif
    return true
endfunction

function Trig_Hint_Initialization_Actions takes nothing returns nothing
    set udg_strings01[1]= "There are hints showing in-game!"
    set udg_strings01[2]= "Wait a minute or two if you get stuck! The anti-stuck system is slow, but it'll get you out of there sooner or later."
    set udg_strings01[3]= "If you have overlapping hotkeys go to the menu > options > preset keybindings and set it to grid mode to fix it! (needs to be done in main menu)"
    set udg_strings01[4]= "Maximum level of ALL abilities is 30! Unless you're the Tauren."
    set udg_strings01[5]= "Not all abilities stack! Be sure to check if you have more than one unique attack modifier."
    set udg_strings01[6]= "Some items have attributes that stack, but not all do, if it has an [unique] tag it doesn't stack."
    set udg_strings01[8]= "You can turn off/on hints by using the -hint command."
    set udg_strings01[9]= "Creeps are stronger when they are fewer in number. Be sure to have both single target and area of effect damage."
    set udg_strings01[10]= "Press the Space Bar to center the screen on your hero."
    set udg_strings01[11]= "If enabled, you can buy creep upgrades at the Power Ups Shop II to get mroe gold per round at the cost of fighting stronger creeps."
    set udg_strings01[12]= "Xesil has a chance to instantly reset an abilities cooldown when it's used, you can buy the Xesil's Legacy item to replicate it with any hero."
    set udg_strings01[13]= "Grizwald may seem to be weak in the beginning, but he gets a lot of stats per level."
    set udg_integers12[1]= 13
    set udg_strings01[14]= "Won prizes will be added to your inventory as soon as you have an empty slot. Don't forget to collect it before the next PvP round!"
    if(Trig_Hint_Initialization_Func019C())then
        set udg_strings01[15]= "It's PvP every 5th level, in which the winner receives a prize."
    else
        set udg_strings01[15]= "It's PvP every 10th level, in which the winner receives a prize."
    endif
    set udg_integers12[2]= 15
    set udg_strings01[16]= "Players surviving all levels will settle the score in a battle royal."
    set udg_integers12[3]= 16
    call EnableTrigger(udg_trigger87)
endfunction
*/

function Trig_Map_Initialization_Func010001001001001 takes nothing returns boolean
    return(GetFilterPlayer()!=Player(8))
endfunction

function Trig_Map_Initialization_Func010001001001002 takes nothing returns boolean
    return(GetFilterPlayer()!=Player(11))
endfunction

function Trig_Map_Initialization_Func010001001001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Map_Initialization_Func010001001001001(),Trig_Map_Initialization_Func010001001001002())
endfunction

function Trig_Map_Initialization_Func010001001002001 takes nothing returns boolean
    return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
endfunction

function Trig_Map_Initialization_Func010001001002002 takes nothing returns boolean
    return(IsPlayerInForce(GetFilterPlayer(),udg_force07)==true)
endfunction

function Trig_Map_Initialization_Func010001001002 takes nothing returns boolean
    return GetBooleanOr(Trig_Map_Initialization_Func010001001002001(),Trig_Map_Initialization_Func010001001002002())
endfunction

function Trig_Map_Initialization_Func010001001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Map_Initialization_Func010001001001(),Trig_Map_Initialization_Func010001001002())
endfunction

function Trig_Map_Initialization_Func010A takes nothing returns nothing
    set PlayerCount =(PlayerCount + 1)
    set InitialPlayerCount =(InitialPlayerCount + 1)
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 8
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call SetPlayerAllianceStateBJ(GetEnumPlayer(),ConvertedPlayer(GetForLoopIndexA()),bj_ALLIANCE_UNALLIED)
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_RESOURCE_FOOD_USED,0)
    call ResourseRefresh(GetEnumPlayer()) 
    call SetPlayerAbilityAvailableBJ(false,'A00S',GetEnumPlayer())
    call CreateFogModifierRectBJ(true,GetEnumPlayer(),FOG_OF_WAR_VISIBLE,GetPlayableMapRect())
    call CameraSetupApplyForPlayer(true,udg_camerasetup01,GetEnumPlayer(),0.00)
endfunction

function Trig_Map_Initialization_Func011C takes nothing returns boolean
    if(not(PlayerCount==1))then
        return false
    endif
    return true
endfunction

function Trig_Map_Initialization_Func018001001001001 takes nothing returns boolean
    return(GetFilterPlayer()!=Player(8))
endfunction

function Trig_Map_Initialization_Func018001001001002 takes nothing returns boolean
    return(GetFilterPlayer()!=Player(11))
endfunction

function Trig_Map_Initialization_Func018001001001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Map_Initialization_Func018001001001001(),Trig_Map_Initialization_Func018001001001002())
endfunction

function Trig_Map_Initialization_Func018001001002001 takes nothing returns boolean
    return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
endfunction

function Trig_Map_Initialization_Func018001001002002 takes nothing returns boolean
    return(IsPlayerInForce(GetFilterPlayer(),udg_force07)==true)
endfunction

function Trig_Map_Initialization_Func018001001002 takes nothing returns boolean
    return GetBooleanOr(Trig_Map_Initialization_Func018001001002001(),Trig_Map_Initialization_Func018001001002002())
endfunction

function Trig_Map_Initialization_Func018001001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Map_Initialization_Func018001001001(),Trig_Map_Initialization_Func018001001002())
endfunction

function Trig_Map_Initialization_Func018A takes nothing returns nothing
    call SetPlayerAllianceStateBJ(GetEnumPlayer(),Player(8),bj_ALLIANCE_ALLIED_VISION)
endfunction

function Trig_Map_Initialization_Actions takes nothing returns nothing


    call SetMapFlag(MAP_ALLIANCE_CHANGES_HIDDEN,true)
    call SetMapFlag(MAP_LOCK_RESOURCE_TRADING,true)
    call SetTimeOfDay(12)
    
    call ForForce(GetPlayersMatching(Condition(function Trig_Map_Initialization_Func010001001)),function Trig_Map_Initialization_Func010A)
    if(Trig_Map_Initialization_Func011C())then
        call DisableTrigger(udg_trigger118)
        call DisableTrigger(udg_trigger80)
        call EnableTrigger(udg_trigger81)
    else
    endif
    call ConditionalTriggerExecute(udg_trigger147)
    call SetUnitPositionLoc(udg_unit37,OffsetLocation(GetUnitLoc(udg_unit25),0.00,0.00))
    call SetUnitPositionLoc(udg_unit36,OffsetLocation(GetUnitLoc(udg_unit15),15.00,15.00))
    call SetUnitPositionLoc(udg_unit38,OffsetLocation(GetUnitLoc(udg_unit34),0.00,0.00))
    call SetUnitPositionLoc(udg_unit35,OffsetLocation(GetUnitLoc(udg_unit21),17.00,15.00))
    call TriggerSleepAction(0.00)
    call ForForce(GetPlayersMatching(Condition(function Trig_Map_Initialization_Func018001001)),function Trig_Map_Initialization_Func018A)
endfunction

function Trig_Melee_Initialization_Conditions takes nothing returns boolean
    if(not(IsTriggerEnabled(GetTriggeringTrigger())==true))then
        return false
    endif
    return true
endfunction

function Trig_Melee_Initialization_Func004Func001001 takes nothing returns boolean
    return(udg_boolean16==true)
endfunction

function Trig_Melee_Initialization_Func004C takes nothing returns boolean
    if(not(SpawnedHeroCount < PlayerCount))then
        return false
    endif
    return true
endfunction

function Trig_Melee_Initialization_Func010Func003001001001001 takes nothing returns boolean
    return(GetFilterPlayer()!=Player(8))
endfunction

function Trig_Melee_Initialization_Func010Func003001001001002 takes nothing returns boolean
    return(GetFilterPlayer()!=Player(11))
endfunction

function Trig_Melee_Initialization_Func010Func003001001001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Melee_Initialization_Func010Func003001001001001(),Trig_Melee_Initialization_Func010Func003001001001002())
endfunction

function Trig_Melee_Initialization_Func010Func003001001002001001 takes nothing returns boolean
    return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
endfunction

function Trig_Melee_Initialization_Func010Func003001001002001002 takes nothing returns boolean
    return(IsPlayerInForce(GetFilterPlayer(),udg_force07)==true)
endfunction

function Trig_Melee_Initialization_Func010Func003001001002001 takes nothing returns boolean
    return GetBooleanOr(Trig_Melee_Initialization_Func010Func003001001002001001(),Trig_Melee_Initialization_Func010Func003001001002001002())
endfunction

function Trig_Melee_Initialization_Func010Func003001001002002 takes nothing returns boolean
    return(IsPlayerInForce(GetFilterPlayer(),udg_PlayersWithHero)!=true)
endfunction

function Trig_Melee_Initialization_Func010Func003001001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Melee_Initialization_Func010Func003001001002001(),Trig_Melee_Initialization_Func010Func003001001002002())
endfunction

function Trig_Melee_Initialization_Func010Func003001001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Melee_Initialization_Func010Func003001001001(),Trig_Melee_Initialization_Func010Func003001001002())
endfunction

function Trig_Melee_Initialization_Func010Func003Func001Func003Func002001001002001 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
endfunction

function Trig_Melee_Initialization_Func010Func003Func001Func003Func002001001002002 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_Melee_Initialization_Func010Func003Func001Func003Func002001001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Melee_Initialization_Func010Func003Func001Func003Func002001001002001(),Trig_Melee_Initialization_Func010Func003Func001Func003Func002001001002002())
endfunction

function Trig_Melee_Initialization_Func010Func003Func001Func003C takes nothing returns boolean
    if(not(PlayerHeroPicked[GetConvertedPlayerId(GetEnumPlayer())]==false))then
        return false
    endif
    if(not(CountUnitsInGroup(GetUnitsOfPlayerMatching(GetEnumPlayer(),Condition(function Trig_Melee_Initialization_Func010Func003Func001Func003Func002001001002)))==0))then
        return false
    endif
    return true
endfunction

function Trig_Melee_Initialization_Func010Func003Func001C takes nothing returns boolean
    if(not Trig_Melee_Initialization_Func010Func003Func001Func003C())then
        return false
    endif
    return true
endfunction

function Trig_Melee_Initialization_Func010Func003A takes nothing returns nothing
    if(Trig_Melee_Initialization_Func010Func003Func001C())then
        set udg_player02 = GetEnumPlayer()
        call ConditionalTriggerExecute(udg_trigger79)
    else
    endif
endfunction

function Trig_Melee_Initialization_Func010Func004C takes nothing returns boolean
    if(not(RoundNumber==1))then
        return false
    endif
    if(not(SpawnedHeroCount < PlayerCount))then
        return false
    endif
    return true
endfunction

function Trig_Melee_Initialization_Func010C takes nothing returns boolean
    if(not Trig_Melee_Initialization_Func010Func004C())then
        return false
    endif
    return true
endfunction

function Trig_Melee_Initialization_Actions takes nothing returns nothing
    call DisableTrigger(GetTriggeringTrigger())
    call TriggerSleepAction(0.50)
    if(Trig_Melee_Initialization_Func004C())then
        if(Trig_Melee_Initialization_Func004Func001001())then
            return
        else
            call DoNothing()
        endif
        call PlaySoundBJ(udg_sound14)
        call EnableTrigger(udg_trigger78)
        call MouseHoverInfo_ActivateMouseHover()
        call DisplayTimedTextToForce(GetPlayersAll(),8.00,"|cffffcc00Select your hero! (click again to confirm)|r")
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call CreateTimerDialogBJ(GetLastCreatedTimerBJ(),"Game starting in ...")
        call StartTimerBJ(GetLastCreatedTimerBJ(),false,30.00)
    else
    endif
    call TriggerSleepAction(24.50)
    set udg_location01 = OffsetLocation(GetRectCenter(GetPlayableMapRect()),- 40.00,- 50.00)
    set CountdownCount = 5
    call ConditionalTriggerExecute(udg_trigger117)
    call TriggerSleepAction(5.00)
    if(Trig_Melee_Initialization_Func010C())then
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call PlaySoundBJ(udg_sound11)
        call ForForce(GetPlayersMatching(Condition(function Trig_Melee_Initialization_Func010Func003001001)),function Trig_Melee_Initialization_Func010Func003A)
    else
    endif
endfunction

function Trig_Player_Region_Initialization_Actions takes nothing returns nothing
    set PlayerArenaRects[1]= RectP1Arena
    set PlayerArenaRects[2]= RectP2Arena
    set PlayerArenaRects[3]= RectP3Arena
    set PlayerArenaRects[4]= RectP4Arena
    set PlayerArenaRects[5]= RectP5Arena
    set PlayerArenaRects[6]= RectP6Arena
    set PlayerArenaRects[7]= RectP7Arena
    set PlayerArenaRects[8]= RectP8Arena
endfunction



function Trig_Moonstone_Conditions takes nothing returns boolean
    if(not(UnitHasItemOfTypeBJ(GetTriggerUnit(),'I03O')==true))then
        return false
    endif
    if(not(GetSpellAbilityId()!='AIdb'))then
        return false
    endif
    return true
endfunction

function Trig_Moonstone_Actions takes nothing returns nothing
    call TriggerSleepAction(0.00)
    call SetUnitManaBJ(GetTriggerUnit(),(GetUnitStateSwap(UNIT_STATE_MANA,GetTriggerUnit())+(GetUnitStateSwap(UNIT_STATE_MAX_MANA,GetTriggerUnit())* 0.04)))
    call AddSpecialEffectTargetUnitBJ("weapon",GetTriggerUnit(),"Abilities\\Spells\\Undead\\ReplenishMana\\SpiritTouchTarget.mdl")
    call DestroyEffectBJ(GetLastCreatedEffectBJ())
endfunction

function Trig_Scepter_of_Confusion_Conditions takes nothing returns boolean
    if(not(UnitHasItemOfTypeBJ(GetTriggerUnit(),'I03R')==true))then
        return false
    endif
    return true
endfunction

function Trig_Scepter_of_Confusion_Func002C takes nothing returns boolean
    if(not(RoundCreepAbilCastChance!=1))then
        return false
    endif
    return true
endfunction

function Trig_Scepter_of_Confusion_Actions takes nothing returns nothing
    set RoundCreepAbilCastChance = GetRandomInt(1,4)
    if(Trig_Scepter_of_Confusion_Func002C())then
        call CreateNUnitsAtLoc(1,PRIEST_1_UNIT_ID,GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(GetTriggerUnit()),bj_UNIT_FACING)
        call UnitApplyTimedLifeBJ(5.00,'BTLF',GetLastCreatedUnit())
        call UnitAddAbility(GetLastCreatedUnit(), 'A014')
        call IssueTargetOrderById(GetLastCreatedUnit(), 852274, GetTriggerUnit())
    else
    endif
endfunction

function Trig_The_Divine_Source_Conditions takes nothing returns boolean
    if(not(GetItemTypeId(GetManipulatedItem())=='I043'))then
        return false
    endif
    return true
endfunction

function Trig_The_Divine_Source_Actions takes nothing returns nothing
    call CreateNUnitsAtLoc(1,PRIEST_1_UNIT_ID,GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(GetTriggerUnit()),bj_UNIT_FACING)
    call UnitApplyTimedLifeBJ(2.00,'BTLF',GetLastCreatedUnit())
    call UnitRemoveBuffBJ('Bena',GetTriggerUnit())
    call UnitRemoveBuffBJ('Bens',GetTriggerUnit())
    call UnitRemoveBuffBJ('Beng',GetTriggerUnit())
    call UnitRemoveBuffBJ('Bliq',GetTriggerUnit())
    call UnitRemoveBuffBJ('Bpoi',GetTriggerUnit())
    call UnitRemoveBuffBJ('Bpsd',GetTriggerUnit())
    call UnitAddAbilityBJ('Aadm',GetLastCreatedUnit())
    call IssueTargetOrderBJ(GetLastCreatedUnit(),"autodispel",GetTriggerUnit())
endfunction

function Trig_Volcanic_Armor_Conditions takes nothing returns boolean
    if(not(UnitHasItemOfTypeBJ(GetTriggerUnit(),'I03T')==true))then
        return false
    endif
    if(not(IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))==true))then
        return false
    endif
    return true
endfunction

function Trig_Volcanic_Armor_Func003C takes nothing returns boolean
    if(not(RoundCreepAbilCastChance <= 15))then
        return false
    endif
    return true
endfunction

function Trig_Volcanic_Armor_Actions takes nothing returns nothing
    set RoundCreepAbilCastChance = GetRandomInt(1,100)
    if(Trig_Volcanic_Armor_Func003C())then
        call CreateNUnitsAtLoc(1,PRIEST_1_UNIT_ID,GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(GetTriggerUnit()),bj_UNIT_FACING)
        call UnitApplyTimedLifeBJ(5.00,'BTLF',GetLastCreatedUnit())
        call UnitAddAbilityBJ('A015',GetLastCreatedUnit())
        call IssueTargetOrderBJ(GetLastCreatedUnit(),"firebolt",GetAttacker())
    else
    endif
endfunction

function Trig_Xesils_Legacy_Conditions takes nothing returns boolean
    if(not(UnitHasItemOfTypeBJ(GetTriggerUnit(),'I03P')==true))then
        return false
    endif
    return true
endfunction

function Trig_Xesils_Legacy_Func002C takes nothing returns boolean
    if(not(RoundCreepAbilCastChance==1))then
        return false
    endif
    return true
endfunction

function Trig_Xesils_Legacy_Actions takes nothing returns nothing
    local unit U = GetTriggerUnit()
    local integer Ib = GetSpellAbilityId()

    set RoundCreepAbilCastChance = GetRandomInt(1,4)
    if(Trig_Xesils_Legacy_Func002C())then
        call TriggerSleepAction(0.00)	
        call BlzEndUnitAbilityCooldown(U,Ib)
        call AddSpecialEffectTargetUnitBJ("origin",U,"Abilities\\Spells\\Other\\Charm\\CharmTarget.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
    else
    endif
endfunction

function Trig_Attack_Move_Func001Func001001002001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_Attack_Move_Func001Func001001002002 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())==Player(11))
endfunction

function Trig_Attack_Move_Func001Func001001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Attack_Move_Func001Func001001002001(),Trig_Attack_Move_Func001Func001001002002())
endfunction

function Trig_Attack_Move_Func001Func001A takes nothing returns nothing
    call IssuePointOrderLocBJ(GetEnumUnit(),"patrol",GetRandomLocInRect(PlayerArenaRects[udg_integer43]))
endfunction

function Trig_Attack_Move_Actions takes nothing returns nothing
    set udg_integer43 = 1
    loop
        exitwhen udg_integer43 > 8
        call ForGroupBJ(GetUnitsInRectMatching(PlayerArenaRects[udg_integer43],Condition(function Trig_Attack_Move_Func001Func001001002)),function Trig_Attack_Move_Func001Func001A)
        set udg_integer43 = udg_integer43 + 1
    endloop
endfunction

function Trig_Add_Unit_Abilities_Func001001 takes nothing returns boolean
    return(RoundCreepChanceBash==1)
endfunction

function Trig_Add_Unit_Abilities_Func002001 takes nothing returns boolean
    return(RoundCreepChanceCritStrike==1)
endfunction

function Trig_Add_Unit_Abilities_Func003001 takes nothing returns boolean
    return(RoundCreepChanceEvasion==1)
endfunction

function Trig_Add_Unit_Abilities_Func004001 takes nothing returns boolean
    return(RoundCreepChanceCleave==1)
endfunction

function Trig_Add_Unit_Abilities_Func005001 takes nothing returns boolean
    return(RoundCreepChanceLifesteal==1)
endfunction

function Trig_Add_Unit_Abilities_Func006001 takes nothing returns boolean
    return(RoundCreepChanceThorns==1)
endfunction

function Trig_Add_Unit_Abilities_Func007C takes nothing returns boolean
    if(not(RoundCreepChanceShockwave==1))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Abilities_Func008C takes nothing returns boolean
    if(not(RoundCreepChanceManaBurn==1))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Abilities_Func009C takes nothing returns boolean
    if(not(RoundCreepChanceHurlBoulder==1))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Abilities_Func010C takes nothing returns boolean
    if(not(RoundCreepChanceRejuv==1))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Abilities_Func011C takes nothing returns boolean
    if(not(RoundCreepChanceSlow==1))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Abilities_Func012C takes nothing returns boolean
    if(not(RoundCreepChanceBigBadV==1))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Abilities_Func013C takes nothing returns boolean
    if(not(RoundCreepChanceFaerieFire==1))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Abilities_Func014C takes nothing returns boolean
    if(not(RoundCreepChanceBlink==1))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Abilities_Func015C takes nothing returns boolean
    if(not(RoundCreepChanceThunderClap==1))then
        return false
    endif
    return true
endfunction

function ResetRoundAbilities takes nothing returns nothing
    local integer index = roundAbilities.integer[0]
    loop
        set roundAbilities.integer[index] = 0
        set index = index - 1
        exitwhen index <= 0
    endloop
    set roundAbilities.integer[0] = 0
endfunction

function AddRoundAbility takes integer abilityId returns nothing
    local integer index = roundAbilities.integer[0] + 1
    set roundAbilities[index] = abilityId
    set roundAbilities.integer[0] = index
endfunction

function Trig_Add_Unit_Abilities_Actions takes nothing returns nothing
    if(Trig_Add_Unit_Abilities_Func001001())then
        call UnitAddAbilityBJ('ACbh',GetLastCreatedUnit())
    else
        call DoNothing()
    endif
    if(Trig_Add_Unit_Abilities_Func002001())then
        call UnitAddAbilityBJ('AOcr',GetLastCreatedUnit())
    else
        call DoNothing()
    endif
    if(Trig_Add_Unit_Abilities_Func003001())then
        call AddUnitEvasion (GetLastCreatedUnit(),20) 
        //	call UnitAddAbilityBJ('ACev',GetLastCreatedUnit())
    else
        call DoNothing()
    endif
    if(Trig_Add_Unit_Abilities_Func004001())then
        call UnitAddAbilityBJ('ACce',GetLastCreatedUnit())
    else
        call DoNothing()
    endif
    if(Trig_Add_Unit_Abilities_Func005001())then
        call UnitAddAbilityBJ('SCva',GetLastCreatedUnit())
    else
        call DoNothing()
    endif
    if(Trig_Add_Unit_Abilities_Func006001())then
        call UnitAddAbilityBJ('A08F',GetLastCreatedUnit())
        call SetUnitAbilityLevel(GetLastCreatedUnit(), 'A08F', IMinBJ(R2I(RoundNumber * 0.4), 30))
    else
        call DoNothing()
    endif
    if(Trig_Add_Unit_Abilities_Func007C())then
    else
        call UnitRemoveAbilityBJ('A00U',GetLastCreatedUnit())
    endif
    if(Trig_Add_Unit_Abilities_Func008C())then
    else
        call UnitRemoveAbilityBJ('A00V',GetLastCreatedUnit())
    endif
    if(Trig_Add_Unit_Abilities_Func009C())then
    else
        call UnitRemoveAbilityBJ('A00W',GetLastCreatedUnit())
    endif
    if(Trig_Add_Unit_Abilities_Func010C())then
    else
        call UnitRemoveAbilityBJ('A00X',GetLastCreatedUnit())
    endif
    if(Trig_Add_Unit_Abilities_Func011C())then
    else
        call UnitRemoveAbilityBJ('A013',GetLastCreatedUnit())
    endif
    if(Trig_Add_Unit_Abilities_Func012C())then
    else
        call UnitRemoveAbilityBJ('A018',GetLastCreatedUnit())
    endif
    if(Trig_Add_Unit_Abilities_Func013C())then
    else
        call UnitRemoveAbilityBJ('A016',GetLastCreatedUnit())
    endif
    if(Trig_Add_Unit_Abilities_Func014C())then
    else
        call UnitRemoveAbilityBJ('A01A',GetLastCreatedUnit())
    endif
    if(Trig_Add_Unit_Abilities_Func015C())then
    else
        call UnitRemoveAbilityBJ('A01B',GetLastCreatedUnit())
    endif
endfunction

function Trig_Add_Unit_Power_Func001Func002Func001Func001Func002Func002001 takes nothing returns boolean
    return(RoundCreepNumber==1)
endfunction

function Trig_Add_Unit_Power_Func001Func002Func001Func001Func002Func003Func003001 takes nothing returns boolean
    return(RoundCreepNumber==1)
endfunction

function Trig_Add_Unit_Power_Func001Func002Func001Func001Func002Func003C takes nothing returns boolean
    if(not(RoundNumber <= 25))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Func001Func002Func001Func001Func002C takes nothing returns boolean
    if(not(RoundNumber <= 20))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Func001Func002Func001Func001Func004001 takes nothing returns boolean
    return(RoundCreepNumber==1)
endfunction

function Trig_Add_Unit_Power_Func001Func002Func001Func001C takes nothing returns boolean
    if(not(RoundNumber <= 15))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Func001Func002Func001Func004001 takes nothing returns boolean
    return(RoundCreepNumber==1)
endfunction

function Trig_Add_Unit_Power_Func001Func002Func001C takes nothing returns boolean
    if(not(RoundNumber <= 10))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Func001Func002Func003001 takes nothing returns boolean
    return(RoundCreepNumber==1)
endfunction

function Trig_Add_Unit_Power_Func001Func002C takes nothing returns boolean
    if(not(RoundNumber <= 5))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Func001Func004Func002Func002001 takes nothing returns boolean
    return(RoundCreepNumber==1)
endfunction

function Trig_Add_Unit_Power_Func001Func004Func002Func003Func003001 takes nothing returns boolean
    return(RoundCreepNumber==1)
endfunction

function Trig_Add_Unit_Power_Func001Func004Func002Func003C takes nothing returns boolean
    if(not(RoundNumber <= 50))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Func001Func004Func002C takes nothing returns boolean
    if(not(RoundNumber <= 40))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Func001Func004Func004001 takes nothing returns boolean
    return(RoundCreepNumber==1)
endfunction

function Trig_Add_Unit_Power_Func001Func004C takes nothing returns boolean
    if(not(RoundNumber <= 30))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Func001Func006Func001Func001Func001Func001C takes nothing returns boolean
    if(not(RoundNumber > 50))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Func001Func006Func001Func001Func001C takes nothing returns boolean
    if(not Trig_Add_Unit_Power_Func001Func006Func001Func001Func001Func001C())then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Func001Func006Func001Func001Func002C takes nothing returns boolean
    if(not(RoundNumber > 40))then
        return false
    endif
    if(not(RoundNumber <= 50))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Func001Func006Func001Func001C takes nothing returns boolean
    if(not Trig_Add_Unit_Power_Func001Func006Func001Func001Func002C())then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Func001Func006Func001Func002C takes nothing returns boolean
    if(not(RoundNumber > 20))then
        return false
    endif
    if(not(RoundNumber <= 40))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Func001Func006Func001C takes nothing returns boolean
    if(not Trig_Add_Unit_Power_Func001Func006Func001Func002C())then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Func001Func006Func002C takes nothing returns boolean
    if(not(RoundNumber > 1))then
        return false
    endif
    if(not(RoundNumber <= 20))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Func001Func006Func003Func002C takes nothing returns boolean
    if(not(RoundNumber >= 8))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Func001Func006Func003Func003C takes nothing returns boolean
    if(not(RoundNumber >= 16))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Func001Func006C takes nothing returns boolean
    if(not Trig_Add_Unit_Power_Func001Func006Func002C())then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Func001Func009Func001Func001Func001Func001C takes nothing returns boolean
    if(not(RoundNumber > 25))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Func001Func009Func001Func001Func001C takes nothing returns boolean
    if(not Trig_Add_Unit_Power_Func001Func009Func001Func001Func001Func001C())then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Func001Func009Func001Func001Func002C takes nothing returns boolean
    if(not(RoundNumber > 20))then
        return false
    endif
    if(not(RoundNumber <= 25))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Func001Func009Func001Func001C takes nothing returns boolean
    if(not Trig_Add_Unit_Power_Func001Func009Func001Func001Func002C())then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Func001Func009Func001Func002C takes nothing returns boolean
    if(not(RoundNumber > 10))then
        return false
    endif
    if(not(RoundNumber <= 20))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Func001Func009Func001C takes nothing returns boolean
    if(not Trig_Add_Unit_Power_Func001Func009Func001Func002C())then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Func001Func009Func002C takes nothing returns boolean
    if(not(RoundNumber > 1))then
        return false
    endif
    if(not(RoundNumber <= 10))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Func001Func009Func003Func002C takes nothing returns boolean
    if(not(RoundNumber >= 4))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Func001Func009Func003Func003C takes nothing returns boolean
    if(not(RoundNumber >= 8))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Func001Func009C takes nothing returns boolean
    if(not Trig_Add_Unit_Power_Func001Func009Func002C())then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Func001C takes nothing returns boolean
    if(not(GameModeShort==true))then
        return false
    endif
    return true
endfunction

function Trig_Add_Unit_Power_Actions takes nothing returns nothing
    local unit u = GetLastCreatedUnit()
    if(Trig_Add_Unit_Power_Func001C())then
        if(Trig_Add_Unit_Power_Func001Func002C())then
            set RoundCreepPower =(I2R((RoundNumber * 1))/(I2R(RoundCreepNumber)/ 2.00))
            if(Trig_Add_Unit_Power_Func001Func002Func003001())then
                set RoundCreepPower =(RoundCreepPower / 1.50)
            else
                call DoNothing()
            endif
        else
            if(Trig_Add_Unit_Power_Func001Func002Func001C())then
                set RoundCreepPower =((I2R(RoundNumber)* 1.25)/(I2R(RoundCreepNumber)/ 2.00))
                if(Trig_Add_Unit_Power_Func001Func002Func001Func004001())then
                    set RoundCreepPower =(RoundCreepPower / 1.50)
                else
                    call DoNothing()
                endif
            else
                if(Trig_Add_Unit_Power_Func001Func002Func001Func001C())then
                    set RoundCreepPower =((I2R(RoundNumber)* 1.75)/(I2R(RoundCreepNumber)/ 2.00))
                    if(Trig_Add_Unit_Power_Func001Func002Func001Func001Func004001())then
                        set RoundCreepPower =(RoundCreepPower / 1.50)
                    else
                        call DoNothing()
                    endif
                else
                    if(Trig_Add_Unit_Power_Func001Func002Func001Func001Func002C())then
                        set RoundCreepPower =((I2R(RoundNumber)* 2.50)/(I2R(RoundCreepNumber)/ 2.00))
                        if(Trig_Add_Unit_Power_Func001Func002Func001Func001Func002Func002001())then
                            set RoundCreepPower =(RoundCreepPower / 1.50)
                        else
                            call DoNothing()
                        endif
                    else
                        if(Trig_Add_Unit_Power_Func001Func002Func001Func001Func002Func003C())then
                            set RoundCreepPower =(I2R((RoundNumber * 4))/(I2R(RoundCreepNumber)/ 2.00))
                            if(Trig_Add_Unit_Power_Func001Func002Func001Func001Func002Func003Func003001())then
                                set RoundCreepPower =(RoundCreepPower / 1.50)
                            else
                                call DoNothing()
                            endif
                        else
                            set RoundCreepPower =(I2R(((RoundNumber * RoundNumber)/ 2))/(I2R(RoundCreepNumber)/ 2.00))
                        endif
                    endif
                endif
            endif
        endif
        if(Trig_Add_Unit_Power_Func001Func009C())then
            set bj_forLoopBIndex = 1
            set bj_forLoopBIndexEnd = R2I(RoundCreepPower)
            loop
                exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
                call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 50)
                if(Trig_Add_Unit_Power_Func001Func009Func003Func002C())then
                    call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 50)
                else
                endif
                if(Trig_Add_Unit_Power_Func001Func009Func003Func003C())then
                    call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 50)
                else
                endif
                set bj_forLoopBIndex = bj_forLoopBIndex + 1
            endloop
        else
            if(Trig_Add_Unit_Power_Func001Func009Func001C())then
                set bj_forLoopBIndex = 1
                set bj_forLoopBIndexEnd =(R2I(RoundCreepPower)/ 4)
                loop
                    exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
                    call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 600)
                    set bj_forLoopBIndex = bj_forLoopBIndex + 1
                endloop
            else
                if(Trig_Add_Unit_Power_Func001Func009Func001Func001C())then
                    set bj_forLoopBIndex = 1
                    set bj_forLoopBIndexEnd =(R2I(RoundCreepPower)/ 8)
                    loop
                        exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 1200)
                        set bj_forLoopBIndex = bj_forLoopBIndex + 1
                    endloop
                else
                    if(Trig_Add_Unit_Power_Func001Func009Func001Func001Func001C())then
                        set bj_forLoopBIndex = 1
                        set bj_forLoopBIndexEnd =(R2I(RoundCreepPower)/ 8)
                        loop
                            exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
                            call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 1200)
                            set bj_forLoopBIndex = bj_forLoopBIndex + 1
                        endloop
                    else
                    endif
                endif
            endif
        endif
    else
        if(Trig_Add_Unit_Power_Func001Func004C())then
            set RoundCreepPower =((I2R(RoundNumber)* 1.75)/(I2R(RoundCreepNumber)/ 2.00))
            if(Trig_Add_Unit_Power_Func001Func004Func004001())then
                set RoundCreepPower =(RoundCreepPower / 1.50)
            else
                call DoNothing()
            endif
        else
            if(Trig_Add_Unit_Power_Func001Func004Func002C())then
                set RoundCreepPower =((I2R(RoundNumber)* 2.50)/(I2R(RoundCreepNumber)/ 2.00))
                if(Trig_Add_Unit_Power_Func001Func004Func002Func002001())then
                    set RoundCreepPower =(RoundCreepPower / 1.50)
                else
                    call DoNothing()
                endif
            else
                if(Trig_Add_Unit_Power_Func001Func004Func002Func003C())then
                    set RoundCreepPower =((I2R(RoundNumber)* 4.00)/(I2R(RoundCreepNumber)/ 2.00))
                    if(Trig_Add_Unit_Power_Func001Func004Func002Func003Func003001())then
                        set RoundCreepPower =(RoundCreepPower / 1.50)
                    else
                        call DoNothing()
                    endif
                else
                    set RoundCreepPower =(I2R(((RoundNumber * RoundNumber)/ 10))/(I2R(RoundCreepNumber)/ 2.00))
                endif
            endif
        endif
        if(Trig_Add_Unit_Power_Func001Func006C())then
            set bj_forLoopBIndex = 1
            set bj_forLoopBIndexEnd = R2I(RoundCreepPower)
            loop
                exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
                call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 50)
                if(Trig_Add_Unit_Power_Func001Func006Func003Func002C())then
                    call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 50)
                else
                endif
                if(Trig_Add_Unit_Power_Func001Func006Func003Func003C())then
                    call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 50)
                else
                endif
                set bj_forLoopBIndex = bj_forLoopBIndex + 1
            endloop
        else
            if(Trig_Add_Unit_Power_Func001Func006Func001C())then
                set bj_forLoopBIndex = 1
                set bj_forLoopBIndexEnd =(R2I(RoundCreepPower)/ 4)
                loop
                    exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
                    call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 600)
                    set bj_forLoopBIndex = bj_forLoopBIndex + 1
                endloop
            else
                if(Trig_Add_Unit_Power_Func001Func006Func001Func001C())then
                    set bj_forLoopBIndex = 1
                    set bj_forLoopBIndexEnd =(R2I(RoundCreepPower)/ 8)
                    loop
                        exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 1200)
                        set bj_forLoopBIndex = bj_forLoopBIndex + 1
                    endloop
                else
                    if(Trig_Add_Unit_Power_Func001Func006Func001Func001Func001C())then
                        set bj_forLoopBIndex = 1
                        set bj_forLoopBIndexEnd =(R2I(RoundCreepPower)/ 8)
                        loop
                            exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
                            call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 1200)
                            set bj_forLoopBIndex = bj_forLoopBIndex + 1
                        endloop
                    else
                    endif
                endif
            endif
        endif
    endif
    call SetUnitState(u, UNIT_STATE_LIFE, GetUnitState(u, UNIT_STATE_MAX_LIFE))
    set u = null
endfunction

function Trig_Creep_AutoCast_Func001001002 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_Creep_AutoCast_Func001Func001Func002Func001C takes nothing returns boolean
    if(not(GameModeShort==true))then
        return false
    endif
    return true
endfunction

function Trig_Creep_AutoCast_Func001Func001Func002Func002003001003001001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_Creep_AutoCast_Func001Func001Func002Func002003001003001002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_MAGIC_IMMUNE)!=true)
endfunction

function Trig_Creep_AutoCast_Func001Func001Func002Func002003001003001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func001Func002Func002003001003001001(),Trig_Creep_AutoCast_Func001Func001Func002Func002003001003001002())
endfunction

function Trig_Creep_AutoCast_Func001Func001Func002Func002003001003002001 takes nothing returns boolean
    return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetEnumUnit()))==true)
endfunction

function Trig_Creep_AutoCast_Func001Func001Func002Func002003001003002002 takes nothing returns boolean
    return(GetUnitStateSwap(UNIT_STATE_MANA,GetFilterUnit())>= 10.00)
endfunction

function Trig_Creep_AutoCast_Func001Func001Func002Func002003001003002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func001Func002Func002003001003002001(),Trig_Creep_AutoCast_Func001Func001Func002Func002003001003002002())
endfunction

function Trig_Creep_AutoCast_Func001Func001Func002Func002003001003 takes nothing returns boolean
    return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func001Func002Func002003001003001(),Trig_Creep_AutoCast_Func001Func001Func002Func002003001003002())
endfunction

function Trig_Creep_AutoCast_Func001Func001Func002C takes nothing returns boolean
    if(not(RoundCreepAbilCastChance==1))then
        return false
    endif
    return true
endfunction

function Trig_Creep_AutoCast_Func001Func001C takes nothing returns boolean
    if(not(GetUnitAbilityLevelSwapped('A00V',GetEnumUnit())> 0))then
        return false
    endif
    return true
endfunction

function Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003001001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003001002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_GROUND)==true)
endfunction

function Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003001001(),Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003001002())
endfunction

function Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003002001 takes nothing returns boolean
    return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetEnumUnit()))==true)
endfunction

function Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003002002001 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
endfunction

function Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003002002002 takes nothing returns boolean
    return(IsUnitVisible(GetFilterUnit(),GetOwningPlayer(GetEnumUnit()))==true)
endfunction

function Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003002002001(),Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003002002002())
endfunction

function Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003002001(),Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003002002())
endfunction

function Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003 takes nothing returns boolean
    return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003001(),Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003002())
endfunction

function Trig_Creep_AutoCast_Func001Func002Func002C takes nothing returns boolean
    if(not(RoundCreepAbilCastChance==1))then
        return false
    endif
    return true
endfunction

function Trig_Creep_AutoCast_Func001Func002C takes nothing returns boolean
    if(not(GetUnitAbilityLevelSwapped('A01A',GetEnumUnit())> 0))then
        return false
    endif
    return true
endfunction

function Trig_Creep_AutoCast_Func001Func003Func002Func001C takes nothing returns boolean
    if(not(GameModeShort==true))then
        return false
    endif
    return true
endfunction

function Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003001001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003001002001 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_MAGIC_IMMUNE)!=true)
endfunction

function Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003001002002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_GROUND)==true)
endfunction

function Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003001002001(),Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003001002002())
endfunction

function Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003001001(),Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003001002())
endfunction

function Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003002001 takes nothing returns boolean
    return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetEnumUnit()))==true)
endfunction

function Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003002002 takes nothing returns boolean
    return(IsUnitVisible(GetFilterUnit(),GetOwningPlayer(GetEnumUnit()))==true)
endfunction

function Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003002001(),Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003002002())
endfunction

function Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003 takes nothing returns boolean
    return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003001(),Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003002())
endfunction

function Trig_Creep_AutoCast_Func001Func003Func002C takes nothing returns boolean
    if(not(RoundCreepAbilCastChance==1))then
        return false
    endif
    return true
endfunction

function Trig_Creep_AutoCast_Func001Func003C takes nothing returns boolean
    if(not(GetUnitAbilityLevelSwapped('A00U',GetEnumUnit())> 0))then
        return false
    endif
    return true
endfunction

function Trig_Creep_AutoCast_Func001Func004Func002Func001C takes nothing returns boolean
    if(not(GameModeShort==true))then
        return false
    endif
    return true
endfunction

function Trig_Creep_AutoCast_Func001Func004Func002Func002003001003001001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_Creep_AutoCast_Func001Func004Func002Func002003001003001002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_MAGIC_IMMUNE)!=true)
endfunction

function Trig_Creep_AutoCast_Func001Func004Func002Func002003001003001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func004Func002Func002003001003001001(),Trig_Creep_AutoCast_Func001Func004Func002Func002003001003001002())
endfunction

function Trig_Creep_AutoCast_Func001Func004Func002Func002003001003002 takes nothing returns boolean
    return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetEnumUnit()))==true)
endfunction

function Trig_Creep_AutoCast_Func001Func004Func002Func002003001003 takes nothing returns boolean
    return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func004Func002Func002003001003001(),Trig_Creep_AutoCast_Func001Func004Func002Func002003001003002())
endfunction

function Trig_Creep_AutoCast_Func001Func004Func002C takes nothing returns boolean
    if(not(RoundCreepAbilCastChance==1))then
        return false
    endif
    return true
endfunction

function Trig_Creep_AutoCast_Func001Func004C takes nothing returns boolean
    if(not(GetUnitAbilityLevelSwapped('A00W',GetEnumUnit())> 0))then
        return false
    endif
    return true
endfunction

function Trig_Creep_AutoCast_Func001Func005Func002Func001C takes nothing returns boolean
    if(not(GameModeShort==true))then
        return false
    endif
    return true
endfunction

function Trig_Creep_AutoCast_Func001Func005Func002Func002003001003001001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_Creep_AutoCast_Func001Func005Func002Func002003001003001002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_MAGIC_IMMUNE)!=true)
endfunction

function Trig_Creep_AutoCast_Func001Func005Func002Func002003001003001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func005Func002Func002003001003001001(),Trig_Creep_AutoCast_Func001Func005Func002Func002003001003001002())
endfunction

function Trig_Creep_AutoCast_Func001Func005Func002Func002003001003002001 takes nothing returns boolean
    return(IsUnitAlly(GetFilterUnit(),GetOwningPlayer(GetEnumUnit()))==true)
endfunction

function Trig_Creep_AutoCast_Func001Func005Func002Func002003001003002002 takes nothing returns boolean
    return(GetUnitLifePercent(GetFilterUnit())<= 75.00)
endfunction

function Trig_Creep_AutoCast_Func001Func005Func002Func002003001003002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func005Func002Func002003001003002001(),Trig_Creep_AutoCast_Func001Func005Func002Func002003001003002002())
endfunction

function Trig_Creep_AutoCast_Func001Func005Func002Func002003001003 takes nothing returns boolean
    return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func005Func002Func002003001003001(),Trig_Creep_AutoCast_Func001Func005Func002Func002003001003002())
endfunction

function Trig_Creep_AutoCast_Func001Func005Func002C takes nothing returns boolean
    if(not(RoundCreepAbilCastChance==1))then
        return false
    endif
    return true
endfunction

function Trig_Creep_AutoCast_Func001Func005C takes nothing returns boolean
    if(not(GetUnitAbilityLevelSwapped('A00X',GetEnumUnit())> 0))then
        return false
    endif
    return true
endfunction

function Trig_Creep_AutoCast_Func001Func006Func002Func001003001003001001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_Creep_AutoCast_Func001Func006Func002Func001003001003001002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_MAGIC_IMMUNE)!=true)
endfunction

function Trig_Creep_AutoCast_Func001Func006Func002Func001003001003001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func006Func002Func001003001003001001(),Trig_Creep_AutoCast_Func001Func006Func002Func001003001003001002())
endfunction

function Trig_Creep_AutoCast_Func001Func006Func002Func001003001003002 takes nothing returns boolean
    return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetEnumUnit()))==true)
endfunction

function Trig_Creep_AutoCast_Func001Func006Func002Func001003001003 takes nothing returns boolean
    return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func006Func002Func001003001003001(),Trig_Creep_AutoCast_Func001Func006Func002Func001003001003002())
endfunction

function Trig_Creep_AutoCast_Func001Func006Func002C takes nothing returns boolean
    if(not(RoundCreepAbilCastChance==1))then
        return false
    endif
    return true
endfunction

function Trig_Creep_AutoCast_Func001Func006C takes nothing returns boolean
    if(not(GetUnitAbilityLevelSwapped('A013',GetEnumUnit())> 0))then
        return false
    endif
    return true
endfunction

function Trig_Creep_AutoCast_Func001Func007Func002Func001Func001Func002001001003001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_Creep_AutoCast_Func001Func007Func002Func001Func001Func002001001003002 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())==GetOwningPlayer(GetEnumUnit()))
endfunction

function Trig_Creep_AutoCast_Func001Func007Func002Func001Func001Func002001001003 takes nothing returns boolean
    return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func007Func002Func001Func001Func002001001003001(),Trig_Creep_AutoCast_Func001Func007Func002Func001Func001Func002001001003002())
endfunction

function Trig_Creep_AutoCast_Func001Func007Func002Func001Func001C takes nothing returns boolean
    if(not(UnitHasBuffBJ(GetEnumUnit(),'BOvd')!=true))then
        return false
    endif
    if(not(CountUnitsInGroup(GetUnitsInRangeOfLocMatching(800.00,GetUnitLoc(GetEnumUnit()),Condition(function Trig_Creep_AutoCast_Func001Func007Func002Func001Func001Func002001001003)))> 1))then
        return false
    endif
    return true
endfunction

function Trig_Creep_AutoCast_Func001Func007Func002Func001C takes nothing returns boolean
    if(not Trig_Creep_AutoCast_Func001Func007Func002Func001Func001C())then
        return false
    endif
    return true
endfunction

function Trig_Creep_AutoCast_Func001Func007Func002C takes nothing returns boolean
    if(not(RoundCreepAbilCastChance==1))then
        return false
    endif
    return true
endfunction

function Trig_Creep_AutoCast_Func001Func007C takes nothing returns boolean
    if(not(GetUnitAbilityLevelSwapped('A018',GetEnumUnit())> 0))then
        return false
    endif
    return true
endfunction

function Trig_Creep_AutoCast_Func001Func008Func002Func001C takes nothing returns boolean
    if(not(GameModeShort==true))then
        return false
    endif
    return true
endfunction

function Trig_Creep_AutoCast_Func001Func008Func002Func002003001003001001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_Creep_AutoCast_Func001Func008Func002Func002003001003001002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_MAGIC_IMMUNE)!=true)
endfunction

function Trig_Creep_AutoCast_Func001Func008Func002Func002003001003001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func008Func002Func002003001003001001(),Trig_Creep_AutoCast_Func001Func008Func002Func002003001003001002())
endfunction

function Trig_Creep_AutoCast_Func001Func008Func002Func002003001003002 takes nothing returns boolean
    return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetEnumUnit()))==true)
endfunction

function Trig_Creep_AutoCast_Func001Func008Func002Func002003001003 takes nothing returns boolean
    return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func008Func002Func002003001003001(),Trig_Creep_AutoCast_Func001Func008Func002Func002003001003002())
endfunction

function Trig_Creep_AutoCast_Func001Func008Func002C takes nothing returns boolean
    if(not(RoundCreepAbilCastChance==1))then
        return false
    endif
    return true
endfunction

function Trig_Creep_AutoCast_Func001Func008C takes nothing returns boolean
    if(not(GetUnitAbilityLevelSwapped('A016',GetEnumUnit())> 0))then
        return false
    endif
    return true
endfunction

function Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003001001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003001002001 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_MAGIC_IMMUNE)!=true)
endfunction

function Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003001002002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_GROUND)==true)
endfunction

function Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003001002001(),Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003001002002())
endfunction

function Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003001001(),Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003001002())
endfunction

function Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003002001 takes nothing returns boolean
    return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetEnumUnit()))==true)
endfunction

function Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003002002 takes nothing returns boolean
    return(IsUnitVisible(GetFilterUnit(),GetOwningPlayer(GetEnumUnit()))==true)
endfunction

function Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003002001(),Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003002002())
endfunction

function Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003 takes nothing returns boolean
    return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003001(),Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003002())
endfunction

function Trig_Creep_AutoCast_Func001Func009Func002Func001Func002C takes nothing returns boolean
    if(not(GameModeShort==true))then
        return false
    endif
    return true
endfunction

function Trig_Creep_AutoCast_Func001Func009Func002Func001C takes nothing returns boolean
    if(not(CountUnitsInGroup(GetUnitsInRangeOfLocMatching(250.00,GetUnitLoc(GetEnumUnit()),Condition(function Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003)))>= 1))then
        return false
    endif
    return true
endfunction

function Trig_Creep_AutoCast_Func001Func009Func002C takes nothing returns boolean
    if(not(RoundCreepAbilCastChance==1))then
        return false
    endif
    return true
endfunction

function Trig_Creep_AutoCast_Func001Func009C takes nothing returns boolean
    if(not(GetUnitAbilityLevelSwapped('A01B',GetEnumUnit())> 0))then
        return false
    endif
    return true
endfunction

function Trig_Creep_AutoCast_Func001A takes nothing returns nothing

    if (IsUnitAliveBJ(GetEnumUnit())==true) then

        if(Trig_Creep_AutoCast_Func001Func001C())then
            set RoundCreepAbilCastChance = GetRandomInt(1,5)
            if(Trig_Creep_AutoCast_Func001Func001Func002C())then
                if(Trig_Creep_AutoCast_Func001Func001Func002Func001C())then
                    call SetUnitAbilityLevelSwapped('A00V',GetEnumUnit(),((RoundNumber * 4)/ RoundCreepNumber))
                else
                    call SetUnitAbilityLevelSwapped('A00V',GetEnumUnit(),(((RoundNumber * 4)/ RoundCreepNumber)/ 2))
                endif
                call IssueTargetOrderBJ(GetEnumUnit(),"manaburn",GroupPickRandomUnit(GetUnitsInRangeOfLocMatching(300.00,GetUnitLoc(GetEnumUnit()),Condition(function Trig_Creep_AutoCast_Func001Func001Func002Func002003001003))))
            else
            endif
        else
        endif
        if(Trig_Creep_AutoCast_Func001Func002C())then
            set RoundCreepAbilCastChance = GetRandomInt(1,5)
            if(Trig_Creep_AutoCast_Func001Func002Func002C())then
                call IssuePointOrderLocBJ(GetEnumUnit(),"blink",OffsetLocation(GetUnitLoc(GroupPickRandomUnit(GetUnitsInRangeOfLocMatching(800.00,GetUnitLoc(GetEnumUnit()),Condition(function Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003)))),GetRandomReal(- 100.00,100.00),GetRandomReal(- 100.00,100.00)))
            else
            endif
        else
        endif
        if(Trig_Creep_AutoCast_Func001Func003C())then
            set RoundCreepAbilCastChance = GetRandomInt(1,5)
            if(Trig_Creep_AutoCast_Func001Func003Func002C())then
                if(Trig_Creep_AutoCast_Func001Func003Func002Func001C())then
                    call SetUnitAbilityLevelSwapped('A00U',GetEnumUnit(),((RoundNumber * 4)/ RoundCreepNumber))
                else
                    call SetUnitAbilityLevelSwapped('A00U',GetEnumUnit(),(((RoundNumber * 4)/ RoundCreepNumber)/ 2))
                endif
                call IssuePointOrderLocBJ(GetEnumUnit(),"shockwave",GetUnitLoc(GroupPickRandomUnit(GetUnitsInRangeOfLocMatching(800.00,GetUnitLoc(GetEnumUnit()),Condition(function Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003)))))
            else
            endif
        else
        endif
        if(Trig_Creep_AutoCast_Func001Func004C())then
            set RoundCreepAbilCastChance = GetRandomInt(1,5)
            if(Trig_Creep_AutoCast_Func001Func004Func002C())then
                if(Trig_Creep_AutoCast_Func001Func004Func002Func001C())then
                    call SetUnitAbilityLevelSwapped('A00W',GetEnumUnit(),((RoundNumber * 4)/ RoundCreepNumber))
                else
                    call SetUnitAbilityLevelSwapped('A00W',GetEnumUnit(),(((RoundNumber * 4)/ RoundCreepNumber)/ 2))
                endif
                call IssueTargetOrderBJ(GetEnumUnit(),"creepthunderbolt",GroupPickRandomUnit(GetUnitsInRangeOfLocMatching(800.00,GetUnitLoc(GetEnumUnit()),Condition(function Trig_Creep_AutoCast_Func001Func004Func002Func002003001003))))
            else
            endif
        else
        endif
        if(Trig_Creep_AutoCast_Func001Func005C())then
            set RoundCreepAbilCastChance = GetRandomInt(1,5)
            if(Trig_Creep_AutoCast_Func001Func005Func002C())then
                if(Trig_Creep_AutoCast_Func001Func005Func002Func001C())then
                    call SetUnitAbilityLevelSwapped('A00X',GetEnumUnit(),((RoundNumber * 4)/ RoundCreepNumber))
                else
                    call SetUnitAbilityLevelSwapped('A00X',GetEnumUnit(),(((RoundNumber * 4)/ RoundCreepNumber)/ 2))
                endif
                call IssueTargetOrderBJ(GetEnumUnit(),"rejuvination",GroupPickRandomUnit(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetEnumUnit()),Condition(function Trig_Creep_AutoCast_Func001Func005Func002Func002003001003))))
            else
            endif
        else
        endif
        if(Trig_Creep_AutoCast_Func001Func006C())then
            set RoundCreepAbilCastChance = GetRandomInt(1,5)
            if(Trig_Creep_AutoCast_Func001Func006Func002C())then
                call IssueTargetOrderBJ(GetEnumUnit(),"slow",GroupPickRandomUnit(GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetEnumUnit()),Condition(function Trig_Creep_AutoCast_Func001Func006Func002Func001003001003))))
            else
            endif
        else
        endif
        if(Trig_Creep_AutoCast_Func001Func007C())then
            set RoundCreepAbilCastChance = GetRandomInt(1,5)
            if(Trig_Creep_AutoCast_Func001Func007Func002C())then
                if(Trig_Creep_AutoCast_Func001Func007Func002Func001C())then
                    call IssueImmediateOrderBJ(GetEnumUnit(),"voodoo")
                else
                endif
            else
            endif
        else
        endif
        if(Trig_Creep_AutoCast_Func001Func008C())then
            set RoundCreepAbilCastChance = GetRandomInt(1,5)
            if(Trig_Creep_AutoCast_Func001Func008Func002C())then
                if(Trig_Creep_AutoCast_Func001Func008Func002Func001C())then
                    call SetUnitAbilityLevelSwapped('A016',GetEnumUnit(),((RoundNumber * 4)/ RoundCreepNumber))
                else
                    call SetUnitAbilityLevelSwapped('A016',GetEnumUnit(),(((RoundNumber * 4)/ RoundCreepNumber)/ 2))
                endif
                call IssueTargetOrderBJ(GetEnumUnit(),"faeriefire",GroupPickRandomUnit(GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetEnumUnit()),Condition(function Trig_Creep_AutoCast_Func001Func008Func002Func002003001003))))
            else
            endif
        else
        endif
        if(Trig_Creep_AutoCast_Func001Func009C())then
            set RoundCreepAbilCastChance = GetRandomInt(1,5)
            if(Trig_Creep_AutoCast_Func001Func009Func002C())then
                if(Trig_Creep_AutoCast_Func001Func009Func002Func001C())then
                    if(Trig_Creep_AutoCast_Func001Func009Func002Func001Func002C())then
                        call SetUnitAbilityLevelSwapped('A01B',GetEnumUnit(),((RoundNumber * 4)/ RoundCreepNumber))
                    else
                        call SetUnitAbilityLevelSwapped('A01B',GetEnumUnit(),(((RoundNumber * 4)/ RoundCreepNumber)/ 2))
                    endif
                    call IssueImmediateOrderBJ(GetEnumUnit(),"thunderclap")
                else
                endif
            else
            endif
        else
        endif
    endif
endfunction

function Trig_Creep_AutoCast_Actions takes nothing returns nothing
    local group GRP = GetUnitsOfPlayerMatching(Player(11),null)
    call ForGroupBJ(GRP,function Trig_Creep_AutoCast_Func001A)
    call DestroyGroup(GRP)
    set GRP = null
endfunction

function Trig_Creep_Dies_Conditions takes nothing returns boolean
    if(not(GetOwningPlayer(GetTriggerUnit())==Player(11)))then
        return false
    endif
    if(not(GetOwningPlayer(GetKillingUnitBJ())!=Player(11)))then
        return false
    endif
    if(not(GetKillingUnitBJ()!=null))then
        return false
    endif
    return true
endfunction

/*
function Trig_Creep_Dies_Func003Func005001001002001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_Creep_Dies_Func003Func005001001002002 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())==Player(11))
endfunction

function Trig_Creep_Dies_Func003Func005001001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Creep_Dies_Func003Func005001001002001(),Trig_Creep_Dies_Func003Func005001001002002())
endfunction

function Trig_Creep_Dies_Func003C takes nothing returns boolean
    if(not(CountUnitsInGroup(GetUnitsInRectMatching(PlayerArenaRects[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))],Condition(function Trig_Creep_Dies_Func003Func005001001002)))==0))then
        return false
    endif
    return true
endfunction
*/
function Trig_Creep_Dies_Actions takes nothing returns nothing
    call CreepDeath_Death(GetTriggerUnit(), PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnit()))])
    call TriggerSleepAction(0.00)
    call SetUnitOwner(GetTriggerUnit(),Player(PLAYER_NEUTRAL_PASSIVE),false)
endfunction

function Trig_Generate_Next_Level_Conditions takes nothing returns boolean
    if(not(IsTriggerEnabled(GetTriggeringTrigger())==true))then
        return false
    endif
    return true
endfunction

function Trig_Generate_Next_Level_Func011C takes nothing returns boolean
    if(not((RoundNumber + 1)> 5))then
        return false
    endif
    return true
endfunction

function Trig_Generate_Next_Level_Func012C takes nothing returns boolean
    if(not((RoundNumber + 1)> 1))then
        return false
    endif
    return true
endfunction

function Trig_Generate_Next_Level_Func014C takes nothing returns boolean
    if(not((RoundNumber + 1)<= 8))then
        return false
    endif
    return true
endfunction

function Trig_Generate_Next_Level_Func018A takes nothing returns nothing
    call DeleteUnit(GetEnumUnit())
endfunction

function Trig_Generate_Next_Level_Func021Func001Func001C takes nothing returns boolean
    if(not(GetPlayerSlotState(ConvertedPlayer(udg_integer40))!=PLAYER_SLOT_STATE_EMPTY))then
        return false
    endif
    if(not(IsPlayerInForce(ConvertedPlayer(udg_integer40),DefeatedPlayers)!=true))then
        return false
    endif
    return true
endfunction

function CheckUnitAbilities takes nothing returns nothing
    local string s = ""

    if RoundCreepChanceBash == 1 then
        set s = s + "Bash "
        call AddRoundAbility('ACbh')
    endif

    if RoundCreepChanceHurlBoulder == 1 then
        set s = s + "Hurl Boulder "
        call AddRoundAbility('A00W')
    endif

    if RoundCreepChanceRejuv == 1 then
        set s = s + "Rejuvenation "
        call AddRoundAbility('A00X')
    endif

    if RoundCreepChanceBigBadV == 1 then
        set s = s + "Big Bad Voodoo "
        call AddRoundAbility('A018')
    endif

    if RoundCreepChanceBlink == 1 then
        set s = s + "Blink "
        call AddRoundAbility('A01A')
    endif

    if RoundCreepChanceCritStrike == 1 then
        set s = s + "Critical Strike "
        call AddRoundAbility('AOcr')
    endif

    if RoundCreepChanceEvasion == 1 then
        set s = s + "Evasion "
    endif

    if RoundCreepChanceFaerieFire == 1 then
        set s = s + "Faerie Fire "
        call AddRoundAbility('A016')
    endif

    if RoundCreepChanceLifesteal == 1 then
        set s = s + "Lifesteal "
        call AddRoundAbility('SCva')
    endif

    if RoundCreepChanceManaBurn == 1 then
        set s = s + "Mana Burn "
        call AddRoundAbility('A00V')
    endif

    if RoundCreepChanceShockwave == 1 then
        set s = s + "Shockwave "
        call AddRoundAbility('A00U')
    endif

    if RoundCreepChanceSlow == 1 then
        set s = s + "Slow "
        call AddRoundAbility('A013')
    endif

    if RoundCreepChanceCleave == 1 then
        set s = s + "Cleave "
        call AddRoundAbility('ACce')
    endif

    if RoundCreepChanceThorns == 1 then
        set s = s + "Thorns Aura "
        call AddRoundAbility('A08F')
    endif

    if RoundCreepChanceThunderClap == 1 then
        set s = s + "Thunder Clap "
        call AddRoundAbility('A01B')
    endif

    if RoundCreepChanceReflectAura == 1 then
        set s = s + "Reflection Aura "
        call AddRoundAbility('A093')
    endif

    if RoundCreepChanceWizardbane == 1 then
        set s = s + "Wizardbane Aura  "
        call AddRoundAbility('A088')
    endif

    if RoundCreepChanceDrunkMaster == 1 then
        set s = s + "Drunken Master "
        call AddRoundAbility('Acdb')
    endif

    if RoundCreepChanceSlowAura == 1 then
        set s = s + "Slow Aura "
        call AddRoundAbility('AOr2')
    endif

    if RoundCreepChancePulverize == 1 then
        set s = s + "Pulverize "
        call AddRoundAbility('Awar')
    endif

    if RoundCreepChanceLastBreath == 1 then
        set s = s + "Last Breath "
        call AddRoundAbility('A05R')
    endif

    if FireshieldChance == 1 then
        set s = s + "Fire Shield "
        call AddRoundAbility('A05S')
    endif

    if RoundCreepChanceCorrosiveSkin == 1 then
        set s = s + "Corrosive Skin "
        call AddRoundAbility('A00Q')
    endif

    if RoundCreepChanceMulticast == 1 then
        set s = s + "Multicast "
        call AddRoundAbility('A04F')
    endif

    if RoundCreepChanceFastMagic == 1 then
        set s = s + "Fast Magic "
        call AddRoundAbility('A03P')
    endif

    if s == "" then
        set RoundAbilities = "|cff77fc94No abilities|r "
    else
        set RoundAbilities = "|cff77fc94" + s + "|r"
    endif
endfunction

function UnitAddNewAbilities takes unit u returns nothing
    if RoundCreepChanceCritStrike == 1 then
        call SetUnitAbilityLevel(u, 'AOcr', IMinBJ(R2I(RoundNumber * 0.2), 30))
    endif

    if RoundCreepChanceDrunkMaster == 1 then
        call UnitAddAbility(u, 'Acdb')
        call FuncEditParam('Acdb',u)
        call SetUnitAbilityLevel(u, 'Acdb', IMinBJ(R2I(RoundNumber * 0.3), 30))
    endif

    if RoundCreepChanceReflectAura == 1 then
        call UnitAddAbility(u, 'A093')
        call SetUnitAbilityLevel(u, 'A093', IMinBJ(R2I(RoundNumber * 0.4), 30))
    endif

    if RoundCreepChanceWizardbane == 1 then
        call UnitAddAbility(u, 'A088')
        call SetUnitAbilityLevel(u, 'A088', IMinBJ(R2I(RoundNumber * 0.4), 30))
    endif

    if RoundCreepChanceSlowAura == 1 then
        call UnitAddAbility(u, 'AOr2')
        call SetUnitAbilityLevel(u, 'AOr2', IMinBJ(R2I(RoundNumber * 0.75), 30))
    endif

    if RoundCreepChancePulverize == 1 then
        call UnitAddAbility(u, 'Awar')
        call SetUnitAbilityLevel(u, 'Awar', IMinBJ(R2I(RoundNumber * 0.4), 30))
    endif

    if RoundCreepChanceLastBreath == 1 then
        call UnitAddAbility(u, 'A05R')
        call FuncEditParam('A05R', u)
        call SetUnitAbilityLevel(u, 'A05R', IMinBJ(R2I(RoundNumber * 0.2), 30))
    endif

    if FireshieldChance == 1 then
        call UnitAddAbility(u, 'A05S')
        call SetUnitAbilityLevel(u, 'A05S', IMinBJ(R2I(RoundNumber * 0.3), 30))
    endif

    if RoundCreepChanceCorrosiveSkin == 1 then
        call UnitAddAbility(u, 'A00Q')
        call SetUnitAbilityLevel(u, 'A00Q', IMinBJ(R2I(RoundNumber * 0.6), 30))
    endif

    if RoundCreepChanceMulticast == 1 then
        call UnitAddAbility(u, 'A04F')
        call SetUnitAbilityLevel(u, 'A04F', IMinBJ(R2I(RoundNumber * 0.5), 30))
    endif

    if RoundCreepChanceFastMagic == 1 then
        call UnitAddAbility(u, 'A03P')
        call SetUnitAbilityLevel(u, 'A03P', IMinBJ(R2I(RoundNumber * 0.6), 30))
    endif
endfunction

//next round unit create

function Trig_Generate_Next_Level_Actions takes nothing returns nothing
    local integer newAbilChance = 50
    local integer oldAbilChance = 20
    local real magicPowerBonus = 0
    local real magicDefBonus = 0
    local real evasionBonus = 0
    local real blockBonus = 0
    local integer damageBonus = 0
    local string s = ""
    local integer temp = 0
    set RoundCreepInfo[0] = ""
    set RoundCreepInfo[1] = ""
    set RoundCreepInfo[2] = ""
    set RoundCreepInfo[3] = ""
    set RoundCreepInfo[4] = ""
    set RoundCreepInfo[5] = ""
    set RoundCreepInfo[6] = ""
    set RoundCreepInfo[7] = ""
    call DisableTrigger(GetTriggeringTrigger())
    call ConditionalTriggerExecute(udg_trigger104)
    call ResetRoundAbilities()
    if RoundNumber < 15 then
        set RoundCreepTypeId = CreepUnitTypeIds[GetRandomInt(1,MaxCreepUnitTypes - 2)]
    else
        set RoundCreepTypeId = CreepUnitTypeIds[GetRandomInt(1,MaxCreepUnitTypes)]
    endif
    set RoundCreepMoveSpeed = GetRandomInt(GetRandomInt(150, 150 + RoundNumber * 2),400)
    set RoundCreepMaxAttackSpeed = GetRandomInt(1,RoundNumber)
    
    if RoundNumber > 25 then
        set newAbilChance = 20
    endif
    if RoundNumber > 40 then
        set oldAbilChance = 15
    endif
    if RoundNumber > 5 then
        set RoundCreepChanceBash = GetRandomInt(1,20)
        set RoundCreepChanceHurlBoulder = GetRandomInt(1,20)
        set RoundCreepChanceRejuv = GetRandomInt(1,20)
        set RoundCreepChanceSlow = GetRandomInt(1,oldAbilChance)
        set RoundCreepChanceSlowAura = GetRandomInt(1,newAbilChance)
    endif
    if(Trig_Generate_Next_Level_Func012C())then
        set RoundCreepChanceBigBadV = GetRandomInt(1,oldAbilChance)
        set RoundCreepChanceBlink = GetRandomInt(1,oldAbilChance)
        if RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
            set RoundCreepChanceCritStrike = GetRandomInt(1,oldAbilChance)
            set RoundCreepChanceShockwave = GetRandomInt(1,oldAbilChance)
            if RoundNumber > 5 then
                set RoundCreepChanceThunderClap = GetRandomInt(1,oldAbilChance)    
            endif
        else
            set RoundCreepChanceCritStrike = 0
            set RoundCreepChanceShockwave = 0
            set RoundCreepChanceThunderClap = 0
        endif
        set RoundCreepChanceEvasion = GetRandomInt(1,oldAbilChance)
        set RoundCreepChanceFaerieFire = GetRandomInt(1,oldAbilChance)
        set RoundCreepChanceLifesteal = GetRandomInt(1,oldAbilChance)
        set RoundCreepChanceManaBurn = GetRandomInt(1,oldAbilChance)
        
        
        set RoundCreepChanceCleave = GetRandomInt(1,oldAbilChance)
        set RoundCreepChanceThorns = 0
        set RoundCreepChanceReflectAura = 0
        set RoundCreepChanceWizardbane = 0
        if GetRandomInt(1, oldAbilChance) == 1 then
            set temp = GetRandomInt(1,4)
            if temp == 1 then
                set RoundCreepChanceThorns = 1
            elseif temp == 2 then
                set RoundCreepChanceReflectAura = 1
            elseif temp == 3 then
                set RoundCreepChanceWizardbane = 1
            elseif RoundNumber > 20 then
                if RoundNumber > 40 then
                    set RoundCreepChanceThorns = GetRandomInt(1,2)
                    set RoundCreepChanceReflectAura = GetRandomInt(1,2)
                    set RoundCreepChanceWizardbane = GetRandomInt(1,2)
                else
                    set RoundCreepChanceThorns = GetRandomInt(1,3)
                    set RoundCreepChanceReflectAura = GetRandomInt(1,3)
                    set RoundCreepChanceWizardbane = GetRandomInt(1,3)
                endif
            endif
        endif
        
        
    endif
    if RoundNumber > 10 then
        if RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
            set RoundCreepChanceDrunkMaster = GetRandomInt(1,oldAbilChance)
            set RoundCreepChancePulverize = GetRandomInt(1,newAbilChance)
        endif
        set FireshieldChance = GetRandomInt(1,newAbilChance)
        set RoundCreepChanceCorrosiveSkin = GetRandomInt(1,newAbilChance)
    endif
    if RoundNumber >= 35 then
        set RoundCreepChanceMulticast = GetRandomInt(1,newAbilChance + 10)
        set RoundCreepChanceFastMagic = GetRandomInt(1,newAbilChance + 6)
    endif

    if RoundNumber == 28 or RoundNumber == 38 or RoundNumber == 48 then
        set RoundCreepChanceLastBreath = 1
    else  
        set RoundCreepChanceLastBreath = 2
    endif

    if(Trig_Generate_Next_Level_Func014C())then
        set RoundCreepNumber = GetRandomInt(2,(RoundNumber / 2 + 4))
    else
        set RoundCreepNumber = GetRandomInt(2,25)
    endif

    if RoundNumber > 0 then
        call CheckUnitAbilities()
    endif

    set NumberOfUnit[0] = 0 
    set NumberOfUnit[1] = 0 
    set NumberOfUnit[2] = 0 
    set NumberOfUnit[3] = 0 
    set NumberOfUnit[4] = 0 
    set NumberOfUnit[5] = 0 
    set NumberOfUnit[6] = 0
    set NumberOfUnit[7] = 0 
    set NumberOfUnit[8] = 0 

    set RoundNumber =(RoundNumber + 1)
    call ForGroupBJ(udg_group05,function Trig_Generate_Next_Level_Func018A)
    call GroupClear(udg_group05)
    set RoundGenCreepIndex = 1
    loop
        exitwhen RoundGenCreepIndex > RoundCreepNumber
        set udg_integer40 = 1
        if RoundGenCreepIndex > 4 then
            set RoundCreepChanceBigBadV = 2
        endif
        loop
            exitwhen udg_integer40 > 8
            if RoundNumber > 1 then
                set ShowCreepAbilButton[udg_integer40 - 1] = true
            endif
            
            //Creep upgrade bonuses
            if RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
                set magicPowerBonus = 1 *(BonusNeutral + BonusNeutralPlayer[udg_integer40 - 1])
                set damageBonus = ((BonusNeutral + BonusNeutralPlayer[udg_integer40 - 1] )* RoundNumber)
            else
                set magicPowerBonus = 0
            endif
            set magicDefBonus = 0.09 *(BonusNeutral + BonusNeutralPlayer[udg_integer40 - 1] )
            set evasionBonus = 0.06 *(BonusNeutral + BonusNeutralPlayer[udg_integer40 - 1] )
            set blockBonus = 0.12 *(BonusNeutral + BonusNeutralPlayer[udg_integer40 - 1] )
            if RoundNumber < 40 then
                set damageBonus = damageBonus / 2
            endif

            if(Trig_Generate_Next_Level_Func021Func001Func001C())then
                call CreateNUnitsAtLoc(1,RoundCreepTypeId,Player(11),OffsetLocation(GetRectCenter(PlayerArenaRects[udg_integer40]),GetRandomReal(- 600.00,600.00),GetRandomReal(- 600.00,600.00)),GetRandomDirectionDeg())
                call GroupAddUnitSimple(GetLastCreatedUnit(),udg_group05)
                //call UnitAddAbility(GetLastCreatedUnit(),'A057')
                //call BlzUnitDisableAbility(GetLastCreatedUnit(),'A057',false,true)
                set NumberOfUnit[udg_integer40 - 1] = NumberOfUnit[udg_integer40 - 1] + 1

                call BlzSetUnitBaseDamage(GetLastCreatedUnit(),BlzGetUnitBaseDamage(GetLastCreatedUnit(),0) + damageBonus,0)

                call AddUnitMagicDmg(GetLastCreatedUnit(), magicPowerBonus)
                call AddUnitMagicDef(GetLastCreatedUnit(), magicDefBonus)
                call AddUnitEvasion(GetLastCreatedUnit(), evasionBonus)	
                call AddUnitBlock(GetLastCreatedUnit(), blockBonus)			




                call AddUnitMagicDef(GetLastCreatedUnit(),0.25 *(RoundNumber))
                if RoundNumber < 3 then
                    call BlzSetUnitBaseDamage(GetLastCreatedUnit(),BlzGetUnitBaseDamage(GetLastCreatedUnit(),0)- 3,0)

                elseif RoundNumber < 8  then
                    call BlzSetUnitBaseDamage(GetLastCreatedUnit(),BlzGetUnitBaseDamage(GetLastCreatedUnit(),0)+ 1 * RoundNumber,0)
                    call BlzSetUnitMaxHP(GetLastCreatedUnit(), BlzGetUnitMaxHP(GetLastCreatedUnit())+ 3 * RoundNumber)
                    call SetWidgetLife(GetLastCreatedUnit(),BlzGetUnitMaxHP(GetLastCreatedUnit()) )
                elseif RoundNumber < 11  then
                    call BlzSetUnitArmor(GetLastCreatedUnit() , BlzGetUnitArmor(GetLastCreatedUnit()) + RoundNumber / 3) 
                    call BlzSetUnitBaseDamage(GetLastCreatedUnit(),BlzGetUnitBaseDamage(GetLastCreatedUnit(),0)+ 2 * RoundNumber,0)
                    call BlzSetUnitMaxHP(GetLastCreatedUnit(), BlzGetUnitMaxHP(GetLastCreatedUnit())+ 10 * RoundNumber)
                    call SetWidgetLife(GetLastCreatedUnit(),BlzGetUnitMaxHP(GetLastCreatedUnit()) ) 		
                elseif RoundNumber < 19  then
                    call BlzSetUnitArmor(GetLastCreatedUnit() , BlzGetUnitArmor(GetLastCreatedUnit()) + RoundNumber * 1) 
                    call BlzSetUnitBaseDamage(GetLastCreatedUnit(),BlzGetUnitBaseDamage(GetLastCreatedUnit(),0)+ 6 * RoundNumber,0)
                    call BlzSetUnitMaxHP(GetLastCreatedUnit(), BlzGetUnitMaxHP(GetLastCreatedUnit())+ 40 * RoundNumber)
                    call SetWidgetLife(GetLastCreatedUnit(),BlzGetUnitMaxHP(GetLastCreatedUnit()) )                	
                elseif RoundNumber < 24  then
                    call BlzSetUnitArmor(GetLastCreatedUnit() , BlzGetUnitArmor(GetLastCreatedUnit()) + RoundNumber * 3) 
                    call BlzSetUnitBaseDamage(GetLastCreatedUnit(),BlzGetUnitBaseDamage(GetLastCreatedUnit(),0)+ 14 * RoundNumber,0)
                    call BlzSetUnitMaxHP(GetLastCreatedUnit(), BlzGetUnitMaxHP(GetLastCreatedUnit())+ 45 * RoundNumber)
                    call SetWidgetLife(GetLastCreatedUnit(),BlzGetUnitMaxHP(GetLastCreatedUnit()) )		    

                elseif RoundNumber < 35  then
                    call BlzSetUnitArmor(GetLastCreatedUnit() , BlzGetUnitArmor(GetLastCreatedUnit()) + RoundNumber * 5) 
                    call BlzSetUnitBaseDamage(GetLastCreatedUnit(),BlzGetUnitBaseDamage(GetLastCreatedUnit(),0)+ 55 * RoundNumber,0)
                    call BlzSetUnitMaxHP(GetLastCreatedUnit(), BlzGetUnitMaxHP(GetLastCreatedUnit())+ 70 * RoundNumber)
                    call SetWidgetLife(GetLastCreatedUnit(),BlzGetUnitMaxHP(GetLastCreatedUnit()) )				    

                elseif RoundNumber < 41  then
                    call BlzSetUnitArmor(GetLastCreatedUnit() , BlzGetUnitArmor(GetLastCreatedUnit()) + RoundNumber * 12) 
                    call BlzSetUnitBaseDamage(GetLastCreatedUnit(),BlzGetUnitBaseDamage(GetLastCreatedUnit(),0)+ 200 * RoundNumber,0)
                    call BlzSetUnitMaxHP(GetLastCreatedUnit(), BlzGetUnitMaxHP(GetLastCreatedUnit())+ 150 * RoundNumber)
                    call SetWidgetLife(GetLastCreatedUnit(),BlzGetUnitMaxHP(GetLastCreatedUnit()) )				    
                elseif RoundNumber < 45  then
                    call BlzSetUnitArmor(GetLastCreatedUnit() , BlzGetUnitArmor(GetLastCreatedUnit()) + RoundNumber * 18) 
                    call BlzSetUnitBaseDamage(GetLastCreatedUnit(),BlzGetUnitBaseDamage(GetLastCreatedUnit(),0)+ 400 * RoundNumber,0)
                    call BlzSetUnitMaxHP(GetLastCreatedUnit(), BlzGetUnitMaxHP(GetLastCreatedUnit())+ 305 * RoundNumber)
                    call SetWidgetLife(GetLastCreatedUnit(),BlzGetUnitMaxHP(GetLastCreatedUnit()) )	
                elseif RoundNumber < 49  then

                    call BlzSetUnitArmor(GetLastCreatedUnit() , BlzGetUnitArmor(GetLastCreatedUnit()) + RoundNumber * 20) 
                    call BlzSetUnitBaseDamage(GetLastCreatedUnit(),BlzGetUnitBaseDamage(GetLastCreatedUnit(),0)+ 500 * RoundNumber,0)
                    call BlzSetUnitMaxHP(GetLastCreatedUnit(), BlzGetUnitMaxHP(GetLastCreatedUnit())+ 600 * RoundNumber)
                    call SetWidgetLife(GetLastCreatedUnit(),BlzGetUnitMaxHP(GetLastCreatedUnit()) )	                                 
                else
                    call BlzSetUnitArmor(GetLastCreatedUnit() , BlzGetUnitArmor(GetLastCreatedUnit()) + RoundNumber * 20) 
                    call BlzSetUnitBaseDamage(GetLastCreatedUnit(),BlzGetUnitBaseDamage(GetLastCreatedUnit(),0)+ 900 * RoundNumber,0)
                    call BlzSetUnitMaxHP(GetLastCreatedUnit(), BlzGetUnitMaxHP(GetLastCreatedUnit())+ 1500 * RoundNumber)
                    call SetWidgetLife(GetLastCreatedUnit(),BlzGetUnitMaxHP(GetLastCreatedUnit()) )	             			    
                endif




                call SetUnitScalePercent(GetLastCreatedUnit(),(85.00 +((I2R(RoundNumber)- 1.00)* 0.50)),100,100)
                call UnitAddNewAbilities(GetLastCreatedUnit())
                call ConditionalTriggerExecute(udg_trigger99)
                call ConditionalTriggerExecute(udg_trigger100)
                call SetUnitMoveSpeed(GetLastCreatedUnit(),I2R(RoundCreepMoveSpeed))
                call SetUnitAbilityLevelSwapped('A000',GetLastCreatedUnit(),(R2I(RoundCreepPower)/ 2))
                call SetUnitAbilityLevelSwapped('A002',GetLastCreatedUnit(),RoundCreepMaxAttackSpeed)
                call PauseUnitBJ(true,GetLastCreatedUnit())
                call SetUnitInvulnerable(GetLastCreatedUnit(),true)
                call ShowUnitHide(GetLastCreatedUnit())

                if SantaHatOn then
                    call UnitAddAbility(GetLastCreatedUnit(), 'A0B1')
                endif
                
                if RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
                    call BlzSetUnitBaseDamage(GetLastCreatedUnit(),R2I(BlzGetUnitBaseDamage(GetLastCreatedUnit(),0) * 0.5),0)
                endif

                //call BJDebugMsg("rci: " + I2S(udg_integer40 - 1))
                if RoundCreepInfo[udg_integer40 - 1] == "" then
                    //call BJDebugMsg("a")
                    set RoundCreepTitle = "|cffdd9bf1" + I2S(RoundCreepNumber) + " |r|cff77d2fc" + GetObjectName(RoundCreepTypeId) + "|r"
                    set s = RoundCreepTitle + ": "
                    set RoundCreepInfo[udg_integer40 - 1] = "|cfff19b9bHit points|r: " + I2S(BlzGetUnitMaxHP(GetLastCreatedUnit())) + "|n"
                    //call BJDebugMsg("b")
                    if IsUnitType(GetLastCreatedUnit(), UNIT_TYPE_MELEE_ATTACKER) then
                        set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cffebde71Range|r: Melee |n"
                    else
                        set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cff82f373Range|r: " + I2S(R2I(BlzGetUnitWeaponRealField(GetLastCreatedUnit(), UNIT_WEAPON_RF_ATTACK_RANGE, 0))) + "|n"
                        set s = s + "|cff82f373Ranged|r: "
                    endif
                    //call BJDebugMsg("c")
                    if RoundCreepTypeId == 'n01H' or RoundCreepTypeId == 'n00W' then
                        set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cff9bddf1Damage Type|r: magic |n"
                        set s = s + "|cff9bddf1Magic Damage|r: "
                    else
                        set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cfff167daDamage Type|r: physical |n"
                    endif
                    //call BJDebugMsg("d")
                    if BonusNeutral == 0 and BonusNeutralPlayer[udg_integer40 - 1] == 0 then
                        set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cfff19bb8Damage|r: " + I2S(BlzGetUnitBaseDamage(GetLastCreatedUnit(), 0) + BlzGetUnitDiceNumber(GetLastCreatedUnit(), 0) + BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(GetLastCreatedUnit(), 'A000'), ABILITY_ILF_ATTACK_BONUS, (R2I(RoundCreepPower)/ 2) - 1)) + " - " + I2S(BlzGetUnitBaseDamage(GetLastCreatedUnit(), 0) + (BlzGetUnitDiceNumber(GetLastCreatedUnit(), 0) * BlzGetUnitDiceSides(GetLastCreatedUnit(), 0) ) + BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(GetLastCreatedUnit(), 'A000'), ABILITY_ILF_ATTACK_BONUS, (R2I(RoundCreepPower)/ 2) - 1)) + "|n"
                        set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cff9babf1Armor|r: " + I2S(R2I(BlzGetUnitArmor(GetLastCreatedUnit()))) + "|n"
                        set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cff78729eBlock|r: " + I2S(R2I(GetUnitBlock(GetLastCreatedUnit()))) + "|n"
                        set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cff9bc7f1Magic power|r: " + I2S(R2I(GetUnitMagicDmg(GetLastCreatedUnit()))) + "|n"
                        set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cff9bf1a9Magic protection|r: " + I2S(R2I(GetUnitMagicDef(GetLastCreatedUnit()))) + "|n"
                        set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cfff1cc9bEvasion|r: " + I2S(R2I(GetUnitEvasion(GetLastCreatedUnit())))
                    else
                        set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cfff19bb8Damage|r: " + I2S(BlzGetUnitBaseDamage(GetLastCreatedUnit(), 0) + BlzGetUnitDiceNumber(GetLastCreatedUnit(), 0) + BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(GetLastCreatedUnit(), 'A000'), ABILITY_ILF_ATTACK_BONUS, (R2I(RoundCreepPower)/ 2) - 1) - damageBonus) + " - " + I2S(BlzGetUnitBaseDamage(GetLastCreatedUnit(), 0) + (BlzGetUnitDiceNumber(GetLastCreatedUnit(), 0) * BlzGetUnitDiceSides(GetLastCreatedUnit(), 0) + BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(GetLastCreatedUnit(), 'A000'), ABILITY_ILF_ATTACK_BONUS, (R2I(RoundCreepPower)/ 2) - 1) - damageBonus )) + " + |cfff19bb8" + I2S(R2I(damageBonus)) + "|r|n"
                        set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cff9babf1Armor|r: " + I2S(R2I(BlzGetUnitArmor(GetLastCreatedUnit()))) + "|n"
                        set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cff78729eBlock|r: " + I2S(R2I(GetUnitBlock(GetLastCreatedUnit()) - blockBonus)) + " + |cff78729e" + I2S(R2I(blockBonus)) + "|r|n"
                        set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cff9bc7f1Magic power|r: " + I2S(R2I(GetUnitMagicDmg(GetLastCreatedUnit()) - magicPowerBonus)) + "+ |cff9bc7f1" + I2S(R2I(magicPowerBonus)) + "|r|n"
                        set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cff9bf1a9Magic protection|r: " + I2S(R2I(GetUnitMagicDef(GetLastCreatedUnit()) - magicDefBonus)) + " + |cff9bf1a9" + I2S(R2I(magicDefBonus)) + "|r|n"
                        set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cfff1cc9bEvasion|r: " + I2S(R2I(GetUnitEvasion(GetLastCreatedUnit()) - evasionBonus)) + " + |cfff1cc9b" + I2S(R2I(evasionBonus)) + "|r"
                    endif
                    //call BJDebugMsg("e")
                    set s = s + RoundAbilities
                    call DisplayTimedTextToPlayer(Player(udg_integer40 - 1), 0, 0, 20, "Next: " + s)
                    //call BJDebugMsg("f")
                endif
                //call BJDebugMsg("rci finish: " + I2S(udg_integer40 - 1))
            else
            endif
            set udg_integer40 = udg_integer40 + 1
        endloop
        set RoundGenCreepIndex = RoundGenCreepIndex + 1
    endloop
endfunction

function Trig_Unit_Type_Actions takes nothing returns nothing
    set CreepUnitTypeIds[1]= 'n000'
    set CreepUnitTypeIds[2]= 'n002'
    set CreepUnitTypeIds[3]= 'n008'
    set CreepUnitTypeIds[4]= 'n009'
    set CreepUnitTypeIds[5]= 'n006'
    set CreepUnitTypeIds[6]= 'n00G'
    set CreepUnitTypeIds[7]= 'n00F'
    set CreepUnitTypeIds[8]= 'n00H'
    set CreepUnitTypeIds[9]= 'n00N'
    set CreepUnitTypeIds[10]= 'n007'
    set CreepUnitTypeIds[11]= 'n00X'
    set CreepUnitTypeIds[12]= 'n019'
    set CreepUnitTypeIds[13]= 'n01B'
    set CreepUnitTypeIds[14]= 'n01C'
    set CreepUnitTypeIds[15]= 'n01A'
    set CreepUnitTypeIds[16]= 'n018'
    set CreepUnitTypeIds[17]= 'n01F'
    set CreepUnitTypeIds[18]= 'n01K'
    set CreepUnitTypeIds[19]= 'n01J'
    set CreepUnitTypeIds[20]= 'n01I'
    set CreepUnitTypeIds[21]= 'n01G'
    set CreepUnitTypeIds[22]= 'n00W'
    set CreepUnitTypeIds[23]= 'n01H'
    set MaxCreepUnitTypes = 23
endfunction

function Trig_Bonus_Exp_Conditions takes nothing returns boolean
    if(not(GetOwningPlayer(GetTriggerUnit())==Player(11)))then
        return false
    endif
    if(not(IsUnitIllusionBJ(GetTriggerUnit())!=true))then
        return false
    endif
    return true
endfunction

function Trig_Bonus_Exp_Func001Func001001002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
endfunction

function Trig_Bonus_Exp_Func001Func001A takes nothing returns nothing
    local real bonus = 1
    if MagicNecklaceBonus.boolean[GetHandleId(GetTriggerUnit())] and UnitHasItemOfTypeBJ(GetEnumUnit(), 'I05G') then
        set bonus = MagicNecklaceBonus
    endif
    call AddHeroXPSwapped(R2I(((RoundCreepPower)* 35) * bonus),GetEnumUnit(),true)
endfunction

function Trig_Bonus_Exp_Func001Func002001002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
endfunction

function Trig_Bonus_Exp_Func001Func002A takes nothing returns nothing
    local real bonus = 1
    if MagicNecklaceBonus.boolean[GetHandleId(GetTriggerUnit())] and UnitHasItemOfTypeBJ(GetEnumUnit(), 'I05G') then
        set bonus = MagicNecklaceBonus
    endif
    call AddHeroXPSwapped(R2I(((RoundCreepPower)* 55) * bonus),GetEnumUnit(),true)
endfunction

function Trig_Bonus_Exp_Func001C takes nothing returns boolean
    if(not(GameModeShort==true))then
        return false
    endif
    return true
endfunction

function Trig_Bonus_Exp_Actions takes nothing returns nothing
    if(Trig_Bonus_Exp_Func001C())then
        call ForGroupBJ(GetUnitsOfPlayerMatching(GetOwningPlayer(GetKillingUnitBJ()),Condition(function Trig_Bonus_Exp_Func001Func002001002)),function Trig_Bonus_Exp_Func001Func002A)
    else
        call ForGroupBJ(GetUnitsOfPlayerMatching(GetOwningPlayer(GetKillingUnitBJ()),Condition(function Trig_Bonus_Exp_Func001Func001001002)),function Trig_Bonus_Exp_Func001Func001A)
    endif
endfunction

function Trig_Complete_Level_Move_Conditions takes nothing returns boolean
    if(not(IsUnitInGroup(GetTriggerUnit(),GroupEmptyArenaCheck)==true))then
        return false
    endif
    return true
endfunction

function Trig_Complete_Level_Move_Func003C takes nothing returns boolean
    if(not(IsPlayerInForce(ConvertedPlayer(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))),DefeatedPlayers)!=true))then
        return false
    endif
    return true
endfunction

function Trig_Complete_Level_Move_Func005Func001C takes nothing returns boolean
    if((ElimModeEnabled==true))then
        return true
    endif
    if((GameModeShort==true))then
        return true
    endif
    return false
endfunction

function Trig_Complete_Level_Move_Func005Func002Func001C takes nothing returns boolean
    if(not(RoundNumber < 8))then
        return false
    endif
    return true
endfunction

function Trig_Complete_Level_Move_Func005Func002C takes nothing returns boolean
    if(not(RoundNumber <= 1))then
        return false
    endif
    return true
endfunction

function Trig_Complete_Level_Move_Func005Func003Func001C takes nothing returns boolean
    if(not(RoundNumber < 4))then
        return false
    endif
    return true
endfunction

function Trig_Complete_Level_Move_Func005Func003C takes nothing returns boolean
    if(not(RoundNumber <= 1))then
        return false
    endif
    return true
endfunction

function Trig_Complete_Level_Move_Func005C takes nothing returns boolean
    if(not Trig_Complete_Level_Move_Func005Func001C())then
        return false
    endif
    return true
endfunction

function Trig_Complete_Level_Move_Actions takes nothing returns nothing
    local integer pid = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))

    if(Trig_Complete_Level_Move_Func003C())then
        call RemoveDebuff(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))], 0)
        call SetUnitPositionLoc(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetRectCenter(RectMidArena))
        call PanCameraToTimedLocForPlayer(ConvertedPlayer(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))),GetRectCenter(RectMidArena),0.20)
    endif
    if(Trig_Complete_Level_Move_Func005C())then
        if(Trig_Complete_Level_Move_Func005Func003C())then
            set LumberGained[pid] = 21 * RoundNumber
            call AdjustPlayerStateBJ((21 * RoundNumber),ConvertedPlayer(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))),PLAYER_STATE_RESOURCE_LUMBER)
            //call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 20, "|cff00aa0e+" + I2S(21*RoundNumber) + " lumber|r")
            call ResourseRefresh(ConvertedPlayer(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))) )
        else
            if(Trig_Complete_Level_Move_Func005Func003Func001C())then
                set LumberGained[pid] = 11 * RoundNumber
                call AdjustPlayerStateBJ((11 * RoundNumber),ConvertedPlayer(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))),PLAYER_STATE_RESOURCE_LUMBER)
                call ResourseRefresh(ConvertedPlayer(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))) )
            else
                set LumberGained[pid] = R2I((I2R(RoundNumber)/ 2.00))* 6
                call AdjustPlayerStateBJ((R2I((I2R(RoundNumber)/ 2.00))* 6),ConvertedPlayer(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))),PLAYER_STATE_RESOURCE_LUMBER)
                call ResourseRefresh(ConvertedPlayer(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))) )
            endif
        endif
    else
        if(Trig_Complete_Level_Move_Func005Func002C())then
            set LumberGained[pid] = 10 * RoundNumber
            call AdjustPlayerStateBJ((10 * RoundNumber),ConvertedPlayer(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))),PLAYER_STATE_RESOURCE_LUMBER)
            //call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 20, "|cff00aa0e+" + I2S(10*RoundNumber) + " lumber|r")
            call ResourseRefresh(ConvertedPlayer(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))) )
        else
            if(Trig_Complete_Level_Move_Func005Func002Func001C())then
                set LumberGained[pid] = 6 * RoundNumber
                call AdjustPlayerStateBJ((6 * RoundNumber),ConvertedPlayer(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))),PLAYER_STATE_RESOURCE_LUMBER)
                //call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 20, "|cff00aa0e+" + I2S(6*RoundNumber) + " lumber|r")
                call ResourseRefresh(ConvertedPlayer(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))) )
            else
                set LumberGained[pid] = R2I((I2R(RoundNumber)/ 4.00))* 6
                call AdjustPlayerStateBJ((R2I((I2R(RoundNumber)/ 4.00))* 6),ConvertedPlayer(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))),PLAYER_STATE_RESOURCE_LUMBER)
                //call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 20, "|cff00aa0e+" + I2S((R2I((I2R(RoundNumber)/4.00))*6)) + " lumber|r")
                call ResourseRefresh(ConvertedPlayer(GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))) )
            endif
        endif
    endif
    call DisplayTimedTextToPlayer(Player(pid), 0, 0, 10, ("|cffffcc00Level Completed!"))
    call Func_completeLevel(  PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] )
    call DeleteUnit(GetTriggerUnit())
    call ConditionalTriggerExecute(udg_trigger108)
endfunction

function Trig_Complete_Level_Player_Func006Func002001001002001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_Complete_Level_Player_Func006Func002001001002002 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())==Player(11))
endfunction

function Trig_Complete_Level_Player_Func006Func002001001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Complete_Level_Player_Func006Func002001001002001(),Trig_Complete_Level_Player_Func006Func002001001002002())
endfunction

function Trig_Complete_Level_Player_Func006C takes nothing returns boolean
    if(not(GetOwningPlayer(GetTriggerUnit())==Player(11)))then
        return false
    endif
    if(not(CountUnitsInGroup(GetUnitsInRectMatching(PlayerArenaRects[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))],Condition(function Trig_Complete_Level_Player_Func006Func002001001002)))==0))then
        return false
    endif
    if(not(IsPlayerInForce(GetOwningPlayer(GetKillingUnitBJ()),DefeatedPlayers)!=true))then
        return false
    endif
    if(not(IsPlayerInForce(GetOwningPlayer(GetKillingUnitBJ()),RoundPlayersCompleted)!=true))then
        return false
    endif
    if(not(GetOwningPlayer(GetKillingUnitBJ())!=Player(11)))then
        return false
    endif
    if(not(GetKillingUnitBJ()!=null))then
        return false
    endif
    return true
endfunction

function Trig_Complete_Level_Player_Conditions takes nothing returns boolean
    if(not Trig_Complete_Level_Player_Func006C())then
        return false
    endif
    return true
endfunction

function Trig_Complete_Level_Player_Func001001 takes nothing returns boolean
    return(RoundNumber==5)
endfunction

function Trig_Complete_Level_Player_Func004001 takes nothing returns boolean
    return(BettingPlayerCount > 3)
endfunction

function Trig_Complete_Level_Player_Func005Func004001 takes nothing returns boolean
    return(GameModeShort==false)
endfunction

function Trig_Complete_Level_Player_Func005C takes nothing returns boolean
    if(not(CountPlayersInForceBJ(RoundPlayersCompleted)< BettingPlayerCount))then
        return false
    endif
    //	if(not(GetUnitTypeId(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])!='N00K'))then
    //		return false
    //	endif
    return true
endfunction

function Trig_Complete_Level_Player_Func010C takes nothing returns boolean
    if(not(RoundClearXpBonus==0))then
        return false
    endif
    return true
endfunction

function RemoveNonHeroUnitFilter takes nothing returns boolean
    return UnitAlive(GetFilterUnit()) and GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') == 0 and (IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == false or IsUnitIllusion(GetFilterUnit())) and GetUnitTypeId(GetFilterUnit()) != DRAFT_BUY_UNIT_ID and GetUnitTypeId(GetFilterUnit()) != DRAFT_UPGRADE_UNIT_ID 
endfunction

function RemoveNonHeroUnits takes nothing returns nothing
    call DeleteUnit(GetEnumUnit())
endfunction

function Trig_Complete_Level_Player_Actions takes nothing returns nothing
    local player p = GetOwningPlayer(GetKillingUnit())
    local integer pid = GetPlayerId(p)

    if(Trig_Complete_Level_Player_Func001001())then
        set udg_boolean09 = false
    else
        call DoNothing()
    endif
    set BettingPlayerCount =(PlayerCount / 2)
    if(Trig_Complete_Level_Player_Func004001())then
        set BettingPlayerCount = 3
    else
        call DoNothing()
    endif
    if(Trig_Complete_Level_Player_Func005C())then
        set RoundClearXpBonus =((PlayerCount -(1 + CountPlayersInForceBJ(RoundPlayersCompleted)))*(RoundNumber * 5))
        set RoundClearXpBonus =(RoundClearXpBonus * RoundNumber)
        if(Trig_Complete_Level_Player_Func005Func004001())then
            set RoundClearXpBonus =(RoundClearXpBonus / 2)
        else
            call DoNothing()
        endif
    else
        set RoundClearXpBonus = 0
    endif
    call ForceAddPlayerSimple(p,RoundPlayersCompleted)
    call SetCurrentlyFighting(p, false)
    set RoundFinishedCount =(RoundFinishedCount + 1)
    call SetUnitInvulnerable(PlayerHeroes[pid + 1],true)
    if RoundLiveLost[pid] then
        set RoundLiveLost[pid] = false
        call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(p)+ " |cffff7300died and lost a life!|r |cffbe5ffd" + I2S(Lives[pid]) + " remaining.|r")))
    else
        if(Trig_Complete_Level_Player_Func010C())then
            call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(p)+ " |cffffcc00survived the level!|r")))
        else
            call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(p)+(" |cffffcc00survived the level!|r |cff7bff00(+" +(I2S(RoundClearXpBonus)+ " exp)|r")))))
            call AddHeroXPSwapped(RoundClearXpBonus,PlayerHeroes[pid + 1],true)
        endif
    endif
    call CreateNUnitsAtLoc(1,PRIEST_1_UNIT_ID,p,GetRectCenter(GetPlayableMapRect()),bj_UNIT_FACING)
    call UnitApplyTimedLifeBJ(2.00,'BTLF',GetLastCreatedUnit())
    call GroupAddUnitSimple(GetLastCreatedUnit(),GroupEmptyArenaCheck)
endfunction

function Trig_Level_Completed_Func001Func001001001 takes nothing returns boolean
    return(IsTriggerEnabled(udg_trigger119)!=true)
endfunction

function Trig_Level_Completed_Func001Func001001002001 takes nothing returns boolean
    return(udg_boolean11!=true)
endfunction

function Trig_Level_Completed_Func001Func001001002002001 takes nothing returns boolean
    return(IsTriggerEnabled(udg_trigger118)!=true)
endfunction

function Trig_Level_Completed_Func001Func001001002002002 takes nothing returns boolean
    return(InitialPlayerCount!=1)
endfunction

function Trig_Level_Completed_Func001Func001001002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Level_Completed_Func001Func001001002002001(),Trig_Level_Completed_Func001Func001001002002002())
endfunction

function Trig_Level_Completed_Func001Func001001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Level_Completed_Func001Func001001002001(),Trig_Level_Completed_Func001Func001001002002())
endfunction

function Trig_Level_Completed_Func001Func001001 takes nothing returns boolean
    return GetBooleanOr(Trig_Level_Completed_Func001Func001001001(),Trig_Level_Completed_Func001Func001001002())
endfunction

function Trig_Level_Completed_Func001Func014Func001Func001Func002C takes nothing returns boolean
    if((RoundNumber==5))then
        return true
    endif
    if((RoundNumber==10))then
        return true
    endif
    if((RoundNumber==15))then
        return true
    endif
    if((RoundNumber==20))then
        return true
    endif
    if((RoundNumber==25))then
        return true
    endif
    if((RoundNumber==30))then
        return true
    endif
    if((RoundNumber==35))then
        return true
    endif
    return false
endfunction

function Trig_Level_Completed_Func001Func014Func001Func001C takes nothing returns boolean
    if(not(PlayerCount > 1))then
        return false
    endif
    if(not Trig_Level_Completed_Func001Func014Func001Func001Func002C())then
        return false
    endif
    return true
endfunction

function Trig_Level_Completed_Func001Func014Func001C takes nothing returns boolean
    if(not Trig_Level_Completed_Func001Func014Func001Func001C())then
        return false
    endif
    return true
endfunction

function Trig_Level_Completed_Func001Func014C takes nothing returns boolean
    if(not(ElimModeEnabled==true))then
        return false
    endif
    return true
endfunction

function Trig_Level_Completed_Func001Func018Func001Func004Func001C takes nothing returns boolean

    if MorePvp == 0 then
        if((RoundNumber==10))then
            return true
        endif
        if((RoundNumber==20))then
            return true
        endif
        if((RoundNumber==30))then
            return true
        endif
        if((RoundNumber==40))then
            return true
        endif
    else

        if((RoundNumber==5))then
            return true
        endif
        if((RoundNumber==10))then
            return true
        endif
        if((RoundNumber==15))then
            return true
        endif
        if((RoundNumber==20))then
            return true
        endif
        if((RoundNumber==25))then
            return true
        endif
        if((RoundNumber==30))then
            return true
        endif	
        if((RoundNumber==35))then
            return true
        endif	
        if((RoundNumber==40))then
            return true
        endif	
        if((RoundNumber==45))then
            return true
        endif	


    endif


    return false
endfunction

function Trig_Level_Completed_Func001Func018Func001Func004C takes nothing returns boolean
    if(not Trig_Level_Completed_Func001Func018Func001Func004Func001C())then
        return false
    endif
    if(not(PlayerCount > 1))then
        return false
    endif
    if(not(ElimModeEnabled==false))then
        return false
    endif
    return true
endfunction

function Trig_Level_Completed_Func001Func018Func001C takes nothing returns boolean
    if(not Trig_Level_Completed_Func001Func018Func001Func004C())then
        return false
    endif
    return true
endfunction

function Trig_Level_Completed_Func001Func018Func002Func004Func001C takes nothing returns boolean
    if((RoundNumber==5))then
        return true
    endif
    if((RoundNumber==10))then
        return true
    endif
    if((RoundNumber==15))then
        return true
    endif
    if((RoundNumber==20))then
        return true
    endif
    return false
endfunction

function Trig_Level_Completed_Func001Func018Func002Func004C takes nothing returns boolean
    if(not Trig_Level_Completed_Func001Func018Func002Func004Func001C())then
        return false
    endif
    if(not(PlayerCount > 1))then
        return false
    endif
    if(not(ElimModeEnabled==false))then
        return false
    endif
    return true
endfunction

function Trig_Level_Completed_Func001Func018Func002C takes nothing returns boolean
    if(not Trig_Level_Completed_Func001Func018Func002Func004C())then
        return false
    endif
    return true
endfunction

function Trig_Level_Completed_Func001Func018C takes nothing returns boolean
    if(not(GameModeShort==true))then
        return false
    endif
    if(not(ElimModeEnabled==false))then
        return false
    endif
    return true
endfunction

function Trig_Level_Completed_Func001Func023Func001Func003C takes nothing returns boolean
    if(not(PlayerCount==1))then
        return false
    endif
    return true
endfunction

function Trig_Level_Completed_Func001Func023Func001C takes nothing returns boolean
    if(not(RoundNumber==50))then
        return false
    endif
    if(not(ElimModeEnabled==false))then
        return false
    endif
    return true
endfunction

function Trig_Level_Completed_Func001Func023Func002Func003C takes nothing returns boolean
    if(not(PlayerCount==1))then
        return false
    endif
    return true
endfunction

function Trig_Level_Completed_Func001Func023Func002C takes nothing returns boolean
    if(not(RoundNumber==25))then
        return false
    endif
    if(not(ElimModeEnabled==false))then
        return false
    endif
    return true
endfunction

function Trig_Level_Completed_Func001Func023C takes nothing returns boolean
    if(not(GameModeShort==true))then
        return false
    endif
    if(not(ElimModeEnabled==false))then
        return false
    endif
    return true
endfunction

function Trig_Level_Completed_Func001Func028C takes nothing returns boolean
    if(not(RoundNumber <= 3))then
        return false
    endif
    return true
endfunction

function Trig_Level_Completed_Func001C takes nothing returns boolean
    if(not(RoundFinishedCount >= PlayerCount))then
        return false
    endif
    return true
endfunction

//trigger108
function Trig_Level_Completed_Actions takes nothing returns nothing
    local integer round = RoundNumber + 1
    if(Trig_Level_Completed_Func001C())then
        if(Trig_Level_Completed_Func001Func001001())then
            return
        else
            call DoNothing()
        endif
        call DisableTrigger(udg_trigger110)
        call StopSuddenDeathTimer()
        call DisableTrigger(udg_trigger116)
        call ConditionalTriggerExecute(udg_trigger122)
        call ConditionalTriggerExecute(udg_trigger119)
        
        set RoundFinishedCount = 0
        call PlaySoundBJ(udg_sound02)
        if(Trig_Level_Completed_Func001Func014C())then
            if(Trig_Level_Completed_Func001Func014Func001C())then
                call ConditionalTriggerExecute(udg_trigger152)
                return
            endif
        endif
        if(Trig_Level_Completed_Func001Func018C())then
            if(Trig_Level_Completed_Func001Func018Func002C())then
                call GroupClear(DuelWinners)
                call ConditionalTriggerExecute(udg_trigger134)
                return
            endif
        else
            if(Trig_Level_Completed_Func001Func018Func001C())then
                call GroupClear(DuelWinners)
                call ConditionalTriggerExecute(udg_trigger134)
                return
            endif
        endif
        if(Trig_Level_Completed_Func001Func023C())then
            if(Trig_Level_Completed_Func001Func023Func002C())then
                if(Trig_Level_Completed_Func001Func023Func002Func003C())then
                    call ConditionalTriggerExecute(udg_trigger119)
                else
                    call ConditionalTriggerExecute(udg_trigger42)
                endif
                return
            endif
        else
            if(Trig_Level_Completed_Func001Func023Func001C())then
                if(Trig_Level_Completed_Func001Func023Func001Func003C())then
                    call ConditionalTriggerExecute(udg_trigger119)
                else
                    call ConditionalTriggerExecute(udg_trigger42)
                endif
                return
            endif
        endif
        call ConditionalTriggerExecute(udg_trigger103)
        call CreateTimerDialogBJ(GetLastCreatedTimerBJ(),"Next Level ...")
        set NextRound[round] = true
        if(Trig_Level_Completed_Func001Func028C())then
            call StartTimerBJ(GetLastCreatedTimerBJ(),false, RoundTime)
            call TriggerSleepAction(RoundTime)
        else
            call StartTimerBJ(GetLastCreatedTimerBJ(),false,RoundTime * 0.75)
            call TriggerSleepAction(RoundTime * 0.75)
        endif

        if NextRound[round] then
            call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
            call TriggerExecute(udg_trigger109)
        endif
    endif
endfunction

function Trig_Start_Level_Conditions takes nothing returns boolean
    if(not(udg_boolean09==false))then
        return false
    endif
    return true
endfunction

function Trig_Start_Level_Func003Func001C takes nothing returns boolean
    if(not(udg_boolean12==false))then
        return false
    endif
    if(not(RoundNumber==1))then
        return false
    endif
    return true
endfunction

function Trig_Start_Level_Func003Func006A takes nothing returns nothing
    call DeleteUnit(GetEnumUnit())
endfunction

function Trig_Start_Level_Func003C takes nothing returns boolean
    if(not Trig_Start_Level_Func003Func001C())then
        return false
    endif
    return true
endfunction

function Trig_Start_Level_Func011A takes nothing returns nothing
    call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_RESOURCE_FOOD_USED,RoundNumber)
    set ShowCreepAbilButton[GetPlayerId(GetEnumPlayer())] = false
    call ResourseRefresh(GetEnumPlayer()) 
endfunction

function Trig_Start_Level_Func013Func001C takes nothing returns boolean
    if((ElimModeEnabled==true))then
        return true
    endif
    if((GameModeShort==true))then
        return true
    endif
    return false
endfunction

function Trig_Start_Level_Func013C takes nothing returns boolean
    if(not Trig_Start_Level_Func013Func001C())then
        return false
    endif
    return true
endfunction

function Trig_Start_Level_Func015Func002001001001001 takes nothing returns boolean
    return(GetFilterPlayer()!=Player(8))
endfunction

function Trig_Start_Level_Func015Func002001001001002 takes nothing returns boolean
    return(GetFilterPlayer()!=Player(11))
endfunction

function Trig_Start_Level_Func015Func002001001001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Start_Level_Func015Func002001001001001(),Trig_Start_Level_Func015Func002001001001002())
endfunction

function Trig_Start_Level_Func015Func002001001002 takes nothing returns boolean
    return(IsPlayerInForce(GetFilterPlayer(),DefeatedPlayers)!=true)
endfunction

function Trig_Start_Level_Func015Func002001001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Start_Level_Func015Func002001001001(),Trig_Start_Level_Func015Func002001001002())
endfunction

function Trig_Start_Level_Func015Func002Func003001002001 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction

function Trig_Start_Level_Func015Func002Func003001002002 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_Start_Level_Func015Func002Func003001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Start_Level_Func015Func002Func003001002001(),Trig_Start_Level_Func015Func002Func003001002002())
endfunction

function Trig_Start_Level_Func015Func002Func003Func001001 takes unit u returns boolean
    return GetUnitTypeId(u)=='h009' or GetUnitTypeId(u)=='h014' or GetUnitTypeId(u)==PRIEST_1_UNIT_ID or GetUnitTypeId(u)=='h00B'
endfunction

function Trig_Start_Level_Func015Func002Func003A takes nothing returns nothing
    if GetUnitTypeId(GetEnumUnit()) != DRAFT_BUY_UNIT_ID and GetUnitTypeId(GetEnumUnit()) != DRAFT_UPGRADE_UNIT_ID then
        if(Trig_Start_Level_Func015Func002Func003Func001001(GetEnumUnit()))then
            call DeleteUnit(GetEnumUnit())
        else
            call DoNothing()
        endif
        call ExplodeUnitBJ(GetEnumUnit())
    endif
endfunction

function Trig_Start_Level_Func015Func002Func004A takes nothing returns nothing
    call RemoveItem(GetEnumItem())
endfunction

function StartLevelRoundOne takes nothing returns nothing
    call StartFunctionSpell(PlayerHeroes[GetConvertedPlayerId(GetEnumPlayer())],3) 
    call SetCurrentlyFighting(GetEnumPlayer(), true)
endfunction

function Trig_Start_Level_Func015Func002A takes nothing returns nothing
    
    
    call ForGroupBJ(GetUnitsOfPlayerMatching(GetEnumPlayer(),Condition(function Trig_Start_Level_Func015Func002Func003001002)),function Trig_Start_Level_Func015Func002Func003A)
    call EnumItemsInRectBJ(PlayerArenaRects[GetConvertedPlayerId(GetEnumPlayer())],function Trig_Start_Level_Func015Func002Func004A)
    call SetUnitInvulnerable(PlayerHeroes[GetConvertedPlayerId(GetEnumPlayer())],false)
    call SetUnitPositionLoc(PlayerHeroes[GetConvertedPlayerId(GetEnumPlayer())],GetRectCenter(PlayerArenaRects[GetConvertedPlayerId(GetEnumPlayer())]))
    set udg_unit01 = PlayerHeroes[GetConvertedPlayerId(GetEnumPlayer())]
    call ConditionalTriggerExecute(udg_trigger82)
    call SelectUnitForPlayerSingle(PlayerHeroes[GetConvertedPlayerId(GetEnumPlayer())],GetOwningPlayer(PlayerHeroes[GetConvertedPlayerId(GetEnumPlayer())]))
    call PanCameraToTimedLocForPlayer(GetEnumPlayer(),GetRectCenter(PlayerArenaRects[GetConvertedPlayerId(GetEnumPlayer())]),0)
    call SetCurrentlyFighting(GetEnumPlayer(), true)
endfunction

function StartFunctionSpells takes nothing returns nothing
    call StartFunctionSpell(PlayerHeroes[GetConvertedPlayerId(GetEnumPlayer())],3) 
endfunction

function Trig_Start_Level_Func015C takes nothing returns boolean
    if(not(RoundNumber > 1))then
        return false
    endif
    return true
endfunction
/*
function StartCountdown takes string text, integer value returns nothing
    local texttag ft
    local integer i = 0
    loop
        set ft = CreateTextTag()
        call SetTextTagPos(ft, GetRectCenterX(PlayerArenaRects[i + 1]) - 40, GetRectCenterY(PlayerArenaRects[i + 1]) - 50, 0)
        call SetTextTagText(ft, text, TextTagSize2Height(40))
        call SetTextTagColor(ft, 100, 255 - (50 * value), 255 - (50 * value), 0)
        call SetTextTagPermanentBJ(ft,false)
        call SetTextTagFadepointBJ(ft,0.80)
        call SetTextTagLifespanBJ(ft,1.00)
        set i = i + 1
        exitwhen i > 7
    endloop
    call PlaySoundBJ(udg_sound09)
    set ft = null
endfunction*/

function Trig_Start_Level_Func018A takes nothing returns nothing
    call ShowUnitShow(GetEnumUnit())
    call SetUnitInvulnerable(GetEnumUnit(),false)
    //call StartFunctionSpell(GetEnumUnit(),3 ) 
    call PauseUnitBJ(false,GetEnumUnit())
endfunction

function Trig_Start_Level_Actions takes nothing returns nothing
    local timerdialog td
    local timer t
    call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
    if(Trig_Start_Level_Func003C())then
        set udg_boolean12 = true
        set udg_boolean09 = true
        call DisplayTextToForce(GetPlayersAll(),("|c00F08000Level " +(I2S(RoundNumber)+ "|r")))
        call ConditionalTriggerExecute(udg_trigger143)
        call ForGroupBJ(GetUnitsOfTypeIdAll('n00E'),function Trig_Start_Level_Func003Func006A)
    else
    endif
    call ForceClear(RoundPlayersCompleted)
    
    set RoundFinishedCount = 0
    call ConditionalTriggerExecute(udg_trigger146)
    call ForForce(GetPlayersAll(),function Trig_Start_Level_Func011A)
    if(Trig_Start_Level_Func013C())then
        set udg_integer59 =((125 * RoundNumber)/ RoundCreepNumber)
        set udg_integer61 =((125 * RoundNumber)-(udg_integer59 * RoundCreepNumber))
    else
        set udg_integer59 =((80 * RoundNumber)/ RoundCreepNumber)
        set udg_integer61 =((80 * RoundNumber)-(udg_integer59 * RoundCreepNumber))
    endif
    if(Trig_Start_Level_Func015C())then
        call PlaySoundBJ(udg_sound03)
        call ForForce(GetPlayersMatching(Condition(function Trig_Start_Level_Func015Func002001001)),function Trig_Start_Level_Func015Func002A)
        set t = NewTimer()
        set td = CreateTimerDialog(t)
        call TimerDialogSetTitle(td, "Starting in...")
        call TimerDialogDisplay(td, true)
        call TimerStart(t, 4, false, null)
        call TriggerSleepAction(1.00)
        call PlaySoundBJ(udg_sound09)
        call TriggerSleepAction(1.00)
        call PlaySoundBJ(udg_sound09)
        call TriggerSleepAction(1.00)
        call PlaySoundBJ(udg_sound09)
        call TriggerSleepAction(1.00)
        call ReleaseTimer(t)
        call TimerDialogDisplay(td, false)
        call DestroyTimerDialog(td)
        set t = null
        set td = null
    else
        call ForForce(GetPlayersMatching(Condition(function Trig_Start_Level_Func015Func002001001)),function StartLevelRoundOne)
    endif
    call PlaySoundBJ(udg_sound01)
    call ForGroupBJ(udg_group05,function Trig_Start_Level_Func018A)
    call ForForce(GetPlayersMatching(Condition(function Trig_Start_Level_Func015Func002001001)),function StartFunctionSpells)
    call ConditionalTriggerExecute(udg_trigger98)
    set SuddenDeathTick = 0
    call EnableTrigger(udg_trigger110)
    call StartSuddenDeathTimer()
    call EnableTrigger(udg_trigger116)
    call EnableTrigger(udg_trigger103)
endfunction

function Trig_Sudden_Death_Timer_Func002Func001A takes nothing returns nothing
    call SetUnitMoveSpeed(GetEnumUnit(),(GetUnitMoveSpeed(GetEnumUnit())+ 25.00))
    if GetUnitAbilityLevel(GetEnumUnit(), 'AOcr') == 0 then
        call UnitAddAbility(GetEnumUnit(), 'AOcr')
    elseif GetUnitAbilityLevel(GetEnumUnit(), 'AOcr') < 10 then
        call SetUnitAbilityLevel(GetEnumUnit(), 'AOcr', 10)
    endif
endfunction

function Trig_Sudden_Death_Timer_Func002Func002Func001A takes nothing returns nothing
    call UnitAddAbilityBJ('Atru',GetEnumUnit())
    call UnitAddAbilityBJ('A00W',GetEnumUnit())
    call UnitAddAbilityBJ('A01B',GetEnumUnit())
    if UnitGetAttackDamage(GetEnumUnit()) < 1000000 then
        if UnitGetAttackDamage(GetEnumUnit()) == 0 then
            call UnitSetAttackDamage(GetEnumUnit(), R2I(BlzGetUnitBaseDamage(GetEnumUnit(), 0) * 0.1) + 1)
        endif
        call UnitSetAttackDamage(GetEnumUnit(), R2I(UnitGetAttackDamage(GetEnumUnit()) * 1.1) + 1)
    endif
endfunction

function Trig_Sudden_Death_Timer_Func002Func002Func002Func001001001 takes nothing returns boolean
    return(IsPlayerInForce(GetFilterPlayer(),RoundPlayersCompleted)!=true)
endfunction

function Trig_Sudden_Death_Timer_Func002Func002Func002Func001A takes nothing returns nothing
    call SetUnitLifeBJ(PlayerHeroes[GetConvertedPlayerId(GetEnumPlayer())],(GetUnitStateSwap(UNIT_STATE_LIFE,PlayerHeroes[GetConvertedPlayerId(GetEnumPlayer())])- 1))
endfunction

function Trig_Sudden_Death_Timer_Func002Func002Func002C takes nothing returns boolean
    if(not(SuddenDeathTick >= 720))then
        return false
    endif
    return true
endfunction

function Trig_Sudden_Death_Timer_Func002Func002C takes nothing returns boolean
    if(not(SuddenDeathTick >= 480))then
        return false
    endif
    return true
endfunction

function Trig_Sudden_Death_Timer_Func002C takes nothing returns boolean
    if(not(SuddenDeathTick >= 240))then
        return false
    endif
    return true
endfunction

function Trig_Sudden_Death_Timer_Actions takes nothing returns nothing
    set SuddenDeathTick =(SuddenDeathTick + 1)
    if SuddenDeathTick == 120 or SuddenDeathTick == 240 or SuddenDeathTick == 480 or SuddenDeathTick == 720 then
        call UpdateSuddenDeathTimer()
    endif
    if(Trig_Sudden_Death_Timer_Func002C())then
        call ForGroupBJ(GetUnitsInRectOfPlayer(GetPlayableMapRect(),Player(11)),function Trig_Sudden_Death_Timer_Func002Func001A)
        if(Trig_Sudden_Death_Timer_Func002Func002C())then
            call ForGroupBJ(GetUnitsInRectOfPlayer(GetPlayableMapRect(),Player(11)),function Trig_Sudden_Death_Timer_Func002Func002Func001A)
            if(Trig_Sudden_Death_Timer_Func002Func002Func002C())then
                call ForForce(GetPlayersMatching(Condition(function Trig_Sudden_Death_Timer_Func002Func002Func002Func001001001)),function Trig_Sudden_Death_Timer_Func002Func002Func002Func001A)
            else
            endif
        else
        endif
    else
    endif
endfunction

function Trig_Learn_Ability_Conditions takes nothing returns boolean
    if(not('I00P'!=GetItemTypeId(GetManipulatedItem())))then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func006C takes nothing returns boolean
    if(not(BoughtAbility=='Amnz'))then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func008Func001Func002Func001C takes nothing returns boolean
    if(not(ARLearningAbil==false))then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func008Func001Func002Func002Func001C takes nothing returns boolean
    if(not(ARLearningAbil==false))then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func008Func001Func002Func002C takes nothing returns boolean
    if(not(GetUnitAbilityLevelSwapped(BoughtAbility,GetTriggerUnit())< 30))then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func008Func001Func002C takes nothing returns boolean
    if(not(GetUnitAbilityLevelSwapped(BoughtAbility,GetTriggerUnit())>= 0))then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func008Func001C takes nothing returns boolean
    if(not(ArNotLearningAbil==true))then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func008Func002Func001Func001Func002Func002C takes nothing returns boolean
    if((BoughtAbility=='ANba'))then
        return true
    endif
    if((BoughtAbility=='AHca'))then
        return true
    endif
    if((BoughtAbility=='AHfa'))then
        return true
    endif
    if((BoughtAbility=='Aliq'))then
        return true
    endif
    return false
endfunction

function Trig_Learn_Ability_Func008Func002Func001Func001Func002C takes nothing returns boolean
    if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_MELEE_ATTACKER)==true))then
        return false
    endif
    if(not Trig_Learn_Ability_Func008Func002Func001Func001Func002Func002C())then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func008Func002Func001Func001Func003Func002C takes nothing returns boolean
    if((BoughtAbility=='ANca'))then
        return true
    endif
    return false
endfunction

function Trig_Learn_Ability_Func008Func002Func001Func001Func003C takes nothing returns boolean
    if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_RANGED_ATTACKER)==true))then
        return false
    endif
    if(not Trig_Learn_Ability_Func008Func002Func001Func001Func003Func002C())then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func008Func002Func001Func001Func004Func001C takes nothing returns boolean
    if((IsUnitType(GetTriggerUnit(),UNIT_TYPE_MELEE_ATTACKER)==true))then
        return true
    endif
    return false
endfunction

function Trig_Learn_Ability_Func008Func002Func001Func001Func004Func002C takes nothing returns boolean
    if((BoughtAbility=='ANba'))then
        return true
    endif
    if((BoughtAbility=='Aroc'))then
        return true
    endif
    return false
endfunction

function Trig_Learn_Ability_Func008Func002Func001Func001Func004C takes nothing returns boolean
    if(not Trig_Learn_Ability_Func008Func002Func001Func001Func004Func001C())then
        return false
    endif
    if(not Trig_Learn_Ability_Func008Func002Func001Func001Func004Func002C())then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func008Func002Func001Func001Func005Func001C takes nothing returns boolean
    if((GetUnitTypeId(GetTriggerUnit())=='H004'))then
        return true
    endif
    if((GetUnitTypeId(GetTriggerUnit())=='O005'))then
        return true
    endif
    if((GetUnitTypeId(GetTriggerUnit())=='O001'))then
        return true
    endif
    return false
endfunction

function Trig_Learn_Ability_Func008Func002Func001Func001Func005Func002C takes nothing returns boolean
    if((BoughtAbility=='ACvs'))then
        return true
    endif
    return false
endfunction

function Trig_Learn_Ability_Func008Func002Func001Func001Func005C takes nothing returns boolean
    if(not Trig_Learn_Ability_Func008Func002Func001Func001Func005Func001C())then
        return false
    endif
    if(not Trig_Learn_Ability_Func008Func002Func001Func001Func005Func002C())then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func008Func002Func001Func001C takes nothing returns boolean
    if((HeroAbilityCount[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]>= 10))then
        return true
    endif
    if(Trig_Learn_Ability_Func008Func002Func001Func001Func002C())then
        return true
    endif
    if(Trig_Learn_Ability_Func008Func002Func001Func001Func003C())then
        return true
    endif
    if(Trig_Learn_Ability_Func008Func002Func001Func001Func004C())then
        return true
    endif
    if(Trig_Learn_Ability_Func008Func002Func001Func001Func005C())then
        return true
    endif
    return false
endfunction

function Trig_Learn_Ability_Func008Func002Func001Func007Func001Func001C takes nothing returns boolean
    if(not(ARLearningAbil==false))then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func008Func002Func001Func007Func001C takes nothing returns boolean
    if(not(ARLearningAbil==true))then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func008Func002Func001Func007Func002Func001Func002C takes nothing returns boolean
    if((BoughtAbility=='ANba'))then
        return true
    endif
    if((BoughtAbility=='AHca'))then
        return true
    endif
    if((BoughtAbility=='AHfa'))then
        return true
    endif
    if((BoughtAbility=='Aliq'))then
        return true
    endif
    return false
endfunction

function Trig_Learn_Ability_Func008Func002Func001Func007Func002Func001C takes nothing returns boolean
    if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_MELEE_ATTACKER)==true))then
        return false
    endif
    if(not Trig_Learn_Ability_Func008Func002Func001Func007Func002Func001Func002C())then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func008Func002Func001Func007Func002Func002Func002C takes nothing returns boolean
    if((BoughtAbility=='ANca'))then
        return true
    endif
    return false
endfunction

function Trig_Learn_Ability_Func008Func002Func001Func007Func002Func002C takes nothing returns boolean
    if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_RANGED_ATTACKER)==true))then
        return false
    endif
    if(not Trig_Learn_Ability_Func008Func002Func001Func007Func002Func002Func002C())then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func008Func002Func001Func007Func002Func003Func001C takes nothing returns boolean
    if((IsUnitType(GetTriggerUnit(),UNIT_TYPE_MELEE_ATTACKER)==true))then
        return true
    endif
    return false
endfunction

function Trig_Learn_Ability_Func008Func002Func001Func007Func002Func003Func002C takes nothing returns boolean
    if((BoughtAbility=='ANba'))then
        return true
    endif
    if((BoughtAbility=='Aroc'))then
        return true
    endif
    return false
endfunction

function Trig_Learn_Ability_Func008Func002Func001Func007Func002Func003C takes nothing returns boolean
    if(not Trig_Learn_Ability_Func008Func002Func001Func007Func002Func003Func001C())then
        return false
    endif
    if(not Trig_Learn_Ability_Func008Func002Func001Func007Func002Func003Func002C())then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func008Func002Func001Func007Func002Func004Func001C takes nothing returns boolean
    return false
endfunction

function Trig_Learn_Ability_Func008Func002Func001Func007Func002Func004Func002C takes nothing returns boolean
    if((BoughtAbility=='ACvs'))then
        return true
    endif
    return false
endfunction

function Trig_Learn_Ability_Func008Func002Func001Func007Func002Func004C takes nothing returns boolean
    if(not Trig_Learn_Ability_Func008Func002Func001Func007Func002Func004Func001C())then
        return false
    endif
    if(not Trig_Learn_Ability_Func008Func002Func001Func007Func002Func004Func002C())then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func008Func002Func001Func007Func002C takes nothing returns boolean
    if(Trig_Learn_Ability_Func008Func002Func001Func007Func002Func001C())then
        return true
    endif
    if(Trig_Learn_Ability_Func008Func002Func001Func007Func002Func002C())then
        return true
    endif
    if(Trig_Learn_Ability_Func008Func002Func001Func007Func002Func003C())then
        return true
    endif
    if(Trig_Learn_Ability_Func008Func002Func001Func007Func002Func004C())then
        return true
    endif
    return false
endfunction

function Trig_Learn_Ability_Func008Func002Func001Func007C takes nothing returns boolean
    if(not Trig_Learn_Ability_Func008Func002Func001Func007Func002C())then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func008Func002Func001Func008C takes nothing returns boolean
    if(not(ARLearningAbil==false))then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func008Func002Func001C takes nothing returns boolean
    if(not Trig_Learn_Ability_Func008Func002Func001Func001C())then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func008Func002Func003Func001C takes nothing returns boolean
    if(not(ARLearningAbil==false))then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func008Func002Func003C takes nothing returns boolean
    if(not(GetUnitAbilityLevelSwapped(BoughtAbility,GetTriggerUnit())< 30))then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func008Func002C takes nothing returns boolean
    if(not(GetUnitAbilityLevelSwapped(BoughtAbility,GetTriggerUnit())==0))then
        return false
    endif
    return true
endfunction

function Trig_Learn_Ability_Func008C takes nothing returns boolean
    if(not(ArNotLearningAbil==false))then
        return false
    endif
    return true
endfunction

function BuyLevels takes player p, unit u, integer abil, boolean maxBuy, boolean new returns nothing
    local integer i = GetUnitAbilityLevel(u, abil) + 1
    local integer cost = BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr') )
    local integer lumber = GetPlayerState(p, PLAYER_STATE_RESOURCE_LUMBER)
    if maxBuy then
        loop
            if lumber - cost < 0 then
                exitwhen true
            endif
            set lumber = lumber - cost
            set i = i + 1
            exitwhen i >= 30
        endloop
        call SetPlayerState(p, PLAYER_STATE_RESOURCE_LUMBER, lumber)
    endif

    if new then
        call UnitAddAbility(u, abil)
        call SpellLearnedFunc(u, abil)
    endif
    if i > 1 then
        call SetUnitAbilityLevel(u, BoughtAbility, i)
    endif
    call FuncEditParam(abil,u)
    call AddSpecialEffectLocBJ(GetUnitLoc(u),"Objects\\Spawnmodels\\Other\\ToonBoom\\ToonBoom.mdl")
    call DestroyEffectBJ(GetLastCreatedEffectBJ())
    call DisplayTimedTextToPlayer(p, 0, 0, 2.0, "|cffbbff00Learned |r" + BlzGetAbilityTooltip(abil, GetUnitAbilityLevel(u, abil) - 1))
endfunction

function Trig_Learn_Ability_Actions takes nothing returns nothing
    local integer abilLevel
    local boolean maxAbil = false
    set BoughtAbility = GetAbilityFromItem(GetItemTypeId(GetManipulatedItem()))
    //call ConditionalTriggerExecute(udg_trigger112)
    if BoughtAbility == 0 or IsAbsolute(BoughtAbility) then
        return
    endif
    set abilLevel = GetUnitAbilityLevel(GetTriggerUnit(), BoughtAbility)
    if HoldShift[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] then
        set maxAbil = true
    endif
    if(Trig_Learn_Ability_Func008C())then
        if(Trig_Learn_Ability_Func008Func002C())then
            if(Trig_Learn_Ability_Func008Func002Func001C())then
                if(Trig_Learn_Ability_Func008Func002Func001Func007C())then
                    if(Trig_Learn_Ability_Func008Func002Func001Func007Func001C())then
                        call ConditionalTriggerExecute(udg_trigger114)
                        return
                    else
                        if(Trig_Learn_Ability_Func008Func002Func001Func007Func001Func001C())then

                            call AdjustPlayerStateBJ(   BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr') ) ,GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)

                            call ResourseRefresh(GetOwningPlayer(GetTriggerUnit()) )
                            //	call AdjustPlayerStateBJ((GetItemLevel(GetManipulatedItem())*10),GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)
                        else
                            call AdjustPlayerStateBJ(5,GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)
                            call ResourseRefresh(GetOwningPlayer(GetTriggerUnit()) )
                        endif
                        //call BJDebugMsg("failed?1")
                        call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 2.0, "|cffbbff00Failed to learn|r")
                        return
                    endif
                endif
                if(Trig_Learn_Ability_Func008Func002Func001Func008C())then
                    call AdjustPlayerStateBJ(BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr') ),GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)
                    call ResourseRefresh(GetOwningPlayer(GetTriggerUnit()) )
                else
                    call AdjustPlayerStateBJ(5,GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)
                    call ResourseRefresh(GetOwningPlayer(GetTriggerUnit()) )
                endif
                //call BJDebugMsg("failed?2")
                call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 2.0, "|cffffe600Failed to learn|r")
                return
            else
                set HeroAbilityCount[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=(HeroAbilityCount[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]+ 1)
                set PlayerLastLearnedSpell[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]= BoughtAbility
                call BuyLevels(GetOwningPlayer(GetTriggerUnit()), GetTriggerUnit(), BoughtAbility, maxAbil, true)
            endif
        else
            //increase level ap
            if(Trig_Learn_Ability_Func008Func002Func003C())then
                call BuyLevels(GetOwningPlayer(GetTriggerUnit()), GetTriggerUnit(), BoughtAbility, maxAbil, false)
            else
                //max level reached
                if(Trig_Learn_Ability_Func008Func002Func003Func001C())then
                    call AdjustPlayerStateBJ(BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr') ),GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)
                    call ResourseRefresh(GetOwningPlayer(GetTriggerUnit()) )
                else
                    call AdjustPlayerStateBJ(5,GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)
                    call ResourseRefresh(GetOwningPlayer(GetTriggerUnit()) )
                endif
                //call BJDebugMsg("max lvl ap")
                call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 2.0, "|cffffe600Failed to learn|r: Maximum ability level")
                return
            endif
        endif
    else
        if(Trig_Learn_Ability_Func008Func001C())then
            if(Trig_Learn_Ability_Func008Func001Func002C())then
                //failed ar
                if(Trig_Learn_Ability_Func008Func001Func002Func001C())then
                    call AdjustPlayerStateBJ(BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr') ),GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)
                    call ResourseRefresh(GetOwningPlayer(GetTriggerUnit()) )
                else
                    call AdjustPlayerStateBJ(5,GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)
                    call ResourseRefresh(GetOwningPlayer(GetTriggerUnit()) )
                endif
                call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 2.0, "|cffffe600Failed to learn|r: (Random mode) 3")
                return
            else
                //increase level ap
                if(Trig_Learn_Ability_Func008Func001Func002Func002C())then
                    call IncUnitAbilityLevelSwapped(BoughtAbility,GetTriggerUnit())
                    call FuncEditParam(BoughtAbility,GetTriggerUnit())
                    call AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()),"Objects\\Spawnmodels\\Other\\ToonBoom\\ToonBoom.mdl")
                    call DestroyEffectBJ(GetLastCreatedEffectBJ())
                    call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 2.0, "|cffbbff00Learned |r" + BlzGetAbilityTooltip(BoughtAbility, abilLevel))
                else
                    if(Trig_Learn_Ability_Func008Func001Func002Func002Func001C())then
                        call AdjustPlayerStateBJ(BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr') ),GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)
                        call ResourseRefresh(GetOwningPlayer(GetTriggerUnit()) )
                    else
                        call AdjustPlayerStateBJ(5,GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)
                        call ResourseRefresh(GetOwningPlayer(GetTriggerUnit()) )
                    endif
                    //call BJDebugMsg("inc f ap")
                    call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 2.0, "|cffffe600Failed to learn|r: 4")
                    return
                endif
            endif
        else
        endif
    endif
endfunction

function Trig_Set_Ability_Func001Func001001 takes nothing returns boolean
    return(GetItemTypeId(GetManipulatedItem())==udg_integers09[udg_integer44])
endfunction

function Trig_Set_Ability_Func001Func002C takes nothing returns boolean
    if(not(GetItemTypeId(GetManipulatedItem())==udg_integers09[udg_integer44]))then
        return false
    endif
    return true
endfunction

function Trig_Set_Ability_Actions takes nothing returns nothing
    set udg_integer44 = 1
    loop
        exitwhen udg_integer44 > udg_integer26
        if(Trig_Set_Ability_Func001Func001001())then
            set BoughtAbility = udg_integers08[udg_integer44]
        else
            call DoNothing()
        endif
        if(Trig_Set_Ability_Func001Func002C())then
            set BoughtAbility = udg_integers08[udg_integer44]
            return
        else
        endif
        set udg_integer44 = udg_integer44 + 1
    endloop
endfunction

function Trig_Random_Ability_Conditions takes nothing returns boolean
    if(not('I02J'==GetItemTypeId(GetManipulatedItem())))then
        return false
    endif
    return true
endfunction

function Trig_Random_Ability_Actions takes nothing returns nothing
    if AbilityMode != 2 then
        set UnknownInteger02 = 0
        set udg_unit01 = GetTriggerUnit()
        call ConditionalTriggerExecute(udg_trigger114)
    else
        call DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, "Random is unavailable in Draft mode")
    endif
endfunction

function Trig_Learn_Random_Ability_Func004Func001Func001C takes nothing returns boolean
    if(not(UnknownInteger02 > 500))then
        return false
    endif
    return true
endfunction

function Trig_Learn_Random_Ability_Func004Func001Func002C takes nothing returns boolean
    if(not(ArNotLearningAbil==true))then
        return false
    endif
    return true
endfunction

function Trig_Learn_Random_Ability_Func004Func001Func005Func001Func001C takes nothing returns boolean
    if(not(HeroAbilityCount[GetConvertedPlayerId(GetOwningPlayer(udg_unit01))]>= 10))then
        return false
    endif
    if(not(GetUnitTypeId(udg_unit01)=='O000'))then
        return false
    endif
    return true
endfunction

function Trig_Learn_Random_Ability_Func004Func001Func005Func001Func002C takes nothing returns boolean
    if(not(HeroAbilityCount[GetConvertedPlayerId(GetOwningPlayer(udg_unit01))]>= 10))then
        return false
    endif
    if(not(GetUnitTypeId(udg_unit01)!='O000'))then
        return false
    endif
    return true
endfunction

function Trig_Learn_Random_Ability_Func004Func001Func005Func001C takes nothing returns boolean
    if(Trig_Learn_Random_Ability_Func004Func001Func005Func001Func001C())then
        return true
    endif
    if(Trig_Learn_Random_Ability_Func004Func001Func005Func001Func002C())then
        return true
    endif
    return false
endfunction

function Trig_Learn_Random_Ability_Func004Func001Func005C takes nothing returns boolean
    if(not Trig_Learn_Random_Ability_Func004Func001Func005Func001C())then
        return false
    endif
    if(not(GetUnitAbilityLevelSwapped(GetAbilityFromItem(RoundCreepAbilCastChance),udg_unit01)> 0))then
        return false
    endif
    if(not(GetUnitAbilityLevelSwapped(GetAbilityFromItem(RoundCreepAbilCastChance),udg_unit01)< 30))then
        return false
    endif
    if(not(UnknownInteger02 <= 500))then
        return false
    endif
    return true
endfunction

function Trig_Learn_Random_Ability_Func004Func001C takes nothing returns boolean
    if(not Trig_Learn_Random_Ability_Func004Func001Func005C())then
        return false
    endif
    return true
endfunction

function Trig_Learn_Random_Ability_Func004Func002C takes nothing returns boolean
    if(not(ArNotLearningAbil==true))then
        return false
    endif
    return true
endfunction

function Trig_Learn_Random_Ability_Func004Func003Func003Func001C takes nothing returns boolean
    if(not(HeroAbilityCount[GetConvertedPlayerId(GetOwningPlayer(udg_unit01))]< 10))then
        return false
    endif
    if(not(GetUnitTypeId(udg_unit01)=='O000'))then
        return false
    endif
    return true
endfunction

function Trig_Learn_Random_Ability_Func004Func003Func003Func002C takes nothing returns boolean
    if(not(HeroAbilityCount[GetConvertedPlayerId(GetOwningPlayer(udg_unit01))]< 10))then
        return false
    endif
    if(not(GetUnitTypeId(udg_unit01)!='O000'))then
        return false
    endif
    return true
endfunction

function Trig_Learn_Random_Ability_Func004Func003Func003C takes nothing returns boolean
    if(Trig_Learn_Random_Ability_Func004Func003Func003Func001C())then
        return true
    endif
    if(Trig_Learn_Random_Ability_Func004Func003Func003Func002C())then
        return true
    endif
    return false
endfunction

function Trig_Learn_Random_Ability_Func004Func003C takes nothing returns boolean
    if(not(GetUnitAbilityLevelSwapped(GetAbilityFromItem(RoundCreepAbilCastChance),udg_unit01)==0))then
        return false
    endif
    if(not(RoundCreepAbilCastChance!=GetItemTypeId(null)))then
        return false
    endif
    if(not Trig_Learn_Random_Ability_Func004Func003Func003C())then
        return false
    endif
    return true
endfunction

function Trig_Learn_Random_Ability_Func004C takes nothing returns boolean
    if(not Trig_Learn_Random_Ability_Func004Func003C())then
        return false
    endif
    return true
endfunction

function Trig_Learn_Random_Ability_Actions takes nothing returns nothing
    set udg_player02 = GetOwningPlayer(udg_unit01)
    set RoundCreepAbilCastChance = GetItemFromAbility(GetRandomAbility())
    if(Trig_Learn_Random_Ability_Func004C())then
        if(Trig_Learn_Random_Ability_Func004Func002C())then
            set ArNotLearningAbil = false
            set ARLearningAbil = true
            call UnitAddItemByIdSwapped(RoundCreepAbilCastChance,PlayerHeroes[GetConvertedPlayerId(udg_player02)])
            set ARLearningAbil = false
            set ArNotLearningAbil = true
        else
            call UnitAddItemByIdSwapped(RoundCreepAbilCastChance,PlayerHeroes[GetConvertedPlayerId(udg_player02)])
        endif
    else
        if(Trig_Learn_Random_Ability_Func004Func001C())then
            if(Trig_Learn_Random_Ability_Func004Func001Func002C())then
                set ArNotLearningAbil = false
                set ARLearningAbil = true
                call UnitAddItemByIdSwapped(RoundCreepAbilCastChance,PlayerHeroes[GetConvertedPlayerId(udg_player02)])
                set ARLearningAbil = false
                set ArNotLearningAbil = true
            else
                call AdjustPlayerStateBJ(5,GetOwningPlayer(udg_unit01),PLAYER_STATE_RESOURCE_LUMBER)

                call ResourseRefresh(GetOwningPlayer(udg_unit01) )
                call ForceAddPlayerSimple(GetOwningPlayer(udg_unit01),bj_FORCE_PLAYER[11])
                call DisplayTimedTextToForce(bj_FORCE_PLAYER[11],2.00,"|cffffcc00Failed to learn!")
                call ForceRemovePlayerSimple(GetOwningPlayer(udg_unit01),bj_FORCE_PLAYER[11])
                return
            endif
        else
            if(Trig_Learn_Random_Ability_Func004Func001Func001C())then
                call AdjustPlayerStateBJ(5,GetOwningPlayer(udg_unit01),PLAYER_STATE_RESOURCE_LUMBER)
                call ResourseRefresh(GetOwningPlayer(udg_unit01) )

                call ForceAddPlayerSimple(GetOwningPlayer(udg_unit01),bj_FORCE_PLAYER[11])
                call DisplayTimedTextToForce(bj_FORCE_PLAYER[11],2.00,"|cffffcc00Failed to learn!")
                call ForceRemovePlayerSimple(GetOwningPlayer(udg_unit01),bj_FORCE_PLAYER[11])
                return
            else
            endif
            set UnknownInteger02 =(UnknownInteger02 + 1)
            call ConditionalTriggerExecute(GetTriggeringTrigger())
        endif
    endif
endfunction

function Trig_Unlearn_Ability_Conditions takes nothing returns boolean
    if(not('I00P'==GetItemTypeId(GetManipulatedItem())))then
        return false
    endif
    return true
endfunction

function Trig_Unlearn_Ability_Func001Func003C takes nothing returns boolean
    if(not(ArNotLearningAbil==false))then
        return false
    endif
    return true
endfunction

function Trig_Unlearn_Ability_Func001C takes nothing returns boolean
    if(not(ArNotLearningAbil==false))then
        return false
    endif
    if(not(PlayerLastLearnedSpell[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]!='Amnz'))then
        return false
    endif
    return true
endfunction



function Trig_Unlearn_Ability_Actions takes nothing returns nothing 
    local integer CountS = 0 
    local integer lastLearned = 0
    local integer Pid = GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))

    if(Trig_Unlearn_Ability_Func001C()) and AbilityMode != 2 then

        set CountS = LoadCountHeroSpell(GetTriggerUnit(), 0)
        if CountS > 0 then

            set HeroAbilityCount[Pid]=(HeroAbilityCount[Pid]- 1)
            set PlayerLastLearnedSpell[Pid] = GetLastLearnedSpell(GetTriggerUnit(), SpellList_Normal, true)
            call SetInfoHeroSpell(GetTriggerUnit(),CountS,0 )
            call SaveCountHeroSpell(GetTriggerUnit() ,CountS - 1,0 ) 

            call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 10,"|cffbbff00Removed |r" + BlzGetAbilityTooltip(PlayerLastLearnedSpell[Pid], GetUnitAbilityLevel(GetTriggerUnit(), PlayerLastLearnedSpell[Pid]) - 1))
            call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\Items\\TomeOfRetraining\\TomeOfRetrainingCaster.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
            call UnitRemoveAbilityBJ(PlayerLastLearnedSpell[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetTriggerUnit())
            call FunResetAbility (PlayerLastLearnedSpell[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetTriggerUnit())
        endif

    else
        call AdjustPlayerStateBJ(20,GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_GOLD)
        call ResourseRefresh(GetOwningPlayer(GetTriggerUnit()) )
        call ForceAddPlayerSimple(GetOwningPlayer(GetTriggerUnit()),bj_FORCE_PLAYER[11])

        if(Trig_Unlearn_Ability_Func001Func003C()) or AbilityMode == 2 then
            call DisplayTimedTextToForce(bj_FORCE_PLAYER[11],2.00,"|cffffcc00Failed to unlearn!")
        else
            call DisplayTimedTextToForce(bj_FORCE_PLAYER[11],2.00,"|cffffcc00Failed to unlearn! (Random Mode)")
        endif

        call ForceRemovePlayerSimple(GetOwningPlayer(GetTriggerUnit()),bj_FORCE_PLAYER[11])
    endif
endfunction

function Trig_AntiStuck_Conditions takes nothing returns boolean
    if(not(IsTriggerEnabled(GetTriggeringTrigger())==true))then
        return false
    endif
    return true
endfunction

function Trig_AntiStuck_Func002Func001Func005Func001001001002001 takes nothing returns boolean
    return (IsUnitAliveBJ(GetFilterUnit())==true) and GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') == 0
endfunction

function Trig_AntiStuck_Func002Func001Func005Func001001001002002 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())==Player(11))
endfunction

function Trig_AntiStuck_Func002Func001Func005Func001001001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_AntiStuck_Func002Func001Func005Func001001001002001(),Trig_AntiStuck_Func002Func001Func005Func001001001002002())
endfunction

function Trig_AntiStuck_Func002Func001Func005C takes nothing returns boolean
    if((CountUnitsInGroup(GetUnitsInRectMatching(PlayerArenaRects[AntiStuckPlayerId],Condition(function Trig_AntiStuck_Func002Func001Func005Func001001001002))) != 0))then
        return false
    endif
    if(not(IsPlayerInForce(GetOwningPlayer(PlayerHeroes[AntiStuckPlayerId]),DefeatedPlayers)!=true))then
        return false
    endif
    if(not(IsPlayerInForce(GetOwningPlayer(PlayerHeroes[AntiStuckPlayerId]),RoundPlayersCompleted)!=true))then
        return false
    endif
    if(not(PlayerHeroes[AntiStuckPlayerId]!=null))then
        return false
    endif
    return true
endfunction

function Trig_AntiStuck_Func002Func001C takes nothing returns boolean
    if(not Trig_AntiStuck_Func002Func001Func005C())then
        return false
    endif
    return true
endfunction

function Trig_AntiStuck_Actions takes nothing returns nothing
    set AntiStuckPlayerId = 1
    loop
        exitwhen AntiStuckPlayerId > 8
        if RectContainsUnit(RectMidArena, PlayerHeroes[AntiStuckPlayerId]) and CountUnitsInGroup(GetUnitsInRectMatching(PlayerArenaRects[AntiStuckPlayerId],Condition(function Trig_AntiStuck_Func002Func001Func005Func001001001002))) != 0 then
            call ForGroupBJ(GetUnitsInRectMatching(PlayerArenaRects[AntiStuckPlayerId],Condition( function Trig_Hero_Dies_Func024Func001Func0010010025551) ),function Trig_Hero_Dies_Func024Func001Func001A111a)
        endif

        if(Trig_AntiStuck_Func002Func001C())then
            call CreateNUnitsAtLoc(1,'n00T',Player(11),GetRectCenter(PlayerArenaRects[AntiStuckPlayerId]),bj_UNIT_FACING)
            call SuspendHeroXPBJ(false,PlayerHeroes[AntiStuckPlayerId])
            call UnitDamageTargetBJ(PlayerHeroes[AntiStuckPlayerId],GetLastCreatedUnit(),500,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
            call SuspendHeroXPBJ(true,PlayerHeroes[AntiStuckPlayerId])
        endif

        set AntiStuckPlayerId = AntiStuckPlayerId + 1
    endloop
endfunction

function Trig_Countdown_Func001Func001C takes nothing returns boolean
    if(not(CountdownCount > 0))then
        return false
    endif
    if(not(RoundNumber==1))then
        return false
    endif
    if(not(SpawnedHeroCount < PlayerCount))then
        return false
    endif
    return true
endfunction

function Trig_Countdown_Func001Func002C takes nothing returns boolean
    if(not(CountdownCount > 0))then
        return false
    endif
    if(not(udg_boolean09==false))then
        return false
    endif
    return true
endfunction

function Trig_Countdown_Func001C takes nothing returns boolean
    if(Trig_Countdown_Func001Func001C())then
        return true
    endif
    if(Trig_Countdown_Func001Func002C())then
        return true
    endif
    return false
endfunction

function Trig_Countdown_Conditions takes nothing returns boolean
    if(not Trig_Countdown_Func001C())then
        return false
    endif
    return true
endfunction

function Trig_Countdown_Actions takes nothing returns nothing
    call CreateTextTagLocBJ((I2S(CountdownCount)+ " ..."),udg_location01,0.00,40.00,100,I2R((CountdownCount * 20)),I2R((CountdownCount * 20)),0)
    call SetTextTagPermanentBJ(GetLastCreatedTextTag(),false)
    call SetTextTagFadepointBJ(GetLastCreatedTextTag(),0.80)
    call SetTextTagLifespanBJ(GetLastCreatedTextTag(),1.00)
    call PlaySoundBJ(udg_sound09)
    set CountdownCount =(CountdownCount - 1)
    call TriggerSleepAction(1.00)
    call ConditionalTriggerExecute(GetTriggeringTrigger())
endfunction

function Trig_Defeat_Conditions takes nothing returns boolean
    if(not(PlayerCount==0))then
        return false
    endif
    if(not(IsTriggerEnabled(GetTriggeringTrigger())==true))then
        return false
    endif
    return true
endfunction

function Trig_Defeat_Func012A takes nothing returns nothing
    call CustomDefeatBJ(GetEnumPlayer(),"Defeat!")
endfunction

function Trig_Defeat_Actions takes nothing returns nothing
    call DisableTrigger(GetTriggeringTrigger())
    call DisableTrigger(udg_trigger106)
    call DisableTrigger(udg_trigger107)
    call CinematicFilterGenericBJ(2,BLEND_MODE_BLEND,"ReplaceableTextures\\CameraMasks\\DreamFilter_Mask.blp",50.00,0.00,0.00,100,0,0,0,0)
    call DisplayTimedTextToForce(GetPlayersAll(),30,"|cffffcc00All heroes were slain and everyone was forced to admit defeat!|r")
    call EndThematicMusicBJ()
    call SetMusicVolumeBJ(0.00)
    call PlaySoundBJ(udg_sound06)
    call TriggerSleepAction(2.00)
    call DisplayTimedTextToForce(GetPlayersAll(),26.00,"|cffffcc00But thank you for playing!!|r")
    call TriggerSleepAction(5.00)
    call ForForce(DefeatedPlayers,function Trig_Defeat_Func012A)
endfunction

function Trig_End_Game_Conditions takes nothing returns boolean
    if(not(udg_boolean11==true))then
        return false
    endif
    if(not(IsTriggerEnabled(GetTriggeringTrigger())==true))then
        return false
    endif
    return true
endfunction

function Trig_End_Game_Func003Func007Func001C takes nothing returns boolean
    if((udg_boolean07==true))then
        return true
    endif
    if((ElimModeEnabled==true))then
        return true
    endif
    return false
endfunction

function Trig_End_Game_Func003Func007Func002C takes nothing returns boolean
    if(not(GameModeShort==true))then
        return false
    endif
    if(not(RoundNumber==25))then
        return false
    endif
    if(not(ElimModeEnabled==false))then
        return false
    endif
    return true
endfunction

function Trig_End_Game_Func003Func007Func003C takes nothing returns boolean
    if(not(GameModeShort==false))then
        return false
    endif
    if(not(RoundNumber==50))then
        return false
    endif
    if(not(ElimModeEnabled==false))then
        return false
    endif
    return true
endfunction

function Trig_End_Game_Func003Func007C takes nothing returns boolean
    if(Trig_End_Game_Func003Func007Func001C())then
        return true
    endif
    if(Trig_End_Game_Func003Func007Func002C())then
        return true
    endif
    if(Trig_End_Game_Func003Func007Func003C())then
        return true
    endif
    return false
endfunction

function Trig_End_Game_Func003Func009A takes nothing returns nothing
    call CustomDefeatBJ(GetEnumPlayer(),"Defeat!")
endfunction

function Trig_End_Game_Func003C takes nothing returns boolean
    if(not Trig_End_Game_Func003Func007C())then
        return false
    endif
    return true
endfunction

function Trig_End_Game_Actions takes nothing returns nothing
    if(Trig_End_Game_Func003C())then
        call DisableTrigger(GetTriggeringTrigger())
        set udg_boolean09 = true
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call TriggerSleepAction(8.00)
        call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 120, "The game has finished, you can leave whenever you want.")
    else
    endif
endfunction

function Trig_Playtime_Func002C takes nothing returns boolean
    if(not(Playtime[2]> 59))then
        return false
    endif
    return true
endfunction

function Trig_Playtime_Actions takes nothing returns nothing
    set Playtime[2]=(Playtime[2]+ 1)
    if(Trig_Playtime_Func002C())then
        set Playtime[2]= 0
        set Playtime[1]=(Playtime[1]+ 1)
    else
    endif
endfunction

function Trig_Remove_Selection_Circles_Func001A takes nothing returns nothing
    call DeleteUnit(GetEnumUnit())
endfunction

function Trig_Remove_Selection_Circles_Func002001002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
endfunction

function Trig_Remove_Selection_Circles_Func002A takes nothing returns nothing
    call DeleteUnit(GetEnumUnit())
endfunction

function Trig_Remove_Selection_Circles_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsOfTypeIdAll('ncop'),function Trig_Remove_Selection_Circles_Func001A)
    call ForGroupBJ(GetUnitsOfPlayerMatching(Player(8),Condition(function Trig_Remove_Selection_Circles_Func002001002)),function Trig_Remove_Selection_Circles_Func002A)
endfunction

function Trig_Victory_Func001Func001C takes nothing returns boolean
    if(not(IsTriggerEnabled(GetTriggeringTrigger())==true))then
        return false
    endif
    if(not(InitialPlayerCount > 1))then
        return false
    endif
    if(not(PlayerCount==1))then
        return false
    endif
    if(not(udg_boolean11==false))then
        return false
    endif
    return true
endfunction

function Trig_Victory_Func001Func002Func003Func001C takes nothing returns boolean
    if(not(GameModeShort==true))then
        return false
    endif
    if(not(RoundNumber==25))then
        return false
    endif
    if(not(ElimModeEnabled==false))then
        return false
    endif
    return true
endfunction

function Trig_Victory_Func001Func002Func003Func002C takes nothing returns boolean
    if(not(GameModeShort==false))then
        return false
    endif
    if(not(RoundNumber==50))then
        return false
    endif
    if(not(ElimModeEnabled==false))then
        return false
    endif
    return true
endfunction

function Trig_Victory_Func001Func002Func003C takes nothing returns boolean
    if(Trig_Victory_Func001Func002Func003Func001C())then
        return true
    endif
    if(Trig_Victory_Func001Func002Func003Func002C())then
        return true
    endif
    return false
endfunction

function Trig_Victory_Func001Func002C takes nothing returns boolean
    if(not(InitialPlayerCount==1))then
        return false
    endif
    if(not(PlayerCount==1))then
        return false
    endif
    if(not Trig_Victory_Func001Func002Func003C())then
        return false
    endif
    return true
endfunction

function Trig_Victory_Func001C takes nothing returns boolean
    if(Trig_Victory_Func001Func001C())then
        return true
    endif
    if(Trig_Victory_Func001Func002C())then
        return true
    endif
    return false
endfunction

function Trig_Victory_Conditions takes nothing returns boolean
    if(not Trig_Victory_Func001C())then
        return false
    endif
    return true
endfunction

function Trig_Victory_Func006C takes nothing returns boolean
    if(not(BrStarted==false))then
        return false
    endif
    return true
endfunction

function Trig_Victory_Func011001002001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_Victory_Func011001002002001 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
endfunction

function Trig_Victory_Func011001002002002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(8))
endfunction

function Trig_Victory_Func011001002002002002 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(11))
endfunction

function Trig_Victory_Func011001002002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Victory_Func011001002002002001(),Trig_Victory_Func011001002002002002())
endfunction

function Trig_Victory_Func011001002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Victory_Func011001002002001(),Trig_Victory_Func011001002002002())
endfunction

function Trig_Victory_Func011001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Victory_Func011001002001(),Trig_Victory_Func011001002002())
endfunction

function Trig_Victory_Func011Func002A takes nothing returns nothing
    call SetCameraTargetControllerNoZForPlayer(GetEnumPlayer(),GetEnumUnit(),0,0,false)
    call SelectUnitForPlayerSingle(GetEnumUnit(),GetEnumPlayer())
endfunction

function Trig_Victory_Func011A takes nothing returns nothing
    call ForForce(DefeatedPlayers,function Trig_Victory_Func011Func002A)
endfunction

function Trig_Victory_Func012C takes nothing returns boolean
    if(not(InitialPlayerCount==1))then
        return false
    endif
    if(not(PlayerCount==1))then
        return false
    endif
    return true
endfunction

function Trig_Victory_Actions takes nothing returns nothing
    set udg_boolean11 = true
    call DisableTrigger(GetTriggeringTrigger())
    call DisableTrigger(udg_trigger118)
    call DisableTrigger(udg_trigger80)
    if(Trig_Victory_Func006C())then
        call EnableTrigger(udg_trigger81)
    else
    endif
    call ConditionalTriggerExecute(udg_trigger119)
    call TriggerSleepAction(2)
    if(Trig_Victory_Func012C())then
        call DisplayTimedTextToForce(GetPlayersAll(),30,("|cffffcc00" +("You survived all levels! Congratulations!!")))
    else
        call DisplayTimedTextToForce(GetPlayersAll(),30,((GetPlayerNameColour(WinningPlayer)+ " |cffffcc00survived longer than all other players! Congratulations!!")))
    endif
    call EndThematicMusicBJ()
    call SetMusicVolumeBJ(0.00)
    call PlaySoundBJ(udg_sound05)
    call DisableTrigger(udg_trigger87)
    call TriggerSleepAction(2.00)
    call DisplayTimedTextToForce(GetPlayersAll(),26.00,"|cffffcc00Thank you for playing|r " + "|cff7bff00" + VERSION + "|r")
endfunction

function Trig_Camera_Command_Func001C takes nothing returns boolean
    if(not(SubStringBJ(StringCase(GetEventPlayerChatString(),false),2,7)=="camera"))then
        return false
    endif
    return true
endfunction

function Trig_Camera_Command_Func002Func001C takes nothing returns boolean
    if(not(S2I(SubStringBJ(GetEventPlayerChatString(),BettingPlayerCount,StringLength(GetEventPlayerChatString())))> 2800))then
        return false
    endif
    return true
endfunction

function Trig_Camera_Command_Func002C takes nothing returns boolean
    if(not(S2I(SubStringBJ(GetEventPlayerChatString(),BettingPlayerCount,StringLength(GetEventPlayerChatString())))>= 1650))then
        return false
    endif
    if(not(S2I(SubStringBJ(GetEventPlayerChatString(),BettingPlayerCount,StringLength(GetEventPlayerChatString())))<= 2800))then
        return false
    endif
    return true
endfunction

function Trig_Camera_Command_Actions takes nothing returns nothing
    if(Trig_Camera_Command_Func001C())then
        set BettingPlayerCount = 9
    else
        set BettingPlayerCount = 6
    endif
    if(Trig_Camera_Command_Func002C())then
        call SetCameraFieldForPlayer(GetTriggerPlayer(),CAMERA_FIELD_TARGET_DISTANCE,S2R(SubStringBJ(GetEventPlayerChatString(),BettingPlayerCount,StringLength(GetEventPlayerChatString()))),0.50)
    else
        if(Trig_Camera_Command_Func002Func001C())then
            call SetCameraFieldForPlayer(GetTriggerPlayer(),CAMERA_FIELD_TARGET_DISTANCE,2800.00,0.50)
        else
            call SetCameraFieldForPlayer(GetTriggerPlayer(),CAMERA_FIELD_TARGET_DISTANCE,1650.00,0.50)
        endif
    endif
endfunction

function Trig_Clear_Command_Func001001001 takes nothing returns boolean
    return(GetFilterPlayer()==GetTriggerPlayer())
endfunction

function Trig_Clear_Command_Actions takes nothing returns nothing
    call ClearTextMessagesBJ(GetPlayersMatching(Condition(function Trig_Clear_Command_Func001001001)))
endfunction

/*
function Trig_Hint_Command_Func001Func002001001 takes nothing returns boolean
    return(GetFilterPlayer()==GetTriggerPlayer())
endfunction

function Trig_Hint_Command_Func001Func004001001 takes nothing returns boolean
    return(GetFilterPlayer()==GetTriggerPlayer())
endfunction

function Trig_Hint_Command_Func001C takes nothing returns boolean
    if(not(IsPlayerInForce(GetTriggerPlayer(),udg_force06)==true))then
        return false
    endif
    return true
endfunction

function Trig_Hint_Command_Actions takes nothing returns nothing
    if(Trig_Hint_Command_Func001C())then
        call ForceRemovePlayerSimple(GetTriggerPlayer(),udg_force06)
        call DisplayTimedTextToForce(GetPlayersMatching(Condition(function Trig_Hint_Command_Func001Func004001001)),3.00,"|cff959697Display Hints: ON|r")
    else
        call ForceAddPlayerSimple(GetTriggerPlayer(),udg_force06)
        call DisplayTimedTextToForce(GetPlayersMatching(Condition(function Trig_Hint_Command_Func001Func002001001)),3.00,"|cff959697Display Hints: OFF|r")
    endif
endfunction
*/

function Trig_Level_Command_Actions takes nothing returns nothing
    call ForceAddPlayerSimple(GetTriggerPlayer(),bj_FORCE_PLAYER[11])
    call DisplayTextToForce(bj_FORCE_PLAYER[11],("|c00F08000Level " +(I2S(RoundNumber)+ "|r")))
    call ForceRemovePlayerSimple(GetTriggerPlayer(),bj_FORCE_PLAYER[11])
endfunction

function Trig_Movement_Speed_Command_Conditions takes nothing returns boolean
    if(not(IsUnitAliveBJ(PlayerHeroes[GetConvertedPlayerId(GetTriggerPlayer())])==true))then
        return false
    endif
    return true
endfunction

function Trig_Movement_Speed_Command_Actions takes nothing returns nothing
    call ForceAddPlayerSimple(GetTriggerPlayer(),bj_FORCE_PLAYER[11])
    call DisplayTextToForce(bj_FORCE_PLAYER[11],("|c00F08000Current Movement Speed: " +(I2S(R2I(GetUnitMoveSpeed(PlayerHeroes[GetConvertedPlayerId(GetTriggerPlayer())])))+ "|r")))
    call ForceRemovePlayerSimple(GetTriggerPlayer(),bj_FORCE_PLAYER[11])
endfunction

function Trig_Playtime_Command_Func002Func001Func001Func003C takes nothing returns boolean
    if(not(Playtime[1]!=1))then
        return false
    endif
    if(not(Playtime[2]==1))then
        return false
    endif
    return true
endfunction

function Trig_Playtime_Command_Func002Func001Func001C takes nothing returns boolean
    if(not Trig_Playtime_Command_Func002Func001Func001Func003C())then
        return false
    endif
    return true
endfunction

function Trig_Playtime_Command_Func002Func001Func003C takes nothing returns boolean
    if(not(Playtime[1]==1))then
        return false
    endif
    if(not(Playtime[2]!=1))then
        return false
    endif
    return true
endfunction

function Trig_Playtime_Command_Func002Func001C takes nothing returns boolean
    if(not Trig_Playtime_Command_Func002Func001Func003C())then
        return false
    endif
    return true
endfunction

function Trig_Playtime_Command_Func002Func003C takes nothing returns boolean
    if(not(Playtime[1]==1))then
        return false
    endif
    if(not(Playtime[2]==1))then
        return false
    endif
    return true
endfunction

function Trig_Playtime_Command_Func002C takes nothing returns boolean
    if(not Trig_Playtime_Command_Func002Func003C())then
        return false
    endif
    return true
endfunction

function Trig_Playtime_Command_Actions takes nothing returns nothing
    call ForceAddPlayerSimple(GetTriggerPlayer(),bj_FORCE_PLAYER[11])
    if(Trig_Playtime_Command_Func002C())then
        call DisplayTextToForce(bj_FORCE_PLAYER[11],("|c00F08000Current Playtime: " +((I2S(Playtime[1])+(" minute and " +(I2S(Playtime[2])+ " second")))+ "|r")))
    else
        if(Trig_Playtime_Command_Func002Func001C())then
            call DisplayTextToForce(bj_FORCE_PLAYER[11],("|c00F08000Current Playtime: " +((I2S(Playtime[1])+(" minute and " +(I2S(Playtime[2])+ " seconds")))+ "|r")))
        else
            if(Trig_Playtime_Command_Func002Func001Func001C())then
                call DisplayTextToForce(bj_FORCE_PLAYER[11],("|c00F08000Current Playtime: " +((I2S(Playtime[1])+(" minutes and " +(I2S(Playtime[2])+ " second")))+ "|r")))
            else
                call DisplayTextToForce(bj_FORCE_PLAYER[11],("|c00F08000Current Playtime: " +((I2S(Playtime[1])+(" minutes and " +(I2S(Playtime[2])+ " seconds")))+ "|r")))
            endif
        endif
    endif
    call ForceRemovePlayerSimple(GetTriggerPlayer(),bj_FORCE_PLAYER[11])
endfunction

function Trig_Player_Leaves_Conditions takes nothing returns boolean
    if(not(IsPlayerInForce(GetTriggerPlayer(),DefeatedPlayers)!=true))then
        return false
    endif
    return true
endfunction

function Trig_Player_Leaves_Func005001 takes nothing returns boolean
    return(GetTriggerPlayer()==udg_player03)
endfunction

function Trig_Player_Leaves_Func007Func001Func002001001002001 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
endfunction

function Trig_Player_Leaves_Func007Func001Func002001001002002 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_Player_Leaves_Func007Func001Func002001001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Player_Leaves_Func007Func001Func002001001002001(),Trig_Player_Leaves_Func007Func001Func002001001002002())
endfunction

function Trig_Player_Leaves_Func007Func001C takes nothing returns boolean
    if(not(RoundNumber==0))then
        return false
    endif
    if(not(CountUnitsInGroup(GetUnitsOfPlayerMatching(GetTriggerPlayer(),Condition(function Trig_Player_Leaves_Func007Func001Func002001001002)))==0))then
        return false
    endif
    return true
endfunction

function Trig_Player_Leaves_Func007Func003002001001002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
endfunction

function Trig_Player_Leaves_Func007C takes nothing returns boolean
    if(not Trig_Player_Leaves_Func007Func001C())then
        return false
    endif
    return true
endfunction

function ResetHero takes unit u returns nothing

    if IsUnitType(u, UNIT_TYPE_HERO) then
        call RemoveItem(UnitItemInSlot(u, 0))
        call RemoveItem(UnitItemInSlot(u, 1))
        call RemoveItem(UnitItemInSlot(u, 2))
        call RemoveItem(UnitItemInSlot(u, 3))
        call RemoveItem(UnitItemInSlot(u, 4))
        call RemoveItem(UnitItemInSlot(u, 5))

        call RemoveHeroAbilities(u)
    endif
    call UnitRemoveAbility(u, 'ANr2')
endfunction

function Trig_Player_Leaves_Actions takes nothing returns nothing
    local integer pid = GetPlayerId(GetTriggerPlayer()) + 1
    call PlaySoundBJ(udg_sound04)
    call ForceAddPlayerSimple(GetTriggerPlayer(),udg_force07)
    call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(GetTriggerPlayer()))+ " |cffffcc00has left the game!|r"))
    call ResetHero(PlayerHeroes[pid])
    if(Trig_Player_Leaves_Func005001())then
        call ConditionalTriggerExecute(udg_trigger131)
    else
        call DoNothing()
    endif
    if(Trig_Player_Leaves_Func007C())then
        set SpawnedHeroCount =(SpawnedHeroCount + 1)
        call CreateNUnitsAtLoc(1,GetUnitTypeId(GroupPickRandomUnit(GetUnitsOfPlayerMatching(Player(8),Condition(function Trig_Player_Leaves_Func007Func003002001001002)))),GetTriggerPlayer(),GetRectCenter(PlayerArenaRects[GetConvertedPlayerId(GetTriggerPlayer())]),bj_UNIT_FACING)
        call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(GetTriggerPlayer())+(" |cffffcc00has randomed " +(GetUnitName(GetLastCreatedUnit())+ "! (+5 bonus gold)")))))
        call AdjustPlayerStateBJ(5,GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)
        call ResourseRefresh(GetTriggerPlayer() )
        set PlayerHeroes[GetConvertedPlayerId(GetTriggerPlayer())]= GetLastCreatedUnit()
        call UnitAddItemByIdSwapped('ankh',GetLastCreatedUnit())
        call UnitAddItemByIdSwapped('pghe',GetLastCreatedUnit())
        call ResetToGameCameraForPlayer(GetTriggerPlayer(),0)
        call PanCameraToTimedLocForPlayer(GetTriggerPlayer(),GetRectCenter(PlayerArenaRects[GetConvertedPlayerId(GetTriggerPlayer())]),0.10)
        call SelectUnitForPlayerSingle(GetLastCreatedUnit(),GetTriggerPlayer())
        call TriggerSleepAction(2)
        call ResetToGameCameraForPlayer(GetTriggerPlayer(),0)
    else
    endif
endfunction

function Trig_Spacebar_Point_Func001001002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
endfunction

function Trig_Spacebar_Point_Func001A takes nothing returns nothing
    call SetCameraQuickPositionLocForPlayer(GetOwningPlayer(GetEnumUnit()),GetUnitLoc(GetEnumUnit()))
endfunction

function Trig_Spacebar_Point_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_Spacebar_Point_Func001001002)),function Trig_Spacebar_Point_Func001A)
endfunction

function Trig_Select_Game_Master_Func001Func001C takes nothing returns boolean
    if(not(GetPlayerController(ConvertedPlayer(GetForLoopIndexA()))==MAP_CONTROL_USER))then
        return false
    endif
    if(not(GetPlayerSlotState(ConvertedPlayer(GetForLoopIndexA()))==PLAYER_SLOT_STATE_PLAYING))then
        return false
    endif
    return true
endfunction

function Trig_Select_Game_Master_Actions takes nothing returns nothing
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 8
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if(Trig_Select_Game_Master_Func001Func001C())then
            set udg_player03 = ConvertedPlayer(GetForLoopIndexA())
            exitwhen true
        else
        endif
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
endfunction

function Trig_Kick_Player_Command_Conditions takes nothing returns boolean
    if(not(GetTriggerPlayer()==udg_player03))then
        return false
    endif
    return true
endfunction

function Trig_Kick_Player_Command_Func002001001001001 takes nothing returns boolean
    return(IsPlayerInForce(GetFilterPlayer(),udg_force07)!=true)
endfunction

function Trig_Kick_Player_Command_Func002001001001002 takes nothing returns boolean
    return(GetFilterPlayer()!=udg_player03)
endfunction

function Trig_Kick_Player_Command_Func002001001001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Kick_Player_Command_Func002001001001001(),Trig_Kick_Player_Command_Func002001001001002())
endfunction

function Trig_Kick_Player_Command_Func002001001002 takes nothing returns boolean
    return(StringCase(GetPlayerName(GetFilterPlayer()),false)==StringCase(SubStringBJ(GetEventPlayerChatString(),7,StringLength(GetEventPlayerChatString())),false))
endfunction

function Trig_Kick_Player_Command_Func002001001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Kick_Player_Command_Func002001001001(),Trig_Kick_Player_Command_Func002001001002())
endfunction

function Trig_Kick_Player_Command_Func002A takes nothing returns nothing
    set udg_boolean17 = true
    call PlaySoundBJ(udg_sound04)
    call ForceAddPlayerSimple(GetEnumPlayer(),udg_force07)
    call CustomDefeatBJ(GetEnumPlayer(),"Kicked!")
    call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(GetEnumPlayer())+ "|cffffcc00 was kicked out of the game!|r")))
endfunction

function Trig_Kick_Player_Command_Func003001 takes nothing returns boolean
    return(udg_boolean17==true)
endfunction

function Trig_Kick_Player_Command_Func004001001 takes nothing returns boolean
    return(GetFilterPlayer()==GetTriggerPlayer())
endfunction
/*
function KickPlayer takes player p returns nothing
    set udg_boolean17 = true
    call PlaySoundBJ(udg_sound04)
    call ForceAddPlayerSimple(p,udg_force07)
    call CustomDefeatBJ(p,"Kicked!")
    call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(p)+ "|cffffcc00 was kicked out of the game!|r")))
endfunction

function Trig_Kick_Player_Command_Actions takes nothing returns nothing
    local string command = SubStringBJ(GetEventPlayerChatString(),7,StringLength(GetEventPlayerChatString()))
    set udg_boolean17 = false
    if command == "red" then
        call KickPlayer(Player(0))
    elseif command == "blue" then
        call KickPlayer(Player(1))
    elseif command == "teal" then
        call KickPlayer(Player(2))
    elseif command == "purple" then
        call KickPlayer(Player(3))
    elseif command == "yellow" then
        call KickPlayer(Player(4))
    elseif command == "orange" then
        call KickPlayer(Player(5))
    elseif command == "green" then
        call KickPlayer(Player(6))
    elseif command == "pink" then
        call KickPlayer(Player(7))
    else
        call ForForce(GetPlayersMatching(Condition(function Trig_Kick_Player_Command_Func002001001)),function Trig_Kick_Player_Command_Func002A)
        if(Trig_Kick_Player_Command_Func003001())then
            return
        else
            call DoNothing()
        endif
        call DisplayTimedTextToForce(GetPlayersMatching(Condition(function Trig_Kick_Player_Command_Func004001001)),5.00,("|cffffcc00" +("Couldn't kick player \"" +(SubStringBJ(GetEventPlayerChatString(),7,StringLength(GetEventPlayerChatString()))+ "\"|r"))))
    endif
endfunction */

function Trig_Player_Selection_Camera_Func001001 takes nothing returns boolean
    return(udg_boolean12==true)
endfunction

function Trig_Player_Selection_Camera_Func002001001 takes nothing returns boolean
    return(IsPlayerInForce(GetFilterPlayer(),udg_PlayersWithHero)!=true)
endfunction

function Trig_Player_Selection_Camera_Func002A takes nothing returns nothing
    call CameraSetupApplyForPlayer(true,udg_camerasetup01,GetEnumPlayer(),0.00)
endfunction

function Trig_Player_Selection_Camera_Actions takes nothing returns nothing
    if(Trig_Player_Selection_Camera_Func001001())then
        call DisableTrigger(GetTriggeringTrigger())
    else
        call DoNothing()
    endif
    call ForForce(GetPlayersMatching(Condition(function Trig_Player_Selection_Camera_Func002001001)),function Trig_Player_Selection_Camera_Func002A)
endfunction

/*
function Trig_PvP_Func002001002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(8))
endfunction

function Trig_PvP_Func002001002002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(11))
endfunction

function Trig_PvP_Func002001002002002001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_PvP_Func002001002002002002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
endfunction

function Trig_PvP_Func002001002002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_PvP_Func002001002002002001(),Trig_PvP_Func002001002002002002())
endfunction

function Trig_PvP_Func002001002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_PvP_Func002001002002001(),Trig_PvP_Func002001002002002())
endfunction
*/

function Trig_PvP_Func002001002 takes nothing returns boolean
    return IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO) and UnitAlive(GetFilterUnit()) and GetOwningPlayer(GetFilterUnit())!=Player(11) and GetOwningPlayer(GetFilterUnit())!=Player(8)
endfunction

function Trig_PvP_Func002A takes nothing returns nothing
    call GroupAddUnitSimple(GetEnumUnit(),PotentialDuelHeroes)
endfunction

function Trig_PvP_Func004Func001Func001001 takes nothing returns boolean
    return(RoundNumber==20)
endfunction

function Trig_PvP_Func004Func001Func002001 takes nothing returns boolean
    return(RoundNumber==30)
endfunction

function Trig_PvP_Func004Func001Func003001 takes nothing returns boolean
    return(RoundNumber==40)
endfunction

function Trig_PvP_Func004Func001Func004001 takes nothing returns boolean
    return(RoundNumber==10)
endfunction

function Trig_PvP_Func004Func001Func005001 takes nothing returns boolean
    return(RoundNumber==15)
endfunction

function Trig_PvP_Func004Func001Func006001 takes nothing returns boolean
    return(RoundNumber==20)
endfunction

function Trig_PvP_Func004Func001C takes nothing returns boolean
    if(not(GameModeShort==true))then
        return false
    endif
    return true
endfunction

function Trig_PvP_Func004Func002001 takes nothing returns boolean
    return(udg_integer15=='I01D')
endfunction

function Trig_PvP_Func004Func003001 takes nothing returns boolean
    return(udg_integer15=='I01C')
endfunction

function Trig_PvP_Func004Func004001 takes nothing returns boolean
    return(udg_integer15=='I01E')
endfunction

function Trig_PvP_Func004A takes nothing returns nothing
    if(Trig_PvP_Func004Func001C())then
        if(Trig_PvP_Func004Func001Func004001())then
            call AdjustPlayerStateBJ(200,GetOwningPlayer(GetEnumUnit()),PLAYER_STATE_RESOURCE_GOLD)
        else
            call DoNothing()
        endif
        if(Trig_PvP_Func004Func001Func005001())then
            call AdjustPlayerStateBJ(400,GetOwningPlayer(GetEnumUnit()),PLAYER_STATE_RESOURCE_GOLD)
        else
            call DoNothing()
        endif
        if(Trig_PvP_Func004Func001Func006001())then
            call AdjustPlayerStateBJ(800,GetOwningPlayer(GetEnumUnit()),PLAYER_STATE_RESOURCE_GOLD)
        else
            call DoNothing()
        endif
    else
        if(Trig_PvP_Func004Func001Func001001())then
            call AdjustPlayerStateBJ(200,GetOwningPlayer(GetEnumUnit()),PLAYER_STATE_RESOURCE_GOLD)
        else
            call DoNothing()
        endif
        if(Trig_PvP_Func004Func001Func002001())then
            call AdjustPlayerStateBJ(400,GetOwningPlayer(GetEnumUnit()),PLAYER_STATE_RESOURCE_GOLD)
        else
            call DoNothing()
        endif
        if(Trig_PvP_Func004Func001Func003001())then
            call AdjustPlayerStateBJ(800,GetOwningPlayer(GetEnumUnit()),PLAYER_STATE_RESOURCE_GOLD)
        else
            call DoNothing()
        endif
    endif
    if(Trig_PvP_Func004Func002001())then
        call AdjustPlayerStateBJ(1400,GetOwningPlayer(GetEnumUnit()),PLAYER_STATE_RESOURCE_GOLD)
    else
        call DoNothing()
    endif
    if(Trig_PvP_Func004Func003001())then
        call AdjustPlayerStateBJ(1750,GetOwningPlayer(GetEnumUnit()),PLAYER_STATE_RESOURCE_GOLD)
    else
        call DoNothing()
    endif
    if(Trig_PvP_Func004Func004001())then
        call AdjustPlayerStateBJ(2750,GetOwningPlayer(GetEnumUnit()),PLAYER_STATE_RESOURCE_GOLD)
    else
        call DoNothing()
    endif

    call ResourseRefresh(GetOwningPlayer(GetEnumUnit()) )
endfunction

function Trig_PvP_Func007C takes nothing returns boolean
    if(not(udg_boolean07==true))then
        return false
    endif
    return true
endfunction

function Trig_PvP_Actions takes nothing returns nothing
    call TriggerSleepAction(5.00)
    call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_PvP_Func002001002)),function Trig_PvP_Func002A)
    call ForGroupBJ(DuelWinners,function Trig_PvP_Func004A)
    call GroupClear(DuelWinners)
    if(Trig_PvP_Func007C())then
        call DisplayTextToForce(GetPlayersAll(),"|cffffcc00Death Match - Survive to advance to the next level!")
    else
        /*
        call UpdatePlayerCount()
        call MoveRoundRobin()
        call DisplayDuelNemesis()*/
    endif
    call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
    call CreateTimerDialogBJ(GetLastCreatedTimerBJ(),"PvP Battle")
    call StartTimerBJ(GetLastCreatedTimerBJ(),false,15.00)
    call DisplayTimedTextToForce(GetPlayersAll(), 15, "|cff9dff00You can freely use items during PvP. They will be restored when finished.|r \n|cffff5050You will lose any items bought during the duel.\n|r|cffffcc00If there is an odd amount of players, losing a duel might mean you could duel again vs the last player.|r")
    call TriggerSleepAction(15.00)
    call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
    call ConditionalTriggerExecute(udg_trigger136)
endfunction

function Trig_End_PvP_Conditions takes nothing returns boolean
    if(not(IsUnitInGroup(GetTriggerUnit(),DuelingHeroGroup)==true))then
        return false
    endif
    return true
endfunction

function Trig_End_PvP_Func001C takes nothing returns boolean
    if(not(DuelingHeroes[1]==GetTriggerUnit()))then
        return false
    endif
    return true
endfunction

function Trig_End_PvP_Func019A takes nothing returns nothing
    call PanCameraToTimedLocForPlayer(GetEnumPlayer(),GetRectCenter(RectMidArena),0.20)
endfunction

function Trig_End_PvP_Func021Func001Func001C takes nothing returns boolean
    if(not(DuelingHeroes[1]==udg_unit05))then
        return false
    endif
    return true
endfunction

function Trig_End_PvP_Func021C takes nothing returns boolean
    if(not(udg_boolean07==false))then
        return false
    endif
    return true
endfunction

function Trig_End_PvP_Func024Func001A takes nothing returns nothing
    call RemoveItem(GetEnumItem())
endfunction

function Trig_End_PvP_Func026Func007001002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(8))
endfunction

function Trig_End_PvP_Func026Func007001002002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())==Player(11))
endfunction

function Trig_End_PvP_Func026Func007001002002002001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_End_PvP_Func026Func007001002002002002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
endfunction

function Trig_End_PvP_Func026Func007001002002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_End_PvP_Func026Func007001002002002001(),Trig_End_PvP_Func026Func007001002002002002())
endfunction

function Trig_End_PvP_Func026Func007001002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_End_PvP_Func026Func007001002002001(),Trig_End_PvP_Func026Func007001002002002())
endfunction

function Trig_End_PvP_Func026Func007001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_End_PvP_Func026Func007001002001(),Trig_End_PvP_Func026Func007001002002())
endfunction

function Trig_End_PvP_Func026Func007A takes nothing returns nothing
    call SetUnitPositionLoc(GetEnumUnit(),GetRectCenter(RectMidArena))
endfunction

function Trig_End_PvP_Func026Func008Func003C takes nothing returns boolean
    if(not(CountUnitsInGroup(DuelWinners)> 1))then
        return false
    endif
    return true
endfunction

function Trig_End_PvP_Func026Func008C takes nothing returns boolean
    if(not(PlayerCount > 1))then
        return false
    endif
    return true
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func001Func001Func002001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==1)
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func001Func001Func003001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==2)
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func001Func001Func004001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==3)
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func001Func001Func005001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==4)
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func001Func001Func006001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==5)
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func001Func001C takes nothing returns boolean
    if(not(RoundNumber==40))then
        return false
    endif
    return true
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func001Func003001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==1)
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func001Func004001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==2)
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func001Func005001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==3)
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func001Func006001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==4)
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func001C takes nothing returns boolean
    if(not(RoundNumber==30))then
        return false
    endif
    return true
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func003001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==1)
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func004001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==2)
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func005001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==3)
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func006001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==4)
endfunction

function Trig_End_PvP_Func026Func016Func001Func001C takes nothing returns boolean
    if(not(RoundNumber==20))then
        return false
    endif
    return true
endfunction

function Trig_End_PvP_Func026Func016Func001Func003001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==1)
endfunction

function Trig_End_PvP_Func026Func016Func001Func004001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==2)
endfunction

function Trig_End_PvP_Func026Func016Func001Func005001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==3)
endfunction

function Trig_End_PvP_Func026Func016Func001Func006001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==4)
endfunction

function Trig_End_PvP_Func026Func016Func001C takes nothing returns boolean
    if(not(RoundNumber==10))then
        return false
    endif
    return true
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func001Func001Func002001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==1)
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func001Func001Func003001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==2)
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func001Func001Func004001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==3)
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func001Func001Func005001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==4)
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func001Func001Func006001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==5)
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func001Func001C takes nothing returns boolean
    if(not(RoundNumber==20))then
        return false
    endif
    return true
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func001Func003001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==1)
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func001Func004001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==2)
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func001Func005001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==3)
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func001Func006001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==4)
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func001C takes nothing returns boolean
    if(not(RoundNumber==15))then
        return false
    endif
    return true
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func003001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==1)
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func004001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==2)
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func005001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==3)
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func006001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==4)
endfunction

function Trig_End_PvP_Func026Func016Func002Func001C takes nothing returns boolean
    if(not(RoundNumber==10))then
        return false
    endif
    return true
endfunction

function Trig_End_PvP_Func026Func016Func002Func003001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==1)
endfunction

function Trig_End_PvP_Func026Func016Func002Func004001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==2)
endfunction

function Trig_End_PvP_Func026Func016Func002Func005001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==3)
endfunction

function Trig_End_PvP_Func026Func016Func002Func006001 takes nothing returns boolean
    return(RoundCreepAbilCastChance==4)
endfunction

function Trig_End_PvP_Func026Func016Func002C takes nothing returns boolean
    if(not(RoundNumber==5))then
        return false
    endif
    return true
endfunction

function Trig_End_PvP_Func026Func016C takes nothing returns boolean
    if(not(GameModeShort==true))then
        return false
    endif
    return true
endfunction

function Trig_End_PvP_Func026Func018Func002A takes nothing returns nothing
    call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\Human\\Resurrect\\ResurrectCaster.mdl")
    call DestroyEffectBJ(GetLastCreatedEffectBJ())
endfunction

function Trig_End_PvP_Func026Func018C takes nothing returns boolean
    if(not(udg_boolean07==false))then
        return false
    endif
    return true
endfunction

function Trig_End_PvP_Func026C takes nothing returns boolean
    if(not(CountUnitsInGroup(PotentialDuelHeroes)==0))then
        return false
    endif
    return true
endfunction

function Trig_End_PvP_Actions takes nothing returns nothing
    local real bonus = 1
    if(Trig_End_PvP_Func001C())then
        set udg_unit05 = DuelingHeroes[2]
    else
        set udg_unit05 = DuelingHeroes[1]
    endif
    call DisableTrigger(udg_trigger140)
    call DisableTrigger(udg_trigger141)
    call PvpStopSuddenDeathTimer()
    call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(GetOwningPlayer(udg_unit05))+(" |cffffcc00has defeated |r" +(GetPlayerNameColour(GetOwningPlayer(GetDyingUnit()))+ "|cffffcc00!!|r")))))
    call SetUnitInvulnerable(udg_unit05,true)

    //Midas Touch
    if GetMidasTouch(GetHandleId(GetDyingUnit())) != 0 then
        call CreepDeath_BountyText(udg_unit05, GetDyingUnit(), GetMidasTouch(GetHandleId(GetDyingUnit())).bonus)
        if ChestOfGreedBonus.boolean[GetHandleId(GetDyingUnit())] then
            set bonus = CgBonus
        endif
        call SetPlayerState(GetOwningPlayer(udg_unit05), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(udg_unit05), PLAYER_STATE_RESOURCE_GOLD) + R2I(GetMidasTouch(GetHandleId(GetDyingUnit())).bonus * bonus))
        set GetMidasTouch(GetHandleId(GetDyingUnit())).stop = true
    endif

    call TriggerSleepAction(4.00)
    if IsUnitInGroup(udg_unit05, DuelWinners) == false then
        call GroupAddUnitSimple(udg_unit05,DuelWinners)
    endif
    call FunWinner( udg_unit05 )
    //call GroupRemoveUnitSimple(GetDyingUnit(),DuelWinners)
    call GroupRemoveUnitSimple(udg_unit05,DuelingHeroGroup)
    call GroupRemoveUnitSimple(GetDyingUnit(),DuelingHeroGroup)
    call ForceAddPlayer(DuelLosers, GetOwningPlayer(GetDyingUnit()))
    call SetPlayerAllianceStateBJ(GetOwningPlayer(DuelingHeroes[1]),GetOwningPlayer(DuelingHeroes[2]),bj_ALLIANCE_UNALLIED)
    call SetPlayerAllianceStateBJ(GetOwningPlayer(DuelingHeroes[2]),GetOwningPlayer(DuelingHeroes[1]),bj_ALLIANCE_UNALLIED)
    call ForForce(GetPlayersAll(),function Trig_End_PvP_Func019A)
    call SetUnitPositionLoc(udg_unit05,GetRectCenter(RectMidArena))
    if(Trig_End_PvP_Func021C())then
        call ReviveHeroLoc(GetDyingUnit(),GetRectCenter(RectMidArena),true)
        call FixDeath(GetDyingUnit())
        set PvpEndIndex = 1
        loop
            exitwhen PvpEndIndex > 6
            call RemoveItem(UnitItemInSlotBJ(DuelingHeroes[1],PvpEndIndex))
            call RemoveItem(UnitItemInSlotBJ(DuelingHeroes[2],PvpEndIndex))
            call UnitAddItemByIdSwapped(DuelHeroItemIds1[PvpEndIndex],DuelingHeroes[1])
            if UnitDropItemSlotBJ(DuelingHeroes[1],GetLastCreatedItem(),PvpEndIndex) then
                //call BJDebugMsg("1a item move success")
            else
                //call BJDebugMsg("1a item move fail")
            endif
            call UnitAddItemByIdSwapped(DuelHeroItemIds2[PvpEndIndex],DuelingHeroes[2])
            if UnitDropItemSlotBJ(DuelingHeroes[2],GetLastCreatedItem(),PvpEndIndex) then
                //call BJDebugMsg("2a item move success")
            else
                //call BJDebugMsg("2a item move fail")
            endif
            set PvpEndIndex = PvpEndIndex + 1
        endloop
    else
        set PvpEndIndex = 1
        loop
            exitwhen PvpEndIndex > 6
            if(Trig_End_PvP_Func021Func001Func001C())then
                call RemoveItem(UnitItemInSlotBJ(DuelingHeroes[1],PvpEndIndex))
                call UnitAddItemByIdSwapped(DuelHeroItemIds1[PvpEndIndex],DuelingHeroes[1])
                if UnitDropItemSlotBJ(DuelingHeroes[1],GetLastCreatedItem(),PvpEndIndex) then
                    //call BJDebugMsg("1b item move success")
                else
                   //call BJDebugMsg("1b item move fail")
                endif
            else
                call RemoveItem(UnitItemInSlotBJ(DuelingHeroes[2],PvpEndIndex))
                call UnitAddItemByIdSwapped(DuelHeroItemIds2[PvpEndIndex],DuelingHeroes[2])
                if UnitDropItemSlotBJ(DuelingHeroes[2],GetLastCreatedItem(),PvpEndIndex) then
                    //call BJDebugMsg("2b item move success")
                else
                    //call BJDebugMsg("2b item move fail")
                endif
            endif
            call SetItemPawnable(UnitItemInSlotBJ(DuelingHeroes[1],PvpEndIndex), true)
            call SetItemPawnable(UnitItemInSlotBJ(DuelingHeroes[2],PvpEndIndex), true)
            set PvpEndIndex = PvpEndIndex + 1
        endloop
    endif
    call ConditionalTriggerExecute(udg_trigger54)
    call ConditionalTriggerExecute(udg_trigger122)
    set udg_integer38 = 1
    loop
        exitwhen udg_integer38 > 8
        call EnumItemsInRectBJ(PlayerArenaRects[udg_integer38],function Trig_End_PvP_Func024Func001A)
        set udg_integer38 = udg_integer38 + 1
    endloop
    set udg_unit05 = null
    call SetCurrentlyFighting(GetOwningPlayer(DuelingHeroes[1]), false)
    call SetCurrentlyFighting(GetOwningPlayer(DuelingHeroes[2]), false)
    if(Trig_End_PvP_Func026C())then
        call TriggerSleepAction(2)
        call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_End_PvP_Func026Func007001002)),function Trig_End_PvP_Func026Func007A)
        if(Trig_End_PvP_Func026Func008C())then
        else
            return
        endif
        call ForceClear(DuelLosers)
        set udg_integer41 =(udg_integer41 + 1)
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call TriggerSleepAction(1.00)

        if(Trig_End_PvP_Func026Func016C())then
            set udg_integer15 = DuelGoldReward[RoundNumber]
        else
            set udg_integer15 = DuelGoldReward[RoundNumber]		
        endif
        if(Trig_End_PvP_Func026Func018C())then
            call ForGroupBJ(DuelWinners,function Trig_End_PvP_Func026Func018Func002A)
        endif
        call PlaySoundBJ(udg_sound07)
        call ConditionalTriggerExecute(udg_trigger138)
        call DisplayTimedTextToForce(GetPlayersAll(),10.00,("|cffffcc00The PvP battles are over and all winners receive:|r |cff3bc739" + (I2S(udg_integer15) + " gold|r")))
        call ConditionalTriggerExecute(udg_trigger136)
    else
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call CreateTimerDialogBJ(GetLastCreatedTimerBJ(),"Next PvP Battle ...")
        call StartTimerBJ(GetLastCreatedTimerBJ(),false,10.00)
        call TriggerSleepAction(10.00)
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call ConditionalTriggerExecute(udg_trigger136)
    endif
endfunction

function Trig_PvP_Battle_Func001Func001001 takes nothing returns boolean
    return(IsTriggerEnabled(udg_trigger119)==false)
endfunction

function Trig_PvP_Battle_Func001Func008002001002001 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
endfunction

function Trig_PvP_Battle_Func001Func008002001002002001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_PvP_Battle_Func001Func008002001002002002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(8))
endfunction

function Trig_PvP_Battle_Func001Func008002001002002002002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(11))
endfunction

function Trig_PvP_Battle_Func001Func008002001002002002002002 takes nothing returns boolean
    return(IsUnitInGroup(GetFilterUnit(),PotentialDuelHeroes)==true)
endfunction

function Trig_PvP_Battle_Func001Func008002001002002002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_PvP_Battle_Func001Func008002001002002002002001(),Trig_PvP_Battle_Func001Func008002001002002002002002())
endfunction

function Trig_PvP_Battle_Func001Func008002001002002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_PvP_Battle_Func001Func008002001002002002001(),Trig_PvP_Battle_Func001Func008002001002002002002())
endfunction

function Trig_PvP_Battle_Func001Func008002001002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_PvP_Battle_Func001Func008002001002002001(),Trig_PvP_Battle_Func001Func008002001002002002())
endfunction

function Trig_PvP_Battle_Func001Func008002001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_PvP_Battle_Func001Func008002001002001(),Trig_PvP_Battle_Func001Func008002001002002())
endfunction

function Trig_PvP_Battle_Func001Func010Func001002001002001 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
endfunction

function Trig_PvP_Battle_Func001Func010Func001002001002002001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_PvP_Battle_Func001Func010Func001002001002002002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(8))
endfunction

function Trig_PvP_Battle_Func001Func010Func001002001002002002002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(11))
endfunction

function Trig_PvP_Battle_Func001Func010Func001002001002002002002002 takes nothing returns boolean
    return IsPlayerInForce(GetOwningPlayer(GetFilterUnit()), DuelLosers) and GetFilterUnit() != DuelingHeroes[1]
endfunction

function Trig_PvP_Battle_Func001Func010Func001002001002002002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_PvP_Battle_Func001Func010Func001002001002002002002001(),Trig_PvP_Battle_Func001Func010Func001002001002002002002002())
endfunction

function Trig_PvP_Battle_Func001Func010Func001002001002002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_PvP_Battle_Func001Func010Func001002001002002002001(),Trig_PvP_Battle_Func001Func010Func001002001002002002002())
endfunction

function Trig_PvP_Battle_Func001Func010Func001002001002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_PvP_Battle_Func001Func010Func001002001002002001(),Trig_PvP_Battle_Func001Func010Func001002001002002002())
endfunction

function Trig_PvP_Battle_Func001Func010Func001002001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_PvP_Battle_Func001Func010Func001002001002001(),Trig_PvP_Battle_Func001Func010Func001002001002002())
endfunction

function Trig_PvP_Battle_Func001Func010Func003002001002001 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
endfunction

function Trig_PvP_Battle_Func001Func010Func003002001002002001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_PvP_Battle_Func001Func010Func003002001002002002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(8))
endfunction

function Trig_PvP_Battle_Func001Func010Func003002001002002002002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(11))
endfunction

function Trig_PvP_Battle_Func001Func010Func003002001002002002002002 takes nothing returns boolean
    return(IsUnitInGroup(GetFilterUnit(),PotentialDuelHeroes)==true) and GetFilterUnit() != DuelingHeroes[1]
endfunction

function GetPvpEnemy takes nothing returns boolean
    return IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO) and UnitAlive(GetFilterUnit()) and GetFilterUnit() != DuelingHeroes[1] and GetOwningPlayer(GetFilterUnit()) != Player(8) and GetOwningPlayer(GetFilterUnit()) != Player(11) 
endfunction

function Trig_PvP_Battle_Func001Func010Func003002001002002002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_PvP_Battle_Func001Func010Func003002001002002002002001(),Trig_PvP_Battle_Func001Func010Func003002001002002002002002())
endfunction

function Trig_PvP_Battle_Func001Func010Func003002001002002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_PvP_Battle_Func001Func010Func003002001002002002001(),Trig_PvP_Battle_Func001Func010Func003002001002002002002())
endfunction

function Trig_PvP_Battle_Func001Func010Func003002001002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_PvP_Battle_Func001Func010Func003002001002002001(),Trig_PvP_Battle_Func001Func010Func003002001002002002())
endfunction

function Trig_PvP_Battle_Func001Func010Func003002001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_PvP_Battle_Func001Func010Func003002001002001(),Trig_PvP_Battle_Func001Func010Func003002001002002())
endfunction

function Trig_PvP_Battle_Func001Func010C takes nothing returns boolean
    if(not(CountUnitsInGroup(PotentialDuelHeroes)>= 1))then
        return false
    endif
    return true
endfunction

function Trig_PvP_Battle_Func001Func017A takes nothing returns nothing
    call PanCameraToTimedLocForPlayer(GetEnumPlayer(),GetRectCenter(PlayerArenaRects[RoundCreepAbilCastChance]),0.20)
endfunction

function Trig_PvP_Battle_Func001Func018001002001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_PvP_Battle_Func001Func018001002002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction

function Trig_PvP_Battle_Func001Func018001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_PvP_Battle_Func001Func018001002001(),Trig_PvP_Battle_Func001Func018001002002())
endfunction

function Trig_PvP_Battle_Func001Func018Func001001 takes nothing returns boolean
    return(GetUnitTypeId(GetEnumUnit())=='hphx')
endfunction

function Trig_PvP_Battle_Func001Func018A takes nothing returns nothing
    if(Trig_Start_Level_Func015Func002Func003Func001001(GetEnumUnit()))then
        call DeleteUnit(GetEnumUnit())
    else
        call DoNothing()
    endif
    call ExplodeUnitBJ(GetEnumUnit())
endfunction

function Trig_PvP_Battle_Func001Func019A takes nothing returns nothing
    call RemoveItem(GetEnumItem())
endfunction

function Trig_PvP_Battle_Func001Func031Func003Func001C takes nothing returns boolean
    if(not(GetForLoopIndexA()==1))then
        return false
    endif
    return true
endfunction

function Trig_PvP_Battle_Func001Func031Func006001001001 takes nothing returns boolean
    return(GetOwningPlayer(DuelingHeroes[1])!=GetFilterPlayer())
endfunction

function Trig_PvP_Battle_Func001Func031Func006001001002001 takes nothing returns boolean
    return(GetOwningPlayer(DuelingHeroes[2])!=GetFilterPlayer())
endfunction

function Trig_PvP_Battle_Func001Func031Func006001001002002 takes nothing returns boolean
    return(IsPlayerInForce(GetFilterPlayer(),DefeatedPlayers)!=true)
endfunction

function Trig_PvP_Battle_Func001Func031Func006001001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_PvP_Battle_Func001Func031Func006001001002001(),Trig_PvP_Battle_Func001Func031Func006001001002002())
endfunction

function Trig_PvP_Battle_Func001Func031Func006001001 takes nothing returns boolean
    return GetBooleanAnd(Trig_PvP_Battle_Func001Func031Func006001001001(),Trig_PvP_Battle_Func001Func031Func006001001002())
endfunction

function Trig_PvP_Battle_Func001Func031Func006Func001Func001C takes nothing returns boolean
    if((GetPlayerState(GetEnumPlayer(),PLAYER_STATE_RESOURCE_GOLD)> 0))then
        return true
    endif
    if((GetPlayerState(GetEnumPlayer(),PLAYER_STATE_RESOURCE_LUMBER)> 0))then
        return true
    endif
    return false
endfunction

function Trig_PvP_Battle_Func001Func031Func006Func001C takes nothing returns boolean
    if(not Trig_PvP_Battle_Func001Func031Func006Func001Func001C())then
        return false
    endif
    return true
endfunction

function Trig_PvP_Battle_Func001Func031Func006A takes nothing returns nothing
    if(Trig_PvP_Battle_Func001Func031Func006Func001C())then
        call DialogDisplayBJ(true,Dialogs[1],GetEnumPlayer())
    else
    endif
endfunction

function Trig_PvP_Battle_Func001Func031C takes nothing returns boolean
    if(not(udg_boolean13==true))then
        return false
    endif
    return true
endfunction

function Trig_PvP_Battle_Func001Func041A takes nothing returns nothing
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 3
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call DialogDisplayBJ(false,Dialogs[GetForLoopIndexA()],GetEnumPlayer())
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
endfunction

function Trig_PvP_Battle_Func001C takes nothing returns boolean
    if(not(CountUnitsInGroup(PotentialDuelHeroes)>= 1))then
        return false
    endif
    return true
endfunction

function TempDuelDebug takes nothing returns string
    local integer i = 0
    local string debugText = "DL"
    loop
        if BlzForceHasPlayer(DuelLosers, Player(i)) then
            set debugText = debugText + I2S(i)
        endif
        set i = i + 1
        exitwhen i >= 8
    endloop

    set debugText = debugText + " GP"
    loop
        set debugText = debugText + I2S(GetPlayerId(GetOwningPlayer(BlzGroupUnitAt(PotentialDuelHeroes, i))))
        set i = i - 1
        exitwhen i < 0
    endloop

    return debugText
endfunction

function Trig_PvP_Battle_Actions takes nothing returns nothing
    if(Trig_PvP_Battle_Func001C())then
        set DuelingHeroes[1]= GroupPickRandomUnit(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_PvP_Battle_Func001Func008002001002)))
        call GroupRemoveUnitSimple(DuelingHeroes[1],PotentialDuelHeroes)
        if(Trig_PvP_Battle_Func001Func010C())then
            set DuelingHeroes[2]= GroupPickRandomUnit(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_PvP_Battle_Func001Func010Func003002001002)))
        else
            set DuelingHeroes[2]= GroupPickRandomUnit(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_PvP_Battle_Func001Func010Func001002001002)))
        endif
        //shitty attempt at making sure it doesnt fuck up
        if DuelingHeroes[2] == DuelingHeroes[1] or DuelingHeroes[2] == null then
            call DisplayTimedTextToForce(GetPlayersAll(), 90, "|cfffd2727Duel Error|r: " + GetPlayerName(GetOwningPlayer(DuelingHeroes[1])) + " will fight any random player.\nPlease send this code in the bug-report channel on discord: " + TempDuelDebug() )
            set DuelingHeroes[2] = GroupPickRandomUnit(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function GetPvpEnemy)))
        endif
        call GroupRemoveUnitSimple(DuelingHeroes[2],PotentialDuelHeroes)
        call PlaySoundBJ(udg_sound08)
        call DisplayTextToForce(GetPlayersAll(),("|cffa0966dPvP Battle:|r " +(GetPlayerNameColour(GetOwningPlayer(DuelingHeroes[1]))+(" vs " +(GetPlayerNameColour(GetOwningPlayer(DuelingHeroes[2])))))))
        set RoundCreepAbilCastChance = GetRandomInt(1,8)
        call ForForce(GetPlayersAll(),function Trig_PvP_Battle_Func001Func017A)
        call ForGroupBJ(GetUnitsInRectMatching(PlayerArenaRects[RoundCreepAbilCastChance],Condition(function Trig_PvP_Battle_Func001Func018001002)),function Trig_PvP_Battle_Func001Func018A)
        call ForGroupBJ(GetUnitsOfPlayerMatching(GetOwningPlayer(DuelingHeroes[1]) , Condition(function RemoveNonHeroUnitFilter)), function RemoveNonHeroUnits)
        call ForGroupBJ(GetUnitsOfPlayerMatching(GetOwningPlayer(DuelingHeroes[2]) , Condition(function RemoveNonHeroUnitFilter)), function RemoveNonHeroUnits)
        call EnumItemsInRectBJ(PlayerArenaRects[RoundCreepAbilCastChance],function Trig_PvP_Battle_Func001Func019A)
        set udg_location01 = OffsetLocation(GetRectCenter(PlayerArenaRects[RoundCreepAbilCastChance]),- 40.00,- 50.00)
        call SetUnitPositionLocFacingLocBJ(DuelingHeroes[1],OffsetLocation(GetRectCenter(PlayerArenaRects[RoundCreepAbilCastChance]),- 500.00,0),GetRectCenter(PlayerArenaRects[RoundCreepAbilCastChance]))
        call SetUnitPositionLocFacingLocBJ(DuelingHeroes[2],OffsetLocation(GetRectCenter(PlayerArenaRects[RoundCreepAbilCastChance]),500.00,0),GetRectCenter(PlayerArenaRects[RoundCreepAbilCastChance]))
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 2
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            call PauseUnitBJ(true,DuelingHeroes[GetForLoopIndexA()])
            call SelectUnitForPlayerSingle(DuelingHeroes[GetForLoopIndexA()],GetOwningPlayer(DuelingHeroes[GetForLoopIndexA()]))
            set udg_unit01 = DuelingHeroes[GetForLoopIndexA()]
            call ConditionalTriggerExecute(udg_trigger82)
            call GroupAddUnitSimple(DuelingHeroes[GetForLoopIndexA()],DuelingHeroGroup)
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
        call SetPlayerAllianceStateBJ(GetOwningPlayer(DuelingHeroes[1]),GetOwningPlayer(DuelingHeroes[2]),bj_ALLIANCE_UNALLIED)
        call SetPlayerAllianceStateBJ(GetOwningPlayer(DuelingHeroes[2]),GetOwningPlayer(DuelingHeroes[1]),bj_ALLIANCE_UNALLIED)
        set PvpStartIndex = 1
        loop
            exitwhen PvpStartIndex > 6
            set DuelHeroItemIds1[PvpStartIndex]= GetItemTypeId(UnitItemInSlotBJ(DuelingHeroes[1],PvpStartIndex))
            call SetItemPawnable(UnitItemInSlotBJ(DuelingHeroes[1],PvpStartIndex), false)
            set DuelHeroItemIds2[PvpStartIndex]= GetItemTypeId(UnitItemInSlotBJ(DuelingHeroes[2],PvpStartIndex))
            call SetItemPawnable(UnitItemInSlotBJ(DuelingHeroes[2],PvpStartIndex), false)
            set PvpStartIndex = PvpStartIndex + 1
        endloop
        call TriggerSleepAction(0.20)
        set udg_boolean18 = true
        if(Trig_PvP_Battle_Func001Func031C())then
            call DialogClearBJ(Dialogs[1])
            call DialogSetMessageBJ(Dialogs[1],"Betting Menu")
            set bj_forLoopAIndex = 1
            set bj_forLoopAIndexEnd = 2
            loop
                exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
                if(Trig_PvP_Battle_Func001Func031Func003Func001C())then
                    call DialogAddButtonBJ(Dialogs[1],("<< " +(GetPlayerNameColour(GetOwningPlayer(DuelingHeroes[GetForLoopIndexA()]))+ "|r   ")))
                else
                    call DialogAddButtonBJ(Dialogs[1],("   " +(GetPlayerNameColour(GetOwningPlayer(DuelingHeroes[GetForLoopIndexA()]))+ "|r >>")))
                endif
                set DialogButtons[GetForLoopIndexA()]= GetLastCreatedButtonBJ()
                set bj_forLoopAIndex = bj_forLoopAIndex + 1
            endloop
            call DialogAddButtonBJ(Dialogs[1],"Skip")
            set DialogButtons[3]= GetLastCreatedButtonBJ()
            call ForForce(GetPlayersMatching(Condition(function Trig_PvP_Battle_Func001Func031Func006001001)),function Trig_PvP_Battle_Func001Func031Func006A)
        endif
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call CreateTimerDialogBJ(GetLastCreatedTimerBJ(),"Prepare ...")
        call StartTimerBJ(GetLastCreatedTimerBJ(),false,10.00)
        call TriggerSleepAction(4.50)
        set CountdownCount = 5
        call ConditionalTriggerExecute(udg_trigger117)
        call TriggerSleepAction(5.50)
        set udg_boolean18 = false
        call ForForce(GetPlayersAll(),function Trig_PvP_Battle_Func001Func041A)
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        set SuddenDeathTick = 0
        set udg_real03 = 0.02
        call EnableTrigger(udg_trigger140)
        call EnableTrigger(udg_trigger141)
        call PvpStartSuddenDeathTimer()
        call SetCurrentlyFighting(GetOwningPlayer(DuelingHeroes[1]), true)
        call SetCurrentlyFighting(GetOwningPlayer(DuelingHeroes[2]), true)
        call PlaySoundBJ(udg_sound15)
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 2
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            call SetUnitInvulnerable(DuelingHeroes[GetForLoopIndexA()],false)
            call StartFunctionSpell(DuelingHeroes[GetForLoopIndexA()],4 ) 
            call PauseUnitBJ(false,DuelingHeroes[GetForLoopIndexA()])
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
    else
        if(Trig_PvP_Battle_Func001Func001001())then
            return
        else
            call DoNothing()
        endif
        call ConditionalTriggerExecute(udg_trigger103)
        call CreateTimerDialogBJ(GetLastCreatedTimerBJ(),"Next Level ...")
        call StartTimerBJ(GetLastCreatedTimerBJ(),false,30)
        call TriggerSleepAction(30.00)
        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call TriggerExecute(udg_trigger109)
    endif
endfunction

function Trig_PvP_No_Player_Func001Func001001002001001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_PvP_No_Player_Func001Func001001002001002 takes nothing returns boolean
    return(IsUnitInGroup(GetFilterUnit(),DuelingHeroGroup)==true)
endfunction

function Trig_PvP_No_Player_Func001Func001001002001 takes nothing returns boolean
    return GetBooleanAnd(Trig_PvP_No_Player_Func001Func001001002001001(),Trig_PvP_No_Player_Func001Func001001002001002())
endfunction

function Trig_PvP_No_Player_Func001Func001001002002001 takes nothing returns boolean
    return(GetPlayerSlotState(GetOwningPlayer(GetFilterUnit()))!=PLAYER_SLOT_STATE_PLAYING)
endfunction

function Trig_PvP_No_Player_Func001Func001001002002002 takes nothing returns boolean
    return(GetPlayerController(GetOwningPlayer(GetFilterUnit()))==MAP_CONTROL_COMPUTER)
endfunction

function Trig_PvP_No_Player_Func001Func001001002002 takes nothing returns boolean
    return GetBooleanOr(Trig_PvP_No_Player_Func001Func001001002002001(),Trig_PvP_No_Player_Func001Func001001002002002())
endfunction

function Trig_PvP_No_Player_Func001Func001001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_PvP_No_Player_Func001Func001001002001(),Trig_PvP_No_Player_Func001Func001001002002())
endfunction

function Trig_PvP_No_Player_Func001Func001Func001C takes nothing returns boolean
    if(not(RectContainsUnit(PlayerArenaRects[udg_integer45],GetEnumUnit())==true))then
        return false
    endif
    return true
endfunction

function Trig_PvP_No_Player_Func001Func001A takes nothing returns nothing
    if(Trig_PvP_No_Player_Func001Func001Func001C())then
        call IssuePointOrderLocBJ(GetEnumUnit(),"attack",GetRandomLocInRect(PlayerArenaRects[udg_integer45]))
    else
    endif
endfunction

function Trig_PvP_No_Player_Actions takes nothing returns nothing
    set udg_integer45 = 1
    loop
        exitwhen udg_integer45 > 8
        call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_PvP_No_Player_Func001Func001001002)),function Trig_PvP_No_Player_Func001Func001A)
        set udg_integer45 = udg_integer45 + 1
    endloop
endfunction

function Trig_Receive_Prize_Conditions takes nothing returns boolean
    if(not(CountUnitsInGroup(DuelWinners)> 0))then
        return false
    endif
    return true
endfunction

function Trig_Receive_Prize_Func002Func002Func001C takes nothing returns boolean
    if(not(UnitItemInSlotBJ(GetEnumUnit(),udg_integer34)==null))then
        return false
    endif
    return true
endfunction

function Trig_Receive_Prize_Func002Func003Func001C takes nothing returns boolean
    if(not(BettingPlayerCount > 0))then
        return false
    endif
    if(not(IsUnitAliveBJ(GetEnumUnit())==true))then
        return false
    endif
    return true
endfunction

function Trig_Receive_Prize_Func002Func003C takes nothing returns boolean
    if(not Trig_Receive_Prize_Func002Func003Func001C())then
        return false
    endif
    return true
endfunction

function Trig_Receive_Prize_Func002A takes nothing returns nothing
    if(Trig_Receive_Prize_Func002Func003C())then
        call SetPlayerState(GetOwningPlayer(GetEnumUnit()), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(GetEnumUnit()), PLAYER_STATE_RESOURCE_GOLD) + udg_integer15)
        call GroupRemoveUnitSimple(GetEnumUnit(),DuelWinners)
    else
    endif
endfunction

function Trig_Receive_Prize_Actions takes nothing returns nothing
    call ForGroupBJ(DuelWinners,function Trig_Receive_Prize_Func002A)
    call TriggerSleepAction(0.50)
    call ConditionalTriggerExecute(GetTriggeringTrigger())
endfunction

function Trig_Drop_Prize_Item_Conditions takes nothing returns boolean
    if(not(IsItemOwned(GetManipulatedItem())==true))then
        return false
    endif
    return true
endfunction

function Trig_Drop_Prize_Item_Func001C takes nothing returns boolean
    if(not(udg_items01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==GetManipulatedItem()))then
        return false
    endif
    return true
endfunction

function Trig_Drop_Prize_Item_Actions takes nothing returns nothing
    if(Trig_Drop_Prize_Item_Func001C())then
        call UnitDropItemPointLoc(GetTriggerUnit(),GetManipulatedItem(),GetUnitLoc(GetTriggerUnit()))
        call UnitAddItemByIdSwapped(GetItemTypeId(GetManipulatedItem()),GetTriggerUnit())
        call RemoveItem(GetManipulatedItem())
    else
        call UnitDropItemPointLoc(GetTriggerUnit(),GetManipulatedItem(),GetUnitLoc(GetTriggerUnit()))
    endif
endfunction

function Trig_Sudden_Death_Damage_PvP_Conditions takes nothing returns boolean
    if ( not ( IsTriggerEnabled(udg_trigger141) == true ) ) then
        return false
    endif
    if ( not ( SuddenDeathTick >= 240 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sudden_Death_Damage_PvP_Actions takes nothing returns nothing
    set udg_real03 = udg_real03 * 1.1
    call PvpUpdateDeathTimerDisplay(udg_real03)
endfunction

function Trig_Sudden_Death_Timer_PvP_Func002C takes nothing returns boolean
    if(not(SuddenDeathTick >= 240))then
        return false
    endif
    return true
endfunction

function Trig_Sudden_Death_Timer_PvP_Actions takes nothing returns nothing
    set SuddenDeathTick =(SuddenDeathTick + 1)
    if(Trig_Sudden_Death_Timer_PvP_Func002C())then
        call DisableTrigger(udg_trigger11)
        call DisableTrigger(udg_trigger26)
        call CreateNUnitsAtLoc(1,SUDDEN_DEATH_UNIT_ID,GetOwningPlayer(DuelingHeroes[1]),GetUnitLoc(DuelingHeroes[1]),bj_UNIT_FACING)
        call UnitApplyTimedLifeBJ(0.25,'BTLF',GetLastCreatedUnit())
        call UnitDamageTargetBJ(GetLastCreatedUnit(),DuelingHeroes[2],(GetUnitStateSwap(UNIT_STATE_MAX_LIFE,DuelingHeroes[2])* udg_real03),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
        call CreateNUnitsAtLoc(1,SUDDEN_DEATH_UNIT_ID,GetOwningPlayer(DuelingHeroes[2]),GetUnitLoc(DuelingHeroes[2]),bj_UNIT_FACING)
        call UnitApplyTimedLifeBJ(0.25,'BTLF',GetLastCreatedUnit())
        call UnitDamageTargetBJ(GetLastCreatedUnit(),DuelingHeroes[1],(GetUnitStateSwap(UNIT_STATE_MAX_LIFE,DuelingHeroes[1])* udg_real03),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
        call EnableTrigger(udg_trigger11)
        call EnableTrigger(udg_trigger26)
    else
    endif
endfunction

function Trig_Enter_Center_Conditions takes nothing returns boolean
    if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
        return false
    endif
    return true
endfunction

function Trig_Enter_Center_Actions takes nothing returns nothing
    call SetUnitInvulnerable(GetTriggerUnit(),true)
    call SetUnitLifePercentBJ(GetTriggerUnit(),100)
    call SetUnitManaPercentBJ(GetTriggerUnit(),100)
endfunction

function Trig_Enter_Shop_Mode_Conditions takes nothing returns boolean
    if(not(IsTriggerEnabled(GetTriggeringTrigger())==true))then
        return false
    endif
    return true
endfunction

function Trig_Enter_Shop_Mode_Func036001002001 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)==true)
endfunction

function Trig_Enter_Shop_Mode_Func036001002002 takes nothing returns boolean
    return(GetUnitTypeId(GetFilterUnit())!='ncop')
endfunction

function Trig_Enter_Shop_Mode_Func036001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Enter_Shop_Mode_Func036001002001(),Trig_Enter_Shop_Mode_Func036001002002())
endfunction

function Trig_Enter_Shop_Mode_Func036A takes nothing returns nothing
    if GetUnitTypeId(GetEnumUnit()) == 'n02L' and IncomeMode > 0 then
        if IncomeMode == 1 then
            call ReplaceUnitBJ(GetEnumUnit(),'n035',bj_UNIT_STATE_METHOD_RELATIVE)
        elseif IncomeMode == 2 then
            call ReplaceUnitBJ(GetEnumUnit(),'n034',bj_UNIT_STATE_METHOD_RELATIVE)		
        endif
    else
        call ShowUnitShow(GetEnumUnit())
    endif
endfunction

function Trig_Enter_Shop_Mode_Func039A takes nothing returns nothing
    call DeleteUnit(GetEnumUnit())
endfunction

function Trig_Enter_Shop_Mode_Actions takes nothing returns nothing
    call DisableTrigger(GetTriggeringTrigger())
    call DisableTrigger(udg_trigger78)
    call MouseHoverInfo_DisableMouseHover()
    call DeleteUnit(udg_unit33)
    call DeleteUnit(udg_unit25)
    call DeleteUnit(udg_unit24)
    call DeleteUnit(udg_unit23)
    call DeleteUnit(udg_unit22)
    call DeleteUnit(udg_unit34)
    call DeleteUnit(udg_unit26)
    call DeleteUnit(udg_unit08)
    call DeleteUnit(udg_unit09)
    call DeleteUnit(udg_unit10)
    call DeleteUnit(udg_unit21)
    call DeleteUnit(udg_unit31)
    call DeleteUnit(udg_unit27)
    call DeleteUnit(udg_unit07)
    call DeleteUnit(udg_unit06)
    call DeleteUnit(udg_unit11)
    call DeleteUnit(udg_unit20)
    call DeleteUnit(udg_unit32)
    call DeleteUnit(udg_unit28)
    call DeleteUnit(udg_unit14)
    call DeleteUnit(udg_unit13)
    call DeleteUnit(udg_unit12)
    call DeleteUnit(udg_unit19)
    call DeleteUnit(udg_unit29)
    call DeleteUnit(udg_unit15)
    call DeleteUnit(udg_unit16)
    call DeleteUnit(udg_unit17)
    call DeleteUnit(udg_unit18)
    call DeleteUnit(udg_unit30)
    call DeleteUnit( CicrleUnit[0])
    call DeleteUnit( CicrleUnit[1])
    call DeleteUnit( CicrleUnit[2])
    call DeleteUnit( CicrleUnit[3])
    call DeleteUnit( CicrleUnit[4])
    call DeleteUnit( CicrleUnit[5])
    call DeleteUnit( CicrleUnit[6])
    call DeleteUnit( CicrleUnit[7])
    call DeleteUnit( CicrleUnit[8])
    call DeleteUnit( CicrleUnit[9])
    call DeleteUnit( CicrleUnit[10])
    call DeleteUnit( CicrleUnit[11])
    call DeleteUnit( CicrleUnit[12])
    call DeleteUnit( CicrleUnit[13])
    call DeleteUnit( CicrleUnit[14])
    call DeleteUnit( CicrleUnit[15])
    call DeleteUnit( CicrleUnit[16])
    call DeleteUnit( CicrleUnit[17])
    call DeleteUnit( CicrleUnit[18])
    call DeleteUnit( CicrleUnit[19])
    call DeleteUnit( CicrleUnit[20])
    call ForGroupBJ(GetUnitsOfPlayerMatching(Player(PLAYER_NEUTRAL_PASSIVE),Condition(function Trig_Enter_Shop_Mode_Func036001002)),function Trig_Enter_Shop_Mode_Func036A)
    call TriggerSleepAction(0.00)
    call ForGroupBJ(GetUnitsOfPlayerAll(Player(8)),function Trig_Enter_Shop_Mode_Func039A)
    call EnableTrigger(udg_trigger123)
    call EnableTrigger(udg_trigger127)
    call EnableTrigger(udg_trigger132)
endfunction

function Trig_Remove_Power_Ups_Conditions takes nothing returns boolean
    if(not(GetItemType(GetManipulatedItem())==ITEM_TYPE_POWERUP))then
        return false
    endif
    return true
endfunction

function Trig_Remove_Power_Ups_Actions takes nothing returns nothing
    call RemoveItem(GetManipulatedItem())
endfunction

function Trig_Remove_Units_From_Center_Func001C takes nothing returns boolean
    if(not(GetUnitTypeId(GetTriggerUnit())!=SUDDEN_DEATH_UNIT_ID))then
        return false
    endif
    if(not(GetUnitTypeId(GetTriggerUnit())!=PRIEST_1_UNIT_ID))then
        return false
    endif
    if(not(GetUnitTypeId(GetTriggerUnit())!='h014'))then
        return false
    endif
    if(not(GetUnitTypeId(GetTriggerUnit())!='n00E'))then
        return false
    endif
    if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_STRUCTURE)!=true))then
        return false
    endif
    if(not(IsUnitIdType(GetUnitTypeId(GetTriggerUnit()),UNIT_TYPE_HERO)!=true))then
        return false
    endif
    /*if(not(GetUnitTypeId(GetTriggerUnit())!='e001'))then
        return false
    endif*/
    if(not(GetUnitTypeId(GetTriggerUnit())!='e003'))then
        return false
    endif
    return true
endfunction

function Trig_Remove_Units_From_Center_Conditions takes nothing returns boolean
    if(not Trig_Remove_Units_From_Center_Func001C())then
        return false
    endif
    return true
endfunction

function Trig_Remove_Units_From_Center_Func003001 takes nothing returns boolean
    return(GetUnitTypeId(GetTriggerUnit())=='hphx')
endfunction

function Trig_Remove_Units_From_Center_Actions takes nothing returns nothing
    call TriggerSleepAction(0.00)
    if(Trig_Remove_Units_From_Center_Func003001())then
        call DeleteUnit(GetTriggerUnit())
    else
        call DoNothing()
    endif
    call KillUnit(GetTriggerUnit())
endfunction

function Trig_Update_Items_Func001Func001C takes nothing returns boolean
    if((ElimModeEnabled==true))then
        return true
    endif
    if((GameModeShort==true))then
        return true
    endif
    return false
endfunction

function Trig_Update_Items_Func001Func002Func001Func001A takes nothing returns nothing
    call ReplaceUnitBJ(GetEnumUnit(),'n017',bj_UNIT_STATE_METHOD_RELATIVE)
endfunction

function Trig_Update_Items_Func001Func002Func001C takes nothing returns boolean
    if(not(RoundNumber==10))then
        return false
    endif
    return true
endfunction

function Trig_Update_Items_Func001Func002Func002A takes nothing returns nothing
    call ReplaceUnitBJ(GetEnumUnit(),'n00Z',bj_UNIT_STATE_METHOD_RELATIVE)
endfunction

function Trig_Update_Items_Func001Func002Func003A takes nothing returns nothing
    call ReplaceUnitBJ(GetEnumUnit(),'n01D',bj_UNIT_STATE_METHOD_RELATIVE)
endfunction

function Trig_Update_Items_Func001Func002C takes nothing returns boolean
    if(not(RoundNumber==5))then
        return false
    endif
    return true
endfunction

function Trig_Update_Items_Func001Func003Func001Func001A takes nothing returns nothing
    call ReplaceUnitBJ(GetEnumUnit(),'n017',bj_UNIT_STATE_METHOD_RELATIVE)
endfunction

function Trig_Update_Items_Func001Func003Func001C takes nothing returns boolean
    if(not(RoundNumber==20))then
        return false
    endif
    return true
endfunction

function Trig_Update_Items_Func001Func003Func002A takes nothing returns nothing
    call ReplaceUnitBJ(GetEnumUnit(),'n00Z',bj_UNIT_STATE_METHOD_RELATIVE)
endfunction

function Trig_Update_Items_Func001Func003Func003A takes nothing returns nothing
    call ReplaceUnitBJ(GetEnumUnit(),'n01D',bj_UNIT_STATE_METHOD_RELATIVE)
endfunction

function Trig_Update_Items_Func001Func003C takes nothing returns boolean
    if(not(RoundNumber==10))then
        return false
    endif
    return true
endfunction

function Trig_Update_Items_Func001C takes nothing returns boolean
    if(not Trig_Update_Items_Func001Func001C())then
        return false
    endif
    return true
endfunction

function Trig_Update_Items_Actions takes nothing returns nothing
    if(Trig_Update_Items_Func001C())then
        if(Trig_Update_Items_Func001Func002Func001C())then
            call ForGroupBJ(GetUnitsOfTypeIdAll('n004'),function Trig_Update_Items_Func001Func002Func001Func001A)
        endif
    else
        if(Trig_Update_Items_Func001Func003Func001C())then
            call ForGroupBJ(GetUnitsOfTypeIdAll('n004'),function Trig_Update_Items_Func001Func003Func001Func001A)
        endif
    endif
endfunction

function Trig_Hide_Shops_Func002001002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)==true)
endfunction

function Trig_Hide_Shops_Func002A takes nothing returns nothing
    set HideShopsCount =(HideShopsCount + 1)
    set udg_locations01[HideShopsCount]= GetUnitLoc(GetEnumUnit())
    set ShopIds[HideShopsCount]= GetUnitTypeId(GetEnumUnit())
    call SetUnitPositionLoc(GetEnumUnit(),OffsetLocation(GetRectCenter(GetEntireMapRect()),0,1000000000.00))
    call DeleteUnit(GetEnumUnit())
endfunction

function Trig_Hide_Shops_Actions takes nothing returns nothing
    set HideShopsCount = 0
    call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_Hide_Shops_Func002001002)),function Trig_Hide_Shops_Func002A)
endfunction

function Trig_Unhide_Shops_Func001Func001Func001Func002C takes nothing returns boolean
    if(not(ArNotLearningAbil!=true))then
        return false
    endif
    if(not(ShopIds[HideShopsIndex]!='n016'))then
        return false
    endif
    return true
endfunction

function Trig_Unhide_Shops_Func001Func001Func001C takes nothing returns boolean
    if((ArNotLearningAbil==true))then
        return true
    endif
    if(Trig_Unhide_Shops_Func001Func001Func001Func002C())then
        return true
    endif
    return false
endfunction

function Trig_Unhide_Shops_Func001Func001Func003C takes nothing returns boolean
    if(not(GetUnitTypeId(GetLastCreatedUnit())=='n012'))then
        return false
    endif
    return true
endfunction

function Trig_Unhide_Shops_Func001Func001C takes nothing returns boolean
    if(not Trig_Unhide_Shops_Func001Func001Func001C())then
        return false
    endif
    return true
endfunction

function Trig_Unhide_Shops_Actions takes nothing returns nothing
    set HideShopsIndex = 1
    loop
        exitwhen HideShopsIndex > HideShopsCount
        if(Trig_Unhide_Shops_Func001Func001C())then
            call CreateNUnitsAtLoc(1,ShopIds[HideShopsIndex],Player(PLAYER_NEUTRAL_PASSIVE),udg_locations01[HideShopsIndex],bj_UNIT_FACING)
            if(Trig_Unhide_Shops_Func001Func001Func003C())then
                call TriggerRegisterUnitInRangeSimple(udg_trigger149,300.00,GetLastCreatedUnit())
                set udg_unit04 = GetLastCreatedUnit()
            else
            endif
        else
        endif
        set HideShopsIndex = HideShopsIndex + 1
    endloop
endfunction

function Trig_Passive_Spells_II_Conditions takes nothing returns boolean
    if(not(IsUnitAliveBJ(GetTriggerUnit())==true))then
        return false
    endif
    if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
        return false
    endif
    if(not(IsUnitInGroup(GetTriggerUnit(),udg_group09)!=true))then
        return false
    endif
    if(not(IsUnitHiddenBJ(udg_unit04)!=true))then
        return false
    endif
    if(not(IsUnitVisible(udg_unit04,GetOwningPlayer(GetTriggerUnit()))==true))then
        return false
    endif
    return true
endfunction

function Trig_Passive_Spells_II_Func001001003 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
endfunction

function Trig_Passive_Spells_II_Func001A takes nothing returns nothing
    call GroupAddUnitSimple(GetEnumUnit(),udg_group09)
endfunction

function Trig_Passive_Spells_II_Actions takes nothing returns nothing
    call ForGroupBJ(GetUnitsInRangeOfLocMatching(512,GetUnitLoc(udg_unit04),Condition(function Trig_Passive_Spells_II_Func001001003)),function Trig_Passive_Spells_II_Func001A)
    call DisableTrigger(GetTriggeringTrigger())
    call CreateNUnitsAtLoc(1,'n00E',GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(udg_unit04),bj_UNIT_FACING)
    call UnitApplyTimedLifeBJ(4.00,'BTLF',GetLastCreatedUnit())
    call SetUnitFlyHeightBJ(GetLastCreatedUnit(),400.00,0.00)
    call SetUnitFlyHeightBJ(GetLastCreatedUnit(),200.00,400.00)
    set udg_unit03 = GetLastCreatedUnit()
    call TriggerSleepAction(6.00)
    call EnableTrigger(GetTriggeringTrigger())
endfunction

function Trig_Remove_HintEffect_Conditions takes nothing returns boolean
    if(not(GetTriggerUnit()==udg_unit03))then
        return false
    endif
    return true
endfunction

function Trig_Remove_HintEffect_Actions takes nothing returns nothing
    call DeleteUnit(GetTriggerUnit())
endfunction

function Trig_Hero_Dies_Death_Match_PvP_Func019C takes nothing returns boolean
    if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
        return false
    endif
    if(not(GetOwningPlayer(GetTriggerUnit())!=Player(8)))then
        return false
    endif
    if(not(GetOwningPlayer(GetTriggerUnit())!=Player(11)))then
        return false
    endif
    if(not(IsUnitInGroup(GetTriggerUnit(),DuelingHeroGroup)==true))then
        return false
    endif
    if(not(udg_boolean07==true))then
        return false
    endif
    return true
endfunction

function Trig_Hero_Dies_Death_Match_PvP_Conditions takes nothing returns boolean
    if(not Trig_Hero_Dies_Death_Match_PvP_Func019C())then
        return false
    endif
    return true
endfunction

function Trig_Hero_Dies_Death_Match_PvP_Func008A takes nothing returns nothing
    local unit u = GetEnumUnit()

    if IsUnitType(u, UNIT_TYPE_HERO) then
        call RemoveItem(UnitItemInSlot(u, 0))
        call RemoveItem(UnitItemInSlot(u, 1))
        call RemoveItem(UnitItemInSlot(u, 2))
        call RemoveItem(UnitItemInSlot(u, 3))
        call RemoveItem(UnitItemInSlot(u, 4))
        call RemoveItem(UnitItemInSlot(u, 5))

        call RemoveHeroAbilities(u)
    endif

    call KillUnit(u)
    set u = null
endfunction

function Trig_Hero_Dies_Death_Match_PvP_Func011C takes nothing returns boolean
    if(not(GetPlayerController(GetOwningPlayer(GetTriggerUnit()))==MAP_CONTROL_USER))then
        return false
    endif
    return true
endfunction

function Trig_Hero_Dies_Death_Match_PvP_Actions takes nothing returns nothing
    call StopSoundBJ(udg_sound13,false)
    call PlaySoundBJ(udg_sound13)
    call ForceAddPlayerSimple(GetOwningPlayer(GetTriggerUnit()),DefeatedPlayers)
    call SetCurrentlyFighting(GetOwningPlayer(GetTriggerUnit()), false)
    set PlayerCount =(PlayerCount - 1)
    call AllowSinglePlayerCommands()
    
    call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(GetOwningPlayer(GetTriggerUnit()))+ "|cffC60000 was defeated!|r")))
    call DisableTrigger(udg_trigger16)
    call ForGroupBJ(GetUnitsOfPlayerAll(GetOwningPlayer(GetTriggerUnit())),function Trig_Hero_Dies_Death_Match_PvP_Func008A)
    call EnableTrigger(udg_trigger16)
    if(Trig_Hero_Dies_Death_Match_PvP_Func011C())then
        call DialogSetMessageBJ(udg_dialog04,"Defeat!")
        call DialogDisplayBJ(true,udg_dialog04,GetOwningPlayer(GetTriggerUnit()))
    else
        call CustomDefeatBJ(GetOwningPlayer(GetTriggerUnit()),"Defeat!")
    endif
    set ElimDmHeroDeathFxIndex = 1
    loop
        exitwhen ElimDmHeroDeathFxIndex > 5
        call AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()),"Objects\\Spawnmodels\\Human\\HumanLargeDeathExplode\\HumanLargeDeathExplode.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
        call AddSpecialEffectTargetUnitBJ("chest",GetTriggerUnit(),"Objects\\Spawnmodels\\Orc\\OrcLargeDeathExplode\\OrcLargeDeathExplode.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
        call TriggerSleepAction(0.10)
        set ElimDmHeroDeathFxIndex = ElimDmHeroDeathFxIndex + 1
    endloop
    call TriggerSleepAction(0.50)
    call StopSoundBJ(udg_sound13,true)
    call StopSoundBJ(udg_sound12,false)
    call PlaySoundBJ(udg_sound12)
endfunction

function Trig_Elimination_Func018Func001001002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(8))
endfunction

function Trig_Elimination_Func018Func001001002002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(11))
endfunction

function Trig_Elimination_Func018Func001001002002002001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_Elimination_Func018Func001001002002002002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
endfunction

function Trig_Elimination_Func018Func001001002002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Elimination_Func018Func001001002002002001(),Trig_Elimination_Func018Func001001002002002002())
endfunction

function Trig_Elimination_Func018Func001001002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Elimination_Func018Func001001002002001(),Trig_Elimination_Func018Func001001002002002())
endfunction

function Trig_Elimination_Func018Func001001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Elimination_Func018Func001001002001(),Trig_Elimination_Func018Func001001002002())
endfunction

function Trig_Elimination_Func018Func001A takes nothing returns nothing
    call SetPlayerAllianceStateBJ(GetOwningPlayer(GetEnumUnit()),ConvertedPlayer(udg_integer46),bj_ALLIANCE_UNALLIED)
endfunction

function Trig_Elimination_Func020001002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(8))
endfunction

function Trig_Elimination_Func020001002002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(11))
endfunction

function Trig_Elimination_Func020001002002002001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_Elimination_Func020001002002002002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
endfunction

function Trig_Elimination_Func020001002002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Elimination_Func020001002002002001(),Trig_Elimination_Func020001002002002002())
endfunction

function Trig_Elimination_Func020001002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Elimination_Func020001002002001(),Trig_Elimination_Func020001002002002())
endfunction

function Trig_Elimination_Func020001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Elimination_Func020001002001(),Trig_Elimination_Func020001002002())
endfunction

function Trig_Elimination_Func020A takes nothing returns nothing
    set ElimPlayerCount =(ElimPlayerCount + 1)
    set udg_unit01 = GetEnumUnit()
    call ConditionalTriggerExecute(udg_trigger82)
    call SetUnitPositionLocFacingLocBJ(GetEnumUnit(),PolarProjectionBJ(GetRectCenter(GetPlayableMapRect()),750.00,(((I2R(GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit())))- 1)*- 45.00)- 225.00)),GetRectCenter(RectMidArena))
    call SelectUnitForPlayerSingle(GetEnumUnit(),GetOwningPlayer(GetEnumUnit()))
    call PanCameraToTimedLocForPlayer(GetOwningPlayer(GetEnumUnit()),GetUnitLoc(GetEnumUnit()),0.50)
endfunction

function Trig_Elimination_Func021A takes nothing returns nothing
    call RemoveItem(GetEnumItem())
endfunction

function Trig_Elimination_Func036001002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(8))
endfunction

function Trig_Elimination_Func036001002002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(11))
endfunction

function Trig_Elimination_Func036001002002002001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_Elimination_Func036001002002002002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
endfunction

function Trig_Elimination_Func036001002002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Elimination_Func036001002002002001(),Trig_Elimination_Func036001002002002002())
endfunction

function Trig_Elimination_Func036001002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Elimination_Func036001002002001(),Trig_Elimination_Func036001002002002())
endfunction

function Trig_Elimination_Func036001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Elimination_Func036001002001(),Trig_Elimination_Func036001002002())
endfunction

function Trig_Elimination_Func036A takes nothing returns nothing
    call SetUnitInvulnerable(GetEnumUnit(),false)

    call StartFunctionSpell(GetEnumUnit() ,5) 
endfunction

function Trig_Elimination_Func037C takes nothing returns boolean
    if(not(ElimPlayerCount==1))then
        return false
    endif
    return true
endfunction

function Trig_Elimination_Actions takes nothing returns nothing
    call DisableTrigger(udg_trigger149)
    call KillUnit(udg_unit03)
    call TriggerSleepAction(5.00)
    call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
    call CreateTimerDialogBJ(GetLastCreatedTimerBJ(),"Elimination")
    call StartTimerBJ(GetLastCreatedTimerBJ(),false,20.00)
    call StopMusicBJ(true)
    call TriggerSleepAction(2.00)
    call PlaySoundBJ(udg_sound16)
    call TriggerSleepAction(12.50)
    set ElimPvpStarted = true
    call DisplayTextToForce(GetPlayersAll(),"|cffffcc00Elimination - Survive to advance to the next level!")
    call PauseAllUnitsBJ(true)
    call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
    call ConditionalTriggerExecute(udg_trigger147)
    call ShowDraftBuildings(false)
    set udg_integer46 = 1
    loop
        exitwhen udg_integer46 > 8
        call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_Elimination_Func018Func001001002)),function Trig_Elimination_Func018Func001A)
        set udg_integer46 = udg_integer46 + 1
    endloop
    set ElimPlayerCount = 0
    call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_Elimination_Func020001002)),function Trig_Elimination_Func020A)
    call EnumItemsInRectBJ(GetPlayableMapRect(),function Trig_Elimination_Func021A)
    call DisableTrigger(udg_trigger142)
    call DisableTrigger(udg_trigger145)
    call DisableTrigger(udg_trigger87)
    call DisableTrigger(udg_trigger80)
    call DisableTrigger(udg_trigger43)
    call EnableTrigger(udg_trigger153)
    call TriggerSleepAction(2)
    set udg_location01 = OffsetLocation(GetRectCenter(GetPlayableMapRect()),- 40.00,- 50.00)
    set CountdownCount = 5
    call ConditionalTriggerExecute(udg_trigger117)
    call TriggerSleepAction(5.00)
    call ResumeMusicBJ()
    call PlaySoundBJ(udg_sound15)
    call DisplayTimedTextToForce(GetPlayersAll(),1.00,"|cffffcc00GO!!!|r")
    call SetAllCurrentlyFighting(true)
    call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_Elimination_Func036001002)),function Trig_Elimination_Func036A)
    if(Trig_Elimination_Func037C())then
        set PlayerCount = 1
        call ConditionalTriggerExecute(udg_trigger122)
    else
    endif
    call PauseAllUnitsBJ(false)
endfunction

function Trig_Hero_Dies_Elimination_Func039C takes nothing returns boolean
    if(not(ElimPvpStarted==true))then
        return false
    endif
    if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
        return false
    endif
    if(not(GetOwningPlayer(GetTriggerUnit())!=Player(8)))then
        return false
    endif
    if(not(GetOwningPlayer(GetTriggerUnit())!=Player(11)))then
        return false
    endif
    return true
endfunction

function Trig_Hero_Dies_Elimination_Conditions takes nothing returns boolean
    if(not Trig_Hero_Dies_Elimination_Func039C())then
        return false
    endif
    return true
endfunction

function Trig_Hero_Dies_Elimination_Func008A takes nothing returns nothing
    local unit u = GetEnumUnit()

    if IsUnitType(u, UNIT_TYPE_HERO) then
        call RemoveItem(UnitItemInSlot(u, 0))
        call RemoveItem(UnitItemInSlot(u, 1))
        call RemoveItem(UnitItemInSlot(u, 2))
        call RemoveItem(UnitItemInSlot(u, 3))
        call RemoveItem(UnitItemInSlot(u, 4))
        call RemoveItem(UnitItemInSlot(u, 5))

        call RemoveHeroAbilities(u)
    endif

    call KillUnit(u)
    set u = null
endfunction

function Trig_Hero_Dies_Elimination_Func010001002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
endfunction

function Trig_Hero_Dies_Elimination_Func010A takes nothing returns nothing
    call SetUnitInvulnerable(GetEnumUnit(),true)
endfunction

function Trig_Hero_Dies_Elimination_Func012C takes nothing returns boolean
    if(not(GetPlayerController(GetOwningPlayer(GetTriggerUnit()))==MAP_CONTROL_USER))then
        return false
    endif
    return true
endfunction

function Trig_Hero_Dies_Elimination_Func018Func001001002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(8))
endfunction

function Trig_Hero_Dies_Elimination_Func018Func001001002002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(11))
endfunction

function Trig_Hero_Dies_Elimination_Func018Func001001002002002001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_Hero_Dies_Elimination_Func018Func001001002002002002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
endfunction

function Trig_Hero_Dies_Elimination_Func018Func001001002002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Hero_Dies_Elimination_Func018Func001001002002002001(),Trig_Hero_Dies_Elimination_Func018Func001001002002002002())
endfunction

function Trig_Hero_Dies_Elimination_Func018Func001001002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Hero_Dies_Elimination_Func018Func001001002002001(),Trig_Hero_Dies_Elimination_Func018Func001001002002002())
endfunction

function Trig_Hero_Dies_Elimination_Func018Func001001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Hero_Dies_Elimination_Func018Func001001002001(),Trig_Hero_Dies_Elimination_Func018Func001001002002())
endfunction

function Trig_Hero_Dies_Elimination_Func018Func001A takes nothing returns nothing
    call SetPlayerAllianceStateBJ(GetOwningPlayer(GetEnumUnit()),ConvertedPlayer(udg_integer47),bj_ALLIANCE_UNALLIED)
endfunction

function Trig_Hero_Dies_Elimination_Func021001 takes nothing returns boolean
    return(PlayerCount==1)
endfunction

function Trig_Hero_Dies_Elimination_Func030001002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(8))
endfunction

function Trig_Hero_Dies_Elimination_Func030001002002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(11))
endfunction

function Trig_Hero_Dies_Elimination_Func030001002002002001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_Hero_Dies_Elimination_Func030001002002002002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
endfunction

function Trig_Hero_Dies_Elimination_Func030001002002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Hero_Dies_Elimination_Func030001002002002001(),Trig_Hero_Dies_Elimination_Func030001002002002002())
endfunction

function Trig_Hero_Dies_Elimination_Func030001002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Hero_Dies_Elimination_Func030001002002001(),Trig_Hero_Dies_Elimination_Func030001002002002())
endfunction

function Trig_Hero_Dies_Elimination_Func030001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Hero_Dies_Elimination_Func030001002001(),Trig_Hero_Dies_Elimination_Func030001002002())
endfunction

function Trig_Hero_Dies_Elimination_Func030A takes nothing returns nothing
    set udg_unit01 = GetEnumUnit()
    call ConditionalTriggerExecute(udg_trigger82)
    call SetUnitPositionLoc(GetEnumUnit(),GetRectCenter(RectMidArena))
    call SelectUnitForPlayerSingle(GetEnumUnit(),GetOwningPlayer(GetEnumUnit()))
    call PanCameraToTimedLocForPlayer(GetOwningPlayer(GetEnumUnit()),GetUnitLoc(GetEnumUnit()),0.50)
    call SuspendHeroXPBJ(false,GetEnumUnit())
endfunction

function Trig_Hero_Dies_Elimination_Func031001002001001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(8))
endfunction

function Trig_Hero_Dies_Elimination_Func031001002001002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(11))
endfunction

function Trig_Hero_Dies_Elimination_Func031001002001002002001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_Hero_Dies_Elimination_Func031001002001002002002001 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)!=true)
endfunction

function Trig_Hero_Dies_Elimination_Func031001002001002002002002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)!=true)
endfunction

function Trig_Hero_Dies_Elimination_Func031001002001002002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Hero_Dies_Elimination_Func031001002001002002002001(),Trig_Hero_Dies_Elimination_Func031001002001002002002002())
endfunction

function Trig_Hero_Dies_Elimination_Func031001002001002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Hero_Dies_Elimination_Func031001002001002002001(),Trig_Hero_Dies_Elimination_Func031001002001002002002())
endfunction

function Trig_Hero_Dies_Elimination_Func031001002001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Hero_Dies_Elimination_Func031001002001002001(),Trig_Hero_Dies_Elimination_Func031001002001002002())
endfunction

function Trig_Hero_Dies_Elimination_Func031001002001 takes nothing returns boolean
    return GetBooleanAnd(Trig_Hero_Dies_Elimination_Func031001002001001(),Trig_Hero_Dies_Elimination_Func031001002001002())
endfunction

function Trig_Hero_Dies_Elimination_Func031001002002 takes nothing returns boolean
    return(IsUnitIllusionBJ(GetFilterUnit())==true)
endfunction

function Trig_Hero_Dies_Elimination_Func031001002 takes nothing returns boolean
    return GetBooleanOr(Trig_Hero_Dies_Elimination_Func031001002001(),Trig_Hero_Dies_Elimination_Func031001002002())
endfunction

function Trig_Hero_Dies_Elimination_Func031A takes nothing returns nothing
    call KillUnit(GetEnumUnit())
endfunction

function Trig_Hero_Dies_Elimination_Func032001002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(8))
endfunction

function Trig_Hero_Dies_Elimination_Func032001002002001 takes nothing returns boolean
    return(GetOwningPlayer(GetFilterUnit())!=Player(11))
endfunction

function Trig_Hero_Dies_Elimination_Func032001002002002001 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
endfunction

function Trig_Hero_Dies_Elimination_Func032001002002002002 takes nothing returns boolean
    return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
endfunction

function Trig_Hero_Dies_Elimination_Func032001002002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Hero_Dies_Elimination_Func032001002002002001(),Trig_Hero_Dies_Elimination_Func032001002002002002())
endfunction

function Trig_Hero_Dies_Elimination_Func032001002002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Hero_Dies_Elimination_Func032001002002001(),Trig_Hero_Dies_Elimination_Func032001002002002())
endfunction

function Trig_Hero_Dies_Elimination_Func032001002 takes nothing returns boolean
    return GetBooleanAnd(Trig_Hero_Dies_Elimination_Func032001002001(),Trig_Hero_Dies_Elimination_Func032001002002())
endfunction

function Trig_Hero_Dies_Elimination_Func032A takes nothing returns nothing
    call SuspendHeroXPBJ(true,GetEnumUnit())
endfunction

function Trig_Hero_Dies_Elimination_Actions takes nothing returns nothing
    call DisableTrigger(GetTriggeringTrigger())
    call StopSoundBJ(udg_sound13,false)
    call PlaySoundBJ(udg_sound13)
    call ForceAddPlayerSimple(GetOwningPlayer(GetTriggerUnit()),DefeatedPlayers)
    call SetCurrentlyFighting(GetOwningPlayer(GetTriggerUnit()), false)
    set PlayerCount =(PlayerCount - 1)
    call AllowSinglePlayerCommands()
    call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(GetOwningPlayer(GetTriggerUnit()))+ "|cffffcc00 was defeated!|r")))
    call DisableTrigger(udg_trigger16)
    call ForGroupBJ(GetUnitsOfPlayerAll(GetOwningPlayer(GetTriggerUnit())),function Trig_Hero_Dies_Elimination_Func008A)
    call EnableTrigger(udg_trigger16)
    call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_Hero_Dies_Elimination_Func010001002)),function Trig_Hero_Dies_Elimination_Func010A)
    if(Trig_Hero_Dies_Elimination_Func012C())then
        call DialogSetMessageBJ(udg_dialog04,"Defeat!")
        call DialogDisplayBJ(true,udg_dialog04,GetOwningPlayer(GetTriggerUnit()))
    else
        call CustomDefeatBJ(GetOwningPlayer(GetTriggerUnit()),"Defeat!")
    endif
    set ElimDmHeroDeathFxIndex = 1
    loop
        exitwhen ElimDmHeroDeathFxIndex > 5
        call AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()),"Objects\\Spawnmodels\\Human\\HumanLargeDeathExplode\\HumanLargeDeathExplode.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
        call AddSpecialEffectTargetUnitBJ("chest",GetTriggerUnit(),"Objects\\Spawnmodels\\Orc\\OrcLargeDeathExplode\\OrcLargeDeathExplode.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
        call TriggerSleepAction(0.10)
        set ElimDmHeroDeathFxIndex = ElimDmHeroDeathFxIndex + 1
    endloop
    call TriggerSleepAction(3.00)
    set ElimPvpStarted = false
    set udg_integer47 = 1
    loop
        exitwhen udg_integer47 > 8
        call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_Hero_Dies_Elimination_Func018Func001001002)),function Trig_Hero_Dies_Elimination_Func018Func001A)
        set udg_integer47 = udg_integer47 + 1
    endloop
    call ConditionalTriggerExecute(udg_trigger122)
    if(Trig_Hero_Dies_Elimination_Func021001())then
        return
    else
        call DoNothing()
    endif
    call EnableTrigger(udg_trigger142)
    call EnableTrigger(udg_trigger145)
    call EnableTrigger(udg_trigger80)
    call EnableTrigger(udg_trigger87)
    call EnableTrigger(udg_trigger149)
    call DisableTrigger(udg_trigger153)
    call ConditionalTriggerExecute(udg_trigger148)
    call ShowDraftBuildings(true)
    call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_Hero_Dies_Elimination_Func030001002)),function Trig_Hero_Dies_Elimination_Func030A)
    call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_Hero_Dies_Elimination_Func031001002)),function Trig_Hero_Dies_Elimination_Func031A)
    call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_Hero_Dies_Elimination_Func032001002)),function Trig_Hero_Dies_Elimination_Func032A)
    call ConditionalTriggerExecute(udg_trigger103)
    call SetAllCurrentlyFighting(false)
    call CreateTimerDialogBJ(GetLastCreatedTimerBJ(),"Next Level ...")
    call StartTimerBJ(GetLastCreatedTimerBJ(),false,20.00)
    call TriggerSleepAction(20.00)
    call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
    call TriggerExecute(udg_trigger109)
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
    //	set udg_trigger01=CreateTrigger()
    //call TriggerRegisterTimerEventPeriodic(udg_trigger01,0.01)
    //	call TriggerAddAction(udg_trigger01,function Trig_Antimagic_Shell_Actions)
    set udg_trigger02 = CreateTrigger()
    call TriggerRegisterEnterRectSimple(udg_trigger02,GetPlayableMapRect())
    call TriggerAddCondition(udg_trigger02,Condition(function Trig_Black_Arrow_Conditions))
    call TriggerAddAction(udg_trigger02,function Trig_Black_Arrow_Actions)
    set udg_trigger03 = CreateTrigger()
    call TriggerRegisterEnterRectSimple(udg_trigger03,GetPlayableMapRect())
    call TriggerAddCondition(udg_trigger03,Condition(function Trig_Carrion_Beetles_Conditions))
    call TriggerAddAction(udg_trigger03,function Trig_Carrion_Beetles_Actions)
    set udg_trigger04 = CreateTrigger()
    call TriggerRegisterEnterRectSimple(udg_trigger04,GetPlayableMapRect())
    call TriggerAddCondition(udg_trigger04,Condition(function Trig_Clockwerk_Goblin_Conditions))
    call TriggerAddAction(udg_trigger04,function Trig_Clockwerk_Goblin_Actions)
    set udg_trigger05 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger05,EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(udg_trigger05,Condition(function Trig_Corrosive_Skin_Conditions))
    call TriggerAddAction(udg_trigger05,function Trig_Corrosive_Skin_Actions)


    set udg_trigger09 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger09,EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(udg_trigger09,Condition(function Trig_Dark_Ritual_Conditions))
    call TriggerAddAction(udg_trigger09,function Trig_Dark_Ritual_Actions)
    set udg_trigger10 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger10,EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(udg_trigger10,Condition(function Trig_Death_Pact_Conditions))
    call TriggerAddAction(udg_trigger10,function Trig_Death_Pact_Actions)
    set udg_trigger11 = CreateTrigger()
    call TriggerAddCondition(udg_trigger11,Condition(function Trig_Devastating_Blow_Conditions))
    call TriggerAddAction(udg_trigger11,function Trig_Devastating_Blow_Actions)
    set udg_trigger12 = CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(udg_trigger12,0.25)
    call TriggerAddAction(udg_trigger12,function Trig_Devastating_Blow_Ennhance_Actions)
    set udg_trigger13 = CreateTrigger()
    call TriggerRegisterEnterRectSimple(udg_trigger13,GetPlayableMapRect())
    call TriggerAddCondition(udg_trigger13,Condition(function Trig_Devastating_Blow_Add_Conditions))
    call TriggerAddAction(udg_trigger13,function Trig_Devastating_Blow_Add_Actions)
    set udg_trigger14 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger14,EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(udg_trigger14,Condition(function Trig_Dreadlords_Thirst_Conditions))
    call TriggerAddAction(udg_trigger14,function Trig_Dreadlords_Thirst_Actions)
    /*set udg_trigger15 = CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(udg_trigger15,1.00)
    call TriggerAddAction(udg_trigger15,function Trig_Faerie_Dragon_Actions)*/
    set udg_trigger16 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger16,EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(udg_trigger16,Condition(function Trig_Faerie_Dragon_or_Wisp_Dies_Conditions))
    call TriggerAddAction(udg_trigger16,function Trig_Faerie_Dragon_or_Wisp_Dies_Actions)
    set udg_trigger17 = CreateTrigger()
    call TriggerRegisterEnterRectSimple(udg_trigger17,GetPlayableMapRect())
    call TriggerAddCondition(udg_trigger17,Condition(function Trig_Healing_Ward_Conditions))
    call TriggerAddAction(udg_trigger17,function Trig_Healing_Ward_Actions)
    set udg_trigger18 = CreateTrigger()
    call TriggerRegisterEnterRectSimple(udg_trigger18,GetPlayableMapRect())
    call TriggerAddCondition(udg_trigger18,Condition(function Trig_Inferno_Conditions))
    call TriggerAddAction(udg_trigger18,function Trig_Inferno_Actions)
    set udg_trigger19 = CreateTrigger()
    call TriggerRegisterEnterRectSimple(udg_trigger19,GetPlayableMapRect())
    call TriggerAddCondition(udg_trigger19,Condition(function Trig_Mountain_Giant_Conditions))
    call TriggerAddAction(udg_trigger19,function Trig_Mountain_Giant_Actions)
    set udg_trigger20 = CreateTrigger()
    call TriggerRegisterEnterRectSimple(udg_trigger20,GetPlayableMapRect())
    call TriggerAddCondition(udg_trigger20,Condition(function Trig_Parasite_Conditions))
    call TriggerAddAction(udg_trigger20,function Trig_Parasite_Actions)
    set udg_trigger21 = CreateTrigger()
    call TriggerRegisterEnterRectSimple(udg_trigger21,GetPlayableMapRect())
    call TriggerAddCondition(udg_trigger21,Condition(function Trig_Phoenix_Conditions))
    call TriggerAddAction(udg_trigger21,function Trig_Phoenix_Actions)
    set udg_trigger22 = CreateTrigger()
    call TriggerAddCondition(udg_trigger22,Condition(function Trig_Pillage_Conditions))
    set udg_trigger23 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger23,EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(udg_trigger23,Condition(function Trig_Plague_Conditions))
    call TriggerAddAction(udg_trigger23,function Trig_Plague_Actions)
    set udg_trigger24 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger24,EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(udg_trigger24,Condition(function Trig_Plague_Remove_Conditions))
    call TriggerAddAction(udg_trigger24,function Trig_Plague_Remove_Actions)
    set udg_trigger25 = CreateTrigger()
    call TriggerRegisterEnterRectSimple(udg_trigger25,GetPlayableMapRect())
    call TriggerAddCondition(udg_trigger25,Condition(function Trig_Pocket_Factory_Conditions))
    call TriggerAddAction(udg_trigger25,function Trig_Pocket_Factory_Actions)

    set udg_trigger27 = CreateTrigger()
    call TriggerRegisterEnterRectSimple(udg_trigger27,GetPlayableMapRect())
    call TriggerAddCondition(udg_trigger27,Condition(function Trig_Pulverize_Add_Conditions))
    call TriggerAddAction(udg_trigger27,function Trig_Pulverize_Add_Actions)
    set udg_trigger28 = CreateTrigger()
    call TriggerRegisterEnterRectSimple(udg_trigger28,GetPlayableMapRect())
    call TriggerAddCondition(udg_trigger28,Condition(function Trig_Raise_Dead_Conditions))
    call TriggerAddAction(udg_trigger28,function Trig_Raise_Dead_Actions)
    /*set udg_trigger29 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger29,EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(udg_trigger29,Condition(function Trig_Skeletal_Brute_Conditions))
    call TriggerAddAction(udg_trigger29,function Trig_Skeletal_Brute_Actions)*/
    set udg_trigger30 = CreateTrigger()
    call TriggerRegisterEnterRectSimple(udg_trigger30,GetPlayableMapRect())
    call TriggerAddCondition(udg_trigger30,Condition(function Trig_Summon_Bear_Conditions))
    call TriggerAddAction(udg_trigger30,function Trig_Summon_Bear_Actions)
    set udg_trigger31 = CreateTrigger()
    call TriggerRegisterEnterRectSimple(udg_trigger31,GetPlayableMapRect())
    call TriggerAddCondition(udg_trigger31,Condition(function Trig_Summon_Hawk_Conditions))
    call TriggerAddAction(udg_trigger31,function Trig_Summon_Hawk_Actions)
    set udg_trigger32 = CreateTrigger()
    call TriggerRegisterEnterRectSimple(udg_trigger32,GetPlayableMapRect())
    call TriggerAddCondition(udg_trigger32,Condition(function Trig_Summon_Quilbeast_Conditions))
    call TriggerAddAction(udg_trigger32,function Trig_Summon_Quilbeast_Actions)
    set udg_trigger33 = CreateTrigger()
    //call TriggerRegisterAnyUnitEventBJ(udg_trigger33,EVENT_PLAYER_UNIT_SPELL_CAST)
    //call TriggerRegisterAnyUnitEventBJ(udg_trigger33,EVENT_PLAYER_UNIT_SPELL_EFFECT)
    //call TriggerRegisterAnyUnitEventBJ(udg_trigger33,EVENT_PLAYER_UNIT_SPELL_FINISH)
    //call TriggerAddCondition(udg_trigger33,Condition(function Trig_Time_Wizard_Cooldown_Conditions))
    //call TriggerAddAction(udg_trigger33,function Trig_Time_Wizard_Cooldown_Actions)
    set udg_trigger34 = CreateTrigger()
    call TriggerRegisterEnterRectSimple(udg_trigger34,GetPlayableMapRect())
    call TriggerAddCondition(udg_trigger34,Condition(function Trig_Ward_Location_Conditions))
    call TriggerAddAction(udg_trigger34,function Trig_Ward_Location_Actions)
    set udg_trigger35 = CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(udg_trigger35,1.00)
    call TriggerAddAction(udg_trigger35,function Trig_Wisp_Actions)
    set udg_trigger36 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger36,EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddAction(udg_trigger36,function Trig_Disable_Abilities_Actions)
    /*set udg_trigger37=CreateTrigger()
    call TriggerAddCondition(udg_trigger37,Condition(function Trig_Cast_Channeling_Ability_Conditions))
    call TriggerAddAction(udg_trigger37,function Trig_Cast_Channeling_Ability_Actions)*/
    set udg_trigger38 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger38,EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(udg_trigger38,Condition(function Trig_Acquire_Item_Conditions))
    call TriggerAddAction(udg_trigger38,function Trig_Acquire_Item_Actions)
    set udg_trigger39 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger39,EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(udg_trigger39,Condition(function Trig_Drop_Item_Conditions))
    call TriggerAddAction(udg_trigger39,function Trig_Drop_Item_Actions)
    set udg_trigger40 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger40,EVENT_PLAYER_UNIT_DROP_ITEM)
    call TriggerAddCondition(udg_trigger40,Condition(function Trig_Give_Item_Conditions))
    call TriggerAddAction(udg_trigger40,function Trig_Give_Item_Actions)
    set udg_trigger41 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger41,EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(udg_trigger41,Condition(function Trig_Remove_Dummies_Conditions))
    call TriggerAddAction(udg_trigger41,function Trig_Remove_Dummies_Actions)
    set udg_trigger42 = CreateTrigger()
    call TriggerAddAction(udg_trigger42,function Trig_Battle_Royal_Actions)
    set udg_trigger43 = CreateTrigger()
    call DisableTrigger(udg_trigger43)
    call TriggerRegisterAnyUnitEventBJ(udg_trigger43,EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(udg_trigger43,Condition(function Trig_Hero_Dies_Battle_Royal_Conditions))
    call TriggerAddAction(udg_trigger43,function Trig_Hero_Dies_Battle_Royal_Actions)
    set udg_trigger44 = CreateTrigger()
    call TriggerRegisterTimerEventSingle(udg_trigger44,30.00)
    call TriggerAddCondition(udg_trigger44,Condition(function Trig_Betting_Initialization_Conditions))
    call TriggerAddAction(udg_trigger44,function Trig_Betting_Initialization_Actions)
    set udg_trigger45 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger45,Dialogs[1])
    call TriggerAddCondition(udg_trigger45,Condition(function Trig_Place_Bet_PvP1_Conditions))
    call TriggerAddAction(udg_trigger45,function Trig_Place_Bet_PvP1_Actions)
    set udg_trigger46 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger46,Dialogs[1])
    call TriggerAddCondition(udg_trigger46,Condition(function Trig_Place_Bet_PvP2_Conditions))
    call TriggerAddAction(udg_trigger46,function Trig_Place_Bet_PvP2_Actions)
    set udg_trigger47 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger47,Dialogs[1])
    call TriggerAddCondition(udg_trigger47,Condition(function Trig_Skip_Bet_Conditions))
    call TriggerAddAction(udg_trigger47,function Trig_Skip_Bet_Actions)
    set udg_trigger48 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger48,Dialogs[2])
    call TriggerAddCondition(udg_trigger48,Condition(function Trig_Place_Bet_Gold_Conditions))
    call TriggerAddAction(udg_trigger48,function Trig_Place_Bet_Gold_Actions)
    set udg_trigger49 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger49,Dialogs[2])
    call TriggerAddCondition(udg_trigger49,Condition(function Trig_Place_Bet_Lumber_Conditions))
    call TriggerAddAction(udg_trigger49,function Trig_Place_Bet_Lumber_Actions)
    set udg_trigger50 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger50,Dialogs[2])
    call TriggerAddCondition(udg_trigger50,Condition(function Trig_Place_Bet_GoldLumber_Conditions))
    call TriggerAddAction(udg_trigger50,function Trig_Place_Bet_GoldLumber_Actions)
    set udg_trigger51 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger51,Dialogs[3])
    call TriggerAddCondition(udg_trigger51,Condition(function Trig_Place_Bet_Conditions))
    call TriggerAddAction(udg_trigger51,function Trig_Place_Bet_Actions)
    set udg_trigger52 = CreateTrigger()
    call TriggerAddAction(udg_trigger52,function Trig_Eligible_Amount_Actions)
    set udg_trigger53 = CreateTrigger()
    call TriggerAddCondition(udg_trigger53,Condition(function Trig_Eligible_Amount_Loop_Conditions))
    call TriggerAddAction(udg_trigger53,function Trig_Eligible_Amount_Loop_Actions)
    set udg_trigger54 = CreateTrigger()
    call TriggerAddCondition(udg_trigger54,Condition(function Trig_Betting_Complete_Conditions))
    call TriggerAddAction(udg_trigger54,function Trig_Betting_Complete_Actions)
    set udg_trigger55 = CreateTrigger()
    call DisableTrigger(udg_trigger55)
    call TriggerAddAction(udg_trigger55,function Trig_Dialog_Initialization_Actions)
    set udg_trigger56 = CreateTrigger()
    call TriggerRegisterTimerEventSingle(udg_trigger56,0.00)
    call TriggerAddAction(udg_trigger56,function Trig_Voting_Rights_Initialization_Actions)
    set udg_trigger57 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger57,udg_dialog06)
    call TriggerAddCondition(udg_trigger57,Condition(function Trig_Game_Master_Selects_Conditions))
    call TriggerAddAction(udg_trigger57,function Trig_Game_Master_Selects_Actions)
    set udg_trigger58 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger58,udg_dialog06)
    call TriggerAddCondition(udg_trigger58,Condition(function Trig_Everyone_Votes_Conditions))
    call TriggerAddAction(udg_trigger58,function Trig_Everyone_Votes_Actions)
    set udg_trigger59 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger59,GameDurDialog)
    call TriggerAddCondition(udg_trigger59,Condition(function Trig_Dialog_25_Conditions))
    call TriggerAddAction(udg_trigger59,function Trig_Dialog_25_Actions)
    set udg_trigger60 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger60,GameDurDialog)
    call TriggerAddCondition(udg_trigger60,Condition(function Trig_Dialog_50_Conditions))
    call TriggerAddAction(udg_trigger60,function Trig_Dialog_50_Actions)
    set udg_trigger61 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger61,GameDurDialog)
    call TriggerAddCondition(udg_trigger61,Condition(function Trig_Doesnt_Matter_Conditions))
    call TriggerAddAction(udg_trigger61,function Trig_Doesnt_Matter_Actions)
    set udg_trigger62 = CreateTrigger()
    call TriggerAddAction(udg_trigger62,function Trig_Skip_Betting_Menu_Actions)
    set udg_trigger63 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger63,GameModeDialog)
    call TriggerAddCondition(udg_trigger63,Condition(function Trig_Normal_Mode_Conditions))
    call TriggerAddAction(udg_trigger63,function Trig_Normal_Mode_Actions)
    set udg_trigger64 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger64,GameModeDialog)
    call TriggerAddCondition(udg_trigger64,Condition(function Trig_Elimination_Mode_Conditions))
    call TriggerAddAction(udg_trigger64,function Trig_Elimination_Mode_Actions)
    set udg_trigger65 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger65,GameModeDialog)
    call TriggerAddCondition(udg_trigger65,Condition(function Trig_Death_Match_Mode_Conditions))
    call TriggerAddAction(udg_trigger65,function Trig_Death_Match_Mode_Actions)
    set udg_trigger66 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger66,GameModeDialog)
    call TriggerAddCondition(udg_trigger66,Condition(function Trig_Doesnt_Matter_Mode_Conditions))
    call TriggerAddAction(udg_trigger66,function Trig_Doesnt_Matter_Mode_Actions)
    set udg_trigger67 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger67,AbilModeDialog)
    call TriggerAddCondition(udg_trigger67,Condition(function Trig_Pick_Abilities_Conditions))
    call TriggerAddAction(udg_trigger67,function Trig_Pick_Abilities_Actions)
    set udg_trigger68 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger68,AbilModeDialog)
    call TriggerAddCondition(udg_trigger68,Condition(function Trig_Random_Abilities_Conditions))
    call TriggerAddAction(udg_trigger68,function Trig_Random_Abilities_Actions)
    set trg = CreateTrigger()
    call TriggerRegisterDialogEventBJ(trg,AbilModeDialog)
    call TriggerAddCondition(trg,Condition(function Trig_Draft_Abilities_Conditions))
    call TriggerAddAction(trg,function Trig_Draft_Abilities_Actions)
    set udg_trigger69 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger69,AbilModeDialog)
    call TriggerAddCondition(udg_trigger69,Condition(function Trig_Doesnt_Matter_Abilities_Conditions))
    call TriggerAddAction(udg_trigger69,function Trig_Doesnt_Matter_Abilities_Actions)

    set trg = CreateTrigger()
    call TriggerRegisterDialogEventBJ(trg,IncomeModeDialog)
    call TriggerAddCondition(trg,Condition(function Trig_Income_Conditions))
    call TriggerAddAction(trg,function Trig_Income_Actions)
    set trg = CreateTrigger()
    call TriggerRegisterDialogEventBJ(trg,IncomeModeDialog)
    call TriggerAddCondition(trg,Condition(function Trig_Individual_Income_Conditions))
    call TriggerAddAction(trg,function Trig_Individual_Income_Actions)
    set trg = CreateTrigger()
    call TriggerRegisterDialogEventBJ(trg,IncomeModeDialog)
    call TriggerAddCondition(trg,Condition(function Trig_No_Income_Conditions))
    call TriggerAddAction(trg,function Trig_No_Income_Actions)

    set trg = null

    set udg_trigger70 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger70,HeroModeDialog)
    call TriggerAddCondition(udg_trigger70,Condition(function Trig_Pick_Hero_Conditions))
    call TriggerAddAction(udg_trigger70,function Trig_Pick_Hero_Actions)
    set udg_trigger71 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger71,HeroModeDialog)
    call TriggerAddCondition(udg_trigger71,Condition(function Trig_Random_Hero_Conditions))
    call TriggerAddAction(udg_trigger71,function Trig_Random_Hero_Actions)
    set udg_trigger72 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger72,HeroModeDialog)
    call TriggerAddCondition(udg_trigger72,Condition(function Trig_Doesnt_Matter_Hero_Conditions))
    call TriggerAddAction(udg_trigger72,function Trig_Doesnt_Matter_Hero_Actions)
    set udg_trigger73 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger73,BettingModeDialog)
    call TriggerAddCondition(udg_trigger73,Condition(function Trig_Show_Betting_Menu_Conditions))
    call TriggerAddAction(udg_trigger73,function Trig_Show_Betting_Menu_Actions)
    set udg_trigger74 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger74,BettingModeDialog)
    call TriggerAddCondition(udg_trigger74,Condition(function Trig_Hide_Betting_Menu_Conditions))
    call TriggerAddAction(udg_trigger74,function Trig_Hide_Betting_Menu_Actions)
    set udg_trigger75 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger75,BettingModeDialog)
    call TriggerAddCondition(udg_trigger75,Condition(function Trig_Disable_Betting_Menu_Conditions))
    call TriggerAddAction(udg_trigger75,function Trig_Disable_Betting_Menu_Actions)
    set udg_trigger76 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger76,BettingModeDialog)
    call TriggerAddCondition(udg_trigger76,Condition(function Trig_Doesnt_Matter_Betting_Menu_Conditions))
    call TriggerAddAction(udg_trigger76,function Trig_Doesnt_Matter_Betting_Menu_Actions)
    set udg_trigger77 = CreateTrigger()
    call TriggerAddCondition(udg_trigger77,Condition(function Trig_Dialog_Complete_Conditions))
    call TriggerAddAction(udg_trigger77,function Trig_Dialog_Complete_Actions)
    set udg_trigger78 = CreateTrigger()
    call DisableTrigger(udg_trigger78)
    call TriggerRegisterPlayerSelectionEventBJ(udg_trigger78,Player(0),true)
    call TriggerRegisterPlayerSelectionEventBJ(udg_trigger78,Player(1),true)
    call TriggerRegisterPlayerSelectionEventBJ(udg_trigger78,Player(2),true)
    call TriggerRegisterPlayerSelectionEventBJ(udg_trigger78,Player(3),true)
    call TriggerRegisterPlayerSelectionEventBJ(udg_trigger78,Player(4),true)
    call TriggerRegisterPlayerSelectionEventBJ(udg_trigger78,Player(5),true)
    call TriggerRegisterPlayerSelectionEventBJ(udg_trigger78,Player(6),true)
    call TriggerRegisterPlayerSelectionEventBJ(udg_trigger78,Player(7),true)
    call TriggerAddCondition(udg_trigger78,Condition(function Trig_Choose_Hero_Conditions))
    call TriggerAddAction(udg_trigger78,function Trig_Choose_Hero_Actions)
    set udg_trigger79 = CreateTrigger()
    call TriggerAddAction(udg_trigger79,function Trig_Spawn_Hero_Actions)
    set udg_trigger80 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger80,EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(udg_trigger80,Condition(function Trig_Hero_Dies_Conditions))
    call TriggerAddAction(udg_trigger80,function Trig_Hero_Dies_Actions)
    set udg_trigger81 = CreateTrigger()
    call DisableTrigger(udg_trigger81)
    call TriggerRegisterAnyUnitEventBJ(udg_trigger81,EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(udg_trigger81,Condition(function Trig_Hero_Dies_After_Victory_Conditions))
    call TriggerAddAction(udg_trigger81,function Trig_Hero_Dies_After_Victory_Actions)
    set udg_trigger82 = CreateTrigger()
    call TriggerAddAction(udg_trigger82,function Trig_Hero_Refresh_Actions)
    set udg_trigger83 = CreateTrigger()
    call TriggerRegisterTimerEventSingle(udg_trigger83,0.00)
    call TriggerAddAction(udg_trigger83,function Trig_DeathDialog_Initialization_Actions)
    set udg_trigger84 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger84,udg_dialog04)
    call TriggerAddCondition(udg_trigger84,Condition(function Trig_DeathDialog_Leave_Conditions))
    call TriggerAddAction(udg_trigger84,function Trig_DeathDialog_Leave_Actions)
    set udg_trigger85 = CreateTrigger()
    call TriggerAddCondition(udg_trigger85,Condition(function Trig_Pandaren_Death_Sound_Initialization_Conditions))
    call TriggerAddAction(udg_trigger85,function Trig_Pandaren_Death_Sound_Initialization_Actions)
    set udg_trigger86 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger86,EVENT_PLAYER_UNIT_DEATH)
    call TriggerRegisterAnyUnitEventBJ(udg_trigger86,EVENT_PLAYER_UNIT_DROP_ITEM)
    call TriggerAddCondition(udg_trigger86,Condition(function Trig_Pandaren_Dies_Conditions))
    call TriggerAddAction(udg_trigger86,function Trig_Pandaren_Dies_Actions)
    /*
    set udg_trigger87 = CreateTrigger()
    call DisableTrigger(udg_trigger87)
    call TriggerRegisterTimerEventPeriodic(udg_trigger87,60.00)
    call TriggerAddAction(udg_trigger87,function Trig_Display_Hint_Actions)
    set udg_trigger88 = CreateTrigger()
    call TriggerRegisterTimerEventSingle(udg_trigger88,30.00)
    call TriggerAddAction(udg_trigger88,function Trig_Hint_Initialization_Actions)*/
    set udg_trigger89 = CreateTrigger()
    call TriggerAddAction(udg_trigger89,function Trig_Map_Initialization_Actions)
    set udg_trigger90 = CreateTrigger()
    call TriggerAddCondition(udg_trigger90,Condition(function Trig_Melee_Initialization_Conditions))
    call TriggerAddAction(udg_trigger90,function Trig_Melee_Initialization_Actions)
    set udg_trigger91 = CreateTrigger()
    call TriggerAddAction(udg_trigger91,function Trig_Player_Region_Initialization_Actions)
    set udg_trigger92 = CreateTrigger()
    call TriggerAddAction(udg_trigger92,function Trig_Spell_Initialization_Actions)
    set udg_trigger93 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger93,EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(udg_trigger93,Condition(function Trig_Moonstone_Conditions))
    call TriggerAddAction(udg_trigger93,function Trig_Moonstone_Actions)
    set udg_trigger94 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger94,EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(udg_trigger94,Condition(function Trig_Scepter_of_Confusion_Conditions))
    call TriggerAddAction(udg_trigger94,function Trig_Scepter_of_Confusion_Actions)
    set udg_trigger95 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger95,EVENT_PLAYER_UNIT_USE_ITEM)
    call TriggerAddCondition(udg_trigger95,Condition(function Trig_The_Divine_Source_Conditions))
    call TriggerAddAction(udg_trigger95,function Trig_The_Divine_Source_Actions)
    set udg_trigger96 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger96,EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(udg_trigger96,Condition(function Trig_Volcanic_Armor_Conditions))
    call TriggerAddAction(udg_trigger96,function Trig_Volcanic_Armor_Actions)
    /*set udg_trigger97=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger97,EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(udg_trigger97,Condition(function Trig_Xesils_Legacy_Conditions))
    call TriggerAddAction(udg_trigger97,function Trig_Xesils_Legacy_Actions)*/
    set udg_trigger98 = CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(udg_trigger98,6.00)
    call TriggerAddAction(udg_trigger98,function Trig_Attack_Move_Actions)
    set udg_trigger99 = CreateTrigger()
    call TriggerAddAction(udg_trigger99,function Trig_Add_Unit_Abilities_Actions)
    set udg_trigger100 = CreateTrigger()
    call TriggerAddAction(udg_trigger100,function Trig_Add_Unit_Power_Actions)
    set udg_trigger101 = CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(udg_trigger101,1.00)
    call TriggerAddAction(udg_trigger101,function Trig_Creep_AutoCast_Actions)
    set udg_trigger102 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger102,EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(udg_trigger102,Condition(function Trig_Creep_Dies_Conditions))
    call TriggerAddAction(udg_trigger102,function Trig_Creep_Dies_Actions)
    set udg_trigger103 = CreateTrigger()
    call TriggerAddCondition(udg_trigger103,Condition(function Trig_Generate_Next_Level_Conditions))
    call TriggerAddAction(udg_trigger103,function Trig_Generate_Next_Level_Actions)
    set udg_trigger104 = CreateTrigger()
    call TriggerAddAction(udg_trigger104,function Trig_Unit_Type_Actions)
    set udg_trigger105 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger105,EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(udg_trigger105,Condition(function Trig_Bonus_Exp_Conditions))
    call TriggerAddAction(udg_trigger105,function Trig_Bonus_Exp_Actions)
    set udg_trigger106 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger106,EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(udg_trigger106,Condition(function Trig_Complete_Level_Move_Conditions))
    call TriggerAddAction(udg_trigger106,function Trig_Complete_Level_Move_Actions)
    set udg_trigger107 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger107,EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(udg_trigger107,Condition(function Trig_Complete_Level_Player_Conditions))
    call TriggerAddAction(udg_trigger107,function Trig_Complete_Level_Player_Actions)
    set udg_trigger108 = CreateTrigger()
    call TriggerAddAction(udg_trigger108,function Trig_Level_Completed_Actions)
    set udg_trigger109 = CreateTrigger()
    call TriggerAddCondition(udg_trigger109,Condition(function Trig_Start_Level_Conditions))
    call TriggerAddAction(udg_trigger109,function Trig_Start_Level_Actions)
    set udg_trigger110 = CreateTrigger()
    call DisableTrigger(udg_trigger110)
    call TriggerRegisterTimerEventPeriodic(udg_trigger110,0.25)
    call TriggerAddAction(udg_trigger110,function Trig_Sudden_Death_Timer_Actions)
    set udg_trigger111 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger111,EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(udg_trigger111,Condition(function Trig_Learn_Ability_Conditions))
    call TriggerAddAction(udg_trigger111,function Trig_Learn_Ability_Actions)
    set udg_trigger112 = CreateTrigger()
    call TriggerAddAction(udg_trigger112,function Trig_Set_Ability_Actions)
    set udg_trigger113 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger113,EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(udg_trigger113,Condition(function Trig_Random_Ability_Conditions))
    call TriggerAddAction(udg_trigger113,function Trig_Random_Ability_Actions)
    set udg_trigger114 = CreateTrigger()
    call TriggerAddAction(udg_trigger114,function Trig_Learn_Random_Ability_Actions)
    set udg_trigger115 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger115,EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(udg_trigger115,Condition(function Trig_Unlearn_Ability_Conditions))
    call TriggerAddAction(udg_trigger115,function Trig_Unlearn_Ability_Actions)
    set udg_trigger116 = CreateTrigger()
    call DisableTrigger(udg_trigger116)
    call TriggerRegisterTimerEventPeriodic(udg_trigger116,0.50)
    call TriggerAddCondition(udg_trigger116,Condition(function Trig_AntiStuck_Conditions))
    call TriggerAddAction(udg_trigger116,function Trig_AntiStuck_Actions)
    set udg_trigger117 = CreateTrigger()
    call TriggerAddCondition(udg_trigger117,Condition(function Trig_Countdown_Conditions))
    call TriggerAddAction(udg_trigger117,function Trig_Countdown_Actions)
    set udg_trigger118 = CreateTrigger()
    call TriggerAddCondition(udg_trigger118,Condition(function Trig_Defeat_Conditions))
    call TriggerAddAction(udg_trigger118,function Trig_Defeat_Actions)
    set udg_trigger119 = CreateTrigger()
    call TriggerAddCondition(udg_trigger119,Condition(function Trig_End_Game_Conditions))
    call TriggerAddAction(udg_trigger119,function Trig_End_Game_Actions)
    set udg_trigger120 = CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(udg_trigger120,1.00)
    call TriggerAddAction(udg_trigger120,function Trig_Playtime_Actions)
    set udg_trigger121 = CreateTrigger()
    call DisableTrigger(udg_trigger121)
    call TriggerAddAction(udg_trigger121,function Trig_Remove_Selection_Circles_Actions)
    set udg_trigger122 = CreateTrigger()
    call TriggerAddCondition(udg_trigger122,Condition(function Trig_Victory_Conditions))
    call TriggerAddAction(udg_trigger122,function Trig_Victory_Actions)
    set udg_trigger123 = CreateTrigger()
    call DisableTrigger(udg_trigger123)
    call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(0),"-camera ",false)
    call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(0),"-cam",false)
    call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(1),"-camera ",false)
    call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(1),"-cam",false)
    call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(2),"-camera ",false)
    call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(2),"-cam",false)
    call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(3),"-camera ",false)
    call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(3),"-cam",false)
    call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(4),"-camera ",false)
    call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(4),"-cam",false)
    call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(5),"-camera ",false)
    call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(5),"-cam",false)
    call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(6),"-camera ",false)
    call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(6),"-cam",false)
    call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(7),"-camera ",false)
    call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(7),"-cam",false)
    call TriggerAddAction(udg_trigger123,function Trig_Camera_Command_Actions)
    set udg_trigger124 = CreateTrigger()
    call TriggerRegisterPlayerChatEvent(udg_trigger124,Player(0),"-clear",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger124,Player(1),"-clear",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger124,Player(2),"-clear",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger124,Player(3),"-clear",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger124,Player(4),"-clear",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger124,Player(5),"-clear",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger124,Player(6),"-clear",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger124,Player(7),"-clear",true)
    call TriggerAddAction(udg_trigger124,function Trig_Clear_Command_Actions)
    /*
    set udg_trigger125 = CreateTrigger()
    call TriggerRegisterPlayerChatEvent(udg_trigger125,Player(0),"-hint",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger125,Player(1),"-hint",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger125,Player(2),"-hint",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger125,Player(3),"-hint",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger125,Player(4),"-hint",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger125,Player(5),"-hint",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger125,Player(6),"-hint",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger125,Player(7),"-hint",true)
    call TriggerAddAction(udg_trigger125,function Trig_Hint_Command_Actions)*/
    set udg_trigger126 = CreateTrigger()
    call DisableTrigger(udg_trigger126)
    call TriggerRegisterPlayerChatEvent(udg_trigger126,Player(0),"-level",true)
    call TriggerAddAction(udg_trigger126,function Trig_Level_Command_Actions)
    set udg_trigger127 = CreateTrigger()
    call DisableTrigger(udg_trigger127)
    call TriggerRegisterPlayerChatEvent(udg_trigger127,Player(0),"-ms",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger127,Player(1),"-ms",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger127,Player(2),"-ms",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger127,Player(3),"-ms",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger127,Player(4),"-ms",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger127,Player(5),"-ms",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger127,Player(6),"-ms",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger127,Player(7),"-ms",true)
    call TriggerAddCondition(udg_trigger127,Condition(function Trig_Movement_Speed_Command_Conditions))
    call TriggerAddAction(udg_trigger127,function Trig_Movement_Speed_Command_Actions)
    set udg_trigger128 = CreateTrigger()
    call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(0),"-pt",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(0),"-time",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(1),"-pt",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(1),"-time",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(2),"-pt",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(2),"-time",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(3),"-pt",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(3),"-time",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(4),"-pt",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(4),"-time",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(5),"-pt",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(5),"-time",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(6),"-pt",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(6),"-time",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(7),"-pt",true)
    call TriggerRegisterPlayerChatEvent(udg_trigger128,Player(7),"-time",true)
    call TriggerAddAction(udg_trigger128,function Trig_Playtime_Command_Actions)
    set udg_trigger129 = CreateTrigger()
    call TriggerRegisterPlayerEventLeave(udg_trigger129,Player(0))
    call TriggerRegisterPlayerEventLeave(udg_trigger129,Player(1))
    call TriggerRegisterPlayerEventLeave(udg_trigger129,Player(2))
    call TriggerRegisterPlayerEventLeave(udg_trigger129,Player(3))
    call TriggerRegisterPlayerEventLeave(udg_trigger129,Player(4))
    call TriggerRegisterPlayerEventLeave(udg_trigger129,Player(5))
    call TriggerRegisterPlayerEventLeave(udg_trigger129,Player(6))
    call TriggerRegisterPlayerEventLeave(udg_trigger129,Player(7))
    call TriggerAddCondition(udg_trigger129,Condition(function Trig_Player_Leaves_Conditions))
    call TriggerAddAction(udg_trigger129,function Trig_Player_Leaves_Actions)
    set udg_trigger130 = CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(udg_trigger130,4)
    call TriggerAddAction(udg_trigger130,function Trig_Spacebar_Point_Actions)
    set udg_trigger131 = CreateTrigger()
    call TriggerAddAction(udg_trigger131,function Trig_Select_Game_Master_Actions)/*
    set udg_trigger132 = CreateTrigger()
    call DisableTrigger(udg_trigger132)
    call TriggerRegisterPlayerChatEvent(udg_trigger132,Player(0),"-kick",false)
    call TriggerRegisterPlayerChatEvent(udg_trigger132,Player(1),"-kick",false)
    call TriggerRegisterPlayerChatEvent(udg_trigger132,Player(2),"-kick",false)
    call TriggerRegisterPlayerChatEvent(udg_trigger132,Player(3),"-kick",false)
    call TriggerRegisterPlayerChatEvent(udg_trigger132,Player(4),"-kick",false)
    call TriggerRegisterPlayerChatEvent(udg_trigger132,Player(5),"-kick",false)
    call TriggerRegisterPlayerChatEvent(udg_trigger132,Player(6),"-kick",false)
    call TriggerRegisterPlayerChatEvent(udg_trigger132,Player(7),"-kick",false)
    call TriggerAddCondition(udg_trigger132,Condition(function Trig_Kick_Player_Command_Conditions))
    call TriggerAddAction(udg_trigger132,function Trig_Kick_Player_Command_Actions)*/
    set udg_trigger133 = CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(udg_trigger133,0.02)
    call TriggerAddAction(udg_trigger133,function Trig_Player_Selection_Camera_Actions)
    set udg_trigger134 = CreateTrigger()
    call TriggerAddAction(udg_trigger134,function Trig_PvP_Actions)
    set udg_trigger135 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger135,EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(udg_trigger135,Condition(function Trig_End_PvP_Conditions))
    call TriggerAddAction(udg_trigger135,function Trig_End_PvP_Actions)
    set udg_trigger136 = CreateTrigger()
    call TriggerAddAction(udg_trigger136,function Trig_PvP_Battle_Actions)
    set udg_trigger137 = CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(udg_trigger137,6.00)
    call TriggerAddAction(udg_trigger137,function Trig_PvP_No_Player_Actions)
    set udg_trigger138 = CreateTrigger()
    call TriggerAddCondition(udg_trigger138,Condition(function Trig_Receive_Prize_Conditions))
    call TriggerAddAction(udg_trigger138,function Trig_Receive_Prize_Actions)
    set udg_trigger139 = CreateTrigger()
    call DisableTrigger(udg_trigger139)
    call TriggerRegisterAnyUnitEventBJ(udg_trigger139,EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(udg_trigger139,Condition(function Trig_Drop_Prize_Item_Conditions))
    call TriggerAddAction(udg_trigger139,function Trig_Drop_Prize_Item_Actions)
    set udg_trigger140 = CreateTrigger()
    call DisableTrigger(udg_trigger140)
    call TriggerRegisterTimerEventPeriodic(udg_trigger140,1.25)
    call TriggerAddCondition(udg_trigger140,Condition(function Trig_Sudden_Death_Damage_PvP_Conditions))
    call TriggerAddAction(udg_trigger140,function Trig_Sudden_Death_Damage_PvP_Actions)
    set udg_trigger141 = CreateTrigger()
    call DisableTrigger(udg_trigger141)
    call TriggerRegisterTimerEventPeriodic(udg_trigger141,0.25)
    call TriggerAddAction(udg_trigger141,function Trig_Sudden_Death_Timer_PvP_Actions)
    set udg_trigger142 = CreateTrigger()
    call TriggerRegisterEnterRectSimple(udg_trigger142,RectMidArena)
    call TriggerAddCondition(udg_trigger142,Condition(function Trig_Enter_Center_Conditions))
    call TriggerAddAction(udg_trigger142,function Trig_Enter_Center_Actions)
    set udg_trigger143 = CreateTrigger()
    call TriggerAddCondition(udg_trigger143,Condition(function Trig_Enter_Shop_Mode_Conditions))
    call TriggerAddAction(udg_trigger143,function Trig_Enter_Shop_Mode_Actions)
    set udg_trigger144 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger144,EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddCondition(udg_trigger144,Condition(function Trig_Remove_Power_Ups_Conditions))
    call TriggerAddAction(udg_trigger144,function Trig_Remove_Power_Ups_Actions)
    set udg_trigger145 = CreateTrigger()
    call TriggerRegisterEnterRectSimple(udg_trigger145,RectMidArena)
    call TriggerAddCondition(udg_trigger145,Condition(function Trig_Remove_Units_From_Center_Conditions))
    call TriggerAddAction(udg_trigger145,function Trig_Remove_Units_From_Center_Actions)
    set udg_trigger146 = CreateTrigger()
    call TriggerAddAction(udg_trigger146,function Trig_Update_Items_Actions)
    set udg_trigger147 = CreateTrigger()
    call TriggerAddAction(udg_trigger147,function Trig_Hide_Shops_Actions)
    set udg_trigger148 = CreateTrigger()
    call TriggerAddAction(udg_trigger148,function Trig_Unhide_Shops_Actions)
    set udg_trigger149 = CreateTrigger()
    call TriggerAddCondition(udg_trigger149,Condition(function Trig_Passive_Spells_II_Conditions))
    call TriggerAddAction(udg_trigger149,function Trig_Passive_Spells_II_Actions)
    set udg_trigger150 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger150,EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(udg_trigger150,Condition(function Trig_Remove_HintEffect_Conditions))
    call TriggerAddAction(udg_trigger150,function Trig_Remove_HintEffect_Actions)
    set udg_trigger151 = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(udg_trigger151,EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(udg_trigger151,Condition(function Trig_Hero_Dies_Death_Match_PvP_Conditions))
    call TriggerAddAction(udg_trigger151,function Trig_Hero_Dies_Death_Match_PvP_Actions)
    set udg_trigger152 = CreateTrigger()
    call TriggerAddAction(udg_trigger152,function Trig_Elimination_Actions)
    set udg_trigger153 = CreateTrigger()
    call DisableTrigger(udg_trigger153)
    call TriggerRegisterAnyUnitEventBJ(udg_trigger153,EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(udg_trigger153,Condition(function Trig_Hero_Dies_Elimination_Conditions))
    call TriggerAddAction(udg_trigger153,function Trig_Hero_Dies_Elimination_Actions)
    call ConditionalTriggerExecute(udg_trigger08)
    call ConditionalTriggerExecute(udg_trigger89)
    call ConditionalTriggerExecute(udg_trigger91)
    call ConditionalTriggerExecute(udg_trigger92)
    call ConditionalTriggerExecute(udg_trigger103)
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

library OldCodeInit
    public function start takes nothing returns nothing
        call ExecuteFunc("main3")
    endfunction                                                 
endlibrary