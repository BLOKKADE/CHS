library WolfRider initializer init requires NewBonus
    globals
        real SpeedFreakLimit = 0.35
        HashTable SpeedFreakBonus
    endglobals

    private function StatCheck takes unit u, integer stat, integer value, integer highest returns nothing
        local integer bonus
        local integer hid = GetHandleId(u)
        if value < highest * SpeedFreakLimit then
            call AddUnitBonus(u, stat, 0 - SpeedFreakBonus[hid][stat])
            set bonus = R2I(highest * SpeedFreakLimit - (value - SpeedFreakBonus[hid][stat]))
            call AddUnitBonus(u, stat, bonus)
            set SpeedFreakBonus[hid][stat] = bonus
        endif
    endfunction

    function WolfRiderStatBonus takes unit u, integer hid returns nothing
        local integer str = GetHeroStr(u, true)
        local integer agi = GetHeroAgi(u, true)
        local integer int = GetHeroInt(u, true)

        if str > agi and str > int then
            call StatCheck(u, BONUS_AGILITY, agi, str)
            call StatCheck(u, BONUS_INTELLIGENCE, int, str)
        elseif agi > str and agi > int then
            call StatCheck(u, BONUS_STRENGTH, str, agi)
            call StatCheck(u, BONUS_INTELLIGENCE, int, agi)
        elseif int > str and int > agi then
            call StatCheck(u, BONUS_STRENGTH, str, int)
            call StatCheck(u, BONUS_AGILITY, agi, int)
        endif
    endfunction

    private function init takes nothing returns nothing
        set SpeedFreakBonus = HashTable.create()
    endfunction
endlibrary