library TrollBerserker initializer init requires Table

    globals
        Table TrollBerserkerBonus
    endglobals

    private function init takes nothing returns nothing
        set TrollBerserkerBonus= Table.create()
    endfunction
endlibrary
