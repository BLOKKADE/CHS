library SpiritWolf requires CustomState, SpellFormula
    function SpiritWolfStats takes unit u, integer totalLevel returns nothing
        local integer summonLevel = IMaxBJ(totalLevel - 30, 0)
        local integer abilityLevel = IMinBJ(totalLevel, 30)

        call BlzSetUnitBaseDamage(u,BlzGetUnitBaseDamage(u,0) + GetSpellValue(0, 8, abilityLevel) + summonLevel * 50,0)
        call AddUnitCustomState(u, BONUS_EVASION, 3 * totalLevel)
        call AddUnitCustomState(u, BONUS_MAGICRES, 1.5 * totalLevel)
        call BlzSetUnitAttackCooldown(u, BlzGetUnitAttackCooldown(u,0) * (8 / (8.9 + (totalLevel / 2))), 0)
        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + totalLevel * 600)
        call BlzSetUnitArmor(u, BlzGetUnitArmor(u) + 5 * totalLevel)

        call SetUnitVertexColor(u, 150, 150, 255, 128) 

        call UnitAddAbility(u, CRITICAL_STRIKE_ABILITY_ID)
        call SetUnitAbilityLevel(u, CRITICAL_STRIKE_ABILITY_ID, IMinBJ(R2I(totalLevel / 5), 30))
    endfunction
endlibrary