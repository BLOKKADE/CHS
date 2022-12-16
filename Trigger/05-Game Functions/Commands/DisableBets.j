library NoBets initializer init requires Command
    //===========================================================================
    function NoBets takes Args args returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        if pid == 0 and RoundNumber < 5 then
            set BettingEnabled = false
            call DisplayTimedTextToPlayer(Player(pid), 0, 0, 10, "|ccffdef31Betting disabled.|r")
            call DestroyTrigger(GetTriggeringTrigger())
        endif
    endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
        call Command.create(CommandHandler.NoBets).name("nobets").handles("nobets").handles("nb").help("nobets", "Disables betting if used before the first duel. (Player 1 only)")
    endfunction
endlibrary