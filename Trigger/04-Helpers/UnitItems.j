library UnitItems

    function UnitHasInventorySpace takes unit u returns boolean
        return UnitItemInSlot(u, 0) == null or UnitItemInSlot(u, 1) == null or UnitItemInSlot(u, 2) == null or UnitItemInSlot(u, 3) == null or UnitItemInSlot(u, 4) == null or UnitItemInSlot(u, 5) == null
    endfunction

    //Get first item of u with id
    function GetUnitItem takes unit u, integer id returns item 
        local integer i = 0

        loop
            if GetItemTypeId(UnitItemInSlot(u, i)) == id then
                return UnitItemInSlot(u, i)
            endif
            set i = i + 1
            exitwhen i > 5
        endloop

        return null
    endfunction

    //Check if u has item id
    function UnitHasItemType takes unit u, integer id returns boolean 
        local integer i = 0

        loop
            if GetItemTypeId(UnitItemInSlot(u, i)) == id then
                return true
            endif
            set i = i + 1
            exitwhen i > 5
        endloop

        return false
    endfunction

    //Check how many u has of item id
    function GetUnitITemTypeCount takes unit u, integer id returns integer
        local integer i = 0
        local integer count = 0

        loop
            if GetItemTypeId(UnitItemInSlot(u, i)) == id then
                set count = count + 1
            endif
            set i = i + 1
            exitwhen i > 5
        endloop

        return count
    endfunction
endlibrary
