function AUav_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Vampirism"
    set PARAMETR_TOOLTIP = "Every time the Hero damages an enemy it recovers hit points based on !PAR1!% of the damage dealt. |n|nFor every [Blood] spell the Hero has, Vampirism returns a bonus !PAR2! of the damage dealt as hit points."
endfunction


function  AUav_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    
    set A.Param1 = 0.005*lvl
    set A.Param1Chance = true
    set A.Param2 = 0.02

    set u = null
endfunction 