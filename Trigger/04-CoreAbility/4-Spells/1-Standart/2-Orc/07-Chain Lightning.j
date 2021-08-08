function AOcl_initparam takes nothing returns nothing
    set PARAMETR_DMG = -890010 

    set PARAMETR_NAME = "Chain Lightning"
    set PARAMETR_TOOLTIP = "Calls forth a bolt of lightning that bounces up to !PAR1! times, dealing !DMG1! damage to each target."
endfunction


function  AOcl_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Damage1 = (80+lvl*15 )*lvl 

    set A.Param1 = 8 
    set A.Param1Field = 'Ocl2'
    

      
    
    set A.Cost1 = 55 + 65*lvl
    set A.Area1 = 500
    
    set A.Range1 = 900

    set A.Cooldown1 = 6
    
    set u = null
endfunction 