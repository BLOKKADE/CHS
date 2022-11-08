library BattleRunestone initializer init requires RuneInit

    globals
        Table BattleRuneStoneCount
    endglobals

    function ActivateStatRune takes unit u returns nothing
        local integer i = GetRandomInt(1,3)

        if i == 1 then
            call UnitAddItem(u, CreateRune(null, 0, 0, 0, u, Life_Rune_Id))
        elseif i == 2 then
            call UnitAddItem(u, CreateRune(null, 0, 0, 0, u, Power_Rune_Id))
        elseif i == 3 then
            call UnitAddItem(u, CreateRune(null, 0, 0, 0, u, Might_Rune_Id))
        endif
    endfunction

    function CheckBattleRunestoneCount takes unit u, integer hid returns nothing
        if BattleRuneStoneCount[hid] == 1 then
            set BattleRuneStoneCount[hid] = 0
            call ActivateStatRune(u)
        else
            set BattleRuneStoneCount[hid] = BattleRuneStoneCount[hid] + 1
        endif
    endfunction

    private function init takes nothing returns nothing
        set BattleRuneStoneCount = Table.create()
    endfunction
endlibrary