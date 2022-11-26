library UnitFilteringUtility

    function IsAlivePlayerHero takes unit u returns boolean
        return (IsUnitType(u, UNIT_TYPE_HERO) == true) and (UnitAlive(u) == true) and (GetOwningPlayer(u) != Player(8)) and (GetOwningPlayer(u) != Player(11)) 
    endfunction

    function IsPlayerHero takes unit u returns boolean
        return (IsUnitType(u, UNIT_TYPE_HERO) == true) and (GetOwningPlayer(u) != Player(8)) and (GetOwningPlayer(u) != Player(11)) 
    endfunction

endlibrary