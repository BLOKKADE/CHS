library Parasite requires PeriodicDamage, CastSpellOnTarget
    function CastParasite takes unit caster, unit target, integer lvl returns nothing
        local DummyOrder dummy = DummyOrder.create(caster, GetUnitX(caster), GetUnitY(caster), GetUnitFacing(caster), 6)
        call dummy.addActiveAbility(PARASITE_2_ABILITY_ID, 1, 852601)
        call dummy.target(target)
        call dummy.activate()
        //call BJDebugMsg("parasite: " + GetUnitName(target) + " : " + I2S(GetHandleId(target)) + " lvl: " + I2S(lvl))
        call PeriodicDamage.create(caster, target, 30 * lvl, true, 1., 30, 0, true, PARASITE_BUFF_ID, PARASITE_ABILITY_ID).start()
    endfunction
endlibrary