library SpellFormula initializer init requires AbilityData

    globals
        private HashTable SpellValueTable
    endglobals

    function HasAbilityKeyLevelValue takes integer valueFactor, integer level returns boolean
        return level == 0 or SpellValueTable[valueFactor].integer[level] != 0
    endfunction

    function GetAbilityKeyLevelValue takes integer valueFactor, integer level returns integer
        return SpellValueTable[valueFactor].integer[level]
    endfunction

    function SetAbilityKeyLevelValue takes integer valueFactor, integer level, integer value returns nothing
        set SpellValueTable[valueFactor].integer[level] = value
    endfunction

    function CalculateValue takes integer prevValue, integer valueFactor, integer level returns integer
        return prevValue + (valueFactor * level)
    endfunction

    //TODO optimise this
    function CalculateValues takes integer valueFactor, integer level returns nothing
        local integer i = 1
        call SetAbilityKeyLevelValue(valueFactor, 0, 0)

        if level < 30 then
            loop
                call SetAbilityKeyLevelValue(valueFactor, i, CalculateValue(GetAbilityKeyLevelValue(valueFactor, i - 1), valueFactor, i))
                set i = i + 1
                exitwhen i > 30
            endloop
        else
            loop
                call SetAbilityKeyLevelValue(valueFactor, i, CalculateValue(GetAbilityKeyLevelValue(valueFactor, i - 1), valueFactor, i))
                set i = i + 1
                exitwhen i > 120
            endloop
        endif
    endfunction
    //============================================================================
    //calculates ability damage and other values using the world editor object editor formula
    //stores calculated values in a table so it doesnt need to be recalculated
        function GetSpellValue takes integer valueInit, integer valueFactor, integer level returns integer
            if not HasAbilityKeyLevelValue(valueFactor, level) then
                call CalculateValues(valueFactor, level)
            endif

            return (GetAbilityKeyLevelValue(valueFactor, level)) + valueInit
        endfunction

        private function init takes nothing returns nothing
            set SpellValueTable = HashTable.create()
        endfunction
    endlibrary