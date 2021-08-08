function AOsh_initparam takes nothing returns nothing
    set PARAMETR_DMG = -890009 

    set PARAMETR_NAME = "Shockwave"
    set PARAMETR_TOOLTIP = "A wave of force that ripples outward, causing !DMG1! damage to land units in a line."
endfunction


function  AOsh_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Damage1 = (185+lvl*15 )*lvl 

    set A.Param1 = 150 
    set A.Param1Field = 'Osh4'
    
    set A.Param2 =  800
    set A.Param2Field = 'Osh3'
      
    
    set A.Cost1 = 75 + 65*lvl
    set A.Area1 = 150
    
    set A.Range1 = 800

    set A.Cooldown1 = 8
    
    set u = null
endfunction 