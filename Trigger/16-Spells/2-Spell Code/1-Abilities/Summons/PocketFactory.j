library PocketFactory requires CustomState, SpellFormula
    function PocketFactoryStats takes unit u, integer totalLevel returns nothing
        local integer summonLevel = IMaxBJ(totalLevel - 30, 0)
        local integer abilityLevel = IMinBJ(totalLevel, 30)
        
        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + GetSpellValue(0, 150, abilityLevel) + (summonLevel * 3000))
        call BlzSetUnitArmor(u, BlzGetUnitArmor(u) + 20 * totalLevel)
        call AddUnitCustomState(u, BONUS_MAGICRES, 10 * totalLevel)
    endfunction
endlibrary