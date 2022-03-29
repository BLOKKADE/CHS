library SummonParasite requires CustomState, SpellFormula
    function ParasiteStats takes unit u, integer totalLevel returns nothing
        local integer summonLevel = IMaxBJ(totalLevel - 30, 0)
        local integer abilityLevel = IMinBJ(totalLevel, 30)

        call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u,0) + GetSpellValue(0, 7, abilityLevel) + (summonLevel * 100), 0)
        call BlzSetUnitAttackCooldown(u, BlzGetUnitAttackCooldown(u,0) * (8 / (8.9 + (totalLevel / 2))), 0)
        call BlzSetUnitArmor(u, BlzGetUnitArmor(u) + 5 * totalLevel)
        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + totalLevel * 500)
        call AddUnitMagicDef(u,5 * totalLevel)
        call AddUnitEvasion(u,5 * totalLevel)

        /*call UnitAddAbility(u, 'A06I')
        call SetUnitAbilityLevel(u, 'A06I', IMinBJ(R2I(totalLevel / 3), 60))*/
    endfunction
endlibrary