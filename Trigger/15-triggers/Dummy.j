scope DebugCommands initializer init
    globals
        integer PlayerCount
    endglobals
//===========================================================================
    function SpawnDummy takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        call CreateUnit(Player(8), 'hfoo', GetUnitX(udg_units01[pid+1]), GetUnitY(udg_units01[pid+1]), 0)
    endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        local integer i = 0
        set PlayerCount = 0

        loop
            if GetPlayerController(Player(i)) == MAP_CONTROL_USER and GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING then
                set PlayerCount = PlayerCount + 1
            endif
            set i = i + 1
            exitwhen i > 8
        endloop
        
        if PlayerCount == 1 then
            call TriggerRegisterPlayerChatEvent(trg,Player(0),"-dummy",true)
            call TriggerAddAction(trg, function SpawnDummy)
        endif

        set trg = null
    endfunction
endscope