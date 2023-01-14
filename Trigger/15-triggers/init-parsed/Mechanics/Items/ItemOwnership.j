library ItemOwnership initializer init requires Table, GetPlayerNames

    private function PlayerPickupItemActions takes nothing returns nothing
        local item pickedItem = GetManipulatedItem()
        local unit triggeredUnit = GetTriggerUnit()
        local integer itemUserData = GetItemUserData(pickedItem)
        local player owningPlayer = GetOwningPlayer(triggeredUnit)
        local integer playerId = GetPlayerId(owningPlayer) + 1 // Need to be base 1 to prevent the default value of 0 from messing with giving items normally

        // Check if the item is owned by another player
        if (itemUserData != 0 and itemUserData != playerId) then
            call DisplayTimedTextToPlayer(owningPlayer, 0, 0, 10, "You don't own this item. It belongs to " + GetPlayerNameColour(Player(itemUserData)))
            call UnitRemoveItem(triggeredUnit, pickedItem)
        else
            // Not owned by anyone, save it to the player
            call SetItemUserData(pickedItem, playerId)
        endif

        // Cleanup
        set pickedItem = null
        set triggeredUnit = null
        set owningPlayer = null
    endfunction

    private function init takes nothing returns nothing
        local trigger itemPickupTrigger = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(itemPickupTrigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddAction(itemPickupTrigger, function PlayerPickupItemActions)
        set itemPickupTrigger = null
    endfunction

endlibrary