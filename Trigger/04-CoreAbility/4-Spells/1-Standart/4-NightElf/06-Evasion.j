function AEev_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Evasion"
    set PARAMETR_TOOLTIP = "Increases the Hero's evasion by !PAR1!."
endfunction


function AEev_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    set A.Param1 = 2 * lvl
    set u = null
endfunction 