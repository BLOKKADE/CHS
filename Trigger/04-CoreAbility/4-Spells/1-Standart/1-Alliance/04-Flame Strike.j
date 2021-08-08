function AHfs_initparam takes nothing returns nothing
    set PARAMETR_DMG = 890002

    set PARAMETR_NAME = "Flame Strike"
    set PARAMETR_TOOLTIP = "Conjures a pillar of flame that burns ground units for !DMG1! damage every !PAR1! seconds."
endfunction


function AHfs_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.Damage1 = (19+lvl*2 )*lvl 

        
    set A.Param1 = 0.33
    set A.Param1Field = 'Hfs2'
 

    
    set A.Cost1 = 50 + 50*lvl
    set A.Range1 = 500+5*lvl
    set A.Area1 = 350
    
    set A.DurationHero1 = 8
    set A.DurationNormal1 = 8
    set A.Cooldown1 = 12
    
    set u = null
endfunction 