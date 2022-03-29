library LifeRune requires RandomShit
    globals
        constant real RuneOfLife_base = 300
    endglobals


    function RuneOfLife takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local real power = GLOB_RUNE_POWER 
        call SetUnitMaxHp(u, BlzGetUnitMaxHP(u) + R2I(RuneOfLife_base * power) )  
        call SetUnitState(u, UNIT_STATE_MAX_MANA, GetUnitState(u, UNIT_STATE_MAX_MANA) + (RuneOfLife_base * power))
        set u = null
        return false
    endfunction
endlibrary