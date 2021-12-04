/*library SpellFormula initializer init requires AbilityData

    globals
        private HashTable SpellValueHashTable
    endglobals

    function HasAbilityKeyLevelValue takes integer abilId, integer valueKey, integer level returns boolean
        return SpellValueHashTable[abilId][valueKey] != 0 and SpellValueHashTable[abilId][valueKey].real[level] != 0
    endfunction

    function GetAbilityKeyLevelValue takes integer abilId, integer valueKey, integer level returns real
        return SpellValueHashTable[abilId][valueKey].real[level]
    endfunction

    function SetAbilityKeyLevelValue takes integer abilId, integer valueKey, integer level, real value returns nothing
        if SpellValueHashTable[abilId][valueKey] == 0 then
            set SpellValueHashTable[abilId][valueKey] = Table.create()
        endif
        set SpellValueHashTable[abilId][valueKey].real[level] = value
    endfunction

    function CalculateValue takes real prevDamage, real initDamage, real factor, integer level returns real
        if prevDamage != 0 then
            return prevDamage + (factor * level)
        else
            return initDamage
        endif
    endfunction
    //============================================================================
    //calculates ability damage and other values using the world editor object editor formula
    //stores calculated values in a table so it doesnt need to be recalculated
        function GetSpellValue takes integer abilId, integer valueKey, real initDamage, real factor, real level returns real
            local real damage
            local real damageNext
            local integer levelRounded = floor(level)
            local real levelDecimals = level - levelRounded
            local integer i = 2

            if levelDecimals == 0 then
                if HasAbilityKeyLevelValue(abilId, valueKey, levelRounded) then
                    return GetAbilityKeyLevelValue(abilId, valueKey, levelRounded)
                else
                    set damage = CalculateValue(GetAbilityKeyLevelValue(abilId, valueKey, levelRounded -1), initDamage, factor, levelRounded)
                    call SetAbilityKeyLevelValue(abilId, valueKey, levelRounded, damage)
                    return damage
                endif
            else
                if HasAbilityKeyLevelValue(abilId, valueKey, levelRounded) then
                    set damage = GetAbilityKeyLevelValue(abilId, valueKey, levelRounded)
                else
                    set damage = CalculateValue(GetAbilityKeyLevelValue(abilId, valueKey, levelRounded -1), initDamage, factor, levelRounded)
                    call SetAbilityKeyLevelValue(abilId, valueKey, levelRounded, damage)
                endif

                if HasAbilityKeyLevelValue(abilId, valueKey, levelRounded + 1) then
                    set damageNext = GetAbilityKeyLevelValue(abilId, valueKey, levelRounded + 1)
                else
                    set damageNext = CalculateValue(damage, initDamage, factor, levelRounded + 1)
                    call SetAbilityKeyLevelValue(abilId, valueKey, levelRounded + 1, damageNext)
                endif

                return damage + ((damageNext - damage) * levelDecimals)
            endif
        endfunction

        private function init takes nothing returns nothing
            set SpellValueHashTable = HashTable.create()
        endfunction
    endlibrary*/