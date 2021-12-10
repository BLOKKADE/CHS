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
function Trig_Faerie_Dragon_Func001Func001Func002C takes nothing returns boolean
    if(not(DistanceBetweenPoints(GetUnitLoc(GetEnumUnit()),GetUnitLoc(udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]))>= 900.00))then
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
    if(not(GetOwningPlayer(GetEnumUnit())==GetOwningPlayer(udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))])))then
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
            call SetUnitPositionLoc(GetEnumUnit(),GetUnitLoc(udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]))
            call IssueImmediateOrderBJ(GetEnumUnit(),"stop")
            call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
        endif
        if(Trig_Faerie_Dragon_Func001Func001Func003C())then
            set MysticFaerie[GetPlayerId(GetOwningPlayer(GetEnumUnit()))] = GetEnumUnit()
            call BlzSetUnitAttackCooldown(GetEnumUnit(), BlzGetUnitAttackCooldown(udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))], 0), 0)
            call SetUnitAbilityLevelSwapped('A000',GetEnumUnit(),R2I(GetHeroLevel(udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))])/ 3))
            call UnitSetAttackSpeed(GetEnumUnit(), GetHeroLevel(udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]) * 0.03)
            call IssuePointOrderLocBJ(GetEnumUnit(),"attack",OffsetLocation(GetUnitLoc(udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]),GetRandomReal(- 300.00,300.00),GetRandomReal(- 300.00,300.00)))
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
    if(not(GetUnitTypeId(GetTriggerUnit())!='n00V'))then
        return false
    endif
    if(not(GetUnitTypeId(GetTriggerUnit())!='h00V'))then
        return false
    endif
    if(not(GetUnitTypeId(udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))])=='N00O'))then
        return false
    endif
    if(not(IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))]))==true))then
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
/*
*/
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
            call CreateNUnitsAtLoc(1,'h015',GetOwningPlayer(GetTriggerUnit()),PolarProjectionBJ(GetSpellTargetLoc(),256.00,AngleBetweenPoints(GetSpellTargetLoc(),GetUnitLoc(GetTriggerUnit()))),bj_UNIT_FACING)
        else
            call CreateNUnitsAtLoc(1,'h015',GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(GetTriggerUnit()),bj_UNIT_FACING)
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
//income
function SetIncomeMode takes nothing returns nothing
    if IncomeMode == 1 then
        call ReplaceUnitBJ(gg_unit_n02L_0012,'n035',bj_UNIT_STATE_METHOD_RELATIVE)
    elseif IncomeMode == 2 then
        call ReplaceUnitBJ(gg_unit_n02L_0012,'n034',bj_UNIT_STATE_METHOD_RELATIVE)		
    endif
endfunction
globals
    boolean array DisableDeathTrigger
endglobals
/*
*/
function Trig_Xesils_Legacy_Conditions takes nothing returns boolean
    if(not(UnitHasItemOfTypeBJ(GetTriggerUnit(),'I03P')==true))then
        return false
    endif
    return true
endfunction
function Trig_Xesils_Legacy_Func002C takes nothing returns boolean
    if(not(udg_integer14==1))then
        return false
    endif
    return true
endfunction
function Trig_Xesils_Legacy_Actions takes nothing returns nothing
    local unit U = GetTriggerUnit()
    local integer Ib = GetSpellAbilityId()
    set udg_integer14 = GetRandomInt(1,4)
    if(Trig_Xesils_Legacy_Func002C())then
        call TriggerSleepAction(0.00)	
        call BlzEndUnitAbilityCooldown(U,Ib)
        call AddSpecialEffectTargetUnitBJ("origin",U,"Abilities\\Spells\\Other\\Charm\\CharmTarget.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
    else
    endif
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
//next round unit create
    local integer round = udg_integer02 + 1
    if(Trig_Level_Completed_Func001C())then
        if(Trig_Level_Completed_Func001Func001001())then
            return
        else
            call DoNothing()
        endif
        set udg_integer08 = 0
        call PlaySoundBJ(udg_sound02)
        if(Trig_Level_Completed_Func001Func014C())then
            if(Trig_Level_Completed_Func001Func014Func001C())then
            endif
        endif
        if(Trig_Level_Completed_Func001Func018C())then
            if(Trig_Level_Completed_Func001Func018Func002C())then
                call GroupClear(udg_group03)
            endif
        else
            if(Trig_Level_Completed_Func001Func018Func001C())then
                call GroupClear(udg_group03)
            endif
        endif
        if(Trig_Level_Completed_Func001Func023C())then
            if(Trig_Level_Completed_Func001Func023Func002C())then
                if(Trig_Level_Completed_Func001Func023Func002Func003C())then
                return
            endif
        else
            if(Trig_Level_Completed_Func001Func023Func001C())then
                if(Trig_Level_Completed_Func001Func023Func001Func003C())then
                return
            endif
        endif
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
    endif
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
/*
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
    call TriggerRegisterTimerEventPeriodic(udg_trigger15,1.00)
    call TriggerAddAction(udg_trigger15,function Trig_Faerie_Dragon_Actions)*/
    call TriggerRegisterAnyUnitEventBJ(udg_trigger29,EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(udg_trigger29,Condition(function Trig_Skeletal_Brute_Conditions))
    call TriggerAddAction(udg_trigger29,function Trig_Skeletal_Brute_Actions)*/
    call TriggerAddCondition(udg_trigger37,Condition(function Trig_Cast_Channeling_Ability_Conditions))
    call TriggerAddAction(udg_trigger37,function Trig_Cast_Channeling_Ability_Actions)*/
    call TriggerRegisterDialogEventBJ(trg,udg_dialog03)
    call TriggerAddCondition(trg,Condition(function Trig_Draft_Abilities_Conditions))
    call TriggerAddAction(trg,function Trig_Draft_Abilities_Actions)
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
    call TriggerRegisterAnyUnitEventBJ(udg_trigger97,EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(udg_trigger97,Condition(function Trig_Xesils_Legacy_Conditions))
    call TriggerAddAction(udg_trigger97,function Trig_Xesils_Legacy_Actions)*/
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
