function AEer_initparam takes nothing returns nothing
    set PARAMETR_DMG = 890018 
    
    set PARAMETR_NAME = "Entangling Roots"
    set PARAMETR_TOOLTIP = "Causes roots to burst from the ground, immobilizing and disarming a target enemy unit for a few seconds, and dealing !DMG1! damage per second."
endfunction


function AEer_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Damage1 = (20 + (lvl * 3)) * lvl // lvl 1 = 23, lvl 30 = 3300
      
    set A.Range1 = 600
    set A.Cooldown1 = 14
    set A.DurationNormal1 = 5 + (0.034 * lvl)
    set A.DurationHero1 = 4.5
    set A.Cost1 = 70 + 15 * lvl
    
    set u = null
endfunction 