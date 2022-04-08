library AttackRune requires CustomState, TempStateBonus
    function DefenseRune takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local real power = GLOB_RUNE_POWER 
        call UniqueTempBonus(u, BONUS_ARMOR, 50 * power, 20, Runes[Defense_Rune_Id], 0)
        call UniqueTempBonus(u, BONUS_MAGICRES, 5 * power, 20, Runes[Defense_Rune_Id], 0)
        set u = null
        return false
    endfunction
endlibrary