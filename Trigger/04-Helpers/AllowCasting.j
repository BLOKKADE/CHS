library AllowCasting

    globals
        boolean array CurrentlyFighting
    endglobals

    private function IsUnitRestricted takes unit u returns boolean
        return IsUnitInGroup(u, DuelWinnerDisabled) or RectContainsUnit(RectMidArena, u)
    endfunction

    function IsCastingAllowed takes unit u returns boolean
        return BrStarted or not IsUnitRestricted(u) or GetUnitTypeId(u) == SUDDEN_DEATH_UNIT_ID or GetUnitTypeId(u) == PRIEST_1_UNIT_ID or (IsUnitInGroup(u, DuelingHeroes) and IsPlayerInForce(GetOwningPlayer(u), RoundPlayersCompleted))
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
            exitwhen i == 8
        endloop
    endfunction

    function HasPlayerFinishedLevel takes unit u, player p returns boolean
        return CurrentlyFighting[GetPlayerId(p)] == false
        //return (IsPlayerInForce(p,RoundPlayersCompleted) and BrStarted == false and DuelingHeroes[2] != u and DuelingHeroes[1] != u and PvpPrepare = false) or BattleRoyal = true
    endfunction
endlibrary