library SpellFormula initializer init requires AbilityData

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

    function CalculateValues takes integer abilId, integer valueKey, real initDamage, real factor returns nothing
        local integer i = 1

        loop
            call SetAbilityKeyLevelValue(abilId, valueKey, i, CalculateValue(GetAbilityKeyLevelValue(abilId, valueKey, i - 1), initDamage, factor, i))
            set i = i + 1
            exitwhen i > 30
        endloop
    endfunction
    //============================================================================
    //calculates ability damage and other values using the world editor object editor formula
    //stores calculated values in a table so it doesnt need to be recalculated
        function GetSpellValue takes integer abilId, integer valueKey, real initDamage, real factor, integer level returns integer
            local real damage
            local real prevDamage
            //local real damageNext
            //local integer levelRounded = MathRound_floor(level)
            //local real levelDecimals = level - levelRounded
            local integer i = 2

            //if levelDecimals == 0 then
            if not HasAbilityKeyLevelValue(abilId, valueKey, level) then
                call CalculateValues(abilId, valueKey, initDamage, factor)
            endif

            return R2I(GetAbilityKeyLevelValue(abilId, valueKey, level))
                /*
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
            endif*/
        endfunction

        private function init takes nothing returns nothing
            set SpellValueHashTable = HashTable.create()
        endfunction
    endlibrary