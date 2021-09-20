library SpellbaneToken
    function IsSpellbaneCooldownEnabled takes unit u returns boolean
        local boolean bool = SpellData[9].boolean[GetHandleId(u)]
        set SpellData[9].boolean[GetHandleId(u)] = false
        return bool
    endfunction

    function SpellbaneSpellCast takes unit u, integer abilId, integer lvl returns nothing
        call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MANA) - GetUnitState(u, UNIT_STATE_MAX_MANA) * 0.05)
        set SpellData[9].boolean[GetHandleId(u)] = true
    endfunction
endlibrary