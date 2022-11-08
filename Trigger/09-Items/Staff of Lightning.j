library StaffOfLightning
    function CastStaffOfLightning takes unit caster, unit target returns nothing
        local integer abilId = 'A03B'
        local DummyOrder dummy = DummyOrder.create(caster, GetUnitX(caster), GetUnitY(caster), GetUnitFacing(caster), 5)
        call dummy.addActiveAbility(abilId, 1, 852119)
        call dummy.setAbilityRealField(abilId, ABILITY_RLF_DAMAGE_PER_TARGET_OCL1, GetHeroInt(caster,true)* 5)
        call dummy.target(target)
        call dummy.activate()
    endfunction
endlibrary