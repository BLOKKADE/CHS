library DriedMushroom requires AbilityData, DummyOrder, RuneInit

    private function GetAbilityRandomElement takes integer abilId returns integer
        return GetObjectElementAtIndex(abilId, GetRandomInt(1, GetObjectElementIndex(abilId)))
    endfunction

    function DriedMushroomEffects takes unit caster, integer abilId returns nothing
        if ObjectHasAnyElement(abilId) then
            call UnitAddItem(caster, CreateRune(null, 0, 0, 0, caster, GetAbilityRandomElement(abilId)))
        endif
    endfunction

    function CastDriedMushroom takes unit caster returns nothing
        local DummyOrder dummy = DummyOrder.create(caster, GetUnitX(caster), GetUnitY(caster), GetUnitFacing(caster), 3)
        call dummy.addActiveAbility(DRIED_MUSHROOM_DUMMY_ABILITY_ID, 1, 852662)
        call dummy.target(caster).activate()
    endfunction
endlibrary
