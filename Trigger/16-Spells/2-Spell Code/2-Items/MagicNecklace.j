library MagicNecklace initializer init requires Table
    globals
        Table MacigNecklaceBonus
    endglobals

    private function init takes nothing returns nothing
        set MacigNecklaceBonus = Table.create()
    endfunction
endlibrary