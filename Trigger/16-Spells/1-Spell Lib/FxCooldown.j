library FxCooldown initializer init requires Table
    globals
        HashTable FxCooldownDuration
        HashTable FxCooldownStart
    endglobals

    function IsFxOnCooldownSet takes integer hid, integer id, real duration returns boolean
        if T32_Tick - FxCooldownStart[hid].integer[id] < duration * 32 then
            return true
        else
            set FxCooldownStart[hid].integer[id] = T32_Tick
            return false
        endif
    endfunction

    function IsFxOnCooldown takes integer hid, integer id returns boolean
        return T32_Tick - FxCooldownStart[hid].integer[id] < FxCooldownDuration[hid].integer[id]
    endfunction

    function SetFxCooldown takes integer hid, integer id, real duration returns nothing
        set FxCooldownStart[hid].integer[id] = T32_Tick
        set FxCooldownDuration[hid].integer[id] = R2I(duration * 32)
    endfunction

    private function init takes nothing returns nothing
        set FxCooldownStart = HashTable.create()
        set FxCooldownDuration = HashTable.create()
    endfunction
endlibrary