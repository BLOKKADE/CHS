library WolfRider initializer init requires Stats
    globals
        real SpeedFreakLimit = 0.5
        HashTable SpeedFreakBonus
    endglobals

    private function StatCheck takes unit u, integer stat, integer value, integer highest returns nothing
        local integer bonus
        local integer hid = GetHandleId(u)
        if value < highest * SpeedFreakLimit then
            call UnitAddStat(u, stat, 0 - SpeedFreakBonus[hid][stat])
            set bonus = R2I(highest * SpeedFreakLimit - (value - SpeedFreakBonus[hid][stat]))
            call UnitAddStat(u, stat, bonus)
            set SpeedFreakBonus[hid][stat] = bonus
        endif
    endfunction

    function WolfRiderStatBonus takes unit u, integer hid returns nothing
        local integer str = GetHeroStr(u, true)
        local integer agi = GetHeroAgi(u, true)
        local integer int = GetHeroInt(u, true)

        if str > agi and str > int then
            call StatCheck(u, 1, agi, str)
            call StatCheck(u, 2, int, str)
        elseif agi > str and agi > int then
            call StatCheck(u, 0, str, agi)
            call StatCheck(u, 2, int, agi)
        elseif int > str and int > agi then
            call StatCheck(u, 0, str, int)
            call StatCheck(u, 1, agi, int)
        endif
    endfunction

    private function init takes nothing returns nothing
        set SpeedFreakBonus = HashTable.create()
    endfunction
endlibrary