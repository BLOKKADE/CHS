library FingerOfDeath initializer init requires Table
    globals
        Table FingerOfDeathTable
    endglobals

    private function init takes nothing returns nothing
        set FingerOfDeathTable = Table.create()
    endfunction
endlibrary