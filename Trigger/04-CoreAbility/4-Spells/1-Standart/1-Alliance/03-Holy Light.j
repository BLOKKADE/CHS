function A084_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Holy Light"
    set PARAMETR_TOOLTIP = "A holy light that can heal a friendly living unit for !PAR1! or deal !DMG1! damage to an enemy unit."
endfunction


function A084_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Param1 = (200+lvl*4)*lvl
    set A.Damage1 = (100+lvl*2 )*lvl 
    set A.Cost1 = 95 + 55*lvl
    set A.Range1 = 600

    set A.Cooldown1 = 7
    
    set u = null
endfunction 