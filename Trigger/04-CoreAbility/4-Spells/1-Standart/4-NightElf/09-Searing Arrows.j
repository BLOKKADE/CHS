function AHfa_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Searing Arrows"
    set PARAMETR_TOOLTIP = "|cffffcc00Unique Attack Modifier|r|nAdds !PAR1! bonus fire damage to an attack against enemies, but drains mana with each shot fired."
endfunction


function  AHfa_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Param1 = (50 + (lvl * 13)) * lvl // lvl 1 = 63, lvl 30 = 13200
    set A.Param1Field = 'Hfa1'
    
    set A.Cost1 = 75 * lvl
    set u = null
endfunction 