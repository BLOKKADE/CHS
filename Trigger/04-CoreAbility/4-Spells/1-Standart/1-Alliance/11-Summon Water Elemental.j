function AHwe_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Summon Water Elemental"
    set PARAMETR_TOOLTIP = "Summons !PAR1! Water Elementals to attack enemies"
endfunction


function AHwe_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.SummonId1 = 'hwat'
    set A.Param1 = 2
    set A.Param1Field = 'Hwe2'
    
    set A.Cost1 = (150 + lvl)*lvl
    set A.DurationHero1 = 12+0.2*lvl
    set A.DurationNormal1 = 12+0.2*lvl
    set A.Area1 = 200
    set A.Cooldown1 = 14 
    
  
    
    
    set u = null
endfunction 