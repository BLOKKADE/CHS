library DebugCommands initializer init requires CustomState, RandomShit, Functions

    globals
        boolean DebugModeEnabled = false
        boolean array NextRound
        integer dummyId = 'H00E'
        unit array PlayerDummy
        boolean array dummyEnabled
        integer array CreatedDummies
        boolean CreepEnrageEnabled = true
        effect TestFx = null
        boolean DebugMsgMode = false
        group DummyGroup
    endglobals

    private function DummyHelp takes player p returns nothing
        call DisplayTimedTextToPlayer(p, 0, 0, 10, "Dummy Commands: " + I2S(GetHandleId(PlayerDummy[GetPlayerId(p)])) + ": " + GetUnitName(PlayerDummy[GetPlayerId(p)]))
        call DisplayTimedTextToPlayer(p, 0, 0, 10, "To edit the stats of the last dummy you've created:")
        call DisplayTimedTextToPlayer(p, 0, 0, 10, "-dhpo (hit points), -dman (mana), -dhpr (hp regen), -dmar (mana regen)")
        call DisplayTimedTextToPlayer(p, 0, 0, 10, "-ddmg (damage), -dbas (attack speed), -darm (armor), -dblo (block), -dpvp (pvp)")
        call DisplayTimedTextToPlayer(p, 0, 0, 10, "-dstr, dagi, dint (hero stats), -dmpo (magic power), -dmpr (magic protection), -deva (evasion)")
        call DisplayTimedTextToPlayer(p, 0, 0, 10, "-ditem: duplicates all your items to the dummy")
        call DisplayTimedTextToPlayer(p, 0, 0, 10, "-dabil: duplicates all your abilities to the dummy (might bug if used more than once on the same dummy)") 
        call DisplayTimedTextToPlayer(p, 0, 0, 10, "-dname: xxxxxxxxxx: sets the name of the dummy")
        call DisplayTimedTextToPlayer(p, 0, 0, 10, "-dkill: kill the dummy")
        call DisplayTimedTextToPlayer(p, 0, 0, 10, "-help: see this list again")    
        call DisplayTimedTextToPlayer(p, 0, 0, 10, "|cffffcc00example|r: -dhpo 5000 to set hp to 5000")
    endfunction

    private function CopyAbilitiesToDummy takes unit hero, unit dummy returns nothing
        local integer i1 = 1
        local integer id = 0 
        
        loop
            exitwhen i1 > 10
            set id = GetHeroSpellAtPosition(hero, i1)
            call UnitAddAbility(dummy, id)
            call SetUnitAbilityLevel(dummy, id, GetUnitAbilityLevel(hero, id))
            call FuncEditParam(id, dummy)
            set i1 = i1 + 1
        endloop
    endfunction

    private function DummyCommandAction takes nothing returns nothing
        local string command = SubString(GetEventPlayerChatString(), 0, 5)
        local real value = S2R(SubString(GetEventPlayerChatString(), 6, 20))
        local player p = GetTriggerPlayer()
        local unit u = PlayerDummy[GetPlayerId(p)]
        local unit hero = PlayerHeroes[GetPlayerId(p)]
        local string s = ""
        if command == "-ddmg" then
            call BlzSetUnitBaseDamage(u, R2I(value), 0)
            set s = "|cffffcc00" + GetUnitName(u) + "|r: " + R2S(value) + " attack damage"
        elseif command == "-dbas" then
            call BlzSetUnitAttackCooldown(u, value, 0)
            set s = "|cfffff242" + GetUnitName(u) + "|r: " + R2S(value) + " base attack speed"
        elseif command == "-dhpo" then
            call SetUnitMaxHp(u, R2I(value))
            set s = "|cffff7e42" + GetUnitName(u) + "|r: " + R2S(value) + " hit points"
        elseif command == "-dman" then
            call BlzSetUnitMaxMana(u, R2I(value))
            set s = "|cff7b42ff" + GetUnitName(u) + "|r: " + R2S(value) + " mana"
        elseif command == "-darm" then
            call BlzSetUnitArmor(u, value)
            set s = "|cff7bff00" + GetUnitName(u) + "|r: " + R2S(value) + " armor"
        elseif command == "-dblo" then  
            call SetUnitCustomState(u, BONUS_BLOCK, value)
            set s = "|cff00ffea" + GetUnitName(u) + "|r: " + R2S(value) + " block"
        elseif command == "-dpvp" then
            call SetUnitCustomState(u, BONUS_PVP, value)
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
            call SetUnitCustomState(u, BONUS_MAGICPOW, value)
            set s = "|cffff3aff" + GetUnitName(u) + "|r: " + R2S(value) + " magic power"
        elseif command == "-dmpr" then
            call SetUnitCustomState(u, BONUS_MAGICRES, value)
            set s = "|cff00ff40" + GetUnitName(u) + "|r: " + R2S(value) + " magic protection"
        elseif command == "-deva" then
            call SetUnitCustomState(u, BONUS_EVASION, value)
            set s = "|cff9e9e9e" + GetUnitName(u) + "|r: " + R2S(value) + " evasion"
        elseif command == "-dhpr" then  
            call SetUnitBonusReal(u, BONUS_HEALTH_REGEN, value)
            set s = "|cff00ffea" + GetUnitName(u) + "|r: " + R2S(value) + " hp regen"
        elseif command == "-dmar" then
            call SetUnitBonusReal(u, BONUS_MANA_REGEN, value)
            set s = "|cff00a2ff" + GetUnitName(u) + "|r: " + R2S(value) + " mana regen"
        elseif command == "-dppo" then
            call SetUnitCustomState(u, BONUS_PHYSPOW, value)
            set s = "|cff00a2ff" + GetUnitName(u) + "|r: " + R2S(value) + " phys power"
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

        set p = null
        set u = null
        set hero = null
    endfunction

    private function DummyCommands takes player p returns nothing
        local trigger trg = CreateTrigger()
        call DummyHelp(p)
        call TriggerRegisterPlayerChatEvent(trg, p, "-", false)
        call TriggerAddAction(trg, function DummyCommandAction)
        set trg = null
    endfunction

    private function SpawnDummy takes Args args returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        set PlayerDummy[pid] = CreateUnit(Player(21), dummyId, GetUnitX(PlayerHeroes[pid]), GetUnitY(PlayerHeroes[pid]), 0)
        set CreatedDummies[pid] = CreatedDummies[pid] + 1
        call BlzSetHeroProperName(PlayerDummy[pid], "Subject #" + I2S(CreatedDummies[pid]))

        call GroupRefresh(DummyGroup)
        call GroupAddUnit(DummyGroup, PlayerDummy[pid])

        if dummyEnabled[pid] == false then
            set dummyEnabled[pid] = true
            call DummyCommands(GetTriggerPlayer())
        endif
    endfunction

    private function LvlHero takes Args args returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        local integer pn = S2I(args[1])
        if pn > 1 then 
            call SetHeroLevel(PlayerHeroes[pid], GetHeroLevel(PlayerHeroes[pid]) + pn, true)
        endif
    endfunction

    private function AddGlory takes Args args returns nothing
        local integer pn = S2I(args[1])
        local integer pid = GetPlayerId(GetTriggerPlayer())
        if pn > 1 then 
            set Glory[pid] = Glory[pid] + pn
            call ResourseRefresh(GetTriggerPlayer())
        endif
    endfunction

    private function StartNextRound takes Args args returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer()) 
        call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "|cffffcc00Attempting to start next round...|r")
        call AllPlayersCompletedRound_StartNextRound()
    endfunction

    private function SetRoundTime takes Args args returns nothing
        local integer pn = S2I(args[1])
        if pn > 1 then
            set RoundTime = pn
            set pvpWaitDuration = pn
            call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "Time between rounds set to: " + I2S(pn))
        endif
    endfunction

    private function SetBattleRoyale takes Args args returns nothing
        local integer pn = S2I(args[1])
        if pn >= RoundNumber then
            set BattleRoyalRound = pn
            call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "Battle Royal will start after round: " + I2S(pn))
        endif
    endfunction

    private function RandomDebugCommand takes Args args returns nothing
        if GetLocalPlayer() == GetTriggerPlayer() then
            set DebugMsgMode = true
        endif
    endfunction

    private function SetWizardbaneDebug takes Args args returns nothing
        set wizardbaneDebug = wizardbaneDebug != true
        if wizardbaneDebug then
            call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "Creeps will have 100% wizardbane chance in 1 or 2 rounds")
        else
            call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "Creeps will have their regular wizardbane chance in 1 or 2 rounds")
        endif
    endfunction

    private function SetCreepEnrage takes Args args returns nothing
        set CreepEnrageEnabled = CreepEnrageEnabled != true
        if CreepEnrageEnabled then
            call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "Creep Enrage enabled.")
        else
            call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "Creep Enrage disabled.")
        endif
    endfunction

    private function SetRoundNumber takes Args args returns nothing
        local integer pn = S2I(args[1])
        if pn > 1 then
            set RoundNumber = pn
            call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "Round number set to: " + I2S(pn))
        endif
    endfunction

    private function CpuPower takes Args args returns nothing
        local integer pid = 0
        local unit u
        loop
            set u = PlayerHeroes[pid]
            if GetPlayerController(Player(pid)) == MAP_CONTROL_COMPUTER and u != null then
                call SetHeroLevel(u, GetHeroLevel(u) + 200, true)
                call UnitAddAbility(u, ARCANE_ASSAUL_ABILITY_ID)
                call UnitAddAbility(u, LAST_BREATHS_ABILITY_ID)
                call UnitAddAbility(u, TRUESHOT_AURA_ABILITY_ID)
                call UnitAddAbility(u, ICE_FORCE_ABILITY_ID)
                call UnitAddAbility(u, DIVINE_GIFT_ABILITY_ID)
                call UnitAddAbility(u, FAST_MAGIC_ABILITY_ID)
                call UnitAddAbility(u, UNHOLY_AURA_ABILITY_ID)
                call UnitAddAbility(u, DIVINE_BUBBLE_ABILITY_ID)
                call UnitAddAbility(u, CORROSIVE_SKIN_ABILITY_ID)

                call SetUnitAbilityLevel(u, CORROSIVE_SKIN_ABILITY_ID, 30)
                call SetUnitAbilityLevel(u, UNHOLY_AURA_ABILITY_ID, 30)
                call SetUnitAbilityLevel(u, DIVINE_BUBBLE_ABILITY_ID, 30)
                call SetUnitAbilityLevel(u, ARCANE_ASSAUL_ABILITY_ID, 30)
                call SetUnitAbilityLevel(u, LAST_BREATHS_ABILITY_ID, 30)
                call SetUnitAbilityLevel(u, TRUESHOT_AURA_ABILITY_ID, 30)
                call SetUnitAbilityLevel(u, ICE_FORCE_ABILITY_ID, 30)
                call SetUnitAbilityLevel(u, DIVINE_GIFT_ABILITY_ID, 30)
                call SetUnitAbilityLevel(u, FAST_MAGIC_ABILITY_ID, 30)
                //call AddUnitBonusReal(u, BONUS_HEALTH_REGEN, (100000 ))
                //call UnitAddAbility(u, ABSOLUTE_POISON_ABILITY_ID)
                //call UnitAddAbility(u, ENVENOMED_WEAPONS_ABILITY_ID)
                //call UnitAddAbility(u, ANCIENT_ELEMENT_ABILITY_ID)
                //call SetUnitAbilityLevel(u, ANCIENT_ELEMENT_ABILITY_ID, 30)
                //call SetUnitAbilityLevel(u, ENVENOMED_WEAPONS_ABILITY_ID, 30)
                //call SetUnitAbilityLevel(u, ABSOLUTE_POISON_ABILITY_ID, 30)
                //call UnitAddItem(u,CreateItem(POISON_RUNESTONE_ITEM_ID,0,0))
                //call UnitAddItem(u,CreateItem('i0bu',0,0))
                call SetHeroInt(u, GetHeroInt(u, false) + 10000, true)
                call SetHeroStr(u, GetHeroStr(u, false) + 10000, true)
                call SetHeroAgi(u, GetHeroAgi(u, false) + 10000, true)
                set GloryRegenLevel[GetHandleId(u)] = GloryRegenLevel[GetHandleId(u)] + 1
                call AddUnitBonusReal(u, BONUS_HEALTH_REGEN, 50)
            endif
            set pid = pid + 1
            exitwhen pid == 20
        endloop
        
        set u = null
    endfunction
    
    function AllowSinglePlayerCommands takes nothing returns nothing
        local trigger trg = CreateTrigger()
        local integer i = 0
        local trigger trg2 = CreateTrigger()

        if PlayerCount == 1 and (not DebugModeEnabled) then
            loop
                if UnitAlive(PlayerHeroes[i]) then
                    call DisplayTimedTextToPlayer(Player(0), 0, 0, 60, "Single player commands have been enabled")
                    call Command.create(CommandHandler.StartNextRound).name("nx").handles("nx").help("nx", "Starts the next round if used inbetween rounds.")
                    call Command.create(CommandHandler.SetRoundTime).name("rt").handles("rt").help("rt <value>", "Starting next round, sets the time between rounds to <value>.")
                    exitwhen true
                endif
                set i = i + 1
                exitwhen i == 20
            endloop
        endif
    endfunction

    private function SetupDebugCommands takes nothing returns nothing
        local trigger trg = CreateTrigger()
        local integer i = 0
        local integer pc = 0

        set DummyGroup = NewGroup()

        loop
            if GetPlayerController(Player(i)) == MAP_CONTROL_USER and GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING then
                set pc = pc + 1
            endif
            set i = i + 1
            exitwhen i == 20
        endloop
        
        if pc == 1 then
            set DebugModeEnabled = true
            call Command.create(CommandHandler.SpawnDummy).name("dummy").handles("dummy").help("dummy", "Spawns an enemy dummy at your Hero's location")
            call Command.create(CommandHandler.LvlHero).name("lvl").handles("lvl").help("lvl <value>", "Adds <value> to your hero's level")
            call Command.create(CommandHandler.AddGlory).name("glory").handles("glory").help("glory <value>", "Gives you <value> bonus glory.")
            call Command.create(CommandHandler.StartNextRound).name("nx").handles("nx").help("nx", "Starts the next round if used inbetween rounds.")
            call Command.create(CommandHandler.SetRoundTime).name("rt").handles("rt").help("rt <value>", "Starting next round, sets the time between rounds to <value>.")
            call Command.create(CommandHandler.SetBattleRoyale).name("sbr").handles("sbr").help("sbr <value>", "The Battle Royal starts after round <value>.")
            call Command.create(CommandHandler.SetWizardbaneDebug).name("wbd").handles("wbd").help("wbd", "Wizardbane debug.")
            call Command.create(CommandHandler.SetCreepEnrage).name("tce").handles("tce").help("tce", "toggle creep enrage.")
            call Command.create(CommandHandler.CpuPower).name("cpupw").handles("cpupw").help("cpupw", "Gives CPU players stats, levels and some abilities")
            call Command.create(CommandHandler.SetRoundNumber).name("srn").handles("srn").help("srn <value>", "Set round number to <value>.")
            call DisplayTimedTextToPlayer(Player(0), 0, 0, 60, "Debug commands have been enabled")
        endif

        call Command.create(CommandHandler.RandomDebugCommand).name("debug").handles("debug").help("debug", "enables debug msgs.")

        set trg = null
    endfunction

    private function init takes nothing returns nothing
        call TimerStart(CreateTimer(), 0, false, function SetupDebugCommands)
    endfunction

endlibrary