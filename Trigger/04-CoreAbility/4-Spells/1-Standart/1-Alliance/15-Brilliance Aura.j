function AHab_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Brilliance Aura"
    set PARAMETR_TOOLTIP = "Gives !PAR1! additional mana regeneration to the Hero."
endfunction


function AHab_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Area1 = 995 + 5*lvl

    set A.Param1 = (10+ 0.25*lvl)*lvl
    set A.Param1Field = 'Hab1'   //Field in the Object editor
    
    set u = null
endfunction 