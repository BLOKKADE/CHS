library LevelUpStats initializer init requires Table
    globals
        HashTable LevelStatBonus
    endglobals

    function GetStatLevelBonus takes unit u, integer stat returns integer
        return LevelStatBonus[GetHandleId(u)].integer[stat]
    endfunction

    function AddStatLevelBonus takes unit u, integer stat, integer amount returns nothing
        set LevelStatBonus[GetHandleId(u)].integer[stat] = LevelStatBonus[GetHandleId(u)].integer[stat] + amount
    endfunction

    function UpdateStatsOnLevelup takes unit u, integer levelsGained returns nothing
        local integer i = 0
        loop
            // TODO: add support for increasing base value of damage/armor too, not used yet though 
            if i == BONUS_STRENGTH or i == BONUS_AGILITY or i == BONUS_INTELLIGENCE then
                call AddUnitBonus(u, i, levelsGained * GetStatLevelBonus(u, i))
            else
                call AddUnitCustomState(u, i, levelsGained * GetStatLevelBonus(u, i))
            endif
            set i = i + 1
            exitwhen i > STAT_BONUS_COUNT
        endloop
    endfunction

    private function init takes nothing returns nothing
        set LevelStatBonus = HashTable.create()
    endfunction
endlibrary