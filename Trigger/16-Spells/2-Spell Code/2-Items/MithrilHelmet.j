library MithrilHelmet initializer init requires Table
    globals
        Table MithrilHelmetCooldown
    endglobals

    private function init takes nothing returns nothing
        set MithrilHelmetCooldown = Table.create()
    endfunction
endlibrary