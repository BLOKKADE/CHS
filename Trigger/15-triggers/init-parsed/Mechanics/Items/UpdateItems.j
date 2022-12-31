library UpdateItems initializer init requires RandomShit

    private function ReplaceShop takes nothing returns nothing
        call ReplaceUnitBJ(GetEnumUnit(), 'n017', bj_UNIT_STATE_METHOD_RELATIVE)
    endfunction

    private function Trig_Update_Items_Actions takes nothing returns nothing
        local group shopUnits

        if (((RoundNumber == 10) and ((ElimModeEnabled == true) or (GameModeShort == true))) or (RoundNumber == 20)) then
            set shopUnits = GetUnitsOfTypeIdAll('n004')

            call ForGroup(shopUnits, function ReplaceShop)

            // Cleanup
            call DestroyGroup(shopUnits)
            set shopUnits = null
        endif
    endfunction

    private function init takes nothing returns nothing
        set UpdateItemsTrigger = CreateTrigger()
        call TriggerAddAction(UpdateItemsTrigger,function Trig_Update_Items_Actions)
    endfunction

endlibrary
