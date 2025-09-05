library ForcedTauntSystem initializer InitForcedTauntSystem

    globals
        constant real TAUNT_INTERVAL = 0.25
        constant real TAUNT_RADIUS = 500.0
        constant integer MAX_TAUNTS = 100
        constant integer MAX_WAVES = 4
        constant real WAVE_INTERVAL = 10.0

        unit array tauntTarget
        unit array tauntGiant
        integer array tauntTicks
        integer array tauntMaxTicks
        integer array tauntWave
        timer array tauntTimer
        integer tauntCount = 0

        hashtable TauntTable = InitHashtable()
    endglobals

    function TauntTick takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer i = 0

        loop
            exitwhen i >= tauntCount

            if tauntTimer[i] == t then
                if tauntTicks[i] >= tauntMaxTicks[i] or not IsUnitAliveBJ(tauntTarget[i]) or not IsUnitAliveBJ(tauntGiant[i]) then
                    call PauseTimer(t)
                    call DestroyTimer(t)

                    // Shift remaining taunts down
                    set tauntTarget[i] = tauntTarget[tauntCount - 1]
                    set tauntGiant[i] = tauntGiant[tauntCount - 1]
                    set tauntTicks[i] = tauntTicks[tauntCount - 1]
                    set tauntMaxTicks[i] = tauntMaxTicks[tauntCount - 1]
                    set tauntWave[i] = tauntWave[tauntCount - 1]
                    set tauntTimer[i] = tauntTimer[tauntCount - 1]
                    set tauntCount = tauntCount - 1
                    return
                endif

                call IssueTargetOrder(tauntTarget[i], "attack", tauntGiant[i])
                set tauntTicks[i] = tauntTicks[i] + 1
                return
            endif

            set i = i + 1
        endloop
    endfunction

    function StartForcedTaunt takes unit giant, unit target, integer wave returns nothing
        local real duration = 0.0
        local integer ticks

        if tauntCount >= MAX_TAUNTS then
            return
        endif

        if IsUnitType(target, UNIT_TYPE_HERO) then
            set duration = 4.0
        else
            set duration = 6.0
        endif

        set ticks = R2I(duration / TAUNT_INTERVAL)

        set tauntTarget[tauntCount] = target
        set tauntGiant[tauntCount] = giant
        set tauntTicks[tauntCount] = 0
        set tauntMaxTicks[tauntCount] = ticks
        set tauntWave[tauntCount] = wave
        set tauntTimer[tauntCount] = CreateTimer()
        call TimerStart(tauntTimer[tauntCount], TAUNT_INTERVAL, true, function TauntTick)
        set tauntCount = tauntCount + 1
    endfunction

    function TauntWave takes unit caster, integer wave returns nothing
        local group g = CreateGroup()
        local unit u

        call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), TAUNT_RADIUS, null)

        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            call GroupRemoveUnit(g, u)

            if IsUnitAliveBJ(u) and IsUnitEnemy(u, GetOwningPlayer(caster)) then
                if GetUnitTypeId(u) != SHADE_BR_RESPAWN_UNIT_ID then
                    call StartForcedTaunt(caster, u, wave)
                endif
            endif
        endloop

        call DestroyGroup(g)
    endfunction

    function TauntWaveRepeat takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer wave = LoadInteger(TauntTable, GetHandleId(t), 0)
        local unit caster = LoadUnitHandle(TauntTable, GetHandleId(t), 1)

        if wave < MAX_WAVES then
            call TauntWave(caster, wave)
            call SaveInteger(TauntTable, GetHandleId(t), 0, wave + 1)
            call TimerStart(t, WAVE_INTERVAL, false, function TauntWaveRepeat)
        else
            call FlushChildHashtable(TauntTable, GetHandleId(t))
            call DestroyTimer(t)
        endif
    endfunction

    function OnTauntCast takes unit caster returns nothing
        local timer t = CreateTimer()
        local integer id = GetHandleId(t)

        call SaveUnitHandle(TauntTable, id, 1, caster)
        call SaveInteger(TauntTable, id, 0, 1)
        call TauntWave(caster, 1)
        call TimerStart(t, WAVE_INTERVAL, false, function TauntWaveRepeat)
    endfunction

    function InitForcedTauntSystem takes nothing returns nothing
        // Nothing needed here for now
    endfunction

endlibrary
