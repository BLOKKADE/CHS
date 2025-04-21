library Inferno requires CustomState, SpellFormula
    function InfernoStats takes unit u, integer totalLevel returns nothing
        local integer summonLevel = IMaxBJ(totalLevel - 30, 0)
        local integer abilityLevel = IMinBJ(totalLevel, 30)

        call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u,0) + GetSpellValue(50, 13, abilityLevel) + (totalLevel * 300), 0)
        call BlzSetUnitAttackCooldown(u, BlzGetUnitAttackCooldown(u,0) * (20.0 / (20.0 + (totalLevel / 2))), 0)
        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + GetSpellValue(0, 75, abilityLevel) + (summonLevel * 800))
        call BlzSetUnitArmor(u, BlzGetUnitArmor(u) + 20 * totalLevel)
        call AddUnitCustomState(u, BONUS_BLOCK, GetSpellValue(100, 10, abilityLevel) + (summonLevel * 300))
        call AddUnitCustomState(u, BONUS_MAGICRES,  totalLevel * 10)
        call AddUnitCustomState(u, BONUS_PHYSPOW, totalLevel * 3)
        call UnitAddAbility(u, 'ANpi')
        call SetAbilityRealField(u, 'ANpi', 1, ABILITY_RLF_DAMAGE_PER_INTERVAL, GetSpellValue(50, 15, IMinBJ(R2I(totalLevel / 2), 60)))
        call SetPlayerAbilityAvailable(GetOwningPlayer(u), 'ANpi', false)
        call SetPlayerAbilityAvailable(GetOwningPlayer(u), 'ANpi', true)
    endfunction
endlibrary