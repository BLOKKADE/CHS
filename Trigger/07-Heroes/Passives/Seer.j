library Seer requires DamageEngineHelpers
    function IsSeerPassiveActivated takes integer unitTypeId, unit source returns boolean
        return unitTypeId == SEER_UNIT_ID and IsMagicDamage() and GetRandomReal(0, 100) <= 20 + 0.33 * I2R(GetHeroLevel(source))
    endfunction
endlibrary
