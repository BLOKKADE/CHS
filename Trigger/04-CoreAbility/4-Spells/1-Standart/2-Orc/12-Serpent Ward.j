function AOsw_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Serpent Ward"
    set PARAMETR_TOOLTIP = "Summons !PAR1! immobile serpentine ward to attack enemies. The ward is immune to magic."
endfunction


function AOsw_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.SummonId1 = 'osp1'
    set A.Param1 = 2
    set A.Param1Field = 'Hwe2'
    
    set A.Cost1 = (45 + lvl)*lvl
    set A.DurationHero1 = 16
    set A.DurationNormal1 = 16
    set A.Area1 = 200
    set A.Cooldown1 = 8 
    set A.Range1 = 500
  
    
    
    set u = null
endfunction 