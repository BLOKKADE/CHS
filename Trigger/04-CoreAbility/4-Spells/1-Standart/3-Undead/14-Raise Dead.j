function Arai_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Raise Dead"
    set PARAMETR_TOOLTIP = "Raises 2 skeletons from a corpse."
endfunction


function Arai_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.SummonId1 = 'uske'
    set A.Param1 = 1
    set A.Param1Field = 'Rai1'
    
    set A.SummonId2 = 'uskm'
    set A.Param1 = 1
    set A.Param1Field = 'Rai2'
    
    
    set A.Range1 = 600
    set A.Cooldown1 = 4 
    set A.DurationNormal1 = 45
    set A.Cost1 = 60 + (15 * lvl)
    
    set u = null
endfunction 