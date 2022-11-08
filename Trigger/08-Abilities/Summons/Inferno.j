library Inferno requires CustomState, SpellFormula
    function InfernoStats takes unit u, integer totalLevel returns nothing
        local integer summonLevel = IMaxBJ(totalLevel - 30, 0)
        local integer abilityLevel = IMinBJ(totalLevel, 30)

        call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u,0) + GetSpellValue(50, 13, abilityLevel) + (summonLevel * 300), 0)
        call BlzSetUnitAttackCooldown(u, BlzGetUnitAttackCooldown(u,0) * (20.0 / (20.0 + (totalLevel / 2))), 0)
        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + GetSpellValue(0, 75, abilityLevel) + (summonLevel * 800))
        call BlzSetUnitArmor(u, BlzGetUnitArmor(u) + 5 * totalLevel)
        
        call UnitAddAbility(u, 'ANpi')
        call SetAbilityRealField(u, 'ANpi', 1, ABILITY_RLF_DAMAGE_PER_INTERVAL, GetSpellValue(50, 15, IMinBJ(R2I(totalLevel / 2), 60)))
        call SetPlayerAbilityAvailable(GetOwningPlayer(u), 'ANpi', false)
        call SetPlayerAbilityAvailable(GetOwningPlayer(u), 'ANpi', true)
    endfunction
endlibrary