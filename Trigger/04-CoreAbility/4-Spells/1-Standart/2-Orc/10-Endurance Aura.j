function AOae_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Endurance Aura"
    set PARAMETR_TOOLTIP = "Increases nearby friendly units' movement speed by !PAR1!% and attack rate by !PAR2!%"
endfunction


function AOae_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    
    set A.Area1 = 900

    set A.Param1 = 0.075*lvl
    set A.Param1Field = 'Oae1' 
    set A.Param1Chance = true
    
    set A.Param2 = 0.075*lvl
    set A.Param2Field = 'Oae2'   
    set A.Param2Chance = true
    
    set u = null
endfunction 