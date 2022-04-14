library MightRune requires Utility, TempStateBonus
    
    function MightRune takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local real power = GLOB_RUNE_POWER 
        
        call AddRuneBonus(GetHandleId(u), BONUS_STRENGTH, 50 * power)
        call AddRuneBonus(GetHandleId(u), BONUS_AGILITY, 50 * power) 
        call AddRuneBonus(GetHandleId(u), BONUS_INTELLIGENCE, 50 * power) 
        call TempBonus.create(u, BONUS_STRENGTH, 50 * power, StatRuneDuration, Runes[Might_Rune_Id])
        call TempBonus.create(u, BONUS_AGILITY, 50 * power, StatRuneDuration, Runes[Might_Rune_Id])
        call TempBonus.create(u, BONUS_INTELLIGENCE, 50 * power, StatRuneDuration, Runes[Might_Rune_Id])
        set u = null
        return false
    endfunction
endlibrary