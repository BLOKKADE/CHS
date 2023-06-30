library Urn requires StartFunction, ChronusSpellCast
    function Urn takes unit u returns nothing
        call FireRoundStartEvent(GetTriggerUnit(), 6) // 6 = urn
        call CastChronusSpells(u, GetHandleId(u), true)
    endfunction
endlibrary

