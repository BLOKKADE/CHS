function AUau_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Unholy Aura"
    set PARAMETR_TOOLTIP = "Increases nearby friendly units' movement speed by !PAR1!% and life regeneration rate by !PAR2! hit points per second."
endfunction


function AUau_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A

    set A.Param1 = 0.05 + (0.05 * lvl)
    set A.Param1Field = 'Uau1'
    set A.Param1Chance = true
    
    set A.Param2 =  15 * lvl
    set A.Param2Field = 'Uau2'
    
    set A.Area1 = 900
    
    set u = null
endfunction 