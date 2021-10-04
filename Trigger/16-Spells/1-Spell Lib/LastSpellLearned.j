library SpellsLearned initializer init
    globals
        HashTable SpellsLearned

        integer SpellList_Normal = 0
        integer SpellList_Absolute = 1
    endglobals

    function GetLastLearnedSpell takes integer hid, integer spellList, boolean remove returns integer
        local integer index = SpellsLearned[hid][spellList].integer[0]
        local integer spellId = SpellsLearned[hid][spellList].integer[index]

        loop
            if spellId == 0 then
                set SpellsLearned[hid][spellList].integer[index] = 0
                set index = index - 1
                set spellId = SpellsLearned[hid][spellList].integer[index]
            else
                exitwhen true
            endif
            exitwhen index <= 1
        endloop

        if remove then
            set SpellsLearned[hid][spellList].integer[index] = 0
            set SpellsLearned[hid][spellList].integer[0] = index - 1
        endif
        
        return spellId
    endfunction

    function AddSpellLearned takes integer hid, integer spellId, integer spellList returns nothing
        local integer index = 0
        if SpellsLearned[hid].integer[spellList] == 0 then
            set SpellsLearned[hid][spellList] = Table.create()
        endif
        set index = SpellsLearned[hid][spellList].integer[0] + 1
        set SpellsLearned[hid][spellList].integer[index] = spellId
        set SpellsLearned[hid][spellList].integer[0] = index
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        set SpellsLearned = HashTable.create()
    endfunction
endlibrary