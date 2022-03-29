library Quilbeast requires CustomState, SpellFormula
    function QuilbeastStats takes unit u, integer totalLevel returns nothing
        local integer summonLevel = IMaxBJ(totalLevel - 30, 0)
        local integer abilityLevel = IMinBJ(totalLevel, 30)

        call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u, 0) + GetSpellValue(0, 8, abilityLevel) + (summonLevel * 100), 0)
        
        call BlzSetUnitRealField(u, ConvertUnitRealField('uhpr'), BlzGetUnitRealField(u, ConvertUnitRealField('uhpr')) + 25 * totalLevel)
        call BlzSetUnitAttackCooldown(u, BlzGetUnitAttackCooldown(u, 0)*(8 / (8.9 + (totalLevel / 2))), 0)
        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + totalLevel * 600)
        call BlzSetUnitArmor(u, BlzGetUnitArmor(u) + 5 * totalLevel)
        call AddUnitBlock(u, 30 * totalLevel)

        call UnitAddAbility(u, 'A0BF')
        call SetUnitAbilityLevel(u, 'A0BF', IMinBJ(R2I(totalLevel / 3), 60))
    endfunction
endlibrary