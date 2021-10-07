scope AbilityBuyToggle /*initializer init*/
    //===========================================================================
    /*globals
        boolean array MaxAbilityBuyEnabled
    endglobals
    
    private function MAxAbilityBuy takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        set HoldCtrl[pid] = HoldCtrl[pid] != true
        
        if HoldCtrl[pid] == false then
            if firstTime[pid] == false then
                call DisplayTimedTextToPlayer(Player(pid), 0, 0, 10, "|ccffdde31Max Buy|r: Enabled: You can now buy as much levels as you can pay for when you buy an |ccf9efd31ability|r/|ccf31b2fdtome|r/|ccf31fd86glory buff|r/|ccffdfa31creep upgrade|r (|ccffd3131max 1000|r).")
            else
                call DisplayTimedTextToPlayer(Player(pid), 0, 0, 10, "|ccffdde31Max Buy|r: Enabled")
            endif
        else
            call DisplayTimedTextToPlayer(Player(pid), 0, 0, 10, "|ccffd9431Max Buy|r: Disabled")
        endif
        set firstTime[pid] = true
    endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        local integer i = 0
        
        loop
            call TriggerRegisterPlayerChatEvent(trg,Player(i),"-mb",true)
            call TriggerRegisterPlayerChatEvent(trg,Player(i),"-maxbuy",true)
            set i = i + 1   
            exitwhen i > 11
        endloop
        
        call TriggerAddAction(trg, function MAxAbilityBuy)
        set i = 0

        set trg = null
    endfunction*/
endscope