library ItemStock initializer init requires Table

    globals
        Table ItemStock
        Table ItemSwapCooldown
        HashTable ItemCooldown

        constant string ItemStockDisabledIcon = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNRiderlessHorse.blp"
        constant string ItemStockEnabledIcon = "ReplaceableTextures\\CommandButtons\\BTNRiderlessHorse.blp"

        boolean ItemStockEnabled = false
    endglobals

    function MoveItemStockToPlayerArena takes integer pid returns nothing
        local unit sheep = ItemStock.unit[pid]

        if sheep != null then
            call SetUnitX(sheep, GetRectCenterX(PlayerArenaRects[pid]))
            call SetUnitY(sheep, GetRectCenterY(PlayerArenaRects[pid]))
        endif

        set sheep = null
    endfunction

        private function ValidateSwapConditions takes integer pid, unit sheep, unit hero returns boolean
            if (not ItemStockEnabled) or sheep == null or hero == null then
                call DisplayTimedTextToPlayer(Player(pid), 0, 0, 5, "|cffff0000Item stock is disabled.|r")
                return false
            endif

            if BrStarted and T32_Tick < ItemSwapCooldown.integer[pid] then
                call DisplayTimedTextToPlayer(Player(pid), 0, 0, 5, "|cffff0000Item swap is on cooldown: |r" + R2S((ItemSwapCooldown.integer[pid] - T32_Tick) / 32) + "s")
                return false
            endif

            return true
        endfunction

        private function SwapItemsBetweenUnits takes unit source, unit target, integer slot returns string
            local item sourceItem = UnitItemInSlot(source, slot)
            local item targetItem = UnitItemInSlot(target, slot)
            local integer sourceItemCharges = GetItemCharges(sourceItem)
            local integer targetItemCharges = GetItemCharges(targetItem)
            local integer sourceItemTypeId = GetItemTypeId(sourceItem)
            local integer targetItemTypeId = GetItemTypeId(targetItem)
            local real sourceItemCooldown = BlzGetUnitAbilityCooldownRemaining(source, GetItemTypeAbilityId(sourceItemTypeId))
            local real targetItemCooldown = BlzGetUnitAbilityCooldownRemaining(target, GetItemTypeAbilityId(targetItemTypeId))
            local string sourceItemName = ""
            local string targetItemName = ""

            call RemoveItem(sourceItem)
            call RemoveItem(targetItem)

            if sourceItemTypeId != 0 then
                call UnitAddItemToSlotById(target, sourceItemTypeId, slot)
                if sourceItemCharges > 0 then
                    call SetItemCharges(UnitItemInSlot(target, slot), sourceItemCharges)
                endif

                if sourceItemCooldown > 0 then
                    call BlzStartUnitAbilityCooldown(target, GetItemTypeAbilityId(sourceItemTypeId), sourceItemCooldown)
                endif

                set sourceItemName = GetItemName(UnitItemInSlot(target, slot))
            endif

            if targetItemTypeId != 0 then
                call UnitAddItemToSlotById(source, targetItemTypeId, slot)
                if targetItemCharges > 0 then
                    call SetItemCharges(UnitItemInSlot(source, slot), targetItemCharges)
                endif

                if targetItemCooldown > 0 then
                    call BlzStartUnitAbilityCooldown(source, GetItemTypeAbilityId(targetItemTypeId), targetItemCooldown)
                endif

                set targetItemName = GetItemName(UnitItemInSlot(source, slot))
            endif

            set sourceItem = null
            set targetItem = null

            if sourceItemTypeId != 0 or targetItemTypeId != 0 then
                if sourceItemTypeId != 0 and targetItemTypeId != 0 then
                    return "|ccffdde31Swapped|r |ccf31fd6e" + sourceItemName + " |ccffdde31with|r |ccf31effd" + targetItemName
                elseif sourceItemTypeId != 0 then
                    return "|ccffdde31Added|r |ccf31fd6e" + sourceItemName + "|r |ccffdde31to your storage|r"
                else
                    return "|ccffdde31Added|r |ccf31effd" + targetItemName + "|r |ccffdde31to your hero|r"
                endif
            endif

            return "|ccffdde31No items to swap|r"
        endfunction

        function SwapItem takes integer pid, integer slot returns nothing
            local unit sheep = ItemStock.unit[pid]
            local unit hero = PlayerHeroes[pid]
            local string message = ""

            if not ValidateSwapConditions(pid, sheep, hero) then
                set sheep = null
                set hero = null
                return
            endif

            call SetItemAbility(UnitItemInSlot(hero, slot))
            call SetItemAbility(UnitItemInSlot(sheep, slot))

            set message = SwapItemsBetweenUnits(hero, sheep, slot)
            call DisplayTimedTextToPlayer(Player(pid), 0, 0, 5, message)

            if message != "|ccffdde31No items to swap|r" then
                set ItemSwapCooldown.integer[pid] = T32_Tick + (32 * 30)
            endif

            set hero = null
            set sheep = null
        endfunction

    private function SetSkinForPlayer takes player p returns nothing
        local PlayerStats ps = PlayerStats.forPlayer(p)
        local unit sheep = ItemStock.unit[GetPlayerId(p)]
        local PetSpecification psn = AchievementsFrame_PetIndexes[ps.getPetIndex()]
        local real scaling = psn.getScaling() * 1.5

        if psn == 0 then
            set sheep = null
            return
        endif
        
        // Modifying the pet. Not all default models are equal in size or need to fly, so adjustment is needed
        call BlzSetUnitSkin(sheep, psn.getUnitId())
        call SetUnitScale(sheep, scaling, scaling, scaling)

        if (psn.getFlyHeight() != -1.0) then
            // Add then remove the crow form ability. Will allow the unit to fly
            call UnitAddAbility(sheep, 'Amrf')
            call UnitRemoveAbility(sheep, 'Amrf')
            call SetUnitFlyHeight(sheep, psn.getFlyHeight(), 0.)
        endif

        set sheep = null
    endfunction

    function SetItemStockSkin takes player p returns nothing
        if ItemStockEnabled then
            call SetSkinForPlayer(p)
        endif
    endfunction

    function KillItemStock takes integer pid returns nothing
        if ItemStockEnabled then
            call RemoveUnit(ItemStock.unit[pid])
            call ItemStock.remove(pid)
        endif
    endfunction

    function CreateItemStock takes nothing returns nothing
        local integer pid = GetPlayerId(GetEnumPlayer())

        if UnitAlive(PlayerHeroes[pid]) then
            set ItemStock.unit[pid] = CreateUnit(GetEnumPlayer(), FLYING_SHEEP_UNIT_ID, 0, 0, 0)
            call SetItemStockSkin(GetEnumPlayer())
        endif
    endfunction

    function SetUpItemStocks takes force players returns nothing
        set ItemStockEnabled = true
        call ForForce(players, function CreateItemStock)
        call BlzFrameSetTexture(ButtonId[8], "ReplaceableTextures\\CommandButtons\\BTNRiderlessHorse.blp", 0, true)
    endfunction

    function GetItemStock takes integer pid returns unit
        return ItemStock.unit[pid]
    endfunction

    private function init takes nothing returns nothing
        set ItemStock = Table.create()
        set ItemSwapCooldown = Table.create()
    endfunction

endlibrary