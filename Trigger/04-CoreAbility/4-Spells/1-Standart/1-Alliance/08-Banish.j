function AHbn_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Banish"
    set PARAMETR_TOOLTIP = "Turns a non-mechanical unit ethereal and slows its movement speed by 50% for a few seconds. Ethereal creatures cannot attack, but they can cast spells and certain spells cast upon them will have a greater effect."
endfunction


function AHbn_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Cost1 = 100 - lvl
    set A.Range1 = 300 + 25*lvl
    set A.DurationHero1 = 3 + 0.2*(lvl-1) 
    set A.DurationNormal1 = 3 + 0.5*(lvl-1)
    set A.Cooldown1 = 15
    
    set u = null
endfunction 