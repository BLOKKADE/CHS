function AHav_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Avatar"
    set PARAMETR_TOOLTIP = "Activate Avatar to give !PAR1! bonus armor, !PAR2! bonus hit points, !PAR3! bonus damage and spell immunity."
endfunction


function AHav_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Cost1 = (100 + lvl)*lvl
    set A.DurationHero1 = 3+0.12*lvl
    set A.DurationNormal1 = 3+0.12*lvl
    set A.Cooldown1 = 30 + 0.12*lvl
    
    set A.Param1 = 15*lvl
    set A.Param1Field = 'Hav1'   //Field in the Object editor
    
    set A.Param2 = (250+lvl*7)*lvl
    set A.Param2Field = 'Hav2'    
    
    set A.Param3 = (25+lvl*2)*lvl
    set A.Param3Field = 'Hav3'   
    
    
    set u = null
endfunction 