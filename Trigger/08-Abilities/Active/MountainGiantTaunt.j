library ForcedTauntSystem initializer InitForcedTauntSystem

    globals
        constant real TAUNT_INTERVAL = 0.167 // ~6 times per second
        constant real TAUNT_RADIUS = 400.0
        constant integer MAX_TAUNTS = 100
        constant integer MAX_WAVES = 5
        constant real WAVE_INTERVAL = 8.2

        unit array tauntTarget
        unit array tauntGiant
        integer array tauntTicks
        integer array tauntMaxTicks
        integer array tauntWave
        timer array tauntTimer
        integer array tauntOrigR
        integer array tauntOrigG
        integer array tauntOrigB
        integer array tauntColorPhase
        effect array tauntGlow
        integer tauntCount = 0

        hashtable TauntTable = InitHashtable()
    endglobals

    function TauntTick takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer i = 0
        local integer colorIndex

        loop
            exitwhen i >= tauntCount

            if tauntTimer[i] == t then
                if tauntTicks[i] >= tauntMaxTicks[i] or not IsUnitAliveBJ(tauntTarget[i]) or not IsUnitAliveBJ(tauntGiant[i]) then
                    call PauseTimer(t)
                    call DestroyTimer(t)

                    // Reset color
                    call SetUnitVertexColor(tauntTarget[i], tauntOrigR[i], tauntOrigG[i], tauntOrigB[i], 255)

                    // Remove glow effect
                    call DestroyEffect(tauntGlow[i])

                    // Shift remaining taunts down
                    set tauntTarget[i] = tauntTarget[tauntCount - 1]
                    set tauntGiant[i] = tauntGiant[tauntCount - 1]
                    set tauntTicks[i] = tauntTicks[tauntCount - 1]
                    set tauntMaxTicks[i] = tauntMaxTicks[tauntCount - 1]
                    set tauntWave[i] = tauntWave[tauntCount - 1]
                    set tauntTimer[i] = tauntTimer[tauntCount - 1]
                    set tauntOrigR[i] = tauntOrigR[tauntCount - 1]
                    set tauntOrigG[i] = tauntOrigG[tauntCount - 1]
                    set tauntOrigB[i] = tauntOrigB[tauntCount - 1]
                    set tauntColorPhase[i] = tauntColorPhase[tauntCount - 1]
                    set tauntGlow[i] = tauntGlow[tauntCount - 1]
                    set tauntCount = tauntCount - 1
                    return
                endif

                // Cycle between red, yellow, and orange
                set colorIndex = ModuloInteger(tauntColorPhase[i], 3)
                if colorIndex == 0 then
                    call SetUnitVertexColor(tauntTarget[i], 255, 0, 0, 255) // Red
                elseif colorIndex == 1 then
                    call SetUnitVertexColor(tauntTarget[i], 255, 255, 0, 255) // Yellow
                else
                    call SetUnitVertexColor(tauntTarget[i], 255, 165, 0, 255) // Orange
                endif
                set tauntColorPhase[i] = tauntColorPhase[i] + 1

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
        local sound shout = CreateSound("Sound\\Units\\Human\\HeroMountainKing\\MountainKingReady1.wav", false, false, false, 10, 10, "")

        if tauntCount >= MAX_TAUNTS then
            return
        endif

        if IsUnitType(target, UNIT_TYPE_HERO) then
            set duration = 3.0
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

        // Store original color (assumes default white)
        set tauntOrigR[tauntCount] = 255
        set tauntOrigG[tauntCount] = 255
        set tauntOrigB[tauntCount] = 255

        // Start color phase at 0
        set tauntColorPhase[tauntCount] = 0

        // Add Holy Bolt glow effect
        set tauntGlow[tauntCount] = AddSpecialEffectTarget("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl", target, "origin")

        // Play shout sound
        call StartSound(shout)

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
