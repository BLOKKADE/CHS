function A089_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Tranquility"
    set PARAMETR_TOOLTIP = "Causes rains of healing energy to pour down in a large area, healing friendly allied units for !PAR1! hit points every !PAR2! seconds."
endfunction


function A089_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    set A.Param1 = (23 + 2*lvl)*lvl
    set A.Param2 = 1 -  0.8*lvl/(50+lvl)
    set A.Cost1 = 250*lvl
    set A.DurationHero1 = 12
    set A.DurationNormal1 = 12 
    set A.Area1 = 600
    set A.Cooldown1 = 60
    set u = null
endfunction 