function AOr2_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Slow Aura"
    set PARAMETR_TOOLTIP = "Decreases nearby enemy units' movement speed and attack rate by !PAR1!%."
endfunction


function AOr2_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    
    set A.Area1 = 250 + 15*lvl

    set A.Param1 = -0.05*lvl
    set A.Param1Field = 'Oae1' 
    set A.Param1Chance = true
    
    set A.Param2 = -0.05*lvl
    set A.Param2Field = 'Oae2'     
    set A.Param2Chance = true
    
    set u = null
endfunction 