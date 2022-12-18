library AbsoluteLimit initializer init
    globals
        Table UnitAbsoluteLimit
    endglobals

    function GetHeroMaxAbsoluteAbility takes unit u returns integer
        return UnitAbsoluteLimit.integer[GetHandleId(u)]
    endfunction

    function AddHeroMaxAbsoluteAbility takes unit u returns boolean 
        if GetHeroMaxAbsoluteAbility(u) < 10 then
            set UnitAbsoluteLimit.integer[GetHandleId(u)] = UnitAbsoluteLimit.integer[GetHandleId(u)] + 1
            call DisplayTimedTextToPlayer(GetOwningPlayer(u), 0, 0, 10,("|cffffcc00An extra Absolute Ability slot is available."))
            return true
        else
            return false

        endif
    endfunction

    private function init takes nothing returns nothing
        set UnitAbsoluteLimit = Table.create()
    endfunction
endlibrary
