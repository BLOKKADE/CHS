library ItemOwnership initializer init requires Table, GetPlayerNames

    globals
        // Mapping between item handle id and the player id that owns it
        private Table PlayerItemOwnerships
    endglobals

    private function ValidateItem takes item itemToValidate, boolean isStacked returns nothing
        local integer itemHandleId = GetHandleId(itemToValidate)
        local unit unitPickedUpItem = GetTriggerUnit()
        local player triggerPlayer = GetTriggerPlayer()
        local item createdStackedItem

        // Don't bother tracking any Powerup (tomes from shops) items
        if (GetItemType(itemToValidate) != ITEM_TYPE_POWERUP) then
            // If the item has never been picked up, assign it to the player
            if (not PlayerItemOwnerships.has(itemHandleId)) then
                set PlayerItemOwnerships[itemHandleId] = GetPlayerId(triggerPlayer)
            // If the item has been picked up but doesn't match the player picking it up, drop it
            elseif (PlayerItemOwnerships[itemHandleId] != GetPlayerId(triggerPlayer)) then
                call DisplayTimedTextToPlayer(triggerPlayer,0,0,10,"You don't own this item. It belongs to " + GetPlayerNameColour(Player(PlayerItemOwnerships[itemHandleId])))
                
                if isStacked then
                    // Original item was deleted when stacking. Need to re-create it and assign it to the original player with the correct amount of charges
                    set createdStackedItem = CreateItem(GetItemTypeId(itemToValidate), GetUnitX(unitPickedUpItem), GetUnitY(unitPickedUpItem))
                    call SetItemCharges(createdStackedItem, GetItemCharges(BlzGetStackingItemTarget()) - BlzGetStackingItemTargetPreviousCharges())
                    set PlayerItemOwnerships[GetHandleId(createdStackedItem)] = PlayerItemOwnerships[itemHandleId]

                    // At this point, the item is already stacked. We need to remove charges to its original value
                    call SetItemCharges(BlzGetStackingItemTarget(), BlzGetStackingItemTargetPreviousCharges())
                else
                    // Basic item, drop under the hero that tried to pick it up
                    call UnitDropItemPoint(unitPickedUpItem, itemToValidate, GetUnitX(unitPickedUpItem), GetUnitY(unitPickedUpItem))
                endif
            endif
        endif

        // Cleanup
        set createdStackedItem = null
        set itemToValidate = null
        set unitPickedUpItem = null
        set triggerPlayer = null
    endfunction

    private function PlayerPickupItemActions takes nothing returns nothing
        call ValidateItem(GetManipulatedItem(), false)
    endfunction

    private function PlayerPickupItemStackActions takes nothing returns nothing
        call ValidateItem(BlzGetStackingItemSource(), true)
    endfunction

    private function init takes nothing returns nothing
        local trigger itemPickupTrigger = CreateTrigger()
        local trigger itemStackingTrigger = CreateTrigger()

        call TriggerRegisterAnyUnitEventBJ(itemPickupTrigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddAction(itemPickupTrigger, function PlayerPickupItemActions)
        set itemPickupTrigger = null

        call TriggerRegisterAnyUnitEventBJ(itemStackingTrigger, EVENT_PLAYER_UNIT_STACK_ITEM)
        call TriggerAddAction(itemStackingTrigger, function PlayerPickupItemStackActions)
        set itemStackingTrigger = null

        set PlayerItemOwnerships = Table.create()
    endfunction

endlibrary