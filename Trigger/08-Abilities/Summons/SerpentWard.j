library SerpentWard requires CustomState, SpellFormula
    function SerpentWardStats takes unit u, integer totalLevel returns nothing
        local integer summonLevel = IMaxBJ(totalLevel - 30, 0)
        local integer abilityLevel = IMinBJ(totalLevel, 30)

       // call AddUnitCustomState(u, BONUS_MAGICPOW, 0.1 * totalLevel)

        call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u,0) + GetSpellValue(0, 7, abilityLevel) + (summonLevel * 30), 0)
        //call BlzSetUnitAttackCooldown(u, BlzGetUnitAttackCooldown(u,0) * (8 / (10.1 + (totalLevel / 2))), 0)
        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + totalLevel * 500)
        call BlzSetUnitArmor(u, BlzGetUnitArmor(u) + 5 * totalLevel)
        call UnitAddAbility(u, SUMMON_MAGIC_DMG_ABILITY_ID)

        call UnitAddAbility(u, MULTISHOT_ABILITY_ID)
        call SetUnitAbilityLevel(u, MULTISHOT_ABILITY_ID, IMinBJ(R2I(totalLevel / 20), 5))
    endfunction
endlibrary