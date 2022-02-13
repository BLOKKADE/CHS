library SpellFormula initializer init requires AbilityData

    globals
        private HashTable SpellValueTable
    endglobals

    function HasAbilityKeyLevelValue takes integer valueFactor, integer level returns boolean
        call BJDebugMsg("has? fctr: " + I2S(valueFactor) + " lvl: " + I2S(level) + " bool: " + B2S(SpellValueTable[valueFactor].integer[level] != 0))
        return level == 0 or SpellValueTable[valueFactor].integer[level] != 0
    endfunction

    function GetAbilityKeyLevelValue takes integer valueFactor, integer level returns integer
        call BJDebugMsg("get fctr: " + I2S(valueFactor) + " lvl: " + I2S(level) + " value: " + R2S(SpellValueTable[valueFactor].integer[level]))
        return SpellValueTable[valueFactor].integer[level]
    endfunction

    function SetAbilityKeyLevelValue takes integer valueFactor, integer level, integer value returns nothing
        set SpellValueTable[valueFactor].integer[level] = value
        call BJDebugMsg("set fctr: " + I2S(valueFactor) + " lvl: " + I2S(level) + " value: " + I2S(SpellValueTable[valueFactor].integer[level]))
    endfunction

    function CalculateValue takes integer prevValue, integer valueFactor, integer level returns integer
        return prevValue + (valueFactor * level)
    endfunction

    function CalculateValues takes integer valueFactor, integer level returns nothing
        local integer i = 1

        if HasAbilityKeyLevelValue(valueFactor, level - 1) then
            call SetAbilityKeyLevelValue(valueFactor, i, CalculateValue(GetAbilityKeyLevelValue(valueFactor, i - 1), valueFactor, i))
        else

            loop
                if not HasAbilityKeyLevelValue(valueFactor, i) then
                    call SetAbilityKeyLevelValue(valueFactor, i, CalculateValue(GetAbilityKeyLevelValue(valueFactor, i - 1), valueFactor, i))
                endif
                set i = i + 1
                exitwhen i > level
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