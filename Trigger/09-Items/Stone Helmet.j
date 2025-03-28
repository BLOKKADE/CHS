library StoneHelmet requires RandomShit

    function StoneHelmetCast takes unit u returns nothing
        if UnitHasItemType(u, 'I090') then
            call RemoveItem(GetItemOfTypeFromUnitBJ(u, 'I090'))
            call UnitAddItemById(u, 'I0CV')
        elseif UnitHasItemType(u, 'I0CV') then
            call RemoveItem(GetItemOfTypeFromUnitBJ(u, 'I0CV'))
            call UnitAddItemById(u, 'I090')
        endif
        call BlzStartUnitAbilityCooldown(u, 'A0ER', 20)
    endfunction
endlibrary