library MagicNecklace initializer init requires Table
    globals
        constant real MnBonus = 1.2
        Table MacigNecklaceBonus
    endglobals

    private function init takes nothing returns nothing
        set MacigNecklaceBonus = Table.create()
    endfunction
endlibrary