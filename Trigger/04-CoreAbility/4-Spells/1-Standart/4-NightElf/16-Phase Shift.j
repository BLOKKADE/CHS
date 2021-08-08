function Apsh_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Phase Shift"
    set PARAMETR_TOOLTIP = "Causes this unit to shift out of existence whenever it takes damage, temporarily avoiding any further damage."
endfunction


function Apsh_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Cooldown1 = RMaxBJ(21 - (1 * lvl) , 0)
    set A.DurationNormal1 = 0.5 * lvl
    set A.DurationHero1 = 0.5 * lvl
    set A.Cost1 = 5 + 15 * lvl
    
    set u = null
endfunction 