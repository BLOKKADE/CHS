library StaffOfPower requires RandomShit
    function StaffOfPowerCast takes unit u returns nothing
        if UnitHasItemS(u, 'I080') then
            call RemoveItem(GetItemOfTypeFromUnitBJ(u, 'I080'))
            call UnitAddItemById(u, 'I0AT')
        elseif UnitHasItemS(u, 'I0AT') then
            call RemoveItem(GetItemOfTypeFromUnitBJ(u, 'I0AT'))
            call UnitAddItemById(u, 'I080')
        endif
    endfunction
endlibrary//