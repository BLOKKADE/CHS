library Utility

    function GetHeroPrimaryStat takes unit u returns integer
        local integer i = BlzGetUnitIntegerField(u, UNIT_IF_PRIMARY_ATTRIBUTE)
        if i == 1 then
            return 0
        elseif i == 2 then
            return 2
        else
            return 1
        endif
    endfunction

    function IsPrimaryStat takes unit u, integer stat returns boolean
        local integer i = BlzGetUnitIntegerField(u, UNIT_IF_PRIMARY_ATTRIBUTE)
        return (i == 1 and stat == 0) or (i == 2 and stat == 2) or (i == 3 and stat == 1)
    endfunction

    function HasPlayerFinishedLevel takes unit u, player p returns boolean
        return IsPlayerInForce(p,udg_force03) and udg_boolean02 == false and udg_units03[2] != u and udg_units03[1] != u
    endfunction

    function CalculateNewCurrentHP takes unit u, real hpBonus returns nothing
        call SetUnitState(u, UNIT_STATE_LIFE, GetUnitState(u, UNIT_STATE_LIFE) * (BlzGetUnitMaxHP(u) / (BlzGetUnitMaxHP(u) - hpBonus)))
    endfunction
endlibrary