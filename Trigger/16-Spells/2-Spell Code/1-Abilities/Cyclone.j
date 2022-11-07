library Cyclone requires AoeDamage
    private function timerCyclone takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit u = LoadUnitHandle(HT,GetHandleId(t),2)
        local unit caster = LoadUnitHandle(HT,GetHandleId(t),1)
        local integer ticks = LoadInteger(HT, GetHandleId(t), 3)
        
        if GetWidgetLife(u) > 0.45 then
            call AreaDamage(caster, GetUnitX(u), GetUnitY(u), GetUnitAbilityLevel(caster,CYCLONE_ABILITY_ID)* 10, 350, false, CYCLONE_ABILITY_ID)

            if ticks == 0 then
                set ticks = 15
                call MoveToPointAoE(caster, GetUnitX(u), GetUnitY(u), 350, false, Target_Enemy, false)
            endif
        else
            call FlushChildHashtable(HT,GetHandleId(t))
            call ReleaseTimer(t)
        endif
        
        set u = null
        set t = null
        set caster = null
    endfunction

    function Cyclone takes unit caster, real targetX, real targetY returns nothing
        local unit u = CreateUnit(GetOwningPlayer(caster), 'h01K', targetX, targetY, 0)
        local timer t = NewTimer()

        call UnitApplyTimedLife(u, 'BTLF', 10)
        call SaveUnitHandle(HT, GetHandleId(t), 1, caster)
        call SaveUnitHandle(HT, GetHandleId(t), 2, u)
        call SaveInteger(HT, GetHandleId(t), 3, 0)
        call TimerStart(t, 0.2, true, function timerCyclone)
            
        set u = null
        set t = null
    endfunction
endlibrary