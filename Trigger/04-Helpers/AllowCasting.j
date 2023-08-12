library AllowCasting

    globals
        boolean array CurrentlyFighting
    endglobals

    private function CheckUnitGroup takes unit u returns boolean
        if(not(IsUnitInGroup(u,DuelingHeroes)!=true)) then
            return false
        endif
        if(not(IsPlayerInForce(GetOwningPlayer(u),RoundPlayersCompleted)==true)) then
            return false
        endif
        return true
    endfunction
    
    private function CheckUnit takes unit u returns boolean
        if (IsUnitInGroup(u, DuelWinnerDisabled)==true) then
            return true
        endif
        if((RectContainsUnit(RectMidArena,u)==true)) then
            return true
        endif
        if(CheckUnitGroup(u)) then
            return true
        endif
        return false
    endfunction
    
    function CheckIfCastAllowed takes unit u returns boolean
        if(not(BrStarted==false)) then
            return false
        endif
        if(not(ElimPvpStarted==false)) then
            return false
        endif
        if(not CheckUnit(u)) then
            return false
        endif
        if(not(GetUnitTypeId(u)!=SUDDEN_DEATH_UNIT_ID)) then
            return false
        endif
        if not DUMMIES.contains(GetUnitTypeId(u)) then
            return false
        endif	
        return true
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