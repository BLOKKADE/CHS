library ItemOwnership initializer init requires Table, GetPlayerNames

    private function PlayerPickupItemActions takes nothing returns nothing
        local item pickedItem = GetManipulatedItem()
        local unit triggeredUnit = GetTriggerUnit()
        local integer itemUserData = GetItemUserData(pickedItem)

        //call BJDebugMsg("Item user data: " + I2S(itemUserData))

        // Check if the item is owned by another player
        if (itemUserData != 0 and itemUserData != GetConvertedPlayerId(GetOwningPlayer(triggeredUnit))) then
            call DisplayTimedTextToPlayer(GetOwningPlayer(triggeredUnit),0,0,10,"You don't own this item. It belongs to " + GetPlayerNameColour(ConvertedPlayer(itemUserData)))
            call UnitRemoveItem(triggeredUnit, pickedItem)
        else
            // Not owned by anyone, save it to the player
            call SetItemUserData(pickedItem, GetConvertedPlayerId(GetOwningPlayer(triggeredUnit)))
        endif

        // Cleanup
        set pickedItem = null
        set triggeredUnit = null
    endfunction

    private function init takes nothing returns nothing
        local trigger itemPickupTrigger = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(itemPickupTrigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddAction(itemPickupTrigger, function PlayerPickupItemActions)
        set itemPickupTrigger = null
    endfunction

endlibrary