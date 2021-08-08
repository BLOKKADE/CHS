function Asal_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Pilage"
    set PARAMETR_TOOLTIP = "Gives a !PAR2!% chance to get !PAR1! bonus gold from kills.|n|n|cffc0c0c0<Asal,Dur1>% less effective for each Learnability level the Hero has."
endfunction


function  Asal_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    set A.Param1 = R2I((13 + lvl/2)*lvl)
    set A.Param2 = 0.65
    set A.Param2Chance = true

    set u = null
endfunction 