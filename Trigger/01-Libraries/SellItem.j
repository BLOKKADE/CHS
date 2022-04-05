library SellItems requires DummyRecycler, GloryItemCosts
    function SellItem takes integer pid, item it returns boolean
            local boolean success = false
            local unit u = CreateUnit(Player(pid), SELL_ITEM_DUMMY, GetItemX(it), GetItemY(it), 0)

            call UnitAddItem(u, it)
            set success = UnitDropItemTarget(u, it, GetShopById(ITEM_SHOP_I_UNIT_ID))
            call UnitApplyTimedLife(u, 'BTLF' , 20)
            
            set u = null
            return success
    endfunction

    function SellItemsFromHero takes unit playerHero returns nothing
        local unit u
        local item itemToSell
        local item tempItem
        local integer i = 0
        local integer cost = 0

        loop
            set itemToSell = UnitItemInSlot(playerHero, i)

            if (itemToSell != null) then
                if (not IsItemPawnable(itemToSell)) then
                    call DisplayTimedTextToPlayer(GetOwningPlayer(playerHero),0,0,10,"You cannot sell items during PVP")

                    set itemToSell = null
                    exitwhen true
                endif

                // Create a dummy with timed life, give it a clone of the item, and make the dummy sell it
                set u = CreateUnit(GetOwningPlayer(playerHero), SELL_ITEM_DUMMY, GetUnitX(playerHero), GetUnitY(playerHero), 0)
                call UnitApplyTimedLife(u, 'BTLF' , 20)
                set tempItem = UnitAddItemById(u, GetItemTypeId(itemToSell))
                call SetItemCharges(tempItem, GetItemCharges(itemToSell))
                call RemoveItem(itemToSell)
                call UnitDropItemTarget(u, tempItem, GetShopById(ITEM_SHOP_I_UNIT_ID))

                // Glory returns should happen automatically
                    
                set u = null
                set itemToSell = null
                set tempItem = null
            endif

            set i = i + 1
            exitwhen i > 5
        endloop

    endfunction   
endlibrary