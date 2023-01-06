library LevelUpStats initializer init requires Table
    globals
        HashTable LevelStatBonus

        private integer Strength = 0
        private integer Agility = 1
        private integer Intelligence = 2
    endglobals

    function GetStatLevelBonus takes unit u, integer stat returns real
        return LevelStatBonus[GetHandleId(u)].real[stat]
    endfunction

    function AddStatLevelBonus takes unit u, integer stat, real amount returns nothing
        set LevelStatBonus[GetHandleId(u)].real[stat] = LevelStatBonus[GetHandleId(u)].real[stat] + amount
    endfunction

    function UpdateStatsOnLevelup takes unit u, integer levelsGained returns nothing
        local integer i = 0
        loop
            // TODO: add support for increasing base value of damage/armor too, not used yet though 
            if i == BONUS_STRENGTH then
                call SetHeroStr(u, GetHeroStr(u, false) + R2I(levelsGained * GetStatLevelBonus(u, i)), true)
            elseif i == BONUS_AGILITY then 
                call SetHeroAgi(u, GetHeroAgi(u, false) + R2I(levelsGained * GetStatLevelBonus(u, i)), true)
            elseif i == BONUS_INTELLIGENCE then
                call SetHeroInt(u, GetHeroInt(u, false) + R2I(levelsGained * GetStatLevelBonus(u, i)), true)
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