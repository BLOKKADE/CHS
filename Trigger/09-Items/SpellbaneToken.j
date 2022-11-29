library SpellbaneToken initializer init
    globals
        Table SpellBaneToggle
    endglobals

    function IsSpellbaneCooldownEnabled takes unit u returns boolean
        local boolean bool = SpellBaneToggle.boolean[GetHandleId(u)]
        set SpellBaneToggle.boolean[GetHandleId(u)] = false
        return bool
    endfunction

    function SpellbaneSpellCast takes unit u, integer abilId, integer lvl returns nothing
        call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MANA) - GetUnitState(u, UNIT_STATE_MAX_MANA) * 0.05)
        set SpellBaneToggle.boolean[GetHandleId(u)] = true
    endfunction

    private function init takes nothing returns nothing
        set SpellBaneToggle = Table.create()
    endfunction
endlibrary