library LifeRune requires RandomShit, TempStateBonus
    globals
        constant real RuneOfLife_base = 3500
    endglobals


    function RuneOfLife takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local real power = GLOB_RUNE_POWER 

        call TempBonus.create(u, BONUS_HEALTH, RuneOfLife_base * power, 10 * power, Runes[Life_Rune_Id]).activate()
        call TempBonus.create(u, BONUS_MANA, RuneOfLife_base * power, 10 * power, Runes[Life_Rune_Id]).activate()
        set u = null
        return false
    endfunction
endlibrary