library ScepterOfConfusion requires BuffSystem, CustomState
    function ActivateScepterOfConfusion takes unit source returns nothing
        local DummyOrder dummyOrder
        if GetRandomInt(1,100) < 25 then
            set dummyOrder = DummyOrder.create(source, GetUnitX(source), GetUnitY(source), GetUnitFacing(source), 5)
            //call BJDebugMsg("ancient staff")
            call dummyOrder.addActiveAbility('A014', 1, 852274)
            call dummyOrder.target(source)
            call dummyOrder.activate()
        endif
    endfunction
endlibrary