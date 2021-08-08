function Aam2_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Anti-Magic Shell"
    set PARAMETR_TOOLTIP = "Creates a barrier that stops !PAR1! points of spell or magic damage from affecting the target unit."
endfunction


function Aam2_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Param1 = 2500 * lvl
    set A.Param1Field = 'Ams3'
    
    set A.Range1 = 500
    set A.Cooldown1 = 8
    set A.DurationHero1 = 15
    set A.DurationNormal1 = 15
    set A.Cost1 = 15 + (35 * lvl)
    
    set u = null
endfunction 