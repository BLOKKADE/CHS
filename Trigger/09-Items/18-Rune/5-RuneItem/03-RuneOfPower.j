library PowerRune requires CustomState, TempStateBonus
   function RuneOfPower takes nothing returns boolean
      local unit u = GLOB_RUNE_U
      local real power = GLOB_RUNE_POWER 
      
      call TempBonus.create(u, BONUS_MAGICPOW, 2 * power, 10 * power, Runes[Power_Rune_Id]).activate()
      call TempBonus.create(u, BONUS_PHYSPOW, 2 * power, 10 * power, Runes[Power_Rune_Id]).activate()
      set u = null
      return false
   endfunction
endlibrary