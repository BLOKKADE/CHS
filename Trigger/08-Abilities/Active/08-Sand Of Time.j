library SandOfTime requires RandomShit
    private function ResetSpell takes unit hero, integer abilId, real reduction, boolean isEarth returns nothing
        local real cd = BlzGetUnitAbilityCooldownRemaining(hero, abilId) - reduction

        if isEarth then
            set cd = cd - reduction
        endif 

        if cd > 0 then
            call BlzStartUnitAbilityCooldown(hero, abilId, cd)
            call BlzStartUnitAbilityCooldown(hero, GetDummySpell(hero, abilId), cd)
        else
            call BlzEndUnitAbilityCooldown(hero, abilId)
            call BlzEndUnitAbilityCooldown(hero, GetDummySpell(hero, abilId))
        endif
    endfunction

    function CastSandOfTime takes unit hero, real cooldownReduction returns nothing
        local integer i = 0
        local integer abilId = 0

        loop
            exitwhen i > 10
            set abilId = GetHeroSpellAtPosition(hero, i)
            if abilId != 0 and IsSpellResettable(abilId) and BlzGetUnitAbilityCooldownRemaining(hero, abilId) > 0 then
                call ResetSpell(hero, abilId, cooldownReduction, IsSpellElement(hero, abilId, Element_Earth))
            endif
            set i = i + 1
        endloop

        // Ogre Warrior
        if GetUnitAbilityLevel(hero, 'A08U') > 0 then
            call ResetSpell(hero, 'A08U', cooldownReduction, IsObjectElement(OGRE_WARRIOR_UNIT_ID, Element_Earth))
        endif

        // Pit Lord
        /*
        if GetUnitTypeId(hero) == PIT_LORD_UNIT_ID then
            call ResetSpell(hero, 'A08V', cooldownReduction, true)
        endif
        */

        // Revenant
        if GetUnitAbilityLevel(hero, COLD_KNIGHT_PASSIVE_ABILITY_ID) > 0 then
            call ResetSpell(hero, COLD_KNIGHT_PASSIVE_ABILITY_ID, cooldownReduction, IsObjectElement(COLD_KNIGHT_UNIT_ID, Element_Earth))
        endif

        // Centaur
        if GetUnitAbilityLevel(hero, 'A08T') > 0 then
            call ResetSpell(hero, 'A08T', cooldownReduction, IsObjectElement(CENTAUR_ARCHER_UNIT_ID, Element_Earth))
        endif

        // Lich
        if GetUnitAbilityLevel(hero, 'A08W') > 0 then
            call ResetSpell(hero, 'A08W', cooldownReduction, IsObjectElement(LICH_UNIT_ID, Element_Earth))
        endif
    endfunction
endlibrary