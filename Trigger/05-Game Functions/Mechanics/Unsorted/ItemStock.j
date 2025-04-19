library ItemStock initializer init requires Table

    globals
        Table ItemStock
        Table ItemSwapCooldown

        constant string ItemStockDisabledIcon = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNRiderlessHorse.blp"
        constant string ItemStockEnabledIcon = "ReplaceableTextures\\CommandButtons\\BTNRiderlessHorse.blp"

        boolean ItemStockEnabled = false
    endglobals

    function SwapItem takes integer pid, integer slot returns nothing
        local unit sheep = ItemStock.unit[pid]
        local unit hero = PlayerHeroes[pid]
        local item heroItem = UnitItemInSlot(hero, slot)
        local item sheepItem = UnitItemInSlot(sheep, slot)
        local integer heroItemCharges = GetItemCharges(heroItem)
        local integer sheepItemCharges = GetItemCharges(sheepItem)
        local integer heroItemTypeId = GetItemTypeId(heroItem)
        local integer sheepItemTypeId = GetItemTypeId(sheepItem)
        local string heroItemName = ""
        local string sheepItemName = ""

        if (not ItemStockEnabled) or sheep == null or hero == null then
            call DisplayTimedTextToPlayer(Player(pid), 0, 0, 5, "|cffff0000Item stock is disabled.|r")

            set sheep = null
            set hero = null
            set heroItem = null
            set sheepItem = null
            return
        endif

        if BrStarted and T32_Tick < ItemSwapCooldown.integer[pid] then
            call DisplayTimedTextToPlayer(Player(pid), 0, 0, 5, "|cffff0000Item swap is on cooldown: |r" + R2S((ItemSwapCooldown.integer[pid] - T32_Tick) / 32) + "s")

            set sheep = null
            set hero = null
            set heroItem = null
            set sheepItem = null
            return
        endif

        call RemoveItem(heroItem)
        call RemoveItem(sheepItem)

        if heroItemTypeId != 0 then
            call UnitAddItemToSlotById(sheep, heroItemTypeId, slot)
            if heroItemCharges > 0 then
                call SetItemCharges(UnitItemInSlot(sheep, slot), heroItemCharges)
            endif

            set heroItemName = GetItemName(UnitItemInSlot(sheep, slot))
        endif

        if sheepItemTypeId != 0 then
            call UnitAddItemToSlotById(hero, sheepItemTypeId, slot)
            if sheepItemCharges > 0 then
                call SetItemCharges(UnitItemInSlot(hero, slot), sheepItemCharges)
            endif

            set sheepItemName = GetItemName(UnitItemInSlot(hero, slot))
        endif

        if heroItemTypeId != 0 or sheepItemTypeId != 0 then
            if heroItemTypeId != 0 and sheepItemTypeId != 0 then
                call DisplayTimedTextToPlayer(Player(pid), 0, 0, 5, "|ccffdde31Swapped|r |ccf31fd6e" + heroItemName + " |ccffdde31with|r |ccf31effd" + sheepItemName)
            elseif heroItemTypeId != 0 then
                call DisplayTimedTextToPlayer(Player(pid), 0, 0, 5, "|ccffdde31Added|r |ccf31fd6e" + heroItemName + "|r |ccffdde31to your storage|r")
            else
                call DisplayTimedTextToPlayer(Player(pid), 0, 0, 5, "|ccffdde31Added|r |ccf31effd" + sheepItemName + "|r |ccffdde31to your hero|r")
            endif

            set ItemSwapCooldown.integer[pid] = T32_Tick + (32 * 30)
        else
            call DisplayTimedTextToPlayer(Player(pid), 0, 0, 5, "|ccffdde31No items to swap|r")
        endif

        set hero = null
        set sheep = null
        set heroItem = null
        set sheepItem = null
    endfunction

    private function SetSkinForPlayer takes player p returns nothing
        local PlayerStats ps = PlayerStats.forPlayer(p)
        local unit sheep = ItemStock.unit[GetPlayerId(p)]
        local PetSpecification psn = AchievementsFrame_PetIndexes[ps.getPetIndex()]
        local real scaling = psn.getScaling() * 1.5

        if psn == 0 then
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
        call RemoveUnit(ItemStock.unit[pid])
        call ItemStock.remove(pid)
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