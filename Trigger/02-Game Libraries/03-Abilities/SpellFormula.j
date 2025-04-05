library SpellFormula initializer init requires AbilityData

    globals
        private HashTable SpellValueTable
        private constant integer MAX_LEVEL_LOW = 30

        //only used for summons
        private constant integer MAX_LEVEL_HIGH = 120
    endglobals

    function HasAbilityKeyLevelValue takes integer valueFactor, integer level returns boolean
        return SpellValueTable[valueFactor].integer[level] != 0
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

    function CalculateLevelValue takes integer valueFactor, integer level returns integer
        local integer prevValue = GetAbilityKeyLevelValue(valueFactor, level - 1)
        return CalculateValue(prevValue, valueFactor, level)
    endfunction

    function EnsureValueCalculated takes integer valueFactor, integer level returns nothing
        local integer i = 1
        local integer maxLevel = 0

        if level < MAX_LEVEL_LOW then
            set maxLevel = MAX_LEVEL_LOW
        else
            set maxLevel = MAX_LEVEL_HIGH
        endif

        if not HasAbilityKeyLevelValue(valueFactor, 0) then
            call SetAbilityKeyLevelValue(valueFactor, 0, 0)
        endif

        loop
            exitwhen i > level or i > maxLevel
            if not HasAbilityKeyLevelValue(valueFactor, i) then
                call SetAbilityKeyLevelValue(valueFactor, i, CalculateLevelValue(valueFactor, i))
            endif
            set i = i + 1
        endloop
    endfunction

    //============================================================================
    //calculates ability damage and other values using the world editor object editor formula
    //stores calculated values in a table so it doesnt need to be recalculated
    function GetSpellValue takes integer valueInit, integer valueFactor, integer level returns integer
        if level <= 1 then
            return valueInit
        endif

        call EnsureValueCalculated(valueFactor, level)

        return GetAbilityKeyLevelValue(valueFactor, level) + valueInit - valueFactor
    endfunction

    private function init takes nothing returns nothing
        set SpellValueTable = HashTable.create()
    endfunction
endlibrary