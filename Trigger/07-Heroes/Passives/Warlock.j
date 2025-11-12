library WarlockIllusion requires DummyOrder, CustomState
    function WarlockIllusion takes unit source returns nothing
        local DummyOrder dummyOrder
        if GetRandomInt(1,100) < 5 then
            set dummyOrder = DummyOrder.create(source, GetUnitX(source), GetUnitY(source), GetUnitFacing(source), 10)
            //call BJDebugMsg("ancient staff")
            call dummyOrder.addActiveAbility('A0FT', 1, 852274)
            call dummyOrder.target(source)
            call dummyOrder.activate()
        endif
    endfunction
endlibrary