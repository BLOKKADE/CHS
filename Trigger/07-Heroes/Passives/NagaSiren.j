library NagaSiren initializer init
    globals
        Table NagaSirenBonus
    endglobals

    private function init takes nothing returns nothing
        set NagaSirenBonus = Table.create()
    endfunction
endlibrary