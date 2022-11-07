library HeroAbilityTable initializer init requires Table

    globals 
        HashTable HeroAbilityTable
    endglobals

    function GetInfoHeroSpell takes unit u, integer num returns integer
        return HeroAbilityTable[GetHandleId(u)].integer[num]
    endfunction

    function GetNumHeroSpell takes unit u,integer id returns integer
        return HeroAbilityTable[GetHandleId(u)].integer[id]
    endfunction

    function LoadCountHeroSpell takes unit u,integer list returns integer 
        return HeroAbilityTable[GetHandleId(u)].integer[0 - list]
    endfunction

    function SetInfoHeroSpell takes unit u, integer num, integer id returns nothing
        set HeroAbilityTable[GetHandleId(u)].integer[num] = id
        set HeroAbilityTable[GetHandleId(u)].integer[id] = num
    endfunction

    function SaveCountHeroSpell takes unit u,integer count,integer list returns nothing 
        set HeroAbilityTable[GetHandleId(u)].integer[0 - list] = count
    endfunction

    function RemoveInfoHeroSpell takes unit u, integer id returns nothing
        set HeroAbilityTable[GetHandleId(u)].integer[HeroAbilityTable[GetHandleId(u)].integer[id]] = 0
        set HeroAbilityTable[GetHandleId(u)].integer[id] = 0
    endfunction

    private function init takes nothing returns nothing
        set HeroAbilityTable = HashTable.create()
    endfunction
endlibrary
