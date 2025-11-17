library Learnability initializer init requires Table
    globals
        Table LearnabilityBonus
    endglobals

    function GetLearnabilityBonus takes unit u returns real
        return LearnabilityBonus.real[GetHandleId(u)]
    endfunction

    private function init takes nothing returns nothing
        set LearnabilityBonus = Table.create()
    endfunction
endlibrary