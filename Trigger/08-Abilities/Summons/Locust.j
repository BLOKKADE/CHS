library Locust
    function LocustStats takes unit u, integer totalLevel returns nothing
        call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u, 0) + (totalLevel * 60), 0)
    endfunction
endlibrary