library Prawn requires CustomState, SpellFormula
    function PrawnStats takes unit u, integer totalLevel returns nothing
        local integer summonLevel = IMaxBJ(totalLevel - 30, 0)
        local integer abilityLevel = IMinBJ(totalLevel, 30)

        call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u,0) + GetSpellValue(0, 11, abilityLevel) + (summonLevel * 200), 0)
        call BlzSetUnitAttackCooldown(u, BlzGetUnitAttackCooldown(u,0) * (8 / (8.9 + (totalLevel / 2))), 0)
        call BlzSetUnitArmor(u, BlzGetUnitArmor(u) + 30 * totalLevel)
        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + GetSpellValue(0, 60, abilityLevel) + (summonLevel * 1100))

        // 500 base mana + 200 per summon level, then fill it up
        call BlzSetUnitMaxMana(u, BlzGetUnitMaxMana(u) + 500 + (summonLevel * 200))
        call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MAX_MANA))

        call AddUnitCustomState(u, BONUS_MAGICRES, 1.75 * totalLevel)

        call UnitAddAbility(u, 'exBB')

        call UnitAddAbility(u, HARDENED_SKIN_ABILITY_ID)
        call SetUnitAbilityLevel(u, HARDENED_SKIN_ABILITY_ID, IMinBJ(R2I(totalLevel / 3), 30))

        call UnitAddAbility(u, WAR_STOMP_ABILITY_ID)
        call SetUnitAbilityLevel(u, WAR_STOMP_ABILITY_ID, abilityLevel)
        call IssueImmediateOrderById(u, 852127)
    endfunction
endlibrary