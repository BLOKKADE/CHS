function AUdd_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Death and Decay"
    set PARAMETR_TOOLTIP = "Damages everything in its area of effect by !PAR1!% of its base hit points per second.."
endfunction


function  AUdd_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A

    set A.Param1 =  0.01 * lvl
    set A.Param1Field = 'Udd1'
    set A.Param1Chance = true
      
    
    set A.Cost1 = 15 + 25*lvl
    set A.Area1 = 300
    
    set A.Range1 = 1000

    set A.Cooldown1 = 30
    set A.DurationNormal1 = 25
    
    set u = null
endfunction 