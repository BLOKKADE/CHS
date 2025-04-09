library ArenaMasterBonus

    function ArenaMasterMultiplier takes unit u returns integer
        if GetUnitTypeId(u) == ARENA_MASTER_UNIT_ID then
            return 2
        endif
        
        return 1
    endfunction
endlibrary