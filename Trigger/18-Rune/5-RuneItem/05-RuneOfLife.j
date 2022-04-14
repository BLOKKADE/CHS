library LifeRune requires RandomShit, TempStateBonus
    globals
        constant real RuneOfLife_base = 3000
    endglobals


    function RuneOfLife takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local real power = GLOB_RUNE_POWER 

        call AddRuneBonus(GetHandleId(u), BONUS_HEALTH, RuneOfLife_base * power)
        call AddRuneBonus(GetHandleId(u), BONUS_MANA, RuneOfLife_base * power) 
        call TempBonus.create(u, BONUS_HEALTH, RuneOfLife_base * power, StatRuneDuration, Runes[Life_Rune_Id])
        call TempBonus.create(u, BONUS_MANA, RuneOfLife_base * power, StatRuneDuration, Runes[Life_Rune_Id])
        set u = null
        return false
    endfunction
endlibrary