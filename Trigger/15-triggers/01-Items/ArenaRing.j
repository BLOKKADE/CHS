library ArenaRing

    function GetRingGloryBonus takes unit u returns real
        if GetUnitTypeId(u) == 'H00A' then
            return 200.
        endif
        
        return 100.
    endfunction
endlibrary