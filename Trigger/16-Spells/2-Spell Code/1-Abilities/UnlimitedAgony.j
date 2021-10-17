library UnlimitedAgony initializer init requires Table
    globals
        Table UnlimitedAgonyActivated
    endglobals

    private function init takes nothing returns nothing
        set UnlimitedAgonyActivated = Table.create()
    endfunction
endlibrary