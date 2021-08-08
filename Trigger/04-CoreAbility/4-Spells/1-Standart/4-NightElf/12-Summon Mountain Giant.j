function AEsv_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Summon Mountain Giant"
    set PARAMETR_TOOLTIP = "Summons a massive melee unit that can disrupt enemy attackers and take incredible amounts of punishment. Has the Taunt and Hardened Skin abilities."
endfunction


function AEsv_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.SummonId1 = 'e00N'
    
    set A.Cost1 = 225 + (25 * lvl)
    set A.DurationHero1 = 30
    set A.DurationNormal1 = 30
    set A.Cooldown1 = 45
    
    set u = null
endfunction 