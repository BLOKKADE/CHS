library NoIncomeCommand initializer init requires Command
    //===========================================================================
    globals
        boolean array IncomeSpamDisabled
    endglobals
    function NoIncomeSpam takes Args args returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        set IncomeSpamDisabled[pid] = not IncomeSpamDisabled[pid]
        if IncomeSpamDisabled[pid] then
            call DisplayTimedTextToPlayer(Player(pid), 0, 0, 10, "|ccffdde31Income spam disabled.|r")
        else
            call DisplayTimedTextToPlayer(Player(pid), 0, 0, 10, "|ccf61fd31Income spam enabled.|r")
        endif
    endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
        call Command.create(CommandHandler.NoIncomeSpam).name("NoIncomeSpam").handles("NoIncomeSpam").handles("nis").handles("noincomespam").help("NoIncomeSpam", "Toggles income spam on or off.")
    endfunction
endlibrary