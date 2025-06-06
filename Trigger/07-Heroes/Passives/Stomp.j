library Stomp requires RandomShit

    globals
        integer array AppliedSummonHitPoints
        integer array AppliedSummonArmor
        integer array AppliedSummonDamage
    endglobals

    function AddStompStats takes unit u returns nothing
        local integer pid = GetPlayerId(GetOwningPlayer(u))
        
        if GetUnitTypeId(u) == STOMP_TREE_UNIT_ID then
            if SummonHitPoints[pid] > AppliedSummonHitPoints[pid] then
                call SetUnitMaxHp(u, BlzGetUnitMaxHP(u) + (SummonHitPoints[pid] - AppliedSummonHitPoints[pid]) * 200)
                set AppliedSummonHitPoints[pid] = SummonHitPoints[pid]
            endif

            if SummonArmor[pid] > AppliedSummonArmor[pid] then
                call BlzSetUnitArmor(u, BlzGetUnitArmor(u) + (SummonArmor[pid] - AppliedSummonArmor[pid]) * 2)
                set AppliedSummonArmor[pid] = SummonArmor[pid]
            endif

            if SummonDamage[pid] > AppliedSummonDamage[pid] then
                call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u, 0) + (20 * (SummonDamage[pid] - AppliedSummonDamage[pid])), 0)
                set AppliedSummonDamage[pid] = SummonDamage[pid]
            endif
        endif
    endfunction

endlibrary