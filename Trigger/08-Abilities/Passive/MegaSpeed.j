library MegaSpeed initializer init requires Table
    globals
        Table MegaSpeedStartTimer
        Table MegaSpeedLastAttack
    endglobals

    function MegaSpeedBonus takes unit u, integer lvl, real baseSpeed returns real
        local real limit = baseSpeed - 0.50
        local integer hid = GetHandleId(u)

        if T32_Tick - MegaSpeedLastAttack[hid] > 6 * 32 then
            return 0.
        else
            return RMinBJ(limit, (limit) * (((MegaSpeedLastAttack[hid] - MegaSpeedStartTimer[hid]) / 32) / (15.50 - (0.35 * lvl))))
        endif
    endfunction

    private function init takes nothing returns nothing
        set MegaSpeedStartTimer = Table.create()
        set MegaSpeedLastAttack = Table.create()
    endfunction
endlibrary