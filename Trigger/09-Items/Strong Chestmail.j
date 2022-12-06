library StrongChestmail initializer init

    globals
        Table StrongChestMailReduction
    endglobals

    function StrongChestMailDamage takes integer hid, real damage returns real
        set StrongChestMailReduction.integer[hid] = StrongChestMailReduction.integer[hid] + 1
        if StrongChestMailReduction.integer[hid] >= 101 or StrongChestMailReduction.integer[hid] < 35 then
            set StrongChestMailReduction.integer[hid] = 35
        endif

        return damage * (1 - (StrongChestMailReduction.integer[hid] * 0.01))
    endfunction

    private function init takes nothing returns nothing
        set StrongChestMailReduction= Table.create()
    endfunction
endlibrary
