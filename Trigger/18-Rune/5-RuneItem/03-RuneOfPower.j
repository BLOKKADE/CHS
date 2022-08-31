library PowerRune requires CustomState, TempStateBonus
   function RuneOfPower takes nothing returns boolean
      local unit u = GLOB_RUNE_U
      local real power = GLOB_RUNE_POWER 
      
      //call AddRuneBonus(GetHandleId(u), BONUS_MAGICPOW, 5 * power)
      //call AddRuneBonus(GetHandleId(u), BONUS_PHYSPOW, 5 * power) 
      call TempBonus.create(u, BONUS_MAGICPOW, 6 * power, 10 * power, Runes[Power_Rune_Id])
      call TempBonus.create(u, BONUS_PHYSPOW, 6 * power, 10 * power, Runes[Power_Rune_Id])
      set u = null
      return false
   endfunction
endlibrary