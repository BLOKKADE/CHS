library DummySpellCasts requires DummyOrder
    
    function DummyInstantCast4 takes unit u1, real x, real y,integer idsp, string ordstr, real Field1, abilityreallevelfield RealField1, real Field2, abilityreallevelfield RealField2,real Field3, abilityreallevelfield RealField3,real Field4, abilityreallevelfield RealField4 returns nothing
        local DummyOrder dummy = DummyOrder.create(u1, x, y, GetUnitFacing(u1), 2)
        call dummy.addActiveAbility(idsp, 1, OrderId(ordstr))
        if RealField1 != null then
            call dummy.setAbilityRealField(idsp, RealField1, Field1)
        endif
        if RealField2 != null then
            call dummy.setAbilityRealField(idsp, RealField2, Field2)
        endif
        if RealField3 != null then
            call dummy.setAbilityRealField(idsp, RealField3, Field3)
        endif
        if RealField4 != null then
            call dummy.setAbilityRealField(idsp, RealField4, Field4)
        endif
        call dummy.instant().activate()
    endfunction

    function DummyTargetCast1 takes unit u1, unit u2, real x, real y,integer idsp, string ordstr, real life_1, abilityreallevelfield REALF returns nothing
        local DummyOrder dummy = DummyOrder.create(u1, x, y, GetUnitFacing(u1), 6)
        call dummy.addActiveAbility(idsp, 1, OrderId(ordstr))
        if REALF != null then
            call dummy.setAbilityRealField(idsp, REALF, life_1)
        endif
        call dummy.target(u2).activate()
    endfunction

    function DummyTargetCast2 takes unit u1, unit u2, real x, real y,integer idsp, string ordstr, real Field1,real Field2, abilityreallevelfield RealField1,abilityreallevelfield RealField2 returns nothing
        local DummyOrder dummy = DummyOrder.create(u1, x, y, GetUnitFacing(u1), 2)
        call dummy.addActiveAbility(idsp, 1, OrderId(ordstr))
        if RealField1 != null then
            call dummy.setAbilityRealField(idsp, RealField1, Field1)
        endif
        if RealField2 != null then
            call dummy.setAbilityRealField(idsp, RealField2, Field2)
        endif
        call dummy.target(u2).activate()
    endfunction

    function DummyInstantCast1 takes unit u1, real x, real y,integer idsp, string ordstr, real life_1, abilityreallevelfield REALF returns nothing
        local DummyOrder dummy = DummyOrder.create(u1, x, y, GetUnitFacing(u1), 9)
        call dummy.addActiveAbility(idsp, 1, OrderId(ordstr))
        if REALF != null then
            call dummy.setAbilityRealField(idsp, REALF, life_1)
        endif
        call dummy.instant().activate()
    endfunction
endlibrary
