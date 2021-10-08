library DebugCommands initializer init requires CustomState
    globals
        boolean array NextRound
        real RoundTime = 20
        boolean Waiting
        integer dummyId = 0
        unit array PlayerDummy
        boolean array dummyEnabled
    endglobals
    //===========================================================================
    function DummyHelp takes player p returns nothing
        call DisplayTextToPlayer(p, 0, 0, "Dummy Commands: " + GetHandleId(PlayerDummy[GetPlayerId(p)]) + ": " + GetUnitName(PlayerDummy[GetPlayerId(p)]))
        call DisplayTextToPlayer(p, 0, 0, "To edit the stats of the last dummy you've created: ")
        call DisplayTextToPlayer(p, 0, 0, "-ddmg xxx (damage), -dbas xxx (attack speed), -darm xxx (armor), -dblo xxx (block), -dpvp xxx (pvp)")
        call DisplayTextToPlayer(p, 0, 0, "-dstr, dagi, dint xxx (hero stats), -dmpo xxx (magic power), -dmpr xxx (magic protection), -deva xxx (evasion)")
        call DisplayTextToPlayer(p, 0, 0, "-ditim: duplicates all your items to the dummy")
        call DisplayTextToPlayer(p, 0, 0, "-dabil: duplicates all your abilities to the dummy")
        call DisplayTextToPlayer(p, 0, 0, "-dname: xxxxxxxxxx: sets the name of the dummy")
    endfunction

    private function CopyAbilitiesToDummy takes unit hero, unit dummy returns nothing
        local integer i1 = 1
        local integer id = 0 
        
        loop
            exitwhen i1 > 10
            set id = GetInfoHeroSpell(hero ,i1)
            call UnitAddAbility(dummy, id)
            call SetUnitAbilityLevel(dummy, id, GetUnitAbilityLevel(hero, id))
            call FuncEditParam(id, dummy)
            set i1 = i1 + 1
        endloop
    endfunction

    function DummyCommandAction takes nothing returns nothing
        local string command = SubString(GetEventPlayerChatString(), 0, 5)
        local real value = S2R(SubString(GetEventPlayerChatString(), 5, 20))
        local player p = GetTriggerPlayer()
        local unit u = PlayerDummy[GetPlayerId(p)]
        local unit hero = udg_units01[GetPlayerId(p) + 1]
        if command == "-ddmg" then
            call BlzSetUnitBaseDamage(u, R2I(value), 0)
        elseif command == "-dbas" then
            call BlzSetUnitAttackCooldown(u, value, 0)
        elseif command == "-darm" then
            call BlzSetUnitArmor(u, value)
        elseif command == "-dblo" then  
            call SetUnitBlock(u, value)
        elseif command == "-dpvp" then
            call SetUnitPvpBonus(u, value)
        elseif command == "-dstr" then
            call SetHeroStr(u, value, true)
        elseif command == "-dagi" then
            call SetHeroAgi(u, value, true)
        elseif command == "-dint" then
            call SetHeroInt(u, value, true)
        elseif command == "-dmpo" then
            call SetUnitMagicDmg(u, value)
        elseif command == "-dmpr" then
            call SetUnitMagicDef(u, value)
        elseif command == "-deva" then
            call SetUnitEvasion(u, value)
        else
            set command = = SubString(GetEventPlayerChatString(), 0, 6)
            set value = SubString(GetEventPlayerChatString(), 5, 20)

            if command == "-ditem" then
                call UnitRemoveItemFromSlot(u, 0)
                call UnitAddItemById(u, GetItemTypeId(UnitItemInSlot(hero, 0)))
                call UnitRemoveItemFromSlot(u, 1)
                call UnitAddItemById(u, GetItemTypeId(UnitItemInSlot(hero, 1)))
                call UnitRemoveItemFromSlot(u, 2)
                call UnitAddItemById(u, GetItemTypeId(UnitItemInSlot(hero, 2)))
                call UnitRemoveItemFromSlot(u, 3)
                call UnitAddItemById(u, GetItemTypeId(UnitItemInSlot(hero, 3)))
                call UnitRemoveItemFromSlot(u, 4)
                call UnitAddItemById(u, GetItemTypeId(UnitItemInSlot(hero, 4)))
                call UnitRemoveItemFromSlot(u, 5)
                call UnitAddItemById(u, GetItemTypeId(UnitItemInSlot(hero, 5)))
            elseif command == "-dabil" then
                call CopyAbilitiesToDummy(hero, u)
            elseif command == "-dname" then
                call BlzSetUnitName(u, value)
            else

            endif
        endif
    endfunction

    function DummyCommands takes player p returns nothing
        call DummyHelp(p)
    endfunction

    function SpawnDummy takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        set PlayerDummy[pid = CreateUnit(Player(11), 'hfoo', GetUnitX(udg_units01[pid + 1]), GetUnitY(udg_units01[pid + 1]), 0)
        if dummyEnabled[pid] == false then
            set dummyEnabled[pid] = true
            call DummyCommands(GetTriggerPlayer())
        endif
    endfunction

    function LvlHero takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        call SetHeroLevel(udg_units01[pid + 1], 5000, true)
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
                if UnitAlive(udg_units01[i + 1]) then
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