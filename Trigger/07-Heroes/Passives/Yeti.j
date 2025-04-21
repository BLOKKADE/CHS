library Yeti initializer init
    globals
        Table YetiStrengthBonus
    endglobals

    private function init takes nothing returns nothing
        set YetiStrengthBonus = Table.create()
    endfunction
endlibrary