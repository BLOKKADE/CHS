library BlackArrowRangedSkeleton requires CustomState, SpellFormula
    function BlackArrowRangedSkeletonStats takes unit u, integer totalLevel returns nothing
        local integer summonLevel = IMaxBJ(totalLevel - 30, 0)
        local integer abilityLevel = IMinBJ(totalLevel, 30)

        call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u,0) + GetSpellValue(0, 9, abilityLevel) + (summonLevel * 60), 0)
        call BlzSetUnitAttackCooldown(u, BlzGetUnitAttackCooldown(u,0) * (8. / (8. + (totalLevel / 2))), 0)
        call BlzSetUnitArmor(u, BlzGetUnitArmor(u) + 5 * totalLevel)
        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + totalLevel * 500)
        call AddUnitCustomState(u, BONUS_MAGICRES,5 * totalLevel)
        //call AddUnitCustomState(u, BONUS_MAGICPOW, 0.1 * totalLevel)
        //call AddUnitCustomState(u, BONUS_EVASION,5 * totalLevel)
        //call UnitAddAbility(u, SUMMON_MAGIC_DMG_ABILITY_ID)

        /*call UnitAddAbility(u, 'A06I')
        call SetUnitAbilityLevel(u, 'A06I', IMinBJ(R2I(totalLevel / 3), 60))*/
    endfunction
endlibrary