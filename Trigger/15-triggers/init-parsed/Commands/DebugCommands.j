library DebugCommands initializer init requires CustomState, RandomShit, Functions
    globals
        boolean DebugModeEnabled = false
        boolean array NextRound
        real RoundTime = 20
        integer dummyId = 'H00E'
        unit array PlayerDummy
        boolean array dummyEnabled
        integer array CreatedDummies
    endglobals
    //===========================================================================
    function DummyHelp takes player p returns nothing
        call DisplayTimedTextToPlayer(p, 0, 0, 10, "Dummy Commands: " + I2S(GetHandleId(PlayerDummy[GetPlayerId(p)])) + ": " + GetUnitName(PlayerDummy[GetPlayerId(p)]))
        call DisplayTimedTextToPlayer(p, 0, 0, 10, "To edit the stats of the last dummy you've created: ")
        call DisplayTimedTextToPlayer(p, 0, 0, 10, "-dhpo xxx (hit points), -dman xxx (mana)")
        call DisplayTimedTextToPlayer(p, 0, 0, 10, "-ddmg xxx (damage), -dbas xxx (attack speed), -darm xxx (armor), -dblo xxx (block), -dpvp xxx (pvp)")
        call DisplayTimedTextToPlayer(p, 0, 0, 10, "-dstr, dagi, dint xxx (hero stats), -dmpo xxx (magic power), -dmpr xxx (magic protection), -deva xxx (evasion)")
        call DisplayTimedTextToPlayer(p, 0, 0, 10, "-ditem: duplicates all your items to the dummy")
        call DisplayTimedTextToPlayer(p, 0, 0, 10, "-dabil: duplicates all your abilities to the dummy (might bug if used more than once on the same dummy)") 
        call DisplayTimedTextToPlayer(p, 0, 0, 10, "-dname: xxxxxxxxxx: sets the name of the dummy")
        call DisplayTimedTextToPlayer(p, 0, 0, 10, "-dkill: kill the dummy")
        call DisplayTimedTextToPlayer(p, 0, 0, 10, "-help: see this list again")    
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
        local real value = S2R(SubString(GetEventPlayerChatString(), 6, 20))
        local player p = GetTriggerPlayer()
        local unit u = PlayerDummy[GetPlayerId(p)]
        local unit hero = udg_units01[GetPlayerId(p) + 1]
        local string s = ""
        if command == "-ddmg" then
            call BlzSetUnitBaseDamage(u, R2I(value), 0)
            set s = "|cffffcc00" + GetUnitName(u) + "|r: " + R2S(value) + " attack damage"
        elseif command == "-dbas" then
            call BlzSetUnitAttackCooldown(u, value, 0)
            set s = "|cfffff242" + GetUnitName(u) + "|r: " + R2S(value) + " base attack speed"
        elseif command == "-dhpo" then
            call BlzSetUnitMaxHP(u, R2I(value))
            set s = "|cffff7e42" + GetUnitName(u) + "|r: " + R2S(value) + " hit points"
        elseif command == "-dman" then
            call BlzSetUnitMaxMana(u, R2I(value))
            set s = "|cff7b42ff" + GetUnitName(u) + "|r: " + R2S(value) + " mana"
        elseif command == "-darm" then
            call BlzSetUnitArmor(u, value)
            set s = "|cff7bff00" + GetUnitName(u) + "|r: " + R2S(value) + " armor"
        elseif command == "-dblo" then  
            call SetUnitBlock(u, value)
            set s = "|cff00ffea" + GetUnitName(u) + "|r: " + R2S(value) + " block"
        elseif command == "-dpvp" then
            call SetUnitPvpBonus(u, value)
            set s = "|cff00a2ff" + GetUnitName(u) + "|r: " + R2S(value) + " pvp bonus"
        elseif command == "-dstr" then
            call SetHeroStr(u, R2I(value), true)
            set s = "|cffff6464" + GetUnitName(u) + "|r: " + R2S(value) + " strength"
        elseif command == "-dagi" then
            call SetHeroAgi(u, R2I(value), true)
            set s = "|cffffd941" + GetUnitName(u) + "|r: " + R2S(value) + " agility"
        elseif command == "-dint" then
            call SetHeroInt(u, R2I(value), true)
            set s = "|cff3d91ff" + GetUnitName(u) + "|r: " + R2S(value) + " intelligence"
        elseif command == "-dmpo" then
            call SetUnitMagicDmg(u, value)
            set s = "|cffff3aff" + GetUnitName(u) + "|r: " + R2S(value) + " magic power"
        elseif command == "-dmpr" then
            call SetUnitMagicDef(u, value)
            set s = "|cff00ff40" + GetUnitName(u) + "|r: " + R2S(value) + " magic protection"
        elseif command == "-deva" then
            call SetUnitEvasion(u, value)
            set s = "|cff9e9e9e" + GetUnitName(u) + "|r: " + R2S(value) + " evasion"
        elseif command == "-help" then
            call DummyHelp(p)
        else
            set command = SubString(GetEventPlayerChatString(), 0, 6)

            if command == "-ditem" then
                call RemoveItem(UnitItemInSlot(u, 0))
                call UnitAddItemById(u, GetItemTypeId(UnitItemInSlot(hero, 0)))
                call RemoveItem(UnitItemInSlot(u, 1))
                call UnitAddItemById(u, GetItemTypeId(UnitItemInSlot(hero, 1)))
                call RemoveItem(UnitItemInSlot(u, 2))
                call UnitAddItemById(u, GetItemTypeId(UnitItemInSlot(hero, 2)))
                call RemoveItem(UnitItemInSlot(u, 3))
                call UnitAddItemById(u, GetItemTypeId(UnitItemInSlot(hero, 3)))
                call RemoveItem(UnitItemInSlot(u, 4))
                call UnitAddItemById(u, GetItemTypeId(UnitItemInSlot(hero, 4)))
                call RemoveItem(UnitItemInSlot(u, 5))
                call UnitAddItemById(u, GetItemTypeId(UnitItemInSlot(hero, 5)))
                set s = "|cffff9532" + GetUnitName(u) + "|r: duplicated items"
            elseif command == "-dabil" then
                call CopyAbilitiesToDummy(hero, u)
                set s = "|cff9748ff" + GetUnitName(u) + "|r: duplicated abilities"
            elseif command == "-dname" then
                call BlzSetUnitName(u, SubString(GetEventPlayerChatString(), 7, 20))
                set s = "Set name to: |cffc5fca0" + GetUnitName(u) + "|r"
            elseif command == "-dkill" then
                call KillUnit(u)
                set s = "Killed |cffff9532" + GetUnitName(u) + "|r: |cffc8ff32" + GetHeroProperName(u) + "|r"
            else

            endif
        endif
        if s != "" then
            call DisplayTextToPlayer(p, 0, 0, s)
        endif
    endfunction

    function DummyCommands takes player p returns nothing
        local trigger trg = CreateTrigger()
        call DummyHelp(p)
        call TriggerRegisterPlayerChatEvent(trg, p, "-", false)
        call TriggerAddAction(trg, function DummyCommandAction)
        set trg = null
    endfunction

    function SpawnDummy takes Args args returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        set PlayerDummy[pid] = CreateUnit(Player(11), dummyId, GetUnitX(udg_units01[pid + 1]), GetUnitY(udg_units01[pid + 1]), 0)
        set CreatedDummies[pid] = CreatedDummies[pid] + 1
        call BlzSetHeroProperName(PlayerDummy[pid], "Subject #" + I2S(CreatedDummies[pid]))
        if dummyEnabled[pid] == false then
            set dummyEnabled[pid] = true
            call DummyCommands(GetTriggerPlayer())
        endif
    endfunction

    function LvlHero takes Args args returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        local integer pn = S2I(args[1])
        if pn > 1 then 
        call SetHeroLevel(udg_units01[pid + 1], GetHeroLevel(udg_units01[pid+1]) + pn, true)
        endif
    endfunction

    function AddGlory takes Args args returns nothing
        local integer pn = S2I(args[1])
        local integer pid = GetPlayerId(GetTriggerPlayer())
        if pn > 1 then 
            set Glory[pid] = Glory[pid] + pn
            call ResourseRefresh(GetTriggerPlayer())
        endif
    endfunction

    function StartNextRound takes Args args returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer()) 
        if NextRound[udg_integer02] then
            set NextRound[udg_integer02] = false
            call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "|cffffcc00Next round started!|r")
            call TriggerExecute(udg_trigger109)
        endif
    endfunction

    function SetRoundTime takes Args args returns nothing
        local integer pn = S2I(args[1])
        if pn > 1 then
            set RoundTime = pn
            call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "Time between rounds set to: " + I2S(pn))
        endif
    endfunction

    function SetBattleRoyale takes Args args returns nothing
        local integer pn = S2I(args[1])
        if pn > udg_integer02 then
            set BattleRoyalRound = pn
            call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "Battle Royal will start after round: " + I2S(pn))
        endif
    endfunction
    
    //===========================================================================
    function AllowSinglePlayerCommands takes nothing returns nothing
        local trigger trg = CreateTrigger()
        local integer i = 0
        local trigger trg2 = CreateTrigger()
        if udg_integer06 == 1 and (not DebugModeEnabled) then
            loop
                if UnitAlive(udg_units01[i + 1]) then
                    call DisplayTimedTextToPlayer(Player(0), 0, 0, 60, "Single player commands have been enabled")
                    call Command.create(CommandHandler.StartNextRound).name("nx").handles("nx").help("nx", "Starts the next round if used inbetween rounds.")
                    call Command.create(CommandHandler.SetRoundTime).name("rt").handles("rt").help("rt <value>", "Starting next round, sets the time between rounds to <value>.")
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
            set DebugModeEnabled = true
            call Command.create(CommandHandler.SpawnDummy).name("dummy").handles("dummy").help("dummy", "Spawns an enemy dummy at your Hero's location")
            call Command.create(CommandHandler.LvlHero).name("lvl").handles("lvl").help("lvl <value>", "Adds <value> to your hero's level")
            call Command.create(CommandHandler.AddGlory).name("glory").handles("glory").help("glory <value>", "Gives you <value> bonus glory.")
            call Command.create(CommandHandler.StartNextRound).name("nx").handles("nx").help("nx", "Starts the next round if used inbetween rounds.")
            call Command.create(CommandHandler.SetRoundTime).name("rt").handles("rt").help("rt <value>", "Starting next round, sets the time between rounds to <value>.")
            call Command.create(CommandHandler.SetRoundTime).name("sbr").handles("sbr").help("sbr <value>", "The Battle Royal starts after round <value>.")
            call DisplayTimedTextToPlayer(Player(0), 0, 0, 60, "Debug commands have been enabled")
        endif

        set trg = null
    endfunction
endlibrary