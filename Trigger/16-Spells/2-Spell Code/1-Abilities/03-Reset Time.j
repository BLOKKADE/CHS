library ResetTime requires RandomShit
    function ResetTime takes unit u returns nothing
        call UnitResetCooldown(u)
    endfunction
endlibrary
