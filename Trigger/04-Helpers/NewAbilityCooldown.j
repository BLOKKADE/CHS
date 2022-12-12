library NewAbilityCooldown initializer init requires Table
    globals
        HashTable AbilNewCooldown
    endglobals

    function GetUnitAbilityNewCooldown takes unit u, integer abilId returns real
        return AbilNewCooldown[GetHandleId(u)].real[abilId]
    endfunction

    function SetUnitAbilityNewCooldown takes unit u, integer abilId, real value returns nothing
        set AbilNewCooldown[GetHandleId(u)].real[abilId] = value
    endfunction

    private function init takes nothing returns nothing
        set AbilNewCooldown = HashTable.create()
    endfunction
endlibrary
