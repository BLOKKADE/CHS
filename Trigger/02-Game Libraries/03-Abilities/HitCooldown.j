library HitCooldown initializer init requires Table
    globals
        HashTable HitCooldown
    endglobals

    function CheckUnitHitCooldown takes integer hid, integer id, real duration returns boolean
        if T32_Tick - HitCooldown[hid].integer[id] < duration * 32 then
            //call BJDebugMsg("cd on, no bonus dmg")
            return false
        else
            set HitCooldown[hid].integer[id] = T32_Tick
            //call BJDebugMsg("cd off, bonus dmg")
            return true
        endif
    endfunction

    private function init takes nothing returns nothing
        set HitCooldown = HashTable.create()
    endfunction
endlibrary