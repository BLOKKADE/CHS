library MountainGiant requires CustomState, SpellFormula
    function MountainGiantStats takes unit u, integer totalLevel returns nothing
        local integer summonLevel = IMaxBJ(totalLevel - 30, 0)
        local integer abilityLevel = IMinBJ(totalLevel, 30)

        call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u,0) + GetSpellValue(0, 8, abilityLevel) + (summonLevel * 50), 0)
        call BlzSetUnitAttackCooldown(u, BlzGetUnitAttackCooldown(u,0) * (8 / (8.9 + (totalLevel / 2))), 0)
        call BlzSetUnitArmor(u, BlzGetUnitArmor(u) + 10 * totalLevel)
        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + GetSpellValue(0, 100, abilityLevel) + (summonLevel * 2000))
        call AddUnitCustomState(u, BONUS_BLOCK, GetSpellValue(200, 20, abilityLevel) + (500 * summonLevel))

        call SetUnitAbilityLevel(u, 'A06H', IMinBJ(R2I(totalLevel / 3), 60))
        call IssueImmediateOrderById(u, 852520)
    endfunction
endlibrary