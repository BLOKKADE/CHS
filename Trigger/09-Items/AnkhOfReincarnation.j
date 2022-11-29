library AnkhOfReincarnation initializer init requires Table
    globals
        Table AnkhLimitReached
    endglobals

    private function init takes nothing returns nothing
        set AnkhLimitReached = Table.create()
    endfunction
endlibrary