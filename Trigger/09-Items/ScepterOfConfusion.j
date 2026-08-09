library ScepterOfConfusion requires DummyOrder, CustomState
    function ActivateScepterOfConfusion takes unit source returns nothing
        local DummyOrder dummyOrder
        local real luck = GetUnitCustomState(source, BONUS_LUCK)
        if GetRandomInt(1,100) < (75 + LuckyTriggerBonusChance(source)) * luck then
            set dummyOrder = DummyOrder.create(source, GetUnitX(source), GetUnitY(source), GetUnitFacing(source), 5)
            //call BJDebugMsg("ancient staff")
            call dummyOrder.addActiveAbility('A014', 1, 852274)
            call dummyOrder.target(source)
            call dummyOrder.activate()
        endif
    endfunction
endlibrary