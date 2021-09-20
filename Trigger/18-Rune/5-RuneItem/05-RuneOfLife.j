library LifeRune
    globals
        constant real RuneOfLife_base = 150
    endglobals


    function RuneOfLife takes nothing returns boolean
    local unit u = GLOB_RUNE_U
    local real power = GLOB_RUNE_POWER 
    call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + R2I(RuneOfLife_base*power) )  
    return false
    endfunction
endlibrary