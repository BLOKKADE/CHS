library CreepAntagonisation initializer init requires CustomState, CustomGameEvent

    globals
        Table CreepAntagonisationBonus
        boolean array CreepAntagonisationBought
    endglobals

    private function init takes nothing returns nothing
        set CreepAntagonisationBonus = Table.create()
    endfunction
endlibrary
