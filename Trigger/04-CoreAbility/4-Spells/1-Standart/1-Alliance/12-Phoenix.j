function AHpx_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Phoenix"
    set PARAMETR_TOOLTIP = "Summons a powerful Phoenix. The Phoenix burns with such intensity that it damages itself and nearby enemy units. The Phoenix can attack banished units."
endfunction


function AHpx_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.SummonId1 = 'h009'
    set A.Param1 = 1
    set A.Param1Field = 'Hwe2'
    
    set A.Cost1 = (300 + lvl*2)*lvl
    set A.DurationHero1 = 25+0.5*lvl
    set A.DurationNormal1 = 25+0.5*lvl
    set A.Area1 = 200
    set A.Cooldown1 = 30 
    
  
    
    
    set u = null
endfunction 