library SellItems requires DummyRecycler
    function SellItem takes integer pid, item it returns boolean
            local boolean success = false
            local unit u = CreateUnit(Player(pid), SELL_ITEM_DUMMY, GetItemX(it), GetItemY(it), 0)

            call UnitAddItem(u, it)
            set success = UnitDropItemTarget(u, it, GetShopById(ITEM_SHOP_I_UNIT_ID))
            call UnitApplyTimedLife(u, 'BTLF' , 20)
            
            set u = null
            return success
    endfunction
endlibrary