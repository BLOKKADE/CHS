library Learnability initializer init requires Table
    globals
        Table LearnabilityBonus
    endglobals

    function GetLearnabilityBonus takes unit u returns real
        if GetUnitAbilityLevel(u, PILLAGE_ABILITY_ID) == 0 and GetUnitAbilityLevel(u, MIDAS_TOUCH_ABILITY_ID) == 0 then
            return LearnabilityBonus.real[GetHandleId(u)]
        else
            return 0.
        endif
    endfunction

    private function init takes nothing returns nothing
        set LearnabilityBonus = Table.create()
    endfunction
endlibrary