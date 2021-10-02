library PoisonRune initializer init requires RandomShit

    globals
        Table PoisonRuneBonus
    endglobals

    function PoisonRune takes nothing returns boolean
        local integer pid = GetPlayerId(GetOwningPlayer(GLOB_RUNE_U))
        local real power = GLOB_RUNE_POWER * 100
        local integer levels = R2I(power / 20) + 1

        set PoisonRuneBonus[pid] = PoisonRuneBonus[pid] + levels
        return false
    endfunction

    private function init takes nothing returns nothing
        set PoisonRuneBonus = Table.create()
    endfunction
endlibrary