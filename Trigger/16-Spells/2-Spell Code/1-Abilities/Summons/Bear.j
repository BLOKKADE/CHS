library Bear requires CustomState, SpellFormula
    function BearStats takes unit u, integer totalLevel returns nothing
        local integer summonLevel = IMaxBJ(totalLevel - 30, 0)
        local integer abilityLevel = IMinBJ(totalLevel, 30)

        call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u,0) + GetSpellValue(0, 11, abilityLevel) + (summonLevel * 200), 0)
        call BlzSetUnitAttackCooldown(u, BlzGetUnitAttackCooldown(u,0) * (8 / (8.9 + (totalLevel / 2))), 0)
        call BlzSetUnitArmor(u, BlzGetUnitArmor(u) + 20 * totalLevel)
        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + GetSpellValue(0, 60, abilityLevel) + (summonLevel * 1100))

        call UnitAddAbility(u, 'A06I')
        call SetUnitAbilityLevel(u, 'A06I', IMinBJ(R2I(totalLevel / 3), 60))

        call UnitAddAbility(u, 'A06S')
        call SetUnitAbilityLevel(u, 'A06S', IMinBJ(R2I(totalLevel / 3), 30))
    endfunction
endlibrary