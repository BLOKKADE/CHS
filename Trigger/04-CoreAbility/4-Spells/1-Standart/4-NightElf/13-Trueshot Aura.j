function AEar_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Trueshot Aura  "
    set PARAMETR_TOOLTIP = "An aura that gives friendly nearby units a !PAR1!% bonus damage to their attacks."
endfunction


function  AEar_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Param1 = 0.05 * lvl
    set A.Param1Field = 'Ear1'
    set A.Param1Chance = true
    
    set u = null
endfunction 