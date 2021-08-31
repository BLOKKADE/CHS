library SpellsLearned initializer init
    globals
        HashTable SpellsLearned
        Table HeroSpellsIndex
    endglobals
    function GetLastLearnedSpell takes integer hid, boolean remove returns integer
        local integer spellId = SpellsLearned[hid].integer[HeroSpellsIndex[hid]]

        if remove then
            set SpellsLearned[hid].integer[HeroSpellsIndex[hid]] = 0
            set HeroSpellsIndex[hid] = HeroSpellsIndex[hid] - 1
        endif
        
        return spellId
    endfunction

    function AddSpellLearned takes integer hid, integer spellId returns nothing
        set HeroSpellsIndex.integer[hid] = HeroSpellsIndex.integer[hid] + 1
        set SpellsLearned[hid].integer[HeroSpellsIndex[hid]] = spellId
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        set SpellsLearned = HashTable.create()
        set HeroSpellsIndex = Table.create()
    endfunction
endlibrary