library Hawk requires CustomState, SpellFormula
    function HawkStats takes unit u, integer totalLevel returns nothing
        local integer summonLevel = IMaxBJ(totalLevel - 30, 0)
        local integer abilityLevel = IMinBJ(totalLevel, 30)

        call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u,0) + GetSpellValue(0, 9, abilityLevel) + (summonLevel * 150), 0)
        call BlzSetUnitAttackCooldown(u, BlzGetUnitAttackCooldown(u,0) * (7 / (12.1 + I2R(totalLevel))), 0)
        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + totalLevel * 800)
        call BlzSetUnitArmor(u, BlzGetUnitArmor(u) + 5 * totalLevel)
    endfunction
endlibrary