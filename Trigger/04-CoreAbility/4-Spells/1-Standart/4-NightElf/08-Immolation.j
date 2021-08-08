function AEim_initparam takes nothing returns nothing
    set PARAMETR_DMG = 890020
    set PARAMETR_NAME = "Immolation"
    set PARAMETR_TOOLTIP = "Activate Immolation to engulf this unit in flames, causing !DMG1! damage per second to nearby enemy land units. |nDrains !PAR1! mana per second until deactivated."
endfunction


function  AEim_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Damage1 = (25 + (lvl * 3)) * lvl // lvl 1 = 28, lvl 30 = 3450
    
    set A.Param1 = (20 + lvl) * lvl // lvl 1 = 21, lvl 30 = 1500
    set A.Param1Field = 'Eim3'
    
    set A.Param2 = (20 + lvl) * lvl // lvl 1 = 21, lvl 30 = 1500
    set A.Param2Field = 'Eim2'
    
    set A.Area1 = 175
    
    set A.Cooldown1 = 3
    set A.Cost1 = 25 + (15 * lvl)
    set u = null
endfunction 