function AOsf_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Feral Spirit"
    set PARAMETR_TOOLTIP = "Summons !PAR1! Spirit Wolves with evasion to attack enemies."
endfunction


function AOsf_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.SummonId1 = 'osw1'
    set A.Param1 = 2
    set A.Param1Field = 'Osf2'
    
    set A.Cost1 = (25 + lvl)*lvl
    set A.DurationHero1 = 15.8+0.2*lvl
    set A.DurationNormal1 = 15.8+0.2*lvl
    set A.Area1 = 200
    set A.Cooldown1 = 8 
    
  
    
    
    set u = null
endfunction 