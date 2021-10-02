scope NoIncomeCommand initializer init
    //===========================================================================
    globals
        boolean array IncomeSpamDisabled
    endglobals
    function NoIncomeSpam takes nothing returns nothing
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
        local trigger trg = CreateTrigger()
        local integer i = 0
        
        loop
            call TriggerRegisterPlayerChatEvent(trg,Player(i),"-nis",true)
            call TriggerRegisterPlayerChatEvent(trg,Player(i),"-noincomespam",true)
            set i = i + 1
            exitwhen i > 11
        endloop
        
        call TriggerAddAction(trg, function NoIncomeSpam)
        set i = 0

        set trg = null
    endfunction
endscope