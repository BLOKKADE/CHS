library DruidicFocus initializer init requires DummyOrder

    globals
        Table DruidicFocusLastTick
    endglobals

    function CastDruidicFocus takes unit target returns nothing
        local DummyOrder dummyOrder = DummyOrder.create(target, GetUnitX(target), GetUnitY(target), GetUnitFacing(target), 5)
        //call BJDebugMsg("Druidic Focus")
        call dummyOrder.addActiveAbility(DRUIDIC_FOCUS_ROOTS_ABILITY_ID, 1, 852171)
        call dummyOrder.target(target)
        call dummyOrder.activate()
        set DruidicFocusLastTick[GetHandleId(target)] = T32_Tick
    endfunction

    private function init takes nothing returns nothing
        set DruidicFocusLastTick = Table.create()
    endfunction
endlibrary