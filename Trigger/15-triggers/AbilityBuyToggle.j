scope AbilityBuyToggle initializer init
//===========================================================================
    globals
        boolean array MaxAbilityBuyEnabled
    endglobals
    
    private function MAxAbilityBuy takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        if udg_boolean05 == false then
            set MaxAbilityBuyEnabled[pid] = not MaxAbilityBuyEnabled[pid]
            if MaxAbilityBuyEnabled[pid] then
                call DisplayTimedTextToPlayer(Player(pid), 0, 0, 10, "|ccffdde31Max Ability Buy enabled|r: You now buy as much levels as you can pay for with lumber when you buy an ability.")
            else
                call DisplayTimedTextToPlayer(Player(pid), 0, 0, 10, "|ccffdde31Max Ability Buy disabled|r: You now buy 1 level of an ability.")
            endif
        else
            call DisplayTimedTextToPlayer(Player(pid), 0, 0, 10, "|ccfff6d6dMax Ability Buy is only available in ability pick mode|r")
        endif
    endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        local integer i = 0
        
        loop
            call TriggerRegisterPlayerChatEvent(trg,Player(i),"-mab",true)
            call TriggerRegisterPlayerChatEvent(trg,Player(i),"-maxabilitybuy",true)
            set i = i + 1
            exitwhen i>11
        endloop
        
        call TriggerAddAction(trg, function MAxAbilityBuy)
        set i = 0

        set trg = null
    endfunction
endscope