library ContemporaryRunes requires RuneInit, AbsoluteElements, HeroAbilityTable

    function ContempRunesSpellListFilter takes unit u, integer abilId returns boolean
        return ObjectHasAnyElement(abilId)
    endfunction

    private function GetElementFromRandomAbility takes unit caster, IntegerList filteredSpellList returns integer
        local integer i = 0
        local integer random = GetRandomInt(0, filteredSpellList.size() - 1)
        local IntegerListItem node = filteredSpellList.first
        local integer abilId = 0

        loop
            set abilId = node.data
            exitwhen i == random
            set node = node.next
            set i = i + 1
        endloop

        return GetObjectElementAtIndex(abilId, GetRandomInt(1, GetObjectElementIndex(abilId)))
    endfunction

    private function GetElementFromSpellList takes unit caster returns integer
        if FilterListNotEmpty(caster, CONTEMPORARY_RUNES_ABILITY_ID) then
            return GetElementFromRandomAbility(caster, GetFilterList(GetHandleId(caster), CONTEMPORARY_RUNES_ABILITY_ID))
        else
            return GetRandomInt(1, Element_Maximum)
        endif
    endfunction

    function CastContemporaryRunes takes unit caster, integer level returns nothing
        local real max = 1 + R2I(level / 10)
        local integer i = 0
        local integer element = 0
        local real cooldown = 0

        loop
            set element = GetElementFromSpellList(caster)
            if GetRuneCooldown(element) > cooldown then
                set cooldown = GetRuneCooldown(element)
            endif
            call UnitAddItem(caster, CreateRune(null, 5 * level, 0, 0, caster, element))
            set i = i + 1
            exitwhen i >= max
        endloop

        set AbilNewCooldown[GetHandleId(caster)].real[CONTEMPORARY_RUNES_ABILITY_ID] = cooldown
    endfunction
endlibrary