function AEsf_initparam takes nothing returns nothing
    set PARAMETR_DMG = -890023

    set PARAMETR_NAME = "Starfall"
    set PARAMETR_TOOLTIP = "Calls down waves of falling stars that damage nearby enemy units. Each wave deals !DMG1! damage."
endfunction


function  AEsf_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Damage1 = (75 + (lvl * 3)) * lvl // lvl 1 = 79, lvl 30 = 4950
    
    set A.Param1 = 0.81 - (0.01 * lvl)
    set A.Param1Field = 'Esf2'
    
    set A.Area1 = 500
    set A.DurationNormal1 = 30
    set A.Cooldown1 = 12
    set A.Cost1 = 80 + 10*lvl
    set u = null
endfunction 