library StartFunction requires TimerUtils, CustomGameEvent
    
    globals
        integer array RoundTimer
    endglobals

    private function StartRoundEvent takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer pid = GetTimerData(t)

        call CustomGameEvent_FireEvent(EVENT_PLAYER_ROUND_START, EventInfo.create(Player(pid), 0, RoundNumber))

        call ReleaseTimer(t)
        set t = null
    endfunction

    //i1 = 1 = battle royale
    //i1 = 2 = unused
    //i1 = 3 = pve round start
    //i1 = 4 = duels
    //i1 = 5 = elimination
    //i1 = 6 = urn/time manipulation
    function FireRoundStartEvent takes unit Hero, integer i1 returns nothing
        local timer t = NewTimerEx(GetPlayerId(GetOwningPlayer(Hero)))

        //for Wolf Rider passive, todo: refactor with event system
        set RoundTimer[GetPlayerId(GetOwningPlayer(Hero))] = T32_Tick + R2I(0.05 * 32)

        call TimerStart(t, 0.05, false, function StartRoundEvent)

        set t = null
    endfunction
endlibrary
