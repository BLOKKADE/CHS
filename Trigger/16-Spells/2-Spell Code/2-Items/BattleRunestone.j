library BattleRunestone requires RuneInit

    function BattleRunestone takes unit u returns nothing
        local integer i = GetRandomInt(1,4)

        if i == 1 then
            call UnitAddItem(u, CreateRune(null, 0, 0, 0, u, Life_Rune_Id))
        elseif i == 2 then
            call UnitAddItem(u, CreateRune(null, 0, 0, 0, u, Defense_Rune_Id))
        elseif i == 3 then
            call UnitAddItem(u, CreateRune(null, 0, 0, 0, u, Power_Rune_Id))
        elseif i == 4 then
            call UnitAddItem(u, CreateRune(null, 0, 0, 0, u, Might_Rune_Id))
        endif
    endfunction
endlibrary