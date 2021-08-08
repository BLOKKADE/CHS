function Awar_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Pulverize"
    set PARAMETR_TOOLTIP = "When dealing physical damage, gives the Hero a !PAR1! chance to deal !DMG1! bonus damage to enemies in a small area."
endfunction


function Awar_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    
    set A.Damage1 = 100 + 75*lvl
    set A.Param1 = 0.25
    set A.Param1Chance = true

    set A.Area1 = 300

    set u = null
endfunction 