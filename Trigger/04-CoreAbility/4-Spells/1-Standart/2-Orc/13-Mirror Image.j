function AOmi_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Mirror Image"
    set PARAMETR_TOOLTIP = "Confuses the enemy by creating !PAR1! illusions of the hero. Illusions deal !PAR2!% damage, but takes !PAR3!% more. Dispels all magic from the hero."
endfunction


function AOmi_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    

    set A.Param1 = 1 + R2I(lvl*0.2)
    set A.Param1Field = 'Omi1'
    set A.Param1FieldType = 1
    
    set A.Param2 = 0.45 + lvl*0.05
    set A.Param2Field = 'Omi2'
    set A.Param2Chance = true
    
    set A.Param3 = 3 -  2*lvl/(53+lvl) 
    set A.Param3Field = 'Omi3'
    set A.Param3Chance = true
    
    set A.Cost1 = (25 + lvl)*lvl
    set A.DurationHero1 = 10
    set A.DurationNormal1 = 10
    set A.Area1 = 400
    set A.Cooldown1 = 10 
    
  
    
    
    set u = null
endfunction 