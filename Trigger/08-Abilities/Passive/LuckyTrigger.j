library LuckyTrigger initializer init requires CustomState

    function LuckyTriggerBonusChance takes unit u returns real
        if GetUnitAbilityLevel(u, LUCKY_TRIGGER_ABILITY_ID) > 0 then
            return GetUnitAbilityLevel(u, LUCKY_TRIGGER_ABILITY_ID) * 0.1667
        endif
        return 0.0
    endfunction

    private function init takes nothing returns nothing
        // Initialization logic here (if needed)
        // For example: debug messages, registration, etc.
    endfunction

endlibrary
