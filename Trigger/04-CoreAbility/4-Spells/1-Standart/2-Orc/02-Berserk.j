function Absk_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Berserk"
    set PARAMETR_TOOLTIP = "Causes this unit to attack !PAR1!% faster, move !PAR2!% faster, and take no damage."
endfunction


function  Absk_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Damage1 = (120+lvl*2 )*lvl 

    set A.Param1 = 0.9 + 0.1*lvl
    set A.Param1Field = 'bsk2'
    set A.Param1Chance = true
    set A.Param2 = 0.9 + 0.1*lvl
    set A.Param2Field = 'bsk1'
    set A.Param2Chance = true
    
    set A.Cost1 = 175 + 25*lvl

    
    set A.DurationHero1 = 2 + 0.05*lvl
    set A.DurationNormal1 = 2 + 0.05*lvl
    set A.Cooldown1 = 10+0.05*lvl
    
    set u = null
endfunction 