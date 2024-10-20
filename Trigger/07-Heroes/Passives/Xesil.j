library Xesil requires RandomShit

    private struct XesilData
        unit u
        real manaCost
    endstruct

    private function DoManaCostNegation takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local XesilData timerData = GetTimerData(t)

        call SetUnitState(timerData.u, UNIT_STATE_MANA, GetUnitState(timerData.u, UNIT_STATE_MANA) + timerData.manaCost)

        set timerData.u = null
        call timerData.destroy()
        call ReleaseTimer(t)
        set t = null
    endfunction

    function ActivateXesilManaCostNegation takes unit u, integer abilId, integer lvl returns nothing
        local timer t = NewTimer()
        local XesilData timerData = XesilData.create()
        set timerData.u = u
        set timerData.manaCost = BlzGetUnitAbilityManaCost(u, abilId, lvl - 1)
        call SetTimerData(t, timerData)
        call TimerStart(t, 0.01, false, function DoManaCostNegation)

        set t = null
    endfunction
endlibrary