scope DebugCommands initializer init
    globals
        integer PlayerCount
    endglobals
//===========================================================================
    function SpawnDummy takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        call CreateUnit(Player(11), 'hfoo', GetUnitX(udg_units01[pid+1]), GetUnitY(udg_units01[pid+1]), 0)
    endfunction

    function LvlHero takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        call SetHeroLevel(udg_units01[pid+1], 5000, true)
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
            set trg = CreateTrigger()
            call TriggerRegisterPlayerChatEvent(trg,Player(0),"-dummy",true)
            call TriggerAddAction(trg, function SpawnDummy)

            set trg = CreateTrigger()
            call TriggerRegisterPlayerChatEvent(trg,Player(0),"-lvl",true)
            call TriggerAddAction(trg, function LvlHero)
        endif

        set trg = null
    endfunction
endscope