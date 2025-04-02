library DemonsCurse requires DummySpell, AbilityCooldown, RandomShit
    function CastDemonsCurse takes unit u, real chronusBonus, integer abilLevel, integer heroLevel returns nothing
        local DummyOrder dummy
        local real reduction = ((10 * abilLevel) * (1 + 0.02 * heroLevel))
        local real duration = (8 + (heroLevel * 0.09)) * chronusBonus

        call ElemFuncStart(u, DEMONS_CURSE_ABILITY_ID)
        call AbilStartCD(u, DEMONS_CURSE_ABILITY_ID, 120)

        //full damage
        set dummy = DummyOrder.create(u, GetUnitX(u), GetUnitY(u), GetUnitFacing(u), 6)
        call dummy.addActiveAbility(CURSE_OF_DEMONS_DUMMY_ABILITY_ID, 1, 852588)
        call dummy.setAbilityIntegerField(CURSE_OF_DEMONS_DUMMY_ABILITY_ID, ABILITY_ILF_DEFENSE_INCREASE_ROA2, R2I(reduction * 0.25))
        call dummy.setAbilityRealField(CURSE_OF_DEMONS_DUMMY_ABILITY_ID, ABILITY_RLF_DURATION_HERO, duration)
        call dummy.setAbilityRealField(CURSE_OF_DEMONS_DUMMY_ABILITY_ID, ABILITY_RLF_DURATION_NORMAL, duration)
        call dummy.setAbilityRealField(CURSE_OF_DEMONS_DUMMY_ABILITY_ID, ABILITY_RLF_AREA_OF_EFFECT, 2000)
        call dummy.instant()
        call dummy.activate()

        //half damage
        set dummy = DummyOrder.create(u, GetUnitX(u), GetUnitY(u), GetUnitFacing(u), 6)
        call dummy.addActiveAbility(CURSE_OF_DEMONS_DUMMY_ABILITY_ID, 1, 852588)
        call dummy.setAbilityIntegerField(CURSE_OF_DEMONS_DUMMY_ABILITY_ID, ABILITY_ILF_DEFENSE_INCREASE_ROA2, R2I(reduction * 0.5))
        call dummy.setAbilityRealField(CURSE_OF_DEMONS_DUMMY_ABILITY_ID, ABILITY_RLF_DURATION_HERO, duration)
        call dummy.setAbilityRealField(CURSE_OF_DEMONS_DUMMY_ABILITY_ID, ABILITY_RLF_DURATION_NORMAL, duration)
        call dummy.setAbilityRealField(CURSE_OF_DEMONS_DUMMY_ABILITY_ID, ABILITY_RLF_AREA_OF_EFFECT, 1000)
        call dummy.instant()
        call dummy.activate()

        //full damage
        set dummy = DummyOrder.create(u, GetUnitX(u), GetUnitY(u), GetUnitFacing(u), 6)
        call dummy.addActiveAbility(CURSE_OF_DEMONS_DUMMY_ABILITY_ID, 1, 852588)
        call dummy.setAbilityIntegerField(CURSE_OF_DEMONS_DUMMY_ABILITY_ID, ABILITY_ILF_DEFENSE_INCREASE_ROA2, R2I(reduction))
        call dummy.setAbilityRealField(CURSE_OF_DEMONS_DUMMY_ABILITY_ID, ABILITY_RLF_DURATION_HERO, duration)
        call dummy.setAbilityRealField(CURSE_OF_DEMONS_DUMMY_ABILITY_ID, ABILITY_RLF_DURATION_NORMAL, duration)
        call dummy.setAbilityRealField(CURSE_OF_DEMONS_DUMMY_ABILITY_ID, ABILITY_RLF_AREA_OF_EFFECT, 500)
        call dummy.instant()
        call dummy.activate()
    endfunction
endlibrary
