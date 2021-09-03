library UnitHelpers
    native UnitAlive takes unit id returns boolean

    function IsUnitInvis takes unit u returns boolean
        return GetUnitAbilityLevel(u, 'Bpsh') > 0 or GetUnitAbilityLevel(u, 'BOwk') > 0 or GetUnitAbilityLevel(u, 'A03V') > 0
    endfunction

    function IsUnitTargettable takes unit u returns boolean
        return GetUnitAbilityLevel(u, 'Aloc') == 0 and GetUnitAbilityLevel(u, 'Avul') == 0
    endfunction

    function IsUnitSpellTarget takes unit u returns boolean
        return IsUnitTargettable(u) and UnitAlive(u)
    endfunction
endlibrary