function AEsh_initparam takes nothing returns nothing
    set PARAMETR_DMG = 890021
    set PARAMETR_DMG2 = 890022
    
    set PARAMETR_NAME = "Shadow Strike"
    set PARAMETR_TOOLTIP = "Hurls a poisoned dagger at a target enemy unit, dealing !DMG1! initial damage, and !DMG2! damage every !CAST1! seconds. The poison slows the movement speed of the targeted unit by !PAR1!% for a short duration."
endfunction


function  AEsh_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Damage1 = 75 * lvl
    set A.Damage2 = 20 * lvl
    
    set A.Param2 = 75 * lvl
    set A.Param2Field = 'Esh5'
    
    set A.Param1 = -0.01 + (0.02 * lvl)
    set A.Param1Field = 'Esh2'
    set A.Param1Chance = true
    
    set A.CastingTime1 = 3
    set A.Range1 = 500 + (50 * lvl)
    set A.Cooldown1 = 6
    set A.DurationNormal1 = 14.8 + (0.3 * lvl)
    set A.DurationHero1 = 14.8 + (0.3 * lvl)
    set A.Cost1 = 50 + 15 * lvl

    set u = null
endfunction 