globals
    constant real RuneOfAttack_base = 15
endglobals


function RuneOfAttack takes nothing returns boolean
   local unit u = GLOB_RUNE_U
   local real power = GLOB_RUNE_POWER 
   call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u,0) + R2I(RuneOfAttack_base*power) ,0)  
   return false
endfunction