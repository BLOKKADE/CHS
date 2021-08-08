function Ainf_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Inner Fire"
    set PARAMETR_TOOLTIP = "Increases a target friendly unit's damage by !PAR1!% and armor by !PAR2!."
endfunction


function Ainf_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    
    
    set A.Param1 = 0.095*lvl
    set A.Param1Field = 'Inf1'
    set A.Param1Chance = true
    set A.Param2 = 10*lvl
    set A.Param2Field = 'Inf2'
    set A.Param2FieldType = 1

    set A.Cost1 = 150 + 50*lvl
    set A.Range1 = 500
    set A.DurationHero1 = 15
    set A.DurationNormal1 = 15
    set A.Cooldown1 = 18
    
    set u = null
endfunction 