function AOcr_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Critical Strike"
    set PARAMETR_TOOLTIP = "When dealing |cffff8080physical damage|r, there is a !PAR1!% chance of dealing !PAR2! times damage."
endfunction


function AOcr_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Param1 = 0.2
    set A.Param1Chance = true
    set A.Param2 = 1.85 + lvl*0.15
    
    set u = null
endfunction 