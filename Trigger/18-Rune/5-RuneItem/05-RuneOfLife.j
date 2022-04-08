library LifeRune requires RandomShit, TempStateBonus
    globals
        constant real RuneOfLife_base = 3000
    endglobals


    function RuneOfLife takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local real power = GLOB_RUNE_POWER 
        call UniqueTempBonus(u, BONUS_HEALTH, RuneOfLife_base * power, StatRuneDuration, Runes[Life_Rune_Id], 0)
        call UniqueTempBonus(u, BONUS_MANA, RuneOfLife_base * power, StatRuneDuration, Runes[Life_Rune_Id], 0)
        set u = null
        return false
    endfunction
endlibrary