library HeroAbilityTable initializer init requires Table

    globals 
        HashTable HeroAbilityTable
    endglobals

    //gets the spell at position pos, 1-10 = regular spells, 11-20 = absolute
    function GetHeroSpellAtPosition takes unit u, integer pos returns integer
        return HeroAbilityTable[GetHandleId(u)].integer[pos]
    endfunction

    //gets the position of a spell, 1-10 = regular spells, 11-20 = absolute
    function GetHeroPositionOfSpell takes unit u,integer id returns integer
        return HeroAbilityTable[GetHandleId(u)].integer[id]
    endfunction

    //returns amount of spells in hero's spell list. list 0 = regular spells, list 1 = absolute spell
    function GetHeroSpellListCount takes unit u,integer list returns integer 
        return HeroAbilityTable[GetHandleId(u)].integer[0 - list]
    endfunction

    //saves number of spells in hero's spell list. list 0 = regular spells, list 1 = absolute spell
    function SetHeroSpellListCount takes unit u,integer count,integer list returns nothing 
        set HeroAbilityTable[GetHandleId(u)].integer[0 - list] = count
    endfunction

    //set the position and spell id of id to 0 for u
    function ResetHeroSpellPosition takes unit u, integer id returns nothing
        set HeroAbilityTable[GetHandleId(u)].integer[HeroAbilityTable[GetHandleId(u)].integer[id]] = 0
        set HeroAbilityTable[GetHandleId(u)].integer[id] = 0
    endfunction

    //sets the # position (pos) of the spell and the spell id to the ability table, regular spells start at pos 0, absolutes at pos 10
    function SetHeroSpellPosition takes unit u, integer pos, integer id returns nothing
        set HeroAbilityTable[GetHandleId(u)].integer[pos] = id
        set HeroAbilityTable[GetHandleId(u)].integer[id] = pos
    endfunction

    //Update unit u's spell list with ability id, list = 0 = regular spells, list = 1 = absolutes
    function UpdateHeroSpellList takes integer id, unit u, integer list returns nothing
        local integer i1 = 1 + 10 * list
        local integer HeroSpellCount = GetHeroSpellListCount(u, list)
        local integer newPosition = 1
        local integer abilityId 
        local boolean HeroHasSpell = false

        //loop through existing spells
        loop
            set abilityId = GetHeroSpellAtPosition(u, i1)
            //if no spell at position then store position in newPosition
            if  (abilityId == 0) and (newPosition == 0) then
                set newPosition = i1
            endif

            //check if spell not already in list
            if id == abilityId then
                set HeroHasSpell = true
            endif

            set i1 = i1 + 1
            //exit if hero has spell or finished looping through list
            exitwhen HeroHasSpell or (i1 > 10 + 10 * list) 
        endloop

        if not HeroHasSpell then
            set HeroSpellCount = HeroSpellCount + 1
            call SetHeroSpellListCount(u, HeroSpellCount, list)
            call SetHeroSpellPosition(u, HeroSpellCount + list * 10, id)
        endif 
    endfunction

    private function init takes nothing returns nothing
        set HeroAbilityTable = HashTable.create()
    endfunction
endlibrary
