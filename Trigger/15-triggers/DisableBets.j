scope NoBets initializer init
    //===========================================================================
    function NoBets takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        if udg_integer02 < 5 then
            set udg_boolean13 = false
            call DisplayTimedTextToPlayer(Player(pid), 0, 0, 10, "|ccffdef31Betting disabled.|r")
            call DestroyTrigger(GetTriggeringTrigger())
        endif
    endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        local integer i = 0

        call TriggerRegisterPlayerChatEvent(trg,Player(0),"-nobets",true)
        
        call TriggerAddAction(trg, function NoBets)
        set i = 0

        set trg = null
    endfunction
endscope