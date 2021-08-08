function AUin_initparam takes nothing returns nothing
    set PARAMETR_DMG = -890012 
    set PARAMETR_NAME = "Inferno"
    set PARAMETR_TOOLTIP = "Calls an Infernal down from the sky, dealing !DMG1! damage and stunning enemy land units for a few seconds in an area."
endfunction


function AUin_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    
    set A.Damage1 = (1140+60*lvl)*lvl
    set A.SummonId1 = 'n01N'
    
    set A.Param1 = 40
    set A.Param1Field = 'Uin3'
    
    
    set A.Param2 = 1
    set A.Param2Field = 'Uin1'
    
    set A.Cost1 = (397 + 3*lvl)*lvl
    set A.DurationHero1 = 3
    set A.DurationNormal1 = 5
    set A.Area1 = 200 + 5*lvl
    set A.Range1 = 900
    set A.Cooldown1 = 60
    
  
    
    
    set u = null
endfunction 