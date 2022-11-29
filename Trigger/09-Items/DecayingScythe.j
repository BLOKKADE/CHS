library DecayingScythe initializer init requires Table
    globals
        Table DecayingScytheTick
    endglobals

    private function init takes nothing returns nothing
        set DecayingScytheTick = Table.create()
    endfunction
endlibrary