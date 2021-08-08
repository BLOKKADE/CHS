function A087_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Rejuvenation"
    set PARAMETR_TOOLTIP = "Heals a target friendly unit for !PAR1! hit points and restores !PAR2! mana over a short period of time."
endfunction


function A087_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Param1 = (950 + 50*lvl)*lvl
    set A.Param2 = (950 + 50*lvl)*lvl
    
    set A.Cost1 = 140*lvl
    set A.Range1 = 600


    set A.DurationHero1 = 10
    set A.DurationNormal1 = 10 
    set A.Cooldown1 = 12
    
    set u = null
endfunction 