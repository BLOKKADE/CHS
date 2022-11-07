library SpellsLearned requires RandomShit, Functions
    globals
        integer SpellList_Normal = 0
        integer SpellList_Absolute = 1
    endglobals

    function GetLastLearnedSpell takes unit u, integer spellList, boolean remove returns integer
        local integer i = GetHeroSpellListCount(u, spellList)
        local integer spellId = GetHeroSpellAtPosition(u, (spellList * 10) + i)

        loop
            if spellId != 0 then
                return spellId
            endif
            
            set i = i - 1
            set spellId = GetHeroSpellAtPosition(u, (spellList * 10) + i)
            exitwhen i <= 10 * spellList
        endloop

        return spellId
    endfunction
endlibrary