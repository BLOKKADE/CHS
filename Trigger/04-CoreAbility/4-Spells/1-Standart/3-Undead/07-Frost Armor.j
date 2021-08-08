function AUfu_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Frost Armor"
    set PARAMETR_TOOLTIP = "Creates a shield of frost around a target friendly unit that lasts for !PAR2! seconds. The shield adds !PAR1! armor and slows melee units that attack it for a few seconds."
endfunction


function  AUfu_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A

    set A.Param1 =  11 * lvl
    set A.Param1Field = 'Ufa2'
    
    set A.Param2 =  20
    set A.Param2Field = 'Ufa1'
      
    
    set A.Cost1 = 25 + 25*lvl
    
    set A.Range1 = 800

    set A.Cooldown1 = 3
    set A.DurationNormal1 = 4
    set A.DurationHero1 = 4
    
    set u = null
endfunction 