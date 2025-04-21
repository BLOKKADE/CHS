library Starfall initializer init requires Table
    globals
        Table StarfallTable
    endglobals

    private function init takes nothing returns nothing
        set StarfallTable = Table.create()
    endfunction
endlibrary