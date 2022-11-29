library WaterElemental requires CustomState, SpellFormula
    function WaterElementalStats takes unit u, integer totalLevel returns nothing
        local integer summonLevel = IMaxBJ(totalLevel - 30, 0)
        local integer abilityLevel = IMinBJ(totalLevel, 30)

        call BlzSetUnitBaseDamage(u,BlzGetUnitBaseDamage(u,0) + GetSpellValue(0, 8, abilityLevel) + (summonLevel * 100),0)
        call AddUnitCustomState(u, BONUS_MAGICRES,15 * totalLevel)
        call BlzSetUnitAttackCooldown(u,BlzGetUnitAttackCooldown(u,0)*(8 /(8.9 + I2R(totalLevel)))  ,0)
        call BlzSetUnitMaxHP(u,BlzGetUnitMaxHP(u)+ totalLevel * 700)
        call BlzSetUnitArmor(u, BlzGetUnitArmor(u) + 5 * totalLevel)

        call UnitAddAbility(u, ICE_ARMOR_SUMMON_ABILITY_ID)
        call SetUnitAbilityLevel(u, ICE_ARMOR_SUMMON_ABILITY_ID, abilityLevel)
    endfunction
endlibrary