library StableSpells initializer init
    globals
        Table StableSpells
    endglobals

    function IsSpellResettable takes integer abilId returns boolean
        return StableSpells.boolean[abilId] == false
    endfunction

    private function init takes nothing returns nothing
        set StableSpells = Table.create()

        set StableSpells.boolean['AHds'] = true
        set StableSpells.boolean['A07S'] = true
        set StableSpells.boolean['A05R'] = true
        set StableSpells.boolean['A0AB'] = true
        set StableSpells.boolean['A0AM'] = true
        set StableSpells.boolean['A08P'] = true
        set StableSpells.boolean['A08P'] = true
        set StableSpells.boolean['A024'] = true
        set StableSpells.boolean['A05U'] = true
        set StableSpells.boolean['A044'] = true
        set StableSpells.boolean['A0AH'] = true
        set StableSpells.boolean['A08P'] = true
        set StableSpells.boolean['A083'] = true
        set StableSpells.boolean['A0AS'] = true
        set StableSpells.boolean['A06Q'] = true
        set StableSpells.boolean['A06O'] = true
    endfunction
endlibrary