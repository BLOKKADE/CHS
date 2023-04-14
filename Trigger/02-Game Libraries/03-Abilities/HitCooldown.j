library HitCooldown initializer init requires Table
    globals
        HashTable HitCooldown
    endglobals

    function CheckUnitHitCooldown takes integer hid, integer id, real duration returns boolean
        if T32_Tick - HitCooldown[hid].integer[id] < duration * 32 then
            return true
        else
            set HitCooldown[hid].integer[id] = T32_Tick
            return false
        endif
    endfunction

    private function init takes nothing returns nothing
        set HitCooldown = HashTable.create()
    endfunction
endlibrary