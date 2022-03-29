library ClockwerkGoblin requires CustomState, SpellFormula
    function ClockwerkGoblinStats takes unit u, integer totalLevel returns nothing
        local integer summonLevel = IMaxBJ(totalLevel - 30, 0)
        local integer abilityLevel = IMinBJ(totalLevel, 30)

        call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u,0) + GetSpellValue(0, 9, abilityLevel) + (summonLevel * 50), 0)
        call BlzSetUnitAttackCooldown(u, BlzGetUnitAttackCooldown(u,0) * (8 / (8.9 + (totalLevel / 2))), 0)
        call BlzSetUnitArmor(u, BlzGetUnitArmor(u) + 5 * totalLevel)
        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + totalLevel * 500)
        call AddUnitMagicDmg(u, 45 * totalLevel)
        call AddUnitMagicDef(u, 5 * totalLevel)
        call AddUnitEvasion(u, 5 * totalLevel)

        call SetUnitAbilityLevel(u, 'A00P', abilityLevel)
    endfunction
endlibrary