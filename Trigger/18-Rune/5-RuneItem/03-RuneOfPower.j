library PowerRune requires CustomState, TempStateBonus
   function RuneOfPower takes nothing returns boolean
      local unit u = GLOB_RUNE_U
      local real power = GLOB_RUNE_POWER 
      call UniqueTempBonus(u, BONUS_MAGICPOW, 5 * power, StatRuneDuration, Runes[Power_Rune_Id], 0)
      call UniqueTempBonus(u, BONUS_PHYSPOW, 5 * power, StatRuneDuration, Runes[Power_Rune_Id], 0)
      set u = null
      return false
   endfunction
endlibrary