library FxCooldown initializer init requires Table
    globals
        HashTable FxCooldownDuration
        HashTable FxCooldownStart
    endglobals

    //checks ticks to see if an fx cooldown is over
    function IsFxOnCooldownSet takes integer hid, integer id, real duration returns boolean
        if T32_Tick - FxCooldownStart[hid].integer[id] < duration * 32 then
            return true
        else
            set FxCooldownStart[hid].integer[id] = T32_Tick
            return false
        endif
    endfunction

    private function init takes nothing returns nothing
        set FxCooldownStart = HashTable.create()
        set FxCooldownDuration = HashTable.create()
    endfunction
endlibrary