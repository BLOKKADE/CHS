function AUcs_initparam takes nothing returns nothing
    set PARAMETR_DMG = 890013

    set PARAMETR_NAME = "Carrion Swarm"
    set PARAMETR_TOOLTIP = "Sends a horde of bats to deal !DMG1! damage to each enemy unit in a cone."
endfunction


function  AUcs_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Damage1 = 100 * lvl
    
    set A.Param2 =  999999
    set A.Param2Field = 'Ucs2'
      
    
    set A.Cost1 = 15 + 25*lvl
    set A.Area1 = 100
    
    set A.Range1 = 700

    set A.Cooldown1 = 3.5
    
    set u = null
endfunction 