library LevelUpStats initializer init requires Table
    globals
        HashTable LevelStatBonus

        private integer Strength = 0
        private integer Agility = 1
        private integer Intelligence = 2
    endglobals

    function GetStrengthLevelBonus takes unit u returns real
        return LevelStatBonus[GetHandleId(u)].real[Strength]
    endfunction

    function GetAgilityLevelBonus takes unit u returns real
        return LevelStatBonus[GetHandleId(u)].real[Agility]
    endfunction

    function GetIntelligenceLevelBonus takes unit u returns real
        return LevelStatBonus[GetHandleId(u)].real[Intelligence]
    endfunction

    function AddStrengthLevelBonus takes unit u, real amount returns nothing
        set LevelStatBonus[GetHandleId(u)].real[Strength] = LevelStatBonus[GetHandleId(u)].real[Strength] + amount
    endfunction

    function AddAgilityLevelBonus takes unit u, real amount returns nothing
        set LevelStatBonus[GetHandleId(u)].real[Agility] = LevelStatBonus[GetHandleId(u)].real[Agility] + amount
    endfunction

    function AddIntelligenceLevelBonus takes unit u, real amount returns nothing
        set LevelStatBonus[GetHandleId(u)].real[Intelligence] = LevelStatBonus[GetHandleId(u)].real[Intelligence] + amount
    endfunction

    private function init takes nothing returns nothing
        set LevelStatBonus = HashTable.create()
    endfunction
endlibrary