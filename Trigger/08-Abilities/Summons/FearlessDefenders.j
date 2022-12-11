library FearlessDefenders requires CustomState, SpellFormula
    function FearlessDefendersStats takes unit u, integer heroLevel, integer totalLevel returns nothing
        local integer summonLevel = IMaxBJ(totalLevel - 30, 0)
        local integer abilityLevel = IMinBJ(totalLevel, 30)

        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u)- 500 + R2I((totalLevel * 10000)*(1 +(heroLevel * 0.038) )) )
        call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u,0) - 10 + R2I((totalLevel * 100)*(1 +(heroLevel * 0.038)) ),0)
        call SetWidgetLife(u, BlzGetUnitMaxHP(u))

        /*call UnitAddAbility(u, 'A06I')
        call SetUnitAbilityLevel(u, 'A06I', IMinBJ(R2I(totalLevel / 3), 60))*/
    endfunction
endlibrary