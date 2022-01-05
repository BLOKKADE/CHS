library Utility requires NewBonus
    globals
        boolean array CurrentlyFighting
    endglobals
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

    function B2S takes boolean b returns string
        if b then
            return "true"
        else
            return "false"
        endif
    endfunction

    function SetCurrentlyFighting takes player p, boolean b returns nothing
        set CurrentlyFighting[GetPlayerId(p)] = b
        //call BJDebugMsg(GetPlayerName(p) + ", currently fighting: " + B2S(b))
    endfunction

    function SetAllCurrentlyFighting takes boolean b returns nothing
        local integer i = 0
        loop
            set CurrentlyFighting[i] = b
            //call BJDebugMsg(GetPlayerName(Player(i)) + ", currently fighting: " + B2S(b))
            set i = i + 1
            exitwhen i > 8
        endloop
    endfunction

    function HasPlayerFinishedLevel takes unit u, player p returns boolean
        return CurrentlyFighting[GetPlayerId(p)] == false
        //return (IsPlayerInForce(p,udg_force03) and udg_boolean02 == false and udg_units03[2] != u and udg_units03[1] != u and PvpPrepare = false) or BattleRoyal = true
    endfunction

    function GetUnitDamage takes unit u, integer weaponIndex returns real
        call BJDebugMsg(GetUnitName(u) + " attack dmg: " + R2S(BlzGetUnitBaseDamage(u, weaponIndex) + (BlzGetUnitDiceNumber(u, weaponIndex) * BlzGetUnitDiceSides(u, weaponIndex)) + GetUnitBonus(u, BONUS_DAMAGE)))
        return I2R((BlzGetUnitBaseDamage(u, weaponIndex) + (BlzGetUnitDiceNumber(u, weaponIndex) * BlzGetUnitDiceSides(u, weaponIndex))) + GetUnitBonus(u, BONUS_DAMAGE))
    endfunction

    function GetUnitBaseDamage takes unit u, integer weaponIndex returns real
        call BJDebugMsg(GetUnitName(u) + " base attack dmg: " + R2S(BlzGetUnitBaseDamage(u, weaponIndex) + (BlzGetUnitDiceNumber(u, weaponIndex) * BlzGetUnitDiceSides(u, weaponIndex))))
        return I2R((BlzGetUnitBaseDamage(u, weaponIndex) + (BlzGetUnitDiceNumber(u, weaponIndex) * BlzGetUnitDiceSides(u, weaponIndex))))
    endfunction

    function CalculateNewCurrentHP takes unit u, real hpBonus returns nothing
        local real multiplier = (BlzGetUnitMaxHP(u) / (BlzGetUnitMaxHP(u) - hpBonus))
        if multiplier > 1 then
            call SetUnitState(u, UNIT_STATE_LIFE, GetUnitState(u, UNIT_STATE_LIFE) * multiplier)
        endif
    endfunction
endlibrary