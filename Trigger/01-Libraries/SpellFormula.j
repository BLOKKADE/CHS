library SpellFormula initializer init requires AbilityData

    globals
        private HashTable SpellValueHashTable
    endglobals

    function HasAbilityKeyLevelValue takes integer valueInit, integer valueFactor, integer level returns boolean
        return SpellValueHashTable[valueInit][valueFactor] != 0 and SpellValueHashTable[valueInit][valueFactor].real[level] != 0
    endfunction

    function GetAbilityKeyLevelValue takes integer valueInit, integer valueFactor, integer level returns real
        return SpellValueHashTable[valueInit][valueFactor].real[level]
    endfunction

    function SetAbilityKeyLevelValue takes integer valueInit, integer valueFactor, integer level, real value returns nothing
        if SpellValueHashTable[valueInit][valueFactor] == 0 then
            set SpellValueHashTable[valueInit][valueFactor] = Table.create()
        endif
        set SpellValueHashTable[valueInit][valueFactor].real[level] = value
    endfunction

    function CalculateValue takes real prevValue, real valueInit, real valueFactor, integer level returns real
        if prevValue != 0 then
            return prevValue + (valueFactor * level)
        else
            return valueInit
        endif
    endfunction

    function CalculateValues takes integer valueInit, integer valueFactor returns nothing
        local integer i = 1

        loop
            call SetAbilityKeyLevelValue(valueInit, valueFactor, i, CalculateValue(GetAbilityKeyLevelValue(valueInit, valueFactor, i - 1), valueInit, valueFactor, i))
            set i = i + 1
            exitwhen i > 30
        endloop
    endfunction
    //============================================================================
    //calculates ability damage and other values using the world editor object editor formula
    //stores calculated values in a table so it doesnt need to be recalculated
        function GetSpellValue takes integer valueInit, integer valueFactor, integer level returns integer
            if not HasAbilityKeyLevelValue(valueInit, valueFactor, level) then
                call CalculateValues(valueInit, valueFactor)
            endif

            return R2I(GetAbilityKeyLevelValue(valueInit, valueFactor, level))
        endfunction

        private function init takes nothing returns nothing
            set SpellValueHashTable = HashTable.create()
        endfunction
    endlibrary