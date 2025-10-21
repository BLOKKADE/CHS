library BloodstoneHeal

    function BloodstoneHealTick takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer id = GetHandleId(t)
        local unit u = LoadUnitHandle(udg_Hash, id, StringHash("unit"))
        local real heal = LoadReal(udg_Hash, id, StringHash("healAmount")) / 40.0

        call SetUnitState(u, UNIT_STATE_LIFE, GetUnitState(u, UNIT_STATE_LIFE) + heal)
        call SaveReal(udg_Hash, id, StringHash("healAmount"), LoadReal(udg_Hash, id, StringHash("healAmount")) - heal)

        if LoadReal(udg_Hash, id, StringHash("healAmount")) <= 0.0 then
            call FlushChildHashtable(udg_Hash, id)
            call DestroyTimer(t)
        endif
    endfunction

    function StartBloodstoneHeal takes unit u, real hpLoss returns nothing
        local timer t = CreateTimer()
        call SetUnitState(u, UNIT_STATE_LIFE, RMaxBJ(GetUnitState(u, UNIT_STATE_LIFE) - hpLoss, 1.0))

        // Save double the loss for healing
        call SaveUnitHandle(udg_Hash, GetHandleId(t), StringHash("unit"), u)
        call SaveReal(udg_Hash, GetHandleId(t), StringHash("healAmount"), hpLoss * 2.0)
        call TimerStart(t, 0.25, true, function BloodstoneHealTick)
    endfunction

endlibrary
