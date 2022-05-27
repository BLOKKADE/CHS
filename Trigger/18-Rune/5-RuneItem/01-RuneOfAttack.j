library AttackRune requires CustomState, TempStateBonus
    function DefenseRune takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local real power = GLOB_RUNE_POWER 

        //call AddRuneBonus(GetHandleId(u), BONUS_ARMOR, 50 * power)
        //call AddRuneBonus(GetHandleId(u), BONUS_MAGICRES, 5 * power) 
        call TempBonus.create(u, BONUS_ARMOR, 50 * power, StatRuneDuration, Runes[Defense_Rune_Id])
        call TempBonus.create(u, BONUS_MAGICRES, 5 * power, StatRuneDuration, Runes[Defense_Rune_Id])
        set u = null
        return false
    endfunction
endlibrary