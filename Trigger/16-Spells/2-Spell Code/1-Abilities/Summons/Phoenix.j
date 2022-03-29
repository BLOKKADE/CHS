library Phoenix requires CustomState, SpellFormula
    function PhoenixStats takes unit u, integer totalLevel returns nothing
        local integer summonLevel = IMaxBJ(totalLevel - 30, 0)
        local integer abilityLevel = IMinBJ(totalLevel, 30)

        call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u,0) + GetSpellValue(50, 11, abilityLevel) + (summonLevel * 150), 0)
        call BlzSetUnitAttackCooldown(u, BlzGetUnitAttackCooldown(u,0) * (7 / (12.1 + (totalLevel / 2))), 0)
        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + GetSpellValue(0, 50, abilityLevel) + (summonLevel * 1000))
        call BlzSetUnitArmor(u, BlzGetUnitArmor(u) + 5 * totalLevel)
        /*call UnitAddAbility(u, 'A06I')
        call SetUnitAbilityLevel(u, 'A06I', IMinBJ(R2I(totalLevel / 3), 60))*/

        call SetAbilityRealField(u, 'Apxf', 1, ABILITY_RLF_DAMAGE_PER_SECOND_PXF2, GetSpellValue(5, 8, IMinBJ(R2I(totalLevel / 2), 60)))
        call SetAbilityRealField(u, 'Apxf', 1, ABILITY_RLF_INITIAL_DAMAGE_PXF1, GetSpellValue(50, 16, IMinBJ(R2I(totalLevel / 2), 60)))

        call SetPlayerAbilityAvailable(GetOwningPlayer(u), 'Apxf', false)
        call SetPlayerAbilityAvailable(GetOwningPlayer(u), 'Apxf', true)
    endfunction
endlibrary