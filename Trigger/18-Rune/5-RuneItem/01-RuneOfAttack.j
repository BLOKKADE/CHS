library AttackRune
    globals
        constant real RuneOfAttack_base = 30
    endglobals


    function RuneOfAttack takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local real power = GLOB_RUNE_POWER 
        call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u,0) + R2I(RuneOfAttack_base * power) ,0)  
        set u = null
        return false
    endfunction
endlibrary