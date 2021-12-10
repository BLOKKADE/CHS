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
    if(udg_boolean05==false) and AbilityMode == 1 then




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



























/*



globals
    unit array MysticFaerie
endglobals

















library Pillage requires RandomShit
    function Trig_Pillage_Conditions takes nothing returns boolean
        /*local integer GG_d1 = 0
        local integer PilageBonus = 0
        local integer RingBonus = 0
        local integer RemBon = 0
        local integer expBounty = 0
        local integer goldBounty = 0
        local unit Gku = udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]
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
    if(not(udg_integer14==1))then
        return false
    endif
    return true
endfunction







/*

*/





























/*
function Trig_Disable_Abilities_Func001Func003Func003Func003C takes nothing returns boolean
    if(not(IsUnitInGroup(GetTriggerUnit(),udg_group02)!=true))then
        return false
    endif
    if(not(IsPlayerInForce(GetOwningPlayer(GetTriggerUnit()),udg_force03)==true))then
        return false
    endif
    return true
endfunction

function Trig_Disable_Abilities_Func001Func003Func003C takes nothing returns boolean
    if((GetTriggerUnit()==udg_unit05))then
        return true
    endif
    if((RectContainsUnit(udg_rect09,GetTriggerUnit())==true))then
        return true
    endif
    if(Trig_Disable_Abilities_Func001Func003Func003Func003C())then
        return true
    endif
    return false
endfunction

function Trig_Disable_Abilities_Func001Func003C takes nothing returns boolean
    if(not(udg_boolean02==false))then
        return false
    endif
    if(not(udg_boolean03==false))then
        return false
    endif
    if(not Trig_Disable_Abilities_Func001Func003Func003C())then
        return false
    endif
    if(not(GetUnitTypeId(GetTriggerUnit())!='n00V'))then
        return false
    endif
    if(not(GetUnitTypeId(GetTriggerUnit())!='h015'))then
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


/*



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





































































































//income
















































































function CheckAbilityVotes takes nothing returns nothing
    //random
    if udg_integers07[7] > udg_integers07[6] and udg_integers07[7] > udg_integers07[19] then
        set AbilityMode = 0

        //pick
    elseif udg_integers07[6] > udg_integers07[7] and udg_integers07[6] > udg_integers07[19] then
        set AbilityMode = 1

        //draft
    elseif udg_integers07[19] > udg_integers07[6] and udg_integers07[19] > udg_integers07[7] then
        set AbilityMode = 2

        //if tie just do ap
    else
        set AbilityMode = 1
    endif
endfunction


















function SetIncomeMode takes nothing returns nothing
    if IncomeMode == 1 then
        call ReplaceUnitBJ(gg_unit_n02L_0012,'n035',bj_UNIT_STATE_METHOD_RELATIVE)
    elseif IncomeMode == 2 then
        call ReplaceUnitBJ(gg_unit_n02L_0012,'n034',bj_UNIT_STATE_METHOD_RELATIVE)		
    endif
endfunction

function CheckIncomeVotes takes nothing returns nothing
    if udg_integers07[15] > udg_integers07[16] and udg_integers07[15] > udg_integers07[17] then
        set IncomeMode = 0
    elseif udg_integers07[16] > udg_integers07[15] and udg_integers07[16] > udg_integers07[17] then
        set IncomeMode = 1
    else
        set IncomeMode = 2	
    endif
endfunction




























globals
    boolean array DisableDeathTrigger
endglobals




















































/*




















*/












































































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








































function Trig_Creep_AutoCast_Func001001002 takes nothing returns boolean
    return(IsUnitAliveBJ(GetFilterUnit())==true)
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
    if(not(CountUnitsInGroup(GetUnitsInRectMatching(udg_rects01[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))],Condition(function Trig_Creep_Dies_Func003Func005001001002)))==0))then
        return false
    endif
    return true
endfunction
*/


function Trig_Generate_Next_Level_Func011C takes nothing returns boolean
    if(not((udg_integer02 + 1)> 5))then
        return false
    endif
    return true
endfunction





function CheckUnitAbilities takes nothing returns nothing
    local string s = ""

    if udg_integer10 == 1 then
        set s = s + "Bash "
        call AddRoundAbility('ACbh')
    endif

    if udg_integer24 == 1 then
        set s = s + "Hurl Boulder "
        call AddRoundAbility('A00W')
    endif

    if udg_integer25 == 1 then
        set s = s + "Rejuvenation "
        call AddRoundAbility('A00X')
    endif

    if udg_integer50 == 1 then
        set s = s + "Big Bad Voodoo "
        call AddRoundAbility('A018')
    endif

    if udg_integer54 == 1 then
        set s = s + "Blink "
        call AddRoundAbility('A01A')
    endif

    if udg_integer11 == 1 then
        set s = s + "Critical Strike "
        call AddRoundAbility('AOcr')
    endif

    if udg_integer12 == 1 then
        set s = s + "Evasion "
    endif

    if udg_integer51 == 1 then
        set s = s + "Faerie Fire "
        call AddRoundAbility('A016')
    endif

    if udg_integer18 == 1 then
        set s = s + "Lifesteal "
        call AddRoundAbility('SCva')
    endif

    if udg_integer23 == 1 then
        set s = s + "Mana Burn "
        call AddRoundAbility('A00V')
    endif

    if udg_integer21 == 1 then
        set s = s + "Shockwave "
        call AddRoundAbility('A00U')
    endif

    if udg_integer49 == 1 then
        set s = s + "Slow "
        call AddRoundAbility('A013')
    endif

    if udg_integer17 == 1 then
        set s = s + "Cleave "
        call AddRoundAbility('ACce')
    endif

    if udg_integer20 == 1 then
        set s = s + "Thorns Aura "
        call AddRoundAbility('A08F')
    endif

    if udg_integer55 == 1 then
        set s = s + "Thunder Clap "
        call AddRoundAbility('A01B')
    endif

    if ReflectionAuraChance == 1 then
        set s = s + "Reflection Aura "
        call AddRoundAbility('A093')
    endif

    if WizardbaneAuraChance == 1 then
        set s = s + "Wizardbane Aura  "
        call AddRoundAbility('A088')
    endif

    if DrunkenMasterchance == 1 then
        set s = s + "Drunken Master "
        call AddRoundAbility('Acdb')
    endif

    if SlowAuraChance == 1 then
        set s = s + "Slow Aura "
        call AddRoundAbility('AOr2')
    endif

    if PulverizeChance == 1 then
        set s = s + "Pulverize "
        call AddRoundAbility('Awar')
    endif

    if LastBreathChance == 1 then
        set s = s + "Last Breath "
        call AddRoundAbility('A05R')
    endif

    if FireshieldChance == 1 then
        set s = s + "Fire Shield "
        call AddRoundAbility('A05S')
    endif

    if CorrosiveSkinChance == 1 then
        set s = s + "Corrosive Skin "
        call AddRoundAbility('A00Q')
    endif

    if MulticastChance == 1 then
        set s = s + "Multicast "
        call AddRoundAbility('A04F')
    endif

    if FastMagicChance == 1 then
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
    if udg_integer11 == 1 then
        call SetUnitAbilityLevel(u, 'AOcr', IMinBJ(R2I(udg_integer02 * 0.2), 30))
    endif

    if DrunkenMasterchance == 1 then
        call UnitAddAbility(u, 'Acdb')
        call FuncEditParam('Acdb',u)
        call SetUnitAbilityLevel(u, 'Acdb', IMinBJ(R2I(udg_integer02 * 0.3), 30))
    endif

    if ReflectionAuraChance == 1 then
        call UnitAddAbility(u, 'A093')
        call SetUnitAbilityLevel(u, 'A093', IMinBJ(R2I(udg_integer02 * 0.4), 30))
    endif

    if WizardbaneAuraChance == 1 then
        call UnitAddAbility(u, 'A088')
        call SetUnitAbilityLevel(u, 'A088', IMinBJ(R2I(udg_integer02 * 0.4), 30))
    endif

    if SlowAuraChance == 1 then
        call UnitAddAbility(u, 'AOr2')
        call SetUnitAbilityLevel(u, 'AOr2', IMinBJ(R2I(udg_integer02 * 0.75), 30))
    endif

    if PulverizeChance == 1 then
        call UnitAddAbility(u, 'Awar')
        call SetUnitAbilityLevel(u, 'Awar', IMinBJ(R2I(udg_integer02 * 0.4), 30))
    endif

    if LastBreathChance == 1 then
        call UnitAddAbility(u, 'A05R')
        call FuncEditParam('A05R', u)
        call SetUnitAbilityLevel(u, 'A05R', IMinBJ(R2I(udg_integer02 * 0.2), 30))
    endif

    if FireshieldChance == 1 then
        call UnitAddAbility(u, 'A05S')
        call SetUnitAbilityLevel(u, 'A05S', IMinBJ(R2I(udg_integer02 * 0.3), 30))
    endif

    if CorrosiveSkinChance == 1 then
        call UnitAddAbility(u, 'A00Q')
        call SetUnitAbilityLevel(u, 'A00Q', IMinBJ(R2I(udg_integer02 * 0.6), 30))
    endif

    if MulticastChance == 1 then
        call UnitAddAbility(u, 'A04F')
        call SetUnitAbilityLevel(u, 'A04F', IMinBJ(R2I(udg_integer02 * 0.5), 30))
    endif

    if FastMagicChance == 1 then
        call UnitAddAbility(u, 'A03P')
        call SetUnitAbilityLevel(u, 'A03P', IMinBJ(R2I(udg_integer02 * 0.6), 30))
    endif
endfunction

//next round unit create

























































//trigger108
















function Trig_Start_Level_Func015Func002Func003Func001001 takes unit u returns boolean
    return GetUnitTypeId(u)=='h009' or GetUnitTypeId(u)=='h014' or GetUnitTypeId(u)=='h015' or GetUnitTypeId(u)=='h00B'
endfunction






/*
function StartCountdown takes string text, integer value returns nothing
    local texttag ft
    local integer i = 0
    loop
        set ft = CreateTextTag()
        call SetTextTagPos(ft, GetRectCenterX(udg_rects01[i + 1]) - 40, GetRectCenterY(udg_rects01[i + 1]) - 50, 0)
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












function Trig_Learn_Ability_Func006C takes nothing returns boolean
    if(not(udg_integer01=='Amnz'))then
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
        call SetUnitAbilityLevel(u, udg_integer01, i)
    endif
    call FuncEditParam(abil,u)
    call AddSpecialEffectLocBJ(GetUnitLoc(u),"Objects\\Spawnmodels\\Other\\ToonBoom\\ToonBoom.mdl")
    call DestroyEffectBJ(GetLastCreatedEffectBJ())
    call DisplayTimedTextToPlayer(p, 0, 0, 2.0, "|cffbbff00Learned |r" + BlzGetAbilityTooltip(abil, GetUnitAbilityLevel(u, abil) - 1))
endfunction















































function Trig_End_Game_Func003Func009A takes nothing returns nothing
    call CustomDefeatBJ(GetEnumPlayer(),"Defeat!")
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
    call ForForce(udg_force02,function Trig_Victory_Func011Func002A)
endfunction









/*



*/



















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















/*
function KickPlayer takes player p returns nothing
    set udg_boolean17 = true
    call PlaySoundBJ(udg_sound04)
    call ForceAddPlayerSimple(p,udg_force07)
    call CustomDefeatBJ(p,"Kicked!")
    call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(p)+ "|cffffcc00 was kicked out of the game!|r")))
endfunction






/*





*/






























function Trig_End_PvP_Func026Func008Func003C takes nothing returns boolean
    if(not(CountUnitsInGroup(udg_group03)> 1))then
        return false
    endif
    return true
endfunction


function Trig_End_PvP_Func026Func016Func001Func001Func001Func001Func002001 takes nothing returns boolean
    return(udg_integer14==1)
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func001Func001Func003001 takes nothing returns boolean
    return(udg_integer14==2)
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func001Func001Func004001 takes nothing returns boolean
    return(udg_integer14==3)
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func001Func001Func005001 takes nothing returns boolean
    return(udg_integer14==4)
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func001Func001Func006001 takes nothing returns boolean
    return(udg_integer14==5)
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func001Func001C takes nothing returns boolean
    if(not(udg_integer02==40))then
        return false
    endif
    return true
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func001Func003001 takes nothing returns boolean
    return(udg_integer14==1)
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func001Func004001 takes nothing returns boolean
    return(udg_integer14==2)
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func001Func005001 takes nothing returns boolean
    return(udg_integer14==3)
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func001Func006001 takes nothing returns boolean
    return(udg_integer14==4)
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func001C takes nothing returns boolean
    if(not(udg_integer02==30))then
        return false
    endif
    return true
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func003001 takes nothing returns boolean
    return(udg_integer14==1)
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func004001 takes nothing returns boolean
    return(udg_integer14==2)
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func005001 takes nothing returns boolean
    return(udg_integer14==3)
endfunction

function Trig_End_PvP_Func026Func016Func001Func001Func006001 takes nothing returns boolean
    return(udg_integer14==4)
endfunction

function Trig_End_PvP_Func026Func016Func001Func001C takes nothing returns boolean
    if(not(udg_integer02==20))then
        return false
    endif
    return true
endfunction

function Trig_End_PvP_Func026Func016Func001Func003001 takes nothing returns boolean
    return(udg_integer14==1)
endfunction

function Trig_End_PvP_Func026Func016Func001Func004001 takes nothing returns boolean
    return(udg_integer14==2)
endfunction

function Trig_End_PvP_Func026Func016Func001Func005001 takes nothing returns boolean
    return(udg_integer14==3)
endfunction

function Trig_End_PvP_Func026Func016Func001Func006001 takes nothing returns boolean
    return(udg_integer14==4)
endfunction

function Trig_End_PvP_Func026Func016Func001C takes nothing returns boolean
    if(not(udg_integer02==10))then
        return false
    endif
    return true
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func001Func001Func002001 takes nothing returns boolean
    return(udg_integer14==1)
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func001Func001Func003001 takes nothing returns boolean
    return(udg_integer14==2)
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func001Func001Func004001 takes nothing returns boolean
    return(udg_integer14==3)
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func001Func001Func005001 takes nothing returns boolean
    return(udg_integer14==4)
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func001Func001Func006001 takes nothing returns boolean
    return(udg_integer14==5)
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func001Func001C takes nothing returns boolean
    if(not(udg_integer02==20))then
        return false
    endif
    return true
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func001Func003001 takes nothing returns boolean
    return(udg_integer14==1)
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func001Func004001 takes nothing returns boolean
    return(udg_integer14==2)
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func001Func005001 takes nothing returns boolean
    return(udg_integer14==3)
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func001Func006001 takes nothing returns boolean
    return(udg_integer14==4)
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func001C takes nothing returns boolean
    if(not(udg_integer02==15))then
        return false
    endif
    return true
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func003001 takes nothing returns boolean
    return(udg_integer14==1)
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func004001 takes nothing returns boolean
    return(udg_integer14==2)
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func005001 takes nothing returns boolean
    return(udg_integer14==3)
endfunction

function Trig_End_PvP_Func026Func016Func002Func001Func006001 takes nothing returns boolean
    return(udg_integer14==4)
endfunction

function Trig_End_PvP_Func026Func016Func002Func001C takes nothing returns boolean
    if(not(udg_integer02==10))then
        return false
    endif
    return true
endfunction

function Trig_End_PvP_Func026Func016Func002Func003001 takes nothing returns boolean
    return(udg_integer14==1)
endfunction

function Trig_End_PvP_Func026Func016Func002Func004001 takes nothing returns boolean
    return(udg_integer14==2)
endfunction

function Trig_End_PvP_Func026Func016Func002Func005001 takes nothing returns boolean
    return(udg_integer14==3)
endfunction

function Trig_End_PvP_Func026Func016Func002Func006001 takes nothing returns boolean
    return(udg_integer14==4)
endfunction

function Trig_End_PvP_Func026Func016Func002C takes nothing returns boolean
    if(not(udg_integer02==5))then
        return false
    endif
    return true
endfunction








































function Trig_PvP_Battle_Func001Func018Func001001 takes nothing returns boolean
    return(GetUnitTypeId(GetEnumUnit())=='hphx')
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
        set debugText = debugText + I2S(GetPlayerId(GetOwningPlayer(BlzGroupUnitAt(udg_group01, i))))
        set i = i - 1
        exitwhen i < 0
    endloop

    return debugText
endfunction













function Trig_Receive_Prize_Func002Func002Func001C takes nothing returns boolean
    if(not(UnitItemInSlotBJ(GetEnumUnit(),udg_integer34)==null))then
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
    if(not(udg_integer02==5))then
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
    if(not(udg_integer02==10))then
        return false
    endif
    return true
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
    call TriggerRegisterDialogEventBJ(udg_trigger45,udg_dialogs01[1])
    call TriggerAddCondition(udg_trigger45,Condition(function Trig_Place_Bet_PvP1_Conditions))
    call TriggerAddAction(udg_trigger45,function Trig_Place_Bet_PvP1_Actions)
    set udg_trigger46 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger46,udg_dialogs01[1])
    call TriggerAddCondition(udg_trigger46,Condition(function Trig_Place_Bet_PvP2_Conditions))
    call TriggerAddAction(udg_trigger46,function Trig_Place_Bet_PvP2_Actions)
    set udg_trigger47 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger47,udg_dialogs01[1])
    call TriggerAddCondition(udg_trigger47,Condition(function Trig_Skip_Bet_Conditions))
    call TriggerAddAction(udg_trigger47,function Trig_Skip_Bet_Actions)
    set udg_trigger48 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger48,udg_dialogs01[2])
    call TriggerAddCondition(udg_trigger48,Condition(function Trig_Place_Bet_Gold_Conditions))
    call TriggerAddAction(udg_trigger48,function Trig_Place_Bet_Gold_Actions)
    set udg_trigger49 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger49,udg_dialogs01[2])
    call TriggerAddCondition(udg_trigger49,Condition(function Trig_Place_Bet_Lumber_Conditions))
    call TriggerAddAction(udg_trigger49,function Trig_Place_Bet_Lumber_Actions)
    set udg_trigger50 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger50,udg_dialogs01[2])
    call TriggerAddCondition(udg_trigger50,Condition(function Trig_Place_Bet_GoldLumber_Conditions))
    call TriggerAddAction(udg_trigger50,function Trig_Place_Bet_GoldLumber_Actions)
    set udg_trigger51 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger51,udg_dialogs01[3])
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
    call TriggerRegisterDialogEventBJ(udg_trigger59,udg_dialog01)
    call TriggerAddCondition(udg_trigger59,Condition(function Trig_Dialog_25_Conditions))
    call TriggerAddAction(udg_trigger59,function Trig_Dialog_25_Actions)
    set udg_trigger60 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger60,udg_dialog01)
    call TriggerAddCondition(udg_trigger60,Condition(function Trig_Dialog_50_Conditions))
    call TriggerAddAction(udg_trigger60,function Trig_Dialog_50_Actions)
    set udg_trigger61 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger61,udg_dialog01)
    call TriggerAddCondition(udg_trigger61,Condition(function Trig_Doesnt_Matter_Conditions))
    call TriggerAddAction(udg_trigger61,function Trig_Doesnt_Matter_Actions)
    set udg_trigger62 = CreateTrigger()
    call TriggerAddAction(udg_trigger62,function Trig_Skip_Betting_Menu_Actions)
    set udg_trigger63 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger63,udg_dialog02)
    call TriggerAddCondition(udg_trigger63,Condition(function Trig_Normal_Mode_Conditions))
    call TriggerAddAction(udg_trigger63,function Trig_Normal_Mode_Actions)
    set udg_trigger64 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger64,udg_dialog02)
    call TriggerAddCondition(udg_trigger64,Condition(function Trig_Elimination_Mode_Conditions))
    call TriggerAddAction(udg_trigger64,function Trig_Elimination_Mode_Actions)
    set udg_trigger65 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger65,udg_dialog02)
    call TriggerAddCondition(udg_trigger65,Condition(function Trig_Death_Match_Mode_Conditions))
    call TriggerAddAction(udg_trigger65,function Trig_Death_Match_Mode_Actions)
    set udg_trigger66 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger66,udg_dialog02)
    call TriggerAddCondition(udg_trigger66,Condition(function Trig_Doesnt_Matter_Mode_Conditions))
    call TriggerAddAction(udg_trigger66,function Trig_Doesnt_Matter_Mode_Actions)
    set udg_trigger67 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger67,udg_dialog03)
    call TriggerAddCondition(udg_trigger67,Condition(function Trig_Pick_Abilities_Conditions))
    call TriggerAddAction(udg_trigger67,function Trig_Pick_Abilities_Actions)
    set udg_trigger68 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger68,udg_dialog03)
    call TriggerAddCondition(udg_trigger68,Condition(function Trig_Random_Abilities_Conditions))
    call TriggerAddAction(udg_trigger68,function Trig_Random_Abilities_Actions)
    set trg = CreateTrigger()
    call TriggerRegisterDialogEventBJ(trg,udg_dialog03)
    call TriggerAddCondition(trg,Condition(function Trig_Draft_Abilities_Conditions))
    call TriggerAddAction(trg,function Trig_Draft_Abilities_Actions)
    set udg_trigger69 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger69,udg_dialog03)
    call TriggerAddCondition(udg_trigger69,Condition(function Trig_Doesnt_Matter_Abilities_Conditions))
    call TriggerAddAction(udg_trigger69,function Trig_Doesnt_Matter_Abilities_Actions)

    set trg = CreateTrigger()
    call TriggerRegisterDialogEventBJ(trg,IncomeDialog)
    call TriggerAddCondition(trg,Condition(function Trig_Income_Conditions))
    call TriggerAddAction(trg,function Trig_Income_Actions)
    set trg = CreateTrigger()
    call TriggerRegisterDialogEventBJ(trg,IncomeDialog)
    call TriggerAddCondition(trg,Condition(function Trig_Individual_Income_Conditions))
    call TriggerAddAction(trg,function Trig_Individual_Income_Actions)
    set trg = CreateTrigger()
    call TriggerRegisterDialogEventBJ(trg,IncomeDialog)
    call TriggerAddCondition(trg,Condition(function Trig_No_Income_Conditions))
    call TriggerAddAction(trg,function Trig_No_Income_Actions)

    set trg = null

    set udg_trigger70 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger70,udg_dialog07)
    call TriggerAddCondition(udg_trigger70,Condition(function Trig_Pick_Hero_Conditions))
    call TriggerAddAction(udg_trigger70,function Trig_Pick_Hero_Actions)
    set udg_trigger71 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger71,udg_dialog07)
    call TriggerAddCondition(udg_trigger71,Condition(function Trig_Random_Hero_Conditions))
    call TriggerAddAction(udg_trigger71,function Trig_Random_Hero_Actions)
    set udg_trigger72 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger72,udg_dialog07)
    call TriggerAddCondition(udg_trigger72,Condition(function Trig_Doesnt_Matter_Hero_Conditions))
    call TriggerAddAction(udg_trigger72,function Trig_Doesnt_Matter_Hero_Actions)
    set udg_trigger73 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger73,udg_dialog05)
    call TriggerAddCondition(udg_trigger73,Condition(function Trig_Show_Betting_Menu_Conditions))
    call TriggerAddAction(udg_trigger73,function Trig_Show_Betting_Menu_Actions)
    set udg_trigger74 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger74,udg_dialog05)
    call TriggerAddCondition(udg_trigger74,Condition(function Trig_Hide_Betting_Menu_Conditions))
    call TriggerAddAction(udg_trigger74,function Trig_Hide_Betting_Menu_Actions)
    set udg_trigger75 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger75,udg_dialog05)
    call TriggerAddCondition(udg_trigger75,Condition(function Trig_Disable_Betting_Menu_Conditions))
    call TriggerAddAction(udg_trigger75,function Trig_Disable_Betting_Menu_Actions)
    set udg_trigger76 = CreateTrigger()
    call TriggerRegisterDialogEventBJ(udg_trigger76,udg_dialog05)
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
    call TriggerRegisterEnterRectSimple(udg_trigger142,udg_rect09)
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
    call TriggerRegisterEnterRectSimple(udg_trigger145,udg_rect09)
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
