function AHbz_initparam takes nothing returns nothing
    set PARAMETR_DMG = 890006 // unique for each spell
    set PARAMETR_NAME = "Blizzard"
    set PARAMETR_TOOLTIP = "Calls down freezing ice shard waves; each wave deals !DMG1! damage to enemy units in an area."
endfunction


function AHbz_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    

    set A.Damage1 = (29+lvl)*lvl
    

        
    set A.Param1 =  R2I(4 + 0.2*lvl)
    set A.Param1Field = 'Hbz3'
    set A.Param1FieldType = 1  // 0 - real  1 - int
    
    set A.Param3 =  R2I(6 + 0.3*lvl)
    set A.Param3Field = 'Hbz1' 
    set A.Param3FieldType = 1  // 0 - real  1 - int
    
    set A.Param4 = 999999999
    set A.Param4Field = 'Hbz6' 
    set A.Param4FieldType = 0
    
    set A.Cost1 = 75*lvl
    set A.Range1 = 600
    
    set A.Area1 = 250 + 20*lvl

    set A.Cooldown1 = 12
    set A.CastingTime1 = 1.5

    
    
    set u = null
endfunction 