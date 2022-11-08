library CarrionBeetle requires CustomState, SpellFormula
    function CarrionBeetleStats takes unit u, integer totalLevel returns nothing
        local integer summonLevel = IMaxBJ(totalLevel - 30, 0)
        local integer abilityLevel = IMinBJ(totalLevel, 30)

        call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u,0) + GetSpellValue(0, 9, abilityLevel) + (summonLevel * 150), 0)
        call BlzSetUnitAttackCooldown(u, BlzGetUnitAttackCooldown(u,0) * (8 / (8.9 + (totalLevel / 2))), 0)
        call BlzSetUnitArmor(u, BlzGetUnitArmor(u) + 10 * totalLevel)
        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + totalLevel * 400)
        call AddUnitCustomState(u, BONUS_BLOCK, GetSpellValue(100, 10, abilityLevel) + (summonLevel * 200))
        call AddUnitCustomState(u, BONUS_MAGICRES,totalLevel * 2)
        call AddUnitCustomState(u, BONUS_EVASION,totalLevel * 2)

        call UnitAddAbility(u, CARBEE_SPIKED_CARAP_ABILITY_ID)
        call SetUnitAbilityLevel(u, CARBEE_SPIKED_CARAP_ABILITY_ID, IMinBJ(R2I(totalLevel / 2), 30))
        call AddUnitBonus(u, BONUS_ARMOR, IMinBJ(R2I(totalLevel / 2), 30) * 4)
    endfunction
endlibrary