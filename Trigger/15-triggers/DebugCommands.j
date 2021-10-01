library DebugCommands initializer init requires CustomState
    globals
        boolean array NextRound
        real RoundTime = 20
        boolean Waiting
    endglobals
//===========================================================================
    function SpawnDummy takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        call AddUnitMagicDmg(CreateUnit(Player(11), 'hfoo', GetUnitX(udg_units01[pid+1]), GetUnitY(udg_units01[pid+1]), 0), 300)
    endfunction

    function LvlHero takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        call SetHeroLevel(udg_units01[pid+1], 5000, true)
    endfunction

    function AddGlory takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        set Glory[pid] = 100000
    endfunction

    function StartNextRound takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer()) 
        if NextRound[udg_integer02] then
            set NextRound[udg_integer02] = false
            call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "|cffffcc00Next round started!|r")
            call TriggerExecute(udg_trigger109)
        endif
    endfunction

    function SetRoundTime takes nothing returns nothing
        local string check = SubString(GetEventPlayerChatString(),0,3)
        local integer pn = S2I(SubString(GetEventPlayerChatString(),4,8))
        if check == "-rt" and pn > 1 then
            set RoundTime = pn
            call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "Time between rounds set to: " + I2S(pn))
        endif
    endfunction
    
    //===========================================================================
    function AllowSinglePlayerCommands takes nothing returns nothing
        local trigger trg = CreateTrigger()
        local integer i = 0
        local trigger trg2 = CreateTrigger()
        if udg_integer06 == 1 then
            loop
                if UnitAlive(udg_units01[i+1]) then
                    call DisplayTimedTextToPlayer(Player(0), 0, 0, 60, "Single player commands have been enabled")
                    call TriggerRegisterPlayerChatEvent(trg,Player(i),"-nx",true)
                    call TriggerAddAction(trg, function StartNextRound)

                    call TriggerRegisterPlayerChatEvent(trg2,Player(i),"-rt",false)
                    call TriggerAddAction(trg2, function SetRoundTime)
                    exitwhen true
                endif
                set i = i + 1
                exitwhen i > 7
            endloop
        endif
    endfunction

    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        local integer i = 0
        local integer pc = 0

        loop
            if GetPlayerController(Player(i)) == MAP_CONTROL_USER and GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING then
                set pc = pc + 1
            endif
            set i = i + 1
            exitwhen i > 8
        endloop
        
        if pc == 1 then
            call DisplayTimedTextToPlayer(Player(0), 0, 0, 60, "Debug commands have been enabled")
            set trg = CreateTrigger()
            call TriggerRegisterPlayerChatEvent(trg,Player(0),"-dummy",true)
            call TriggerAddAction(trg, function SpawnDummy)

            set trg = CreateTrigger()
            call TriggerRegisterPlayerChatEvent(trg,Player(0),"-lvl",true)
            call TriggerAddAction(trg, function LvlHero)

            set trg = CreateTrigger()
            call TriggerRegisterPlayerChatEvent(trg,Player(0),"-glory",true)
            call TriggerAddAction(trg, function AddGlory)

            set trg = CreateTrigger()
            call TriggerRegisterPlayerChatEvent(trg,Player(0),"-nx",true)
            call TriggerAddAction(trg, function StartNextRound)

            set trg = CreateTrigger()
            call TriggerRegisterPlayerChatEvent(trg,Player(0),"-rt",false)
            call TriggerAddAction(trg, function SetRoundTime)
        endif

        set trg = null
    endfunction
endlibrary