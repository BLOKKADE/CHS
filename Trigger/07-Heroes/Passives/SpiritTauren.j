library SpiritTauren initializer init requires IdLibrary, CustomState, AbilityData, HeroAbilityTable

    globals
        Table SpiritTaurenBonus
    endglobals

    function GetActiveAbilityCount takes unit u returns integer
        local integer i = 0
        local integer abilId = 0
        local integer count = 0
        loop
            set abilId = GetHeroSpellAtPosition(u, i)
            if abilId != 0 and IsAbilityCasteable(abilId, true) then
                set count = count + 1
            endif
            set i = i + 1
            exitwhen i > 10
        endloop

        return count
    endfunction

    function UpdateSpiritTaurenRuneBonus takes unit u returns nothing
        local integer count = GetActiveAbilityCount(u)
        local real bonus = count * (10 + (0.3 * GetHeroLevel(u)))
        local integer hid = GetHandleId(u)

        if bonus != SpiritTaurenBonus.real[hid] then
            call AddUnitCustomState(u, BONUS_RUNEPOW, bonus - SpiritTaurenBonus.real[hid])
            set SpiritTaurenBonus.real[hid] = bonus
        endif
    endfunction

    private function init takes nothing returns nothing
        set SpiritTaurenBonus = Table.create()
    endfunction

endlibrary