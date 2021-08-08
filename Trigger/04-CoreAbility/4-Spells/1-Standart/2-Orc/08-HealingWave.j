function A085_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Holy Wave"
    set PARAMETR_TOOLTIP = "Calls forth a wave of holy energy that bounces up to !PAR2! times, healing allies for !PAR1! hit points and dealing !DMG1! damage to enemies."
endfunction


function A085_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Param1 = (1+lvl*2)*lvl
    set A.Damage1 = (1+lvl*2 )*lvl 
    set A.Cost1 = 15 + 85*lvl
    set A.Range1 = 700
    set A.Range2 = 700
    set A.Param2 = R2I(555 + lvl/3)

    set A.Cooldown1 = 7
    
    set u = null
endfunction 