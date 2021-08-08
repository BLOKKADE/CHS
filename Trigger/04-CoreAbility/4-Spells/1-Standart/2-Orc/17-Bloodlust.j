function Ablo_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Bloodlust"
    set PARAMETR_TOOLTIP = "Increases a friendly unit's attack rate by !PAR1!% and movement speed by !PAR2!%"
endfunction


function Ablo_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    

    set A.Param1 = 0.08*lvl
    set A.Param1Field = 'Blo1'
    set A.Param1Chance = true
    
    set A.Param2 =  0.08*lvl
    set A.Param2Field = 'Blo2'
    set A.Param2Chance = true
    
    set A.Cost1 = 25*lvl
    set A.DurationHero1 = 15
    set A.DurationNormal1 = 15

    set A.Cooldown1 = 5 

    set u = null
endfunction 