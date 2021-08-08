function AEbl_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Blink"
    set PARAMETR_TOOLTIP = "Teleports a short distance, allowing the Hero to move in and out of combat."
endfunction


function AEbl_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Param1 = 1200
    set A.Param1Field = 'AEbl'
      
    set A.Cooldown1 = RMaxBJ(10 - (0.334 * lvl) , 0)
    set A.Cost1 = 70 - (5 * lvl)
    
    set u = null
endfunction 