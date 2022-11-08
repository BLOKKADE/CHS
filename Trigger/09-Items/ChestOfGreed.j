library ChestOfGreed initializer init requires Table
    globals
        constant real CgBonus = 1.2
        Table ChestOfGreedBonus
    endglobals

    private function init takes nothing returns nothing
        set ChestOfGreedBonus = Table.create()
    endfunction
endlibrary