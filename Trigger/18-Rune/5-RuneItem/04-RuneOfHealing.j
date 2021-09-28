library HealingRune
   function RuneOfHealing takes nothing returns boolean
      local unit u = GLOB_RUNE_U
      local real power = GLOB_RUNE_POWER 
      
      call SetWidgetLife(u,GetWidgetLife(u) +  BlzGetUnitMaxHP(u)*0.20*power  )
      set u = null
      return false
   endfunction
endlibrary