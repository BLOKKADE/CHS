library Abomination
    function FixAbominationPassive takes unit u returns nothing
        local integer pid = GetPlayerId(GetOwningPlayer(u))
        if GetUnitAbilityLevel(u, 'A08L') > 0 then
            call SetPlayerAbilityAvailable(Player(pid), 'A08L', false)
            call SetPlayerAbilityAvailable(Player(pid), 'A08L', true)
        endif
    endfunction
endlibrary