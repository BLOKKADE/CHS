library RemoveBuffDelay requires TimerUtils, DebuffTypes

    struct buffDelayData
        unit u
        integer buffType
    endstruct

    function RemoveBuffEnd takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local buffDelayData data = GetTimerData(t)
        call RemoveDebuff(data.u, data.buffType)
        call ReleaseTimer(t)
        set data.u = null
        call data.destroy()
        set t = null
    endfunction

    function RemoveBuffsDelayed takes unit u, integer buffType, real duration returns nothing
        local timer t = NewTimer()
        local buffDelayData data = buffDelayData.create()
        set data.u = u
        set data.buffType = buffType
        call SetTimerData(t, data)
        call TimerStart(t, duration, false, function RemoveBuffEnd)

        set t = null
    endfunction
endlibrary