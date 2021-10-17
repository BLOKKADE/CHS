scope KomosetCommand initializer init
    //===========================================================================
    private function KomosetIsGood takes nothing returns nothing
        call DestroyTrigger(GetTriggeringTrigger())
        call TriggerSleepAction(5.)
        call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "|cffff9100Komoset actually sucks.|r")
    endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        local integer i = 0
        
        loop
            call TriggerRegisterPlayerChatEvent(trg,Player(i),"komosetisgood", false)
            set i = i + 1   
            exitwhen i > 11
        endloop
        
        call TriggerAddAction(trg, function KomosetIsGood)
        set i = 0

        set trg = null
    endfunction
endscope