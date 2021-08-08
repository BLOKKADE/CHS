function AEah_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Thorns"
    set PARAMETR_TOOLTIP = "When the hero takes attack damage, the enemy loses !PAR1!% of that damage."
endfunction


function AEah_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    set A.Param1 = 0.01*lvl
    set A.Param1Chance = true
    set u = null
endfunction 