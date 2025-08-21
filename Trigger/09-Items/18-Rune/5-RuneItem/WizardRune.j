library WizardRune requires RandomShit
   function WizardRune takes nothing returns boolean
      local unit u = GLOB_RUNE_U
      
      call MysteriousTalentActivate(u)

      set u = null
      return false
   endfunction
endlibrary