library FilteredSpellList initializer init requires ListT, Utility
    globals
        HashTable FilteredSpellLists
        HashTable UnitFilteredSpellListIndex
        HashTable SpellListFilters
    endglobals

    //check if the unit has any existing filterspelllists
    function UnitHasFilterSpellList takes integer hid returns boolean
        return UnitFilteredSpellListIndex[hid].integer[0] != 0
    endfunction

    //returns a spelllist associated with the handle id and abilId
    function GetFilterList takes integer hid, integer abilId returns IntegerList
        return FilteredSpellLists[hid].integer[abilId]
    endfunction

    //returns the filter associated with a spellist
    function GetSpellListFilter takes integer hid, integer abilId returns SpellListFilter
        call BJDebugMsg(I2S(SpellListFilters[hid].integer[abilId]))
        return SpellListFilters[hid].integer[abilId]
    endfunction

    //check if the spelllist contains any spells
    function FilterListNotEmpty takes unit u, integer abilId returns boolean
        return not GetFilterList(GetHandleId(u), abilId).empty()
    endfunction

    //clears a spelllist and removes references to it, breaks unithasfilterspellist
    function RemoveSpellList takes unit u, integer abilId returns nothing
        local integer hid = GetHandleId(u)
        call GetFilterList(hid, abilId).destroy()
        set FilteredSpellLists[hid].integer[abilId] = 0
        set SpellListFilters[hid].integer[abilId] = 0
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

    //uses the filter from the spellist to check whether an ability can be added to the list of unit u's abilid
    function AddToSpellList takes unit u, integer abilId, integer abilToAddId returns nothing
        local integer hid = GetHandleId(u)
        if GetSpellListFilter(hid, abilId).evaluate(u, abilToAddId) then
            call BJDebugMsg("add spell: " + GetObjectName(abilToAddId))
            call GetFilterList(hid, abilId).push(abilToAddId)
        endif
    endfunction

    //populate the spell list with the units current abilities
    function PopulateSpellList takes unit u, IntegerList spellList, SpellListFilter filter returns nothing
        local integer i = 0
        local integer abilId = 0

        loop
            set abilId = GetHeroSpellAtPosition(u, i)
            if abilId != 0 and filter.evaluate(u, abilId) then
                call BJDebugMsg("add spell: " + GetObjectName(abilId))
                call spellList.push(abilId)
            endif 
            set i = i + 1
            exitwhen i > 10
        endloop
    endfunction

    //stores an index of all units u's, lists created (through abilId) in UnitFilteredSpellListIndex
    function CreateSpellList takes unit u, integer abilId, SpellListFilter filter returns nothing
        local integer hid = GetHandleId(u)
        local IntegerList spellList = 0

        if GetFilterList(hid, abilId) == 0 then
            call BJDebugMsg("create")
            set spellList = spellList.create()
            set FilteredSpellLists[hid].integer[abilId] = spellList
            set UnitFilteredSpellListIndex[hid].integer[0] = UnitFilteredSpellListIndex[hid].integer[0] + 1
            set UnitFilteredSpellListIndex[hid].integer[UnitFilteredSpellListIndex[hid].integer[0]] = abilId
            set SpellListFilters[hid].integer[abilId] = filter
            call PopulateSpellList(u, spellList, filter)
        endif
    endfunction

    private function init takes nothing returns nothing
        set FilteredSpellLists = HashTable.create()
        set UnitFilteredSpellListIndex = HashTable.create()
        set SpellListFilters = HashTable.create()
    endfunction
endlibrary
