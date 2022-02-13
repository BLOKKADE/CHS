library Skeleton requires CustomState, SpellFormula
    function SkeletonStats takes unit u, integer totalLevel returns nothing
        local integer summonLevel = IMaxBJ(totalLevel - 30, 0)
        local integer abilityLevel = IMinBJ(totalLevel, 30)

        call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u,0) + (summonLevel * 100), 0)
        call BlzSetUnitAttackCooldown(u, BlzGetUnitAttackCooldown(u,0) * (8 / (8.9 + I2R(totalLevel))), 0)
        call BlzSetUnitArmor(u, BlzGetUnitArmor(u) + 10 * totalLevel)
        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + totalLevel * 600)
        call AddUnitEvasion(u, 5 * totalLevel)
        call AddUnitMagicDef(u, 5 * totalLevel)

        /*call UnitAddAbility(u, 'A06I')
        call SetUnitAbilityLevel(u, 'A06I', IMinBJ(R2I(totalLevel / 3), 60))*/
    endfunction
endlibrary