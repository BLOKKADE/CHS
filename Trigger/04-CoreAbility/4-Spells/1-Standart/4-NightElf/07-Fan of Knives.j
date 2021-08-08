function AEfk_initparam takes nothing returns nothing
    set PARAMETR_DMG = 890019

    set PARAMETR_NAME = "Fan of Knives"
    set PARAMETR_TOOLTIP = "The Hero hurls a flurry of knives, damaging nearby enemies. Each knife does !DMG1! damage."
endfunction


function  AEfk_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Damage1 = 75 * lvl
    
    set A.Param1 = 999999
    set A.Param1Field = 'Efk2'
    
    set A.Area1 = 385 + 15 * lvl
    
    set A.Cooldown1 = 9
    set A.Cost1 = 50 + 5*lvl
    set u = null
endfunction 