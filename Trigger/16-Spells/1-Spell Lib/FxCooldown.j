library FxCooldown initializer init requires Table
    globals
        HashTable FxCooldown
    endglobals

    function IsFxOnCooldown takes unit u, integer id returns boolean
        return FxCooldown[GetHandleId(u)].boolean[id]
    endfunction

    function FxCooldownEnd takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local FxData data = GetTimerData(t)
        set FxCooldown[data.unitId].boolean[data.fxId] = false
        call ReleaseTimer(t)
        call data.destroy()
        set t = null
    endfunction

    struct FxData
        integer unitId
        integer fxId
    endstruct

    function SetFxCooldown takes unit u, integer id, real duration returns nothing
        local timer t = NewTimer()
        local FxData data = FxData.create()
        set data.unitId = GetHandleId(u)
        set data.fxId = id
        set FxCooldown[data.unitId].boolean[data.fxId] = true
        call SetTimerData(t, data)
        call TimerStart(t, duration, false, function FxCooldownEnd)
        set t = null
    endfunction

    private function init takes nothing returns nothing
        set FxCooldown = HashTable.create()
    endfunction
endlibrary