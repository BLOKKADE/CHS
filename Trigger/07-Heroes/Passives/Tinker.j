library Tinker requires TimerUtils
    struct TinkerData
        unit u
        integer xp
    endstruct

    function TinkerBonus takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local TinkerData td = GetTimerData(t)
        call AddHeroXP(td.u, td.xp, true)
        set td.u = null
        call ReleaseTimer(t)
        call td.destroy()
        set t = null
    endfunction

    function TinkerTimer takes unit u, integer xp returns nothing
        local timer t = NewTimer()
        local TinkerData td = TinkerData.create()
        set td.u = u
        set td.xp = xp
        call SetTimerData(t, td)
        call TimerStart(t, 0.1, false, function TinkerBonus)
        set t = null
    endfunction
endlibrary
