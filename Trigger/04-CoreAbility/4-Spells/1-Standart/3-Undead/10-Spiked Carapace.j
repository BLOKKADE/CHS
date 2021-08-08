function AUts_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Spiked Carapace"
    set PARAMETR_TOOLTIP = "Enhances the hero's chitinous armor with organic barbs, giving the hero !PAR2! bonus armor and returning !PAR1!% of melee attack damage to enemies."
endfunction


function AUts_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Param1 = 0.01*lvl    
    set A.Param1Chance = true
    set A.Param2 = 5*lvl
    set A.Param2Field = 'Uts3'
    
    set u = null
endfunction 