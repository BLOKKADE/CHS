library FilteredSpellList initializer init requires ListT, Utility
    globals
        HashTable FilteredSpellLists
        HashTable UnitFilteredSpellListIndex
    endglobals

    function UnitHasFilterSpellList takes integer hid returns boolean
        return UnitFilteredSpellListIndex[hid].integer[0] != 0
    endfunction

    function GetFilterList takes integer hid, integer abilId returns IntegerList
        return FilteredSpellLists[hid].integer[abilId]
    endfunction

    function FilterListNotEmpty takes unit u, integer abilId returns boolean
        return not GetFilterList(GetHandleId(u), abilId).empty()
    endfunction

    //remove spell from a list
    function RemoveSpellFromFilterList takes unit u, integer abilId, integer abilToRemoveId returns nothing
        local IntegerList spellList = GetFilterList(GetHandleId(u), abilId)
        if spellList != 0 then
            call spellList.removeElem(abilToRemoveId)
        endif
    endfunction

    //removes a spell from all of the hero's lists when it is for example unlearned
    function RemoveSpellFromAllUnitLists takes unit u, integer abilToRemoveId returns nothing
        local integer i = 1
        local integer hid = GetHandleId(u)
        local integer max = UnitFilteredSpellListIndex[hid].integer[0]

        loop
            call RemoveSpellFromFilterList(u, UnitFilteredSpellListIndex[hid].integer[i], abilToRemoveId)
            set i = i + 1
            exitwhen i >= max
        endloop
    endfunction

    //interface used to determine whether an ability can be added to a list
    function interface SpellListFilter takes unit u, integer abilToAddId returns boolean

    //uses the filter supplied to check whether an ability can be added to the list of unit u's abilid
    //stores an index of all units u's, lists created (through abilId) in UnitFilteredSpellListIndex
    function SetSpellList takes unit u, integer abilId, integer abilToAddId, SpellListFilter filter returns nothing
        local integer hid = GetHandleId(u)
        local IntegerList spellList = 0
        if filter.evaluate(u, abilToAddId) then
            if GetFilterList(hid, abilId) == 0 then
                set spellList = spellList.create()
                set FilteredSpellLists[hid].integer[abilId] = spellList
                set UnitFilteredSpellListIndex[hid].integer[0] = UnitFilteredSpellListIndex[hid].integer[0] + 1
                set UnitFilteredSpellListIndex[hid].integer[UnitFilteredSpellListIndex[hid].integer[0]] = abilId
            endif
            call GetFilterList(hid, abilId).push(abilToAddId)
        endif
    endfunction

    private function init takes nothing returns nothing
        set FilteredSpellLists = HashTable.create()
        set UnitFilteredSpellListIndex = HashTable.create()
    endfunction
endlibrary
