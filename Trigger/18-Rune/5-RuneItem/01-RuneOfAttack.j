library AttackRune requires CustomState
    globals
        constant real DefenseRune_base = 30
    endglobals


    function DefenseRune takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local real power = GLOB_RUNE_POWER 
        call BlzSetUnitArmor(u, BlzGetUnitArmor(u) + (5 * power))
        call AddUnitMagicDef(u, 0.5 * power)
        set u = null
        return false
    endfunction
endlibrary