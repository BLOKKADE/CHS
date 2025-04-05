library Utility requires NewBonus, FixDeleteUnit
    function IsUnitExcluded takes unit u returns boolean
        return IsUnitType(u, UNIT_TYPE_STRUCTURE) or IsUnitType(u, UNIT_TYPE_HERO) or DUMMIES.contains(GetUnitTypeId(u)) or GetUnitTypeId(u) == FLYING_SHEEP_UNIT_ID
    endfunction

    private function RemoveUnitsFilter takes nothing returns boolean
        local unit u = GetFilterUnit()

        if UnitAlive(u) and GetOwningPlayer(u) != Player(11) and (not IsUnitExcluded(u)) then
            call DeleteUnit(u)
        endif

        set u = null
        return false
    endfunction

    private function RemoveUnitsFilterCreeps takes nothing returns boolean
        local unit u = GetFilterUnit()

        if UnitAlive(u) and (not IsUnitExcluded(u)) then
            call DeleteUnit(u)
        endif

        set u = null
        return false
    endfunction

    function RemovePlayerUnits takes player p returns nothing
        call GroupEnumUnitsOfPlayer(ENUM_GROUP, p, Condition(function RemoveUnitsFilter))
    endfunction

    function RemoveUnitsInRectCreeps takes rect r returns nothing
        call GroupEnumUnitsInRect(ENUM_GROUP, r, Condition(function RemoveUnitsFilterCreeps))
    endfunction

    function RemoveUnitsInRect takes rect r returns nothing
        call GroupEnumUnitsInRect(ENUM_GROUP, r, Condition(function RemoveUnitsFilter))
    endfunction

    function SaveHeroStrength takes unit u, integer i returns nothing
        call SaveInteger(HT, GetHandleId(u), 15, i)
    endfunction

    function GetHeroSavedStrength takes unit u returns integer
        return LoadInteger(HT, GetHandleId(u), 15)
    endfunction

    function CheckHpForReduction takes unit u, real hpLoss returns nothing
        if GetUnitState(u, UNIT_STATE_LIFE) < hpLoss + 1 then
            call SetUnitState(u, UNIT_STATE_LIFE, hpLoss + 1)
        endif
    endfunction

    function GetUnitDamage takes unit u, integer weaponIndex returns real
        //call BJDebugMsg(GetUnitName(u) + " attack dmg: " + R2S(BlzGetUnitBaseDamage(u, weaponIndex) + (BlzGetUnitDiceNumber(u, weaponIndex) * BlzGetUnitDiceSides(u, weaponIndex)) + GetUnitBonus(u, BONUS_DAMAGE)))
        return I2R((BlzGetUnitBaseDamage(u, weaponIndex) + (BlzGetUnitDiceNumber(u, weaponIndex) * BlzGetUnitDiceSides(u, weaponIndex))) + GetUnitBonus(u, BONUS_DAMAGE))
    endfunction

    function GetUnitBaseDamage takes unit u, integer weaponIndex returns real
        //call BJDebugMsg(GetUnitName(u) + " base attack dmg: " + R2S(BlzGetUnitBaseDamage(u, weaponIndex) + (BlzGetUnitDiceNumber(u, weaponIndex) * BlzGetUnitDiceSides(u, weaponIndex))))
        return I2R((BlzGetUnitBaseDamage(u, weaponIndex) + (BlzGetUnitDiceNumber(u, weaponIndex) * BlzGetUnitDiceSides(u, weaponIndex))))
    endfunction

    function CalculateNewCurrentHP takes unit u, real hpBonus returns nothing
        local real multiplier = (BlzGetUnitMaxHP(u) / (BlzGetUnitMaxHP(u) - hpBonus))
        if multiplier > 1 then
            call SetUnitState(u, UNIT_STATE_LIFE, GetUnitState(u, UNIT_STATE_LIFE) * multiplier)
        endif
    endfunction
endlibrary