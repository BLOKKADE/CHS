library PlayerSummonGroups initializer init requires Table
    globals
        HashTable PlayerSummonGroups
    endglobals

    function RemoveSummonFromPlayerSummonGroup takes unit hero, unit u returns nothing
        call GroupRemoveUnit(PlayerSummonGroups[GetHandleId(hero)].group[GetUnitTypeId(u)], u)
    endfunction

    // returnGroup needs to be created before calling this
    // returnGroup is used to prevent leaks
    function GetPlayerSummonGroup takes unit summoner, integer unitTypeId, group returnGroup returns group
        local group g = PlayerSummonGroups[GetHandleId(summoner)].group[unitTypeId]

        if g != null then
            call GroupRefresh(g)
            call BlzGroupAddGroupFast(g, returnGroup)
        endif

        set g = null
        return returnGroup
    endfunction

    function RegisterPlayerSummon takes unit summoner, unit summon returns nothing
        local group g = PlayerSummonGroups[GetHandleId(summoner)].group[GetUnitTypeId(summon)]

        if g != null then
            call GroupRefresh(g)
            call GroupAddUnit(g, summon)
        else
            set g = NewGroup()
            call GroupAddUnit(g, summon)
            set PlayerSummonGroups[GetHandleId(summoner)].group[GetUnitTypeId(summon)] = g
        endif
    endfunction

    private function init takes nothing returns nothing
        set PlayerSummonGroups = HashTable.create()
    endfunction
endlibrary
