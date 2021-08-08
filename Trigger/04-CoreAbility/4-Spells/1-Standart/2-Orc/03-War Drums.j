function Aakb_initparam takes nothing returns nothing
    set PARAMETR_NAME = "War Drums"
    set PARAMETR_TOOLTIP = "An aura that gives nearby friendly units !PAR1! bonus damage to their attacks."
endfunction


function  Aakb_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    set A.Param1 = (28 + 2*lvl)*lvl
    set A.Param1Field = 'Akb1'
    set A.Area1 = 900
    set u = null
endfunction 