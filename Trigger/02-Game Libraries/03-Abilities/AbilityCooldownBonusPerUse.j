library AbilityCooldownBonusPerUse initializer init requires Table
    globals
        HashTable AbilityCdBonus
    endglobals

    function GetAbilityCooldownBonus takes ability abil returns real
        return AbilityCdBonus[RoundNumber].real[GetHandleId(abil)]
    endfunction

    function SetAbilityCooldownBonus takes ability abil, real bonus returns nothing
        set AbilityCdBonus[RoundNumber].real[GetHandleId(abil)] = AbilityCdBonus[RoundNumber].real[GetHandleId(abil)] + bonus
    endfunction

    private function init takes nothing returns nothing
        set AbilityCdBonus = Table.create()
    endfunction
endlibrary
