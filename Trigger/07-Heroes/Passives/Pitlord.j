library Pitlord requires DummyOrder, AbilityCooldown, RandomShit
    function PitlordLevelup takes unit u, integer level returns nothing
        if level > 75 and GetUnitAbilityLevel(u, 'A0EH') == 0 then
            call UnitAddAbility(u, 'A0EH')
        endif

        if level > 150 and GetUnitAbilityLevel(u, 'A0EI') == 0 then
            call UnitAddAbility(u, 'A0EI')
        endif

        if level > 225 and GetUnitAbilityLevel(u, 'A0EJ') == 0 then
            call UnitAddAbility(u, 'A0EJ')
        endif

        if level > 300 and GetUnitAbilityLevel(u, 'A0EK') == 0 then
            call UnitAddAbility(u, 'A0EK')
        endif
    endfunction

    private function Cast takes unit u, unit target, integer level returns nothing
        local DummyOrder dummy = DummyOrder.create(u, GetUnitX(u),GetUnitY(u), GetUnitFacing(u), 5)

        call dummy.addActiveAbility('A08N', 1, 852238)
        call dummy.setAbilityRealField('A08N', ABILITY_RLF_DAMAGE_HBZ2, level * 40)
        call dummy.setAbilityRealField('A08N', ABILITY_RLF_DAMAGE_PER_SECOND_HBZ5, level * 20)
        call dummy.point(GetUnitX(target), GetUnitY(target)).activate()
    endfunction

    private function CheckCooldownAbility takes unit u, integer abilId returns boolean
        if GetUnitAbilityLevel(u, abilId) > 0 and BlzGetUnitAbilityCooldownRemaining(u, abilId) <= 0 then
            call AbilStartCD(u, abilId, 2)
            return true
        endif
        return false
    endfunction

    function CastPitlordRainOfFire takes unit u, unit target returns nothing
        local integer level = GetHeroLevel(u)

        if CheckCooldownAbility(u, 'A08V') or CheckCooldownAbility(u, 'A0EH') or CheckCooldownAbility(u, 'A0EI') or CheckCooldownAbility(u, 'A0EJ') or CheckCooldownAbility(u, 'A0EK') then
            call Cast(u, target, level)
            call ElemFuncStart(u, PIT_LORD_UNIT_ID)
        endif
    endfunction
endlibrary
