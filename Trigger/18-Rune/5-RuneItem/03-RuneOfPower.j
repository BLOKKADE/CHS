library PowerRune requires CustomState
   function RuneOfPower takes nothing returns boolean
      local unit u = GLOB_RUNE_U
      local real power = GLOB_RUNE_POWER 
      call AddUnitMagicDmg(u,0.25*power)
      set u = null
      return false
   endfunction
endlibrary