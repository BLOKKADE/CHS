library Stomp requires RandomShit

    globals
        integer array AppliedSummonHitPoints
        integer array AppliedSummonArmor
        integer array AppliedSummonDamage
    endglobals

    function AddStompStats takes unit u returns nothing
    local integer pid   = GetPlayerId(GetOwningPlayer(u))
    local unit    hero  = PlayerHeroes[pid]
    local real     lvl  = GetHeroLevel(hero)
    local real  factor  = 0.5 + (0.5 * (lvl / 175.0))

    if GetUnitTypeId(u) == STOMP_TREE_UNIT_ID then
        // Hit Points
        if SummonHitPoints[pid] > AppliedSummonHitPoints[pid] then
            call SetUnitMaxHp(u, BlzGetUnitMaxHP(u) + R2I((SummonHitPoints[pid] - AppliedSummonHitPoints[pid]) * 200 * factor))
            set AppliedSummonHitPoints[pid] = SummonHitPoints[pid]
        endif

        // Armor
        if SummonArmor[pid] > AppliedSummonArmor[pid] then
            call BlzSetUnitArmor(u, BlzGetUnitArmor(u) + (SummonArmor[pid] - AppliedSummonArmor[pid]) * 2 * factor)
            set AppliedSummonArmor[pid] = SummonArmor[pid]
        endif

        // Damage
        if SummonDamage[pid] > AppliedSummonDamage[pid] then
            call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u, 0) + R2I(20 * (SummonDamage[pid] - AppliedSummonDamage[pid]) * factor), 0)
            set AppliedSummonDamage[pid] = SummonDamage[pid]
        endif
    endif

    set hero = null
    endfunction
    
endlibrary