scope NoBets initializer init
    //===========================================================================
    function NoBets takes Args args returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        if pid == 0 and RoundNumber < 5 then
            set udg_boolean13 = false
            call DisplayTimedTextToPlayer(Player(pid), 0, 0, 10, "|ccffdef31Betting disabled.|r")
            call DestroyTrigger(GetTriggeringTrigger())
        endif
    endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
        call Command.create(CommandHandler.NoBets).name("nobets").handles("nobets").handles("nb").help("nobets", "Disables betting if used before the first duel. (Player 1 only)")
    endfunction
endscope