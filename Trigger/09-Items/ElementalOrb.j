library ElementalOrb initializer init
    globals
        Table ElementalOrbLastAbil
    endglobals

    function GetElementalOrbAbil takes unit u returns integer
        return ElementalOrbLastAbil[GetHandleId(u)]
    endfunction

    function SetElementalOrbAbil takes unit u, integer abil returns nothing
        set ElementalOrbLastAbil[GetHandleId(u)] = abil
    endfunction

    private function init takes nothing returns nothing
        set ElementalOrbLastAbil = Table.create()
    endfunction
endlibrary

