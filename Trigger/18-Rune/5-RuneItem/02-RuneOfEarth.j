library EarthRune requires RandomShit
   function RuneOfEarth takes nothing returns boolean
      local unit u = GLOB_RUNE_U
      local real power = GLOB_RUNE_POWER 
      call USOrder4field(u,GetUnitX(u),GetUnitY(u),'A074',"stomp",GetEventDamage(),ABILITY_RLF_DAMAGE_INCREASE,500 + 100 * power,ABILITY_RLF_CAST_RANGE ,1000 * power,ABILITY_RLF_DAMAGE_WRS1,2,ABILITY_RLF_DURATION_NORMAL)

      set u = null
      return false
   endfunction
endlibrary