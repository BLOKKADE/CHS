library HpRegen requires NewBonus
    //see CustomState.j for negativehpregenfunctions
    function GetUnitPositiveHpRegen takes unit u returns real
        return GetUnitBonusReal(u, BONUS_HEALTH_REGEN)
    endfunction

    //cannot be lower than 0
    function GetUnitTotalHpRegen takes unit u returns real
        return RMaxBJ(GetUnitPositiveHpRegen(u) - GetUnitNegativeHpRegen(u), 0)
    endfunction
endlibrary