function AHtc_initparam takes nothing returns nothing
    set PARAMETR_DMG = 890003 

    set PARAMETR_NAME = "Thunder Clap"
    set PARAMETR_TOOLTIP = "Slams the ground, dealing !DMG1! damage to nearby enemy land units and slowing their movement by !PAR1!% and attack rate by !PAR2!%."
endfunction


function AHtc_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Damage1 = (200+lvl*3 )*lvl 

        
    set A.Param1 = 0.5
    set A.Param1Field = 'Htc4'
    
    set A.Param2 = 0.5
    set A.Param2Field = 'Htc3' 

    
    set A.Cost1 = 75 + 50*lvl
    set A.Area1 = 350+15*lvl
    
    set A.DurationHero1 = 3 + 0.1*lvl
    set A.DurationNormal1 = 4 + 0.15*lvl
    set A.Cooldown1 = 12
    
    set u = null
endfunction 