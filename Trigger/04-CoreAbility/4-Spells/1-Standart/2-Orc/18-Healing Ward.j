function A086_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Healing Ward"
    set PARAMETR_TOOLTIP = "Summons an immovable ward that heals !PAR1! of a nearby friendly non-mechanical unit's hit points per second."
endfunction


function A086_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    set A.Param1 = (45 + 5*lvl) * lvl 
    set A.Cost1 = 60*lvl
    set A.Area1 = 600
    set A.DurationHero1 = 8.9 + 0.1*lvl
    set A.DurationNormal1 = 8.9 + 0.1*lvl
    set A.Range1 = 600
    set A.Cooldown1 = 4 
    set u = null
endfunction 