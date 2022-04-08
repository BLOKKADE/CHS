library MightRune requires Utility, TempStateBonus
    
    function MightRune takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local real power = GLOB_RUNE_POWER 
        call UniqueTempBonus(u, BONUS_STRENGTH, 50 * power, StatRuneDuration, Runes[Might_Rune_Id], 0)
        call UniqueTempBonus(u, BONUS_AGILITY, 50 * power, StatRuneDuration, Runes[Might_Rune_Id], 0)
        call UniqueTempBonus(u, BONUS_INTELLIGENCE, 50 * power, StatRuneDuration, Runes[Might_Rune_Id], 0)
        set u = null
        return false
    endfunction
endlibrary