function AHds_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Divine Shield"
    set PARAMETR_TOOLTIP = "An impenetrable shield surrounds this unit, protecting it from all damage and spells."
endfunction


function AHds_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Cost1 = (25 + lvl)*lvl
    set A.DurationHero1 = 1+0.05*lvl
    set A.Cooldown1 = 30 + 0.05*lvl
    
    set u = null
endfunction 