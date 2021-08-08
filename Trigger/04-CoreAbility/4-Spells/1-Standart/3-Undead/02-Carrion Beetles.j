function AUcb_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Carrion Beetles"
    set PARAMETR_TOOLTIP = "Progenerates a Beetle from a target corpse. Beetles are permanent until killed. |nMaximum of !PAR2! Beetles."
endfunction


function AUcb_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.SummonId1 = 'u001'
    
    set A.Param1 = 2
    set A.Param1Field = 'Rai1'
    
    
    set A.Param2 = R2I(2 + lvl/4)
    set A.Param2Field = 'Ucb5'
    
    set A.Cost1 = (49 + lvl)*lvl
    set A.DurationHero1 = 25
    set A.DurationNormal1 = 25
    set A.Area1 = 800
    set A.Cooldown1 = 2 
    
  
    
    
    set u = null
endfunction 