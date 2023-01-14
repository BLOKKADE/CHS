library HideShops initializer init requires RandomShit

    private function ShopFilter takes nothing returns boolean
        return (IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) == true)
    endfunction

    // Removes preplaced shops, couldve really also just hid them I think
    private function HideShop takes nothing returns nothing
        local unit currentShop = GetEnumUnit()
        local location unitLocation = GetUnitLoc(currentShop)

        // Save the shop type and location for future use
        set HideShopsCount = HideShopsCount + 1
        set HideShopsLocations[HideShopsCount] = unitLocation
        set ShopIds[HideShopsCount] = GetUnitTypeId(currentShop)
        call DeleteUnit(currentShop)

        // call RemoveLocation(unitLocation) // Don't remove this location since it is used elsewhere
        set unitLocation = null
        set currentShop = null
    endfunction

    private function HideShopsActions takes nothing returns nothing
        local group shops = GetUnitsInRectMatching(GetPlayableMapRect(), Condition(function ShopFilter))

        set HideShopsCount = 0
        call ForGroup(shops, function HideShop)

        // Cleanup
        call DestroyGroup(shops)
        set shops = null
    endfunction

    private function init takes nothing returns nothing
        set HideShopsTrigger = CreateTrigger()
        call TriggerAddAction(HideShopsTrigger, function HideShopsActions)
    endfunction

endlibrary
