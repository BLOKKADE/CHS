library trigger77 initializer init requires RandomShit, HeroSelector, HeroInfo, BanningPhase

    globals
        boolean EconomyMode = false
    endglobals

    function Trig_Dialog_Complete_Func026C takes nothing returns boolean
        if((udg_boolean15==false))then // A flag that determines if just the host votes or everyone
            return true
        endif
        if((udg_integer63==PlayerCount))then // Checks how many people have voted
            return true
        endif
        return false
    endfunction


    function Trig_Dialog_Complete_Conditions takes nothing returns boolean
        if(not(IsTriggerEnabled(GetTriggeringTrigger())==true))then
            return false
        endif
        if(not Trig_Dialog_Complete_Func026C())then
            return false
        endif
        return true
    endfunction

    function Trig_Dialog_Complete_Func006Func009001001001001 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(8))
    endfunction
    
    function Trig_Dialog_Complete_Func006Func009001001001002 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(11))
    endfunction
    
    function Trig_Dialog_Complete_Func006Func009001001001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Dialog_Complete_Func006Func009001001001001(),Trig_Dialog_Complete_Func006Func009001001001002())
    endfunction
    
    function Trig_Dialog_Complete_Func006Func009001001002 takes nothing returns boolean
        return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
    endfunction
    
    function Trig_Dialog_Complete_Func006Func009001001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Dialog_Complete_Func006Func009001001001(),Trig_Dialog_Complete_Func006Func009001001002())
    endfunction

    function Trig_Dialog_Complete_Func006Func004Func006001001001001 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(8))
    endfunction
    
    function Trig_Dialog_Complete_Func006Func004Func006001001001002 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(11))
    endfunction
    
    function Trig_Dialog_Complete_Func006Func004Func006001001001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Dialog_Complete_Func006Func004Func006001001001001(),Trig_Dialog_Complete_Func006Func004Func006001001001002())
    endfunction
    
    function Trig_Dialog_Complete_Func006Func004Func006001001002 takes nothing returns boolean
        return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
    endfunction
    
    function Trig_Dialog_Complete_Func006Func004Func006001001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Dialog_Complete_Func006Func004Func006001001001(),Trig_Dialog_Complete_Func006Func004Func006001001002())
    endfunction

    function Trig_Dialog_Complete_Func008Func001C takes nothing returns boolean
        if(not(ElimModeEnabled==false))then
            return false
        endif
        return true
    endfunction


    function Trig_Dialog_Complete_Func008C takes nothing returns boolean
        if(not Trig_Dialog_Complete_Func008Func001C())then
            return false
        endif
        return true
    endfunction

    function Trig_Dialog_Complete_Func008Func003Func014001001001001 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(8))
    endfunction
    
    function Trig_Dialog_Complete_Func008Func003Func014001001001002 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(11))
    endfunction
    
    function Trig_Dialog_Complete_Func008Func003Func014001001001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Dialog_Complete_Func008Func003Func014001001001001(),Trig_Dialog_Complete_Func008Func003Func014001001001002())
    endfunction
    
    function Trig_Dialog_Complete_Func008Func003Func014001001002 takes nothing returns boolean
        return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
    endfunction
    
    function Trig_Dialog_Complete_Func008Func003Func014001001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Dialog_Complete_Func008Func003Func014001001001(),Trig_Dialog_Complete_Func008Func003Func014001001002())
    endfunction


    function Trig_Dialog_Complete_Func008Func003Func014A takes nothing returns nothing
        call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_RESOURCE_FOOD_CAP,25)
        call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_FOOD_CAP_CEILING,25)
        call ResourseRefresh(GetEnumPlayer()) 
    endfunction


    function Trig_Dialog_Complete_Func008Func003Func008001001001001 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(8))
    endfunction
    
    function Trig_Dialog_Complete_Func008Func003Func008001001001002 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(11))
    endfunction
    
    function Trig_Dialog_Complete_Func008Func003Func008001001001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Dialog_Complete_Func008Func003Func008001001001001(),Trig_Dialog_Complete_Func008Func003Func008001001001002())
    endfunction
    
    function Trig_Dialog_Complete_Func008Func003Func008001001002 takes nothing returns boolean
        return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
    endfunction
    
    function Trig_Dialog_Complete_Func008Func003Func008001001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Dialog_Complete_Func008Func003Func008001001001(),Trig_Dialog_Complete_Func008Func003Func008001001002())
    endfunction


    function Trig_Dialog_Complete_Func008Func003Func008A takes nothing returns nothing
        call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_RESOURCE_FOOD_CAP,50)
        call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_FOOD_CAP_CEILING,50)
        call ResourseRefresh(GetEnumPlayer()) 
    endfunction

    //removes random abiltiy shop from ar mode
    function RemoveRandomAbilityShop takes nothing returns nothing
        call DeleteUnit(GetEnumUnit())
    endfunction


    function Trig_Dialog_Complete_Func014Func001C takes nothing returns boolean
        if((ElimModeEnabled==true))then
            return true
        endif
        if((InitialPlayerCount <= 2))then
            return true
        endif
        if(PvpBettingMode == 1)then
            return true
        endif
        return false
    endfunction

    function Trig_Dialog_Complete_Func014C takes nothing returns boolean
        if(not Trig_Dialog_Complete_Func014Func001C())then
            return false
        endif
        return true
    endfunction

    function Trig_Dialog_Complete_Func023001 takes nothing returns boolean
        return(RandomHeroMode==false)
    endfunction


    function Trig_Dialog_Complete_Func025001001001001 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(8))
    endfunction
    
    function Trig_Dialog_Complete_Func025001001001002 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(11))
    endfunction
    
    function Trig_Dialog_Complete_Func025001001001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Dialog_Complete_Func025001001001001(),Trig_Dialog_Complete_Func025001001001002())
    endfunction
    
    function Trig_Dialog_Complete_Func025001001002001001 takes nothing returns boolean
        return(GetPlayerSlotState(GetFilterPlayer())==PLAYER_SLOT_STATE_PLAYING)
    endfunction
    
    function Trig_Dialog_Complete_Func025001001002001002 takes nothing returns boolean
        return(IsPlayerInForce(GetFilterPlayer(),udg_force07)==true)
    endfunction
    
    function Trig_Dialog_Complete_Func025001001002001 takes nothing returns boolean
        return GetBooleanOr(Trig_Dialog_Complete_Func025001001002001001(),Trig_Dialog_Complete_Func025001001002001002())
    endfunction
    
    function Trig_Dialog_Complete_Func025001001002002 takes nothing returns boolean
        return(IsPlayerInForce(GetFilterPlayer(),udg_PlayersWithHero)!=true)
    endfunction
    
    function Trig_Dialog_Complete_Func025001001002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Dialog_Complete_Func025001001002001(),Trig_Dialog_Complete_Func025001001002002())
    endfunction
    
    function Trig_Dialog_Complete_Func025001001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Dialog_Complete_Func025001001001(),Trig_Dialog_Complete_Func025001001002())
    endfunction


    function Trig_Dialog_Complete_Func025A takes nothing returns nothing
        set udg_player02 = GetEnumPlayer()
        // call ConditionalTriggerExecute(udg_trigger79)
    endfunction


    function Trig_Dialog_Complete_Actions takes nothing returns nothing
        local group randomAbilityShops

        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call DisableTrigger(GetTriggeringTrigger())
        set ModeDescriptionBuilder[0]= ""
        call ClearTextMessagesBJ(GetPlayersAll())
        set ElimModeEnabled = false

        // This will average all of the votes and set the needed variables
        call VotingResults_CountVotes()

        call DisableTrigger(GetTriggeringTrigger())

        if ImmortalMode == 1 then
            set ModeDescriptionBuilder[1]= "Mode: Normal|r"
        else
            set ModeDescriptionBuilder[1]= "Mode: Immortal|r"
        endif

        if(GameModeShort == true) then // Is short game
            set ModeDescriptionBuilder[1] = ModeDescriptionBuilder[1] + " (25 Levels)|r"
            call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + ModeDescriptionBuilder[1]))
            call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,"You have an extra life")
            set Lives[0] = 1
            set Lives[1] = 1
            set Lives[2] = 1
            set Lives[3] = 1
            set Lives[4] = 1
            set Lives[5] = 1
            set Lives[6] = 1
            set Lives[7] = 1
            set Lives[8] = 1
            set BattleRoyalRound = 25
            set ModeDescriptionBuilder[0]=(ModeDescriptionBuilder[0]+(ModeDescriptionBuilder[1]+ "|n"))
            set ModeDescriptionBuilder[1]= "PvP: Every 5th Level|r"
            if(InitialPlayerCount==1)then
                set ModeDescriptionBuilder[1]= "PvP: None|r"
            endif

            call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + ModeDescriptionBuilder[1]))
            call ForForce(GetPlayersMatching(Condition(function Trig_Dialog_Complete_Func008Func003Func014001001)),function Trig_Dialog_Complete_Func008Func003Func014A)
        else // Is long game
            set BattleRoyalRound = 50
            set ModeDescriptionBuilder[1] = ModeDescriptionBuilder[1] + " (50 Levels)|r"
            call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + ModeDescriptionBuilder[1]))
            call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,"You have an extra life")
            set Lives[0] = 1
            set Lives[1] = 1
            set Lives[2] = 1
            set Lives[3] = 1
            set Lives[4] = 1
            set Lives[5] = 1
            set Lives[6] = 1
            set Lives[7] = 1
            set Lives[8] = 1	       	
            set ModeDescriptionBuilder[0]=(ModeDescriptionBuilder[0]+(ModeDescriptionBuilder[1]+ "|n"))
            set ModeDescriptionBuilder[1]= "PvP: Every 5th Level|r"
            if(InitialPlayerCount==1)then
                set ModeDescriptionBuilder[1]= "PvP: None|r"
            endif
            call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + ModeDescriptionBuilder[1]))
            call ForForce(GetPlayersMatching(Condition(function Trig_Dialog_Complete_Func008Func003Func008001001)),function Trig_Dialog_Complete_Func008Func003Func008A)
        endif

        // Income mode settings
        // To prevent breaking everything else, set the IncomeMode value to the old voting system
        if IncomeMode == 3 then // Global
            set ModeDescriptionBuilder[0]=(ModeDescriptionBuilder[0]+(ModeDescriptionBuilder[1]+ "|n"))
            set ModeDescriptionBuilder[1]= "Creep Upgrades: Enabled"
            set IncomeMode = 0
        elseif IncomeMode == 2 then // Individual
            set ModeDescriptionBuilder[0]=(ModeDescriptionBuilder[0]+(ModeDescriptionBuilder[1]+ "|n"))
            set ModeDescriptionBuilder[1]= "Creep Upgrades: Individual"
            set IncomeMode = 1
        elseif IncomeMode == 1 then // Auto-Eco
            set ModeDescriptionBuilder[0]=(ModeDescriptionBuilder[0]+(ModeDescriptionBuilder[1]+ "|n"))
            set ModeDescriptionBuilder[1]= "Creep Upgrades: Economy"
            set IncomeMode = 3
        elseif IncomeMode == 4 then // Disabled
            set ModeDescriptionBuilder[0]=(ModeDescriptionBuilder[0]+(ModeDescriptionBuilder[1]+ "|n"))
            set ModeDescriptionBuilder[1]= "Creep Upgrades: Disabled"
            set IncomeMode = 2
        endif

        // Ability mode settings
        // To prevent breaking everything else, set the AbilityMode value to the old voting system
        if AbilityMode == 2 then // Random abilities
            set ArNotLearningAbil = true
            set ModeDescriptionBuilder[0]=(ModeDescriptionBuilder[0]+(ModeDescriptionBuilder[1]+ "|n"))
            set ModeDescriptionBuilder[1]= "Type: Random Abilities"
            set AbilityMode = 0
        elseif AbilityMode == 1 then // Pick abilities
            set ArNotLearningAbil = false
            set ModeDescriptionBuilder[0]=(ModeDescriptionBuilder[0]+(ModeDescriptionBuilder[1]+ "|n"))
            set ModeDescriptionBuilder[1]= "Type: Pick Abilities"
            set AbilityMode = 1

            set randomAbilityShops = GetUnitsOfTypeIdAll('h00G')
            call ForGroup(randomAbilityShops, function RemoveRandomAbilityShop)

            // Cleanup
            call DestroyGroup(randomAbilityShops)
            set randomAbilityShops = null
        elseif AbilityMode == 3 then // Draft abilities
            set ArNotLearningAbil = false
            set ModeDescriptionBuilder[0]=(ModeDescriptionBuilder[0]+(ModeDescriptionBuilder[1]+ "|n"))
            set ModeDescriptionBuilder[1]= "Type: Draft Abilities"
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
            set ModeDescriptionBuilder[1]=(ModeDescriptionBuilder[1]+ ", Random Hero|r")
            call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + ModeDescriptionBuilder[1]))
        elseif HeroMode == 1 then // Pick hero
            call BanningPhase_TryEnablingBanningPhase()

            set RandomHeroMode = false
            set ModeDescriptionBuilder[1]=(ModeDescriptionBuilder[1]+ ", Pick Hero|r")
            call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + ModeDescriptionBuilder[1]))
        elseif HeroMode == 3 then // Draft hero
            call BanningPhase_TryEnablingBanningPhase()

            set RandomHeroMode = false
            set ModeDescriptionBuilder[1]=(ModeDescriptionBuilder[1]+ ", Draft Hero|r")
            call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + ModeDescriptionBuilder[1]))
        elseif HeroMode == 4 then // Same-Draft hero
            call BanningPhase_TryEnablingBanningPhase()

            set RandomHeroMode = false
            set ModeDescriptionBuilder[1]=(ModeDescriptionBuilder[1]+ ", Same-Draft Hero|r")
            call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + ModeDescriptionBuilder[1]))
        endif

        // PVP betting mode settings
        if(Trig_Dialog_Complete_Func014C())then
            set BettingEnabled = false
            set udg_boolean14 = false
            set ModeDescriptionBuilder[0]=(ModeDescriptionBuilder[0]+(ModeDescriptionBuilder[1]+ "|n"))
            set ModeDescriptionBuilder[1]= "Betting: Disabled|r"
            call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + ModeDescriptionBuilder[1]))
        else
            set BettingEnabled = true
            set udg_boolean14 = false
            set ModeDescriptionBuilder[0]=(ModeDescriptionBuilder[0]+(ModeDescriptionBuilder[1]+ "|n"))
            set ModeDescriptionBuilder[1]= "Betting: Enabled (Hidden)|r"
            call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + ModeDescriptionBuilder[1]))
        endif

        call PlaySoundBJ(udg_sound03)
        set ModeDescriptionBuilder[0]=(ModeDescriptionBuilder[0]+ ModeDescriptionBuilder[1])
        call QuestSetDescriptionBJ(GetLastCreatedQuestBJ(),ModeDescriptionBuilder[0])
        call QuestSetDiscoveredBJ(GetLastCreatedQuestBJ(),true)
        
        if(Trig_Dialog_Complete_Func023001())then
            return
        endif

        call TriggerSleepAction(0.00)
        // call ForForce(GetPlayersMatching(Condition(function Trig_Dialog_Complete_Func025001001)),function Trig_Dialog_Complete_Func025A)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger77 = CreateTrigger()
        call TriggerAddCondition(udg_trigger77,Condition(function Trig_Dialog_Complete_Conditions))
        call TriggerAddAction(udg_trigger77,function Trig_Dialog_Complete_Actions)
    endfunction


endlibrary
