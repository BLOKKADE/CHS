library DoomGuard requires ElementalAbility, RandomShit
    function DoomGuardHellfire takes unit u returns nothing
        local DummyOrder dummy = DummyOrder.create(u, GetUnitX(u), GetUnitY(u), GetUnitFacing(u), 10)
        call ElemFuncStart(u, DOOM_GUARD_UNIT_ID)
        call dummy.addActiveAbility('A0CN', 1, 852662)
        call dummy.target(GetRandomUnit(GetUnitX(u), GetUnitY(u), 600, GetOwningPlayer(u), Target_Enemy, false, false)).activate()
    endfunction
endlibrary