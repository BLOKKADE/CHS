library GameModeQuestSetup initializer init requires RandomShit, HeroSelector, HeroInfo, BanningPhase

    globals
        boolean EconomyMode = false
    endglobals

    private function GameModeQuestSetupConditions takes nothing returns boolean
        return (IsTriggerEnabled(GetTriggeringTrigger()) == true) and ((udg_boolean15 == false) or (udg_integer63 == PlayerCount))
    endfunction

    private function PlayingPlayerFilter takes nothing returns boolean
        return (GetFilterPlayer() != Player(8)) and (GetFilterPlayer() != Player(11)) and (GetPlayerSlotState(GetFilterPlayer()) == PLAYER_SLOT_STATE_PLAYING)
    endfunction

    private function ShortGamePlayerActions takes nothing returns nothing
        call SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_FOOD_CAP, 25)
        call SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_FOOD_CAP_CEILING, 25)
        call ResourseRefresh(GetEnumPlayer()) 
    endfunction

    private function LongGamePlayerActions takes nothing returns nothing
        call SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_FOOD_CAP, 50)
        call SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_FOOD_CAP_CEILING, 50)
        call ResourseRefresh(GetEnumPlayer()) 
    endfunction

    private function RemoveRandomAbilityShop takes nothing returns nothing
        call DeleteUnit(GetEnumUnit())
    endfunction

    private function GameModeQuestSetupActions takes nothing returns nothing
        local force playingPlayers = GetPlayersMatching(Condition(function PlayingPlayerFilter))
        local group randomAbilityShops

        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call DisableTrigger(GetTriggeringTrigger())
        call ClearTextMessagesBJ(GetPlayersAll())

        set ElimModeEnabled = false

        // This will average all of the votes and set the needed variables
        call VotingResults_CountVotes()

        if (GameModeShort == true) then
            set BattleRoyalRound = 25

            set Lives[0] = 1
            set Lives[1] = 1
            set Lives[2] = 1
            set Lives[3] = 1
            set Lives[4] = 1
            set Lives[5] = 1
            set Lives[6] = 1
            set Lives[7] = 1
            set Lives[8] = 1

            call ForForce(playingPlayers, function ShortGamePlayerActions)
        else
            set BattleRoyalRound = 50

            set Lives[0] = 1
            set Lives[1] = 1
            set Lives[2] = 1
            set Lives[3] = 1
            set Lives[4] = 1
            set Lives[5] = 1
            set Lives[6] = 1
            set Lives[7] = 1
            set Lives[8] = 1	

            call ForForce(playingPlayers, function LongGamePlayerActions)
        endif

        // Cleanup
        call DestroyForce(playingPlayers)
        set playingPlayers = null
        
        // Income mode settings
        // To prevent breaking everything else, set the IncomeMode value to the old voting system
        if IncomeMode == 3 then // Global
            set IncomeMode = 0
        elseif IncomeMode == 2 then // Individual
            set IncomeMode = 1
        elseif IncomeMode == 1 then // Auto-Eco
            set IncomeMode = 3
        elseif IncomeMode == 4 then // Disabled
            set IncomeMode = 2
        endif

        // Ability mode settings
        // To prevent breaking everything else, set the AbilityMode value to the old voting system
        if AbilityMode == 2 then // Random abilities
            set ArNotLearningAbil = true
            set AbilityMode = 0
        elseif AbilityMode == 1 then // Pick abilities
            set ArNotLearningAbil = false
            set AbilityMode = 1

            set randomAbilityShops = GetUnitsOfTypeIdAll('h00G')
            call ForGroup(randomAbilityShops, function RemoveRandomAbilityShop)

            // Cleanup
            call DestroyGroup(randomAbilityShops)
            set randomAbilityShops = null
        elseif AbilityMode == 3 then // Draft abilities
            set ArNotLearningAbil = false
            set AbilityMode = 2

            set randomAbilityShops = GetUnitsOfTypeIdAll('h00G')
            call ForGroup(randomAbilityShops, function RemoveRandomAbilityShop)
            
            // Cleanup
            call DestroyGroup(randomAbilityShops)
            set randomAbilityShops = null
        endif

        // Hero mode settings
        if HeroMode == 2 then // Random hero
            call BanningPhase_TryEnablingBanningPhase()

            set RandomHeroMode = true
        elseif HeroMode == 1 then // Pick hero
            call BanningPhase_TryEnablingBanningPhase()

            set RandomHeroMode = false
        elseif HeroMode == 3 then // Draft hero
            call BanningPhase_TryEnablingBanningPhase()

            set RandomHeroMode = false
        elseif HeroMode == 4 then // Same-Draft hero
            call BanningPhase_TryEnablingBanningPhase()

            set RandomHeroMode = false
        endif

        // PVP betting mode settings
        if ((ElimModeEnabled == true) or (InitialPlayerCount <= 2) or (PvpBettingMode == 1)) then
            set BettingEnabled = false
            set udg_boolean14 = false
        else
            set BettingEnabled = true
            set udg_boolean14 = false
        endif

        call PlaySoundBJ(udg_sound03)
        call QuestSetDescriptionBJ(GetLastCreatedQuestBJ(), GameDescription)
        call QuestSetDiscoveredBJ(GetLastCreatedQuestBJ(), true)
        
        call TriggerSleepAction(0.00)
    endfunction

    private function init takes nothing returns nothing
        set GameModeQuestSetupTrigger = CreateTrigger()
        call TriggerAddCondition(GameModeQuestSetupTrigger, Condition(function GameModeQuestSetupConditions))
        call TriggerAddAction(GameModeQuestSetupTrigger, function GameModeQuestSetupActions)
    endfunction

endlibrary
