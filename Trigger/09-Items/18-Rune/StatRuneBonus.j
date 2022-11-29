library StatRuneBonus initializer init

    globals
        HashTable StatRuneBonus

        integer StatRuneDuration = 0
    endglobals

    function ResetRuneBonus takes integer hid, integer state returns nothing
        set StatRuneBonus[hid].real[state] = 0
    endfunction

    function AddRuneBonus takes integer hid, integer state, real bonus returns nothing
        set StatRuneBonus[hid].real[state] = StatRuneBonus[hid].real[state] + bonus
    endfunction

    private function init takes nothing returns nothing
        set StatRuneBonus = HashTable.create()
    endfunction
endlibrary