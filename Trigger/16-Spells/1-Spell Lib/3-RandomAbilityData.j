/*globals


    integer array AbilSpellRB1
    integer AbilSRB1_count = 0 
    integer array AbilSpellRB2
    integer AbilSRB2_count = 0 
    
    integer array AbilSpellRB3
    integer AbilSRB3_count = 0 
endglobals

function PreloadRA takes nothing returns nothing
    local unit u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), PRIEST_1_UNIT_ID, 0, 0, 0)
    local integer i = 0
    
    loop
        call UnitAddAbility(u, AbilSpellRB1[i])
        call UnitRemoveAbility(u, AbilSpellRB1[i])
        exitwhen i == AbilSRB1_count
        set i = i + 1
    endloop
    
    set i = 0
    
    loop
        call UnitAddAbility(u, AbilSpellRB2[i])
        call UnitRemoveAbility(u, AbilSpellRB2[i])
        exitwhen i == AbilSRB2_count
        set i = i + 1
    endloop
    
    set i = 0
    
    loop
        call UnitAddAbility(u, AbilSpellRB3[i])
        call UnitRemoveAbility(u, AbilSpellRB3[i])
        exitwhen i == AbilSRB3_count
        set i = i + 1
    endloop
    
    call RemoveUnit(u)
    set u = null
endfunction

function InitDataRA4 takes nothing returns nothing

    set AbilSpellRB1[0] = STORM_BOLT_ABILITY_ID
    set AbilSpellRB1[1] = BANISH_ABILITY_ID
    set AbilSpellRB1[2] = 'AOhx'
    set AbilSpellRB1[3] = CHAIN_LIGHTNING_ABILITY_ID
    set AbilSpellRB1[4] = FROST_NOVA_ABILITY_ID
    set AbilSpellRB1[5] = UNHOLY_FRENZY_ABILITY_ID
    set AbilSpellRB1[6] = CURSE_ABILITY_ID
    set AbilSpellRB1[7] = SHADOW_STRIKE_ABILITY_ID
    set AbilSpellRB1[8] = FAERIE_FIRE_ABILITY_ID
    set AbilSpellRB1[9] = ENTAGLING_ROOTS_ABILITY_ID
    set AbilSpellRB1[10] = ACID_BOMB_ABILITY_ID
    set AbilSpellRB1[11] = SOUL_BURN_ABILITY_ID
    set AbilSpellRB1[12] = DRUNKEN_HAZE_ABILITY_ID
    set AbilSpellRB1[13] = FORKED_LIGHTNING_ABILITY_ID  
    set AbilSpellRB1[14] = LIGHTNING_SHIELD_ABILITY_ID  
    set AbilSpellRB1[15] = PARASITE_ABILITY_ID  
    set AbilSpellRB1[16] = ENSNARE_ABILITY_ID 
   
   
    set AbilSRB1_count = 16
      

    set AbilSpellRB2[0] = FLAME_STRIKE_ABILITY_ID
    set AbilSpellRB2[1] = BLIZZARD_DUMMY_ABILITY_ID
    set AbilSpellRB2[2] = SHOCKWAVE_ABILITY_ID
    set AbilSpellRB2[3] = IMPALE_ABILITY_ID
    set AbilSpellRB2[4] = DEATH_AND_DECAY_ABILITY_ID
    set AbilSpellRB2[5] = CARRION_SWARM_ABILITY_ID
    set AbilSpellRB2[6] = STAMPEDE_DUMMY_ABILITY_ID
    set AbilSpellRB2[7] = ACID_SPRAY_DUMMY_ABILITY_ID
    set AbilSpellRB2[8] = CLUSTER_ROCKETS_DUMMY_ABILITY_ID
    set AbilSpellRB2[9] = SILENCE_ABILITY_ID
    set AbilSpellRB2[10] = RAIN_OF_FIRE_DUMMY_ABILITY_ID
    set AbilSpellRB2[11] = BREATH_OF_FIRE_ABILITY_ID
    set AbilSpellRB2[12] = ICY_BREATH_ABILITY_ID  
    set AbilSpellRB2[13] = CLOUD_DUMMY_ABILITY_ID  
    set AbilSpellRB2[14] = STASIS_TRAP_ABILITY_ID 
    set AbilSpellRB2[15] = MONSOON_DUMMY_ABILITY_ID 
    set AbilSpellRB2[16] = CYCLONE_ABILITY_ID 
    set AbilSpellRB2[17] = PLAGUE_ABILITY_ID
    set AbilSpellRB2[18] = ICY_BREATH_ABILITY_ID   
    set AbilSRB2_count = 18
   
    set AbilSpellRB3[0] = THUNDER_CLAP_ABILITY_ID  
    set AbilSpellRB3[1] = WAR_STOMP_ABILITY_ID  
    set AbilSpellRB3[2] = STARFALL_DUMMY_ABILITY_ID 
    set AbilSpellRB3[3] = FAN_OF_KNIVES_ABILITY_ID      
    set AbilSpellRB3[4] = HOWL_OF_TERROR_ABILITY_ID      
    set AbilSpellRB3[5] = SERPANT_WARD_ABILITY_ID   
    set AbilSpellRB3[6] = FERAL_SPIRIT_ABILITY_ID 
    set AbilSpellRB3[7] = SUMMON_WATER_ELEMENTAL_ABILITY_ID
      
    set AbilSRB3_count = 7  
   
    call PreloadRA()
endfunction


function GetRandomAbility1_B takes nothing returns integer
    local integer I1 = GetRandomInt(0,AbilSRB1_count + AbilSRB2_count + AbilSRB3_count + 2)


    if I1 <= AbilSRB1_count then

        return AbilSpellRB1[I1]

    elseif I1 <= AbilSRB1_count + AbilSRB2_count + 1 then

        return AbilSpellRB2[I1 - AbilSRB1_count - 1]

    else
        return AbilSpellRB3[I1 - AbilSRB1_count - AbilSRB2_count - 2]

    endif




    return AbilSpellRB1[GetRandomInt(0,AbilSRB1_count) ] 
endfunction

//===========================================================================
function InitTrig_RandomAbilityData takes nothing returns nothing
    call InitDataRA4()
endfunction

*/