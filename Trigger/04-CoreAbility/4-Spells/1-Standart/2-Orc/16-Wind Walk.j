function AOwk_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Wind Walk"
    set PARAMETR_TOOLTIP = "Allows the hero to become invisible, and move !PAR2!% faster for a few seconds. If the hero attacks a unit to break invisibility, the attack will do !PAR1! bonus damage."
endfunction


function AOwk_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    

    set A.Param1 = (200+5*lvl)*lvl
    set A.Param1Field = 'Owk3'
    
    set A.Param2 = 0.2 + 0.1*lvl
    set A.Param2Field = 'Owk2'
    set A.Param2Chance = true
    
    set A.Cost1 = (33 + lvl)*lvl
    set A.DurationHero1 = 5
    set A.DurationNormal1 = 5

    set A.Cooldown1 = 4 

    set u = null
endfunction 