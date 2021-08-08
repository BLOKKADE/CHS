function AHad_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Devation Aura"
    set PARAMETR_TOOLTIP = "Gives !PAR1! additional armor to nearby friendly units."
endfunction


function AHad_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    
    set A.Area1 = 995 + 5*lvl

    set A.Param1 = (15+ 0.05*lvl)*lvl
    set A.Param1Field = 'Had1'   //Field in the Object editor

    set u = null
endfunction 