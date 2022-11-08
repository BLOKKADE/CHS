library Initelements initializer init
    globals
        HashTable ElementHitTick
    endglobals

    private function init takes nothing returns nothing
        set ElementHitTick = HashTable.create()
    endfunction
endlibrary