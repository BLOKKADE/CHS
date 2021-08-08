function A00M_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Death Pact"
    set PARAMETR_TOOLTIP = "Kills a target friendly unit, giving !PAR1!% of its hit points to the hero."
endfunction


function  A00M_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A

    set A.Param1 =  0.028 + 0.002 * lvl
    set A.Param1Chance = true
    
    set A.Cost1 = 50 + 50*lvl
    
    set A.Range1 = 800

    set A.Cooldown1 = 15
    
    set u = null
endfunction 