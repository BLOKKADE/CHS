function Aclf_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Fog"
    set PARAMETR_TOOLTIP = "Creates a cloud that stops units that are within it from casting spells, gives them a !PAR1!% chance to miss attacks and slows their movement by !PAR2!% and attack speed by !PAR3!%."
endfunction


function Aclf_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    


        
    set A.Param1 = 1  - 45/(45+lvl)
    set A.Param1Field = 'Nsi2'
    set A.Param1Chance = true
    
    set A.Param3 = 0.35
    set A.Param3Field = 'Nsi4' 
    set A.Param3Chance = true

    set A.Param2 = 0.1 + 25/(25+lvl)
    set A.Param2Field = 'Nsi3' 
    set A.Param2Chance = true
    
    set A.Cost1 = 75*lvl
    set A.Range1 = 550+15*lvl
    
    set A.Area1 = 350
    set A.DurationHero1 = 5 + 0.1*lvl
    set A.DurationNormal1 = 5 + 0.1*lvl
    set A.Cooldown1 = 15
    
    
    
    set u = null
endfunction 