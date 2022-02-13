library Moonstone requires BuffSystem, CustomState
    function ActivateMoonstone takes unit source returns nothing
        call SetUnitState(source, UNIT_STATE_MANA, GetUnitState(source, UNIT_STATE_MANA) + (GetUnitState(source, UNIT_STATE_MAX_MANA) * 0.04))
    endfunction
endlibrary