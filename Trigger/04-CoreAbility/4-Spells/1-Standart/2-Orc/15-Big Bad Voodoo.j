function AOvd_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Big Bad Voodoo"
    set PARAMETR_TOOLTIP = "Turns all friendly units invulnerable in an area around the Hero. The Hero does not turn invulnerable."
endfunction


function  AOvd_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    

        
    
    set A.Cost1 = 400 - 20*lvl
    set A.Area1 = 600 + 20*lvl
    
    set A.DurationHero1 = 15
    set A.DurationNormal1 = 15
    set A.Cooldown1 = 15
    
    set u = null
endfunction 