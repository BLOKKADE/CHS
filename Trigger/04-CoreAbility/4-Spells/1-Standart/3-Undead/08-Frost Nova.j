function AUfn_initparam takes nothing returns nothing
    set PARAMETR_DMG = 890014
    set PARAMETR_DMG2 = 890015

    set PARAMETR_NAME = "Frost Nova"
    set PARAMETR_TOOLTIP = "Blasts enemy units with a wave of frost that deals !DMG1! damage to the target, and !DMG2! nova damage. Cold damage slows units' movement and attack rate for a short period of time."
endfunction


function  AUfn_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Damage1 = -100 + (150 * lvl)
    set A.Damage2 = 25 + (75 * lvl)
      
    
    set A.Cost1 = 125 + 25*lvl
    set A.Area1 = 200
    
    set A.Range1 = 800
    
    set A.DurationNormal1 = 1 * lvl
    set A.DurationHero1 = 1 * lvl

    set A.Cooldown1 = 8
    
    set u = null
endfunction 