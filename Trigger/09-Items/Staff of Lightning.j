library StaffOfLightning requires AbilityCooldown
    function CastStaffOfLightning takes unit caster, unit target returns nothing
        local integer abilId = 'A03B'
        local integer i = 0
        local DummyOrder dummy

        call AbilStartCD(caster, 'A09T', 10)

        loop
            set dummy = DummyOrder.create(caster, GetUnitX(caster), GetUnitY(caster), GetUnitFacing(caster), 5)
            call dummy.addActiveAbility(abilId, 1, 852119)
            call dummy.setAbilityRealField(abilId, ABILITY_RLF_DAMAGE_PER_TARGET_OCL1, GetHeroInt(caster,true) + GetHeroStr(caster, true) + GetHeroAgi(caster, true))
            call dummy.target(target)
            call dummy.activate()

            set i = i + 1
            exitwhen i > 4
        endloop
    endfunction
endlibrary