library EventHelpers requires CustomGameEvent
    public function FireEventForAllPlayers takes integer ev, integer abilId, integer roundNumber, boolean pvp returns nothing
        local integer i = 0
        loop
            call CustomGameEvent_FireEvent(ev, EventInfo.createAll(Player(i), abilId, roundNumber, pvp))
            set i = i + 1
            exitwhen i == 8
        endloop
    endfunction
endlibrary
