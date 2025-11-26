library CelestialSignet requires AbsoluteBonusState

    globals
        hashtable CelestialSignetTable = InitHashtable()
    endglobals

    function GetEmptyItemSlots takes unit u returns integer
        local integer i = 0
        local integer empty = 0
        loop
            exitwhen i >= bj_MAX_INVENTORY
            if UnitItemInSlot(u, i) == null then
                set empty = empty + 1
            endif
            set i = i + 1
        endloop
        return empty
    endfunction

    function ApplyElementBonuses takes unit u returns nothing
        local integer emptySlots = GetEmptyItemSlots(u)
        local integer prev = LoadInteger(CelestialSignetTable, GetHandleId(u), 0)
        local integer diff = emptySlots - prev

        if diff != 0 then
            call AddUnitAbsoluteBonusCount(u, Element_Fire,   diff)
            call AddUnitAbsoluteBonusCount(u, Element_Water,  diff)
            call AddUnitAbsoluteBonusCount(u, Element_Earth,  diff)
            call AddUnitAbsoluteBonusCount(u, Element_Wind,   diff)
            call AddUnitAbsoluteBonusCount(u, Element_Dark,   diff)
            call AddUnitAbsoluteBonusCount(u, Element_Wild,   diff)
            call AddUnitAbsoluteBonusCount(u, Element_Arcane, diff)
            call AddUnitAbsoluteBonusCount(u, Element_Blood,  diff)
            call AddUnitAbsoluteBonusCount(u, Element_Cold,   diff)
            call AddUnitAbsoluteBonusCount(u, Element_Poison, diff)
            call AddUnitAbsoluteBonusCount(u, Element_Light,  diff)

            call SaveInteger(CelestialSignetTable, GetHandleId(u), 0, emptySlots)
        endif
    endfunction

    function RemoveElementBonuses takes unit u returns nothing
        local integer prev = LoadInteger(CelestialSignetTable, GetHandleId(u), 0)
        if prev != 0 then
            call AddUnitAbsoluteBonusCount(u, Element_Fire,   -prev)
            call AddUnitAbsoluteBonusCount(u, Element_Water,  -prev)
            call AddUnitAbsoluteBonusCount(u, Element_Earth,  -prev)
            call AddUnitAbsoluteBonusCount(u, Element_Wind,   -prev)
            call AddUnitAbsoluteBonusCount(u, Element_Dark,   -prev)
            call AddUnitAbsoluteBonusCount(u, Element_Wild,   -prev)
            call AddUnitAbsoluteBonusCount(u, Element_Arcane, -prev)
            call AddUnitAbsoluteBonusCount(u, Element_Blood,  -prev)
            call AddUnitAbsoluteBonusCount(u, Element_Cold,   -prev)
            call AddUnitAbsoluteBonusCount(u, Element_Poison, -prev)
            call AddUnitAbsoluteBonusCount(u, Element_Light,  -prev)

            call SaveInteger(CelestialSignetTable, GetHandleId(u), 0, 0)
        endif
    endfunction

endlibrary
