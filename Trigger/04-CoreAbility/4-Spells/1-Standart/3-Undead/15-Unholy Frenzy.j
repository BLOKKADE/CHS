function Auhf_initparam takes nothing returns nothing
    set PARAMETR_DMG = 890017
    set PARAMETR_NAME = "Unholy Frenzy"
    set PARAMETR_TOOLTIP = "Increases the attack rate of a target unit by !PAR1!%, but drains !DMG1! hit points per second."
endfunction


function Auhf_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Param1 = 3
    set A.Param1Field = 'Uhf1'
    set A.Param1Chance = true
    
    set A.Damage1 = (25 + (lvl * 5)) * lvl 
      
    set A.Range1 = 1000
    set A.Cooldown1 = 3
    set A.DurationNormal1 = 4 + (2 * lvl)
    set A.DurationHero1 = 4 + (2 * lvl)
    set A.Cost1 = 25 + 25*lvl
    
    set u = null
endfunction 