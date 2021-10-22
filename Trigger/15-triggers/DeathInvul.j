library DeathInvul initializer init requires Table
    globals
        Table DeathReviveInvul
    endglobals

    private function init takes nothing returns nothing
        set DeathReviveInvul = Table.create()
    endfunction
endlibrary