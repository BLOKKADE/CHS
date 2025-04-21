library AbilityCooldownBonusPerUse initializer init requires Table
    globals
        HashTable AbilityCdBonus
    endglobals

    function ResetAbilityCooldownBonus takes integer hid, integer abilId returns nothing
        set AbilityCdBonus[hid].real[abilId] = 0
    endfunction

    function GetAbilityCooldownBonus takes integer hid, integer abilId returns real
        return AbilityCdBonus[hid].real[abilId]
    endfunction

    function SetAbilityCooldownBonus takes integer hid, integer abilId, real bonus returns nothing
        set AbilityCdBonus[hid].real[abilId] = AbilityCdBonus[hid].real[abilId] + bonus
    endfunction

    private function init takes nothing returns nothing
        set AbilityCdBonus = HashTable.create()
    endfunction
endlibrary
