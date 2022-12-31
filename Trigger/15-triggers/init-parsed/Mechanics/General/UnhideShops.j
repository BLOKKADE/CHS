library UnhideShops initializer init requires RandomShit

    private function UnhideShopsActions takes nothing returns nothing
        set HideShopsIndex = 1

        loop
            exitwhen HideShopsIndex > HideShopsCount

            if ((ArNotLearningAbil == true) or (ShopIds[HideShopsIndex] != 'h00G')) then
                call CreateUnitAtLoc(Player(PLAYER_NEUTRAL_PASSIVE), ShopIds[HideShopsIndex], HideShopsLocations[HideShopsIndex], bj_UNIT_FACING)
            endif

            set HideShopsIndex = HideShopsIndex + 1
        endloop
    endfunction

    private function init takes nothing returns nothing
        set UnhideShopsTrigger = CreateTrigger()
        call TriggerAddAction(UnhideShopsTrigger, function UnhideShopsActions)
    endfunction

endlibrary
