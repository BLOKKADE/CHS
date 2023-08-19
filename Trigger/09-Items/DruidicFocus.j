library DruidicFocus initializer init requires DummyOrder, UnitHelpers

    globals
        Table DruidicFocusLastTick
    endglobals

    function DruidicFocusPhyspowerbonus takes unit u returns nothing
        call TempBonus.create(u, BONUS_PHYSPOW, 35, 15, DRUIDIC_FOCUS_ABILITY_ID).activate()
    endfunction

    private function GetNearbyDruidicFocusHeroes takes unit target, real x, real y returns nothing
        local unit p
        local integer i = 0

        call GroupClear(ENUM_GROUP)
        call EnumTargettableUnitsInRange(ENUM_GROUP, x, y, 600, GetOwningPlayer(target), true, Target_Enemy)

        loop
            set p = BlzGroupUnitAt(ENUM_GROUP, i)
            exitwhen p == null
            if UnitHasItemType(p, DRUIDIC_FOCUS_ITEM_ID) then
                call TempBonus.create(p, BONUS_PHYSPOW, 35, 15, DRUIDIC_FOCUS_ABILITY_ID).activate()
            endif
            set i = i + 1
        endloop
    endfunction

    function CastDruidicFocus takes unit target returns nothing
        local DummyOrder dummyOrder = DummyOrder.create(target, GetUnitX(target), GetUnitY(target), GetUnitFacing(target), 5)
        call dummyOrder.addActiveAbility(DRUIDIC_FOCUS_ROOTS_ABILITY_ID, 1, 852171)
        call dummyOrder.target(target)
        if dummyOrder.activate() then
            call GetNearbyDruidicFocusHeroes(target, GetUnitX(target), GetUnitY(target))
        endif
        set DruidicFocusLastTick[GetHandleId(target)] = T32_Tick
    endfunction

    private function init takes nothing returns nothing
        set DruidicFocusLastTick = Table.create()
    endfunction
endlibrary