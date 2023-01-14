library DriedMushroom requires AbilityData, DummyOrder, RuneInit

    private function GetAbilityRandomElement takes integer abilId returns integer
        return GetObjectElementAtIndex(abilId, GetRandomInt(1, GetObjectElementIndex(abilId)))
    endfunction

    function DriedMushroomEffects takes unit caster, integer abilId returns nothing
        if ObjectHasAnyElement(abilId) then
            call UnitAddItem(caster, CreateRune(null, 0, 0, 0, caster, GetAbilityRandomElement(abilId)))
        endif
    endfunction
endlibrary
