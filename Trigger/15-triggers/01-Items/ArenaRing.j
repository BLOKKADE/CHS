library ArenaRing

    function GetRingGloryBonus takes unit u returns real
        if GetUnitTypeId(u) == ARENA_MASTER_UNIT_ID then
            return 200.
        endif
        
        return 100.
    endfunction
endlibrary