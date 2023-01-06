library FearlessDefenders requires CustomState, SpellFormula
    function FearlessDefendersStats takes unit u, integer totalLevel returns nothing
        local integer summonLevel = IMaxBJ(totalLevel - 30, 0)
        local integer abilityLevel = IMinBJ(totalLevel, 30)
        local integer heroLevel = GetHeroLevel(PlayerHeroes[GetPlayerId(GetOwningPlayer(u))])

        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + R2I((totalLevel * 10000)*(1 +(heroLevel * 0.038) )) )
        call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u,0) - 10 + R2I((totalLevel * 100)*(1 +(heroLevel * 0.038)) ),0)
        call BlzSetUnitAttackCooldown(u, BlzGetUnitAttackCooldown(u,0) * (8 / (8.9 + (totalLevel / 2))), 0)

        /*call UnitAddAbility(u, 'A06I')
        call SetUnitAbilityLevel(u, 'A06I', IMinBJ(R2I(totalLevel / 3), 60))*/
    endfunction
endlibrary