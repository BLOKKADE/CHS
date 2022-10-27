library Fan requires RandomShit
    function ActivateFan takes unit caster returns nothing
        local integer abilId = FAN_OF_KNIVES_ABILITY_ID
        local integer level = R2I(1 + (GetHeroLevel(caster) * 0.33))
        local DummyOrder dummy

        if GetUnitState(caster, UNIT_STATE_MANA) > level * 7 then
            set dummy = DummyOrder.create(caster, GetUnitX(caster), GetUnitY(caster), GetUnitFacing(caster), 5)
            call dummy.addActiveAbility(abilId, 1, 852526)
            call dummy.setAbilityRealField(abilId, ABILITY_RLF_DAMAGE_PER_TARGET_EFK1, 100 * level)
            call dummy.instant()

            if dummy.activate() then
                call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) - level * 7)
                call AbilStartCD(caster, 'A0DC', 0.3)
            endif
        endif
    endfunction
endlibrary