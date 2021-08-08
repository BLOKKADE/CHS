function Acrs_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Curse"
    set PARAMETR_TOOLTIP = "Curses a target enemy unit, causing it to have a !PAR1!% chance to miss on an attack."
endfunction


function Acrs_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Param1 = 0.03 * lvl
    set A.Param1Field = 'Crs1'
    set A.Param1Chance = true
      
    set A.Range1 = 700
    set A.Cooldown1 = 3
    set A.DurationNormal1 = 20
    set A.DurationHero1 = 6 + (1 * lvl)
    set A.Cost1 = 28 + 12*lvl
    
    set u = null
endfunction 