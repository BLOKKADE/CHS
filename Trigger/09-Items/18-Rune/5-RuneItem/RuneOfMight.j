library MightRune requires Utility, TempStateBonus
    
    function MightRune takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local real power = GLOB_RUNE_POWER 
        
        call TempBonus.create(u, BONUS_STRENGTH, 50 * power, 10 * power, Runes[Might_Rune_Id]).activate()
        call TempBonus.create(u, BONUS_AGILITY, 50 * power, 10 * power, Runes[Might_Rune_Id]).activate()
        call TempBonus.create(u, BONUS_INTELLIGENCE, 50 * power, 10 * power, Runes[Might_Rune_Id]).activate()
        set u = null
        return false
    endfunction
endlibrary