library SpiritTauren requires Stats, IdLibrary

    globals
        integer RuneBonus = 30
    endglobals

    function SpiritTaurenRuneBonusReset takes unit u, integer abilId returns nothing
        if TAUREN_ABILITIES.contains(abilId) then
            call AddUnitPowerRune(u,0 - RuneBonus)
        endif
    endfunction

    function SpiritTaurenRuneBonus takes unit u, integer abilId returns nothing
        if TAUREN_ABILITIES.contains(abilId) then
            call AddUnitPowerRune(u, RuneBonus)
        endif
    endfunction

endlibrary