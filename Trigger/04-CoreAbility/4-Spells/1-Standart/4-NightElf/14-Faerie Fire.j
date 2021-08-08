function Afae_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Faerie Fire"
    set PARAMETR_TOOLTIP = "Reduces a target enemy unit's armor by !PAR1! and gives vision of that unit."
endfunction


function Afae_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Param1 = 15 * lvl // lvl 1 = 23, lvl 30 = 3300
    set A.Param1Field = 'Fae1'
    set A.Param1FieldType = 1
    
    set A.Range1 = 700
    set A.Cooldown1 = 3
    set A.DurationNormal1 = 30
    set A.DurationHero1 = 30
    set A.Cost1 = 20 + 25 * lvl
    
    set u = null
endfunction 