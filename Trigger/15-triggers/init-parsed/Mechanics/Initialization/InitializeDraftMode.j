library InitializeDraftMode requires DraftModeFunctions, RandomShit, DraftModeFunctions

    // NO = Number of
    globals
        integer udg_Draft_NODraftSpells = 0
        player udg_Draft_TempPlayer = null
        unit array udg_Draft_DraftBuildings
        unit array udg_Draft_UpgradeBuildings
        force udg_Draft_PlayersInGame = null
        hashtable udg_Draft_PlayerSpells = null
        integer array udg_Draft_PlayerSpellsMaxIndex
        integer array udg_Draft_NOSpellsLearned
        integer array udg_Draft_DefaultSpells
        integer udg_Draft_DefaultSpellsMaxIndex = 0
        integer udg_Draft_DraftBuilding = 0
        integer udg_Draft_UpgradeBuilding = 0
        trigger udg_Draft_TrgOnBuy = null
    endglobals

    private function ConfigureDraftMode takes nothing returns nothing
        local integer abilityIndex = 1

        // This script is for preconfigurable variables, DraftInit initalizes variables that are not supposed to be changed.
        set udg_Draft_DraftBuilding = 'h00C'
        set udg_Draft_UpgradeBuilding = 'h00D'
        set udg_Draft_DefaultSpellsMaxIndex = GetAbilityCount()

        // NOSpells should be >= 4, otherwise the code in the function GenerateInitialDraftSpells might need to be changed so that all 4 added spells get removed properly.
        set udg_Draft_NODraftSpells = 5
        
        loop
            exitwhen abilityIndex > udg_Draft_DefaultSpellsMaxIndex
            set udg_Draft_DefaultSpells[abilityIndex] = GetItemFromAbility(GetAbilityFromIndex(abilityIndex))
            call GetEconomicSpellIndex(abilityIndex, GetAbilityFromIndex(abilityIndex))
            set abilityIndex = abilityIndex + 1
        endloop

    endfunction

    private function SetupDraftForPlayer takes nothing returns nothing
        local integer playerId = GetPlayerId(GetEnumPlayer())
        local integer abilityIndex = 1

        set udg_Draft_NOSpellsLearned[playerId] = 0

        loop
            exitwhen abilityIndex > udg_Draft_DefaultSpellsMaxIndex
            call SaveIntegerBJ(udg_Draft_DefaultSpells[abilityIndex], playerId + 1, abilityIndex, udg_Draft_PlayerSpells)
            set udg_Draft_PlayerSpellsMaxIndex[playerId] = udg_Draft_DefaultSpellsMaxIndex
            set abilityIndex = abilityIndex + 1
        endloop
    endfunction
    
    private function SetupDraftMode takes nothing returns nothing
        // Enabling Draft should only require you to run this trigger once. It has to be run AFTER all the heroes have been added to udg_units01
        call ConfigureDraftMode()
        call DisableVision()

        set DisplayedSpells = HashTable.create()
        set udg_Draft_PlayerSpells = InitHashtable()

        // For each player: initalizes NOSpellsLearned, the individual arrays the spells are generated from and the max index of that array.
        call ForForce(PlayersWithHero, function SetupDraftForPlayer)

        // Creates buildings and generates draft spells
        call CreateDraftBuildings()
        call EnableTrigger(udg_Draft_TrgOnBuy)
        call SetDraftModeRules('A09P')
    endfunction

    function InitDraftMode takes nothing returns nothing
        call ConfigureDraftMode()
        call SetupDraftMode()
    endfunction

endlibrary