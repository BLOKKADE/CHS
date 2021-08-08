function Asta_initparam takes nothing returns nothing
    set PARAMETR_NAME = "Stasis Trap"
    set PARAMETR_TOOLTIP = "Summons an invisible and immovable ward that stuns enemy land units around it. The trap activates when an enemy land unit approaches and destroys all other stasis wards in its area of effect.|n|n|cffff5e44Stun duration|r: !PAR5!"
endfunction


function Asta_lvl takes nothing returns nothing
    local unit u = GLOBAL_HERO_U
    local real lvl = GLOBAL_HERO_LVL 
    local AbilityData A = GLOBAL_HERO_A
    
    set A.SummonId1 = 'otot'
    
    
    set A.Param1 = 4
    set A.Param1Field = 'Sta1'
    
    set A.Param2 = 200
    set A.Param2Field = 'Sta2'  
    
    set A.Param3 = 1
    set A.Param3Field = 'Sta5' 
    
    set A.Param4 = 325
    set A.Param4Field = 'Sta3' 
 
 
    set A.Param5 = 4
    set A.Param5Field = 'Sta4' 
    
    
    
    set A.Cost1 = (75 + lvl)*lvl
    
    set A.DurationHero1 = 2+0.08*lvl
    set A.DurationNormal1 = 2+0.08*lvl
    
    
    
    set A.Area1 = 550
    set A.Range1 = 400
    set A.Cooldown1 = 8 
    
  
    
    
    set u = null
endfunction 