library EconomicSpelIndex initializer init
    globals
        Table EconomicSpellIndex
    endglobals

    function GetEconomicSpellIndex takes integer index, integer abilId returns nothing
        if EconomicSpellIndex.boolean[abilId] then
            set EconomicSpellIndex.integer[0] = EconomicSpellIndex.integer[0] + 1
            set EconomicSpellIndex.integer[EconomicSpellIndex.integer[0]] = index
        endif
    endfunction

    private function init takes nothing returns nothing
        set EconomicSpellIndex = Table.create()
        set EconomicSpellIndex.boolean['Asal'] = true
        set EconomicSpellIndex.boolean['A02W'] = true
        set EconomicSpellIndex.boolean['A0A2'] = true
        set EconomicSpellIndex.boolean['A04K'] = true
    endfunction
endlibrary