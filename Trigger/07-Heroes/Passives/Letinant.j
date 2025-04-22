library Letinant initializer init requires HeroLvlTable
    globals
        Table LetinantStatBonus
    endglobals

    private function AddToStat takes unit u, integer bonus, integer stat returns nothing
        if stat == 1 then
            call SetHeroStr(u, GetHeroStr(u, false) + bonus, false)
            call UpdateBonus(u, 0, bonus)
        elseif stat == 2 then
            call SetHeroAgi(u, GetHeroAgi(u, false) + bonus, false)
            call UpdateBonus(u, 1, bonus)
        else
            call SetHeroInt(u, GetHeroInt(u, false) + bonus, false)
            call UpdateBonus(u, 2, bonus)
        endif
    endfunction

    function LetinantBonus takes unit u, integer levels returns nothing
        local integer bonus = 5 + ((GetHeroLevel(u) - ModuloInteger(GetHeroLevel(u), 10)) / 10)
        local integer i = 0
        local integer stat

        set LetinantStatBonus[GetHandleId(u)] = bonus
        call SetBonus(u, 3, bonus)

        loop
            call AddToStat(u, bonus, GetRandomInt(1, 3))
            call AddToStat(u, bonus, GetRandomInt(1, 3))

            set i = i + 1
            exitwhen i >= levels
        endloop
    endfunction

    private function init takes nothing returns nothing
        set LetinantStatBonus = Table.create()
    endfunction

endlibrary
