function AUim_initparam takes nothing returns nothing
    set PARAMETR_DMG = 890016

    set PARAMETR_NAME = "Impale"
    set PARAMETR_TOOLTIP = "Slams the ground, shooting spiked tendrils out in a straight line, dealing !DMG1! damage and hurling enemy ground units into the air in their wake, stunning them for a few seconds."
endfunction


function  AUim_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Damage1 = (200 + (lvl * 3)) * lvl 
      
    set A.Area1 = 325
    set A.Range1 = 700
    set A.Cooldown1 = 9
    set A.DurationNormal1 = 5
    set A.DurationHero1 = 2 + (0.01 * lvl)
    set A.Cost1 = 100 + 10*lvl
    
    set u = null
endfunction 