function Assk_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Hardened Skin"
    set PARAMETR_TOOLTIP = "Increases the Hero's block by !PAR1!."
endfunction


function  Assk_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Param1 = 50 * lvl
    
    set u = null
endfunction 