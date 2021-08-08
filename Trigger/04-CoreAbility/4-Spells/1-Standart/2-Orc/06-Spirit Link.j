function Aspl_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Spirit Link"
    set PARAMETR_TOOLTIP = "Links !PAR1! units together in a chain. All units with Spirit Link on them will live longer, by distributing !PAR2!% of the damage they take across other Spirit Linked units.|"
endfunction


function Aspl_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    

    set A.Param1 = R2I(2 + 0.6664*lvl)
    set A.Param1Field = 'spl2'
    
    set A.Param2 = 1 - 0.9*( lvl/(30+lvl))
    set A.Param2Field = 'spl1'
    set A.Param2Chance = true
      
    
    set A.Cost1 = 25 + 25*lvl
    set A.Area1 = 900
    
    set A.DurationHero1 = 15
    set A.DurationNormal1 = 15
    
    set A.Range1 = 800

    set A.Cooldown1 = 20
    
    set u = null
endfunction 