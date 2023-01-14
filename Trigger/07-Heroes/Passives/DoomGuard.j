library DoomGuard requires ElementalAbility, RandomShit

    function DoomGuardHellfireApply takes unit source, unit target returns nothing
        local DummyOrder dummy = DummyOrder.create(source, GetUnitX(target), GetUnitY(target), GetUnitFacing(target), 10)
        //call BJDebugMsg("apply period buff")
        call dummy.addActiveAbility('A0CN', 1, 852662)
        call dummy.target(target).activate()
        call PeriodicDamage.create(source, target, GetHeroLevel(source) * 25, true, 1., 8, 0, true, 'B02L', 'A0CO').start()
    endfunction

    function DoomGuardHellfire takes unit u returns nothing
        local DummyOrder dummy = DummyOrder.create(u, GetUnitX(u), GetUnitY(u), GetUnitFacing(u), 3)
        call ElemFuncStart(u, DOOM_GUARD_UNIT_ID)
        call dummy.addActiveAbility('A0CR', 1, 852662)
        call dummy.target(GetRandomUnit(GetUnitX(u), GetUnitY(u), 600, GetOwningPlayer(u), Target_Enemy, false, false)).activate()
    endfunction
endlibrary