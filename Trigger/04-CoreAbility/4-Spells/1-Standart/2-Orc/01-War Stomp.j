function AOws_initparam takes nothing returns nothing
    set PARAMETR_DMG = -890008 

    set PARAMETR_NAME = "War Stomp"
    set PARAMETR_TOOLTIP = "Slams the ground, dealing !DMG1! damage to nearby enemy land units and stunning them."
endfunction


function  AOws_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Damage1 = (120+lvl*2 )*lvl 

        
    
    set A.Cost1 = 75 + 33*lvl
    set A.Area1 = 275+5*lvl
    
    set A.DurationHero1 = 0.5 + 0.1*lvl
    set A.DurationNormal1 = 3 + 0.15*lvl
    set A.Cooldown1 = 6.9+0.1*lvl
    
    set u = null
endfunction 