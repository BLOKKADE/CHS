library VolcanicArmor
    function ActivateVolcanicArmor takes unit damageSource, unit damageTarget returns nothing
        local DummyOrder dummy = DummyOrder.create(damageTarget, GetUnitX(damageTarget), GetUnitY(damageTarget), GetUnitFacing(damageTarget), 1)
        //call BJDebugMsg("source:" + GetUnitName(damageSource) + " target: " + GetUnitName(damageTarget))
        call dummy.addActiveAbility('A015', 1, 852231)
        call dummy.target(damageSource)
        call dummy.activate()
    endfunction
endlibrary