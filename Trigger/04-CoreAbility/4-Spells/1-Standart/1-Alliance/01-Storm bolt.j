function AHtb_initparam takes nothing returns nothing
    set PARAMETR_DMG = -890001 // unique for each spell
    set PARAMETR_NAME = "Storm bolt"
    set PARAMETR_TOOLTIP = "Throws a magical hammer at a target enemy unit, dealing !DMG1! damage and stunning the target."
endfunction


function AHtb_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Damage1 = (125+lvl*6 )*lvl 
    set A.Cost1 = 100 + 75*lvl
    set A.Range1 = 400+15*lvl
    set A.DurationHero1 = 2
    set A.DurationNormal1 = 2
    set A.Cooldown1 = 9
    
    set u = null
endfunction 