library MegaSpeed initializer init requires Table
    globals
        Table MegaSpeedStartTimer
        Table MegaSpeedLastAttack
    endglobals

    function MegaSpeedBonus takes unit u, integer lvl, real baseSpeed returns real
        local real limit = baseSpeed - 0.32
        if T32_Tick - MegaSpeedLastAttack[GetHandleId(u)] > 4 * 32 then
            return 0.
        else
            return RMinBJ(limit, (limit) * (((MegaSpeedLastAttack[GetHandleId(u)] - MegaSpeedStartTimer[GetHandleId(u)]) / 32) / (15.50 - (0.35 * lvl))))
        endif
    endfunction

    private function init takes nothing returns nothing
        set MegaSpeedStartTimer = Table.create()
        set MegaSpeedLastAttack = Table.create()
    endfunction
endlibrary