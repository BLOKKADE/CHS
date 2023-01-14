library FaerieDragon requires CustomState, SpellFormula
    function FaerieDragonStats takes unit u, integer totalLevel returns nothing
        local unit hero = PlayerHeroes[GetPlayerId(GetOwningPlayer(u))]
        //local integer summonLevel = IMaxBJ(totalLevel - 30, 0)
        //local integer abilityLevel = IMinBJ(totalLevel, 30)
        local integer heroLevel = GetHeroLevel(hero)
        

        call BlzSetUnitAttackCooldown(u, BlzGetUnitAttackCooldown(u, 0) * (8 / (8.9 + (heroLevel / 3))), 0)
        call SetUnitAbilityLevelSwapped('A000', u, R2I(heroLevel / 3))
        call SetUnitBonusReal(u, BONUS_ATTACK_SPEED, heroLevel * 0.03)

        set hero = null
    endfunction
endlibrary