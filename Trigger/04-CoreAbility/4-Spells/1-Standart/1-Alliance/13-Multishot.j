function Aroc_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Multi-shot"
    set PARAMETR_TOOLTIP = "|cffffcc00Unique Attack Modifier|r|nFires several arrows, hitting the current target and !PAR1! additional enemies."
endfunction


function Aroc_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Param1 = (2+lvl/3)
    set A.Param1Field = 'Efk3'
    set A.Param1FieldType = 1
    

    set A.Area1 = 240 + 10*lvl

    
  
    
    
    set u = null
endfunction 