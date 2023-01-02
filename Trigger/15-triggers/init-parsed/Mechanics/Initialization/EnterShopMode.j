library EnterShopMode initializer init requires RandomShit

    private function EnterShopModeConditions takes nothing returns boolean
        return (IsTriggerEnabled(GetTriggeringTrigger()) == true)
    endfunction

    private function ShopFilter takes nothing returns boolean
        return (IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) == true) and (GetUnitTypeId(GetFilterUnit()) != 'ncop')
    endfunction

    private function SetupShowVisibility takes nothing returns nothing
        local unit currentShop = GetEnumUnit()

        if (GetUnitTypeId(currentShop) == 'n02L') then
            if (IncomeMode == 1) then
                call ReplaceUnitBJ(currentShop, 'n035', bj_UNIT_STATE_METHOD_RELATIVE)
            elseif (IncomeMode == 2) then
                call ReplaceUnitBJ(currentShop, 'n034', bj_UNIT_STATE_METHOD_RELATIVE)		
            elseif (IncomeMode == 3) then
                call ReplaceUnitBJ(currentShop, 'n005', bj_UNIT_STATE_METHOD_RELATIVE)
            endif
        else
            call ShowUnitShow(currentShop)
        endif

        // Cleanup
        set currentShop = null
    endfunction

    private function EnterShopModeActions takes nothing returns nothing
        local group shops = GetUnitsOfPlayerMatching(Player(PLAYER_NEUTRAL_PASSIVE), Condition(function ShopFilter))

        call DisableTrigger(GetTriggeringTrigger())
        
        call ForGroup(shops, function SetupShowVisibility)

        // Cleanup
        call DestroyGroup(shops)
        set shops = null

        call TriggerSleepAction(0.00)
    endfunction

    private function init takes nothing returns nothing
        set EnterShopModeTrigger = CreateTrigger()
        call TriggerAddCondition(EnterShopModeTrigger, Condition(function EnterShopModeConditions))
        call TriggerAddAction(EnterShopModeTrigger, function EnterShopModeActions)
    endfunction

endlibrary
