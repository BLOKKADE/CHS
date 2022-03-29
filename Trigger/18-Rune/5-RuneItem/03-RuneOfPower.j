library PowerRune requires CustomState
   function RuneOfPower takes nothing returns boolean
      local unit u = GLOB_RUNE_U
      local real power = GLOB_RUNE_POWER 
      call AddUnitMagicDmg(u,0.5 * power)
      call AddUnitPhysPow(u, 0.5 * power)
      set u = null
      return false
   endfunction
endlibrary