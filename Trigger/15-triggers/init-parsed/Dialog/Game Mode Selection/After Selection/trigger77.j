library trigger77 initializer init requires RandomShit

    globals
        boolean EconomyMode = false
    endglobals

    function Trig_Dialog_Complete_Func026C takes nothing returns boolean
        if((udg_boolean15==false))then
            return true
        endif
        if((udg_integer63==PlayerCount))then
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


    function Trig_Dialog_Complete_Func006Func008C takes nothing returns boolean
        if(not(ModeVotesCount[1]>= ModeVotesCount[2]))then
            return false
        endif
        return true
    endfunction


    function Trig_Dialog_Complete_Func006Func008Func011001 takes nothing returns boolean
        return(InitialPlayerCount==1)
    endfunction


    function Trig_Dialog_Complete_Func006Func008Func006001 takes nothing returns boolean
        return(InitialPlayerCount==1)
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


    function Trig_Dialog_Complete_Func006Func009A takes nothing returns nothing
        call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_RESOURCE_FOOD_CAP,UnknownInteger01)
        call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_FOOD_CAP_CEILING,UnknownInteger01)
        call ResourseRefresh(GetEnumPlayer()) 
    endfunction


    function Trig_Dialog_Complete_Func006Func004C takes nothing returns boolean
        if(not(ModeVotesCount[8]> ModeVotesCount[4]))then
            return false
        endif
        return true
    endfunction


    function Trig_Dialog_Complete_Func006Func004Func005C takes nothing returns boolean
        if(not(ModeVotesCount[1]>= ModeVotesCount[2]))then
            return false
        endif
        return true
    endfunction


    function Trig_Dialog_Complete_Func006Func004Func005Func020001 takes nothing returns boolean
        return(InitialPlayerCount==1)
    endfunction


    function Trig_Dialog_Complete_Func006Func004Func005Func022001 takes nothing returns boolean
        return(PlayerCount==1)
    endfunction


    function Trig_Dialog_Complete_Func006Func004Func005Func023001 takes nothing returns boolean
        return(PlayerCount==2)
    endfunction


    function Trig_Dialog_Complete_Func006Func004Func005Func024001 takes nothing returns boolean
        return(PlayerCount==3)
    endfunction


    function Trig_Dialog_Complete_Func006Func004Func005Func025001 takes nothing returns boolean
        return(PlayerCount==4)
    endfunction


    function Trig_Dialog_Complete_Func006Func004Func005Func026001 takes nothing returns boolean
        return(PlayerCount==5)
    endfunction


    function Trig_Dialog_Complete_Func006Func004Func005Func027001 takes nothing returns boolean
        return(PlayerCount==6)
    endfunction


    function Trig_Dialog_Complete_Func006Func004Func005Func028001 takes nothing returns boolean
        return(PlayerCount==7)
    endfunction


    function Trig_Dialog_Complete_Func006Func004Func005Func029001 takes nothing returns boolean
        return(PlayerCount==8)
    endfunction


    function Trig_Dialog_Complete_Func006Func004Func005Func006001 takes nothing returns boolean
        return(InitialPlayerCount==1)
    endfunction


    function Trig_Dialog_Complete_Func006Func004Func005Func008001 takes nothing returns boolean
        return(PlayerCount==1)
    endfunction


    function Trig_Dialog_Complete_Func006Func004Func005Func009001 takes nothing returns boolean
        return(PlayerCount==2)
    endfunction


    function Trig_Dialog_Complete_Func006Func004Func005Func010001 takes nothing returns boolean
        return(PlayerCount==3)
    endfunction


    function Trig_Dialog_Complete_Func006Func004Func005Func011001 takes nothing returns boolean
        return(PlayerCount==4)
    endfunction


    function Trig_Dialog_Complete_Func006Func004Func005Func012001 takes nothing returns boolean
        return(PlayerCount==5)
    endfunction


    function Trig_Dialog_Complete_Func006Func004Func005Func013001 takes nothing returns boolean
        return(PlayerCount==6)
    endfunction


    function Trig_Dialog_Complete_Func006Func004Func005Func014001 takes nothing returns boolean
        return(PlayerCount==7)
    endfunction


    function Trig_Dialog_Complete_Func006Func004Func005Func015001 takes nothing returns boolean
        return(PlayerCount==8)
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


    function Trig_Dialog_Complete_Func006Func004Func006A takes nothing returns nothing
        call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_RESOURCE_FOOD_CAP,UnknownInteger01)
        call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_FOOD_CAP_CEILING,UnknownInteger01)
        call ResourseRefresh(GetEnumPlayer()) 
    endfunction


    function Trig_Dialog_Complete_Func008Func001C takes nothing returns boolean
        if(not(ElimModeEnabled==false))then
            return false
        endif
        if(not(udg_boolean07==false))then
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


    function Trig_Dialog_Complete_Func008Func002C takes nothing returns boolean
        if(not(ModeVotesCount[1]>= ModeVotesCount[2]))then
            return false
        endif
        return true
    endfunction


    function Trig_Dialog_Complete_Func008Func003C takes nothing returns boolean
        if(not(udg_boolean08==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Dialog_Complete_Func008Func003Func012001 takes nothing returns boolean
        return(InitialPlayerCount==1)
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


    function Trig_Dialog_Complete_Func008Func003Func006001 takes nothing returns boolean
        return(InitialPlayerCount==1)
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


    function CheckIncomeVotes takes nothing returns nothing
        if ModeVotesCount[15] > ModeVotesCount[16] and ModeVotesCount[15] > ModeVotesCount[17] and ModeVotesCount[15] > ModeVotesCount[20] then
            set IncomeMode = 0
        elseif ModeVotesCount[16] > ModeVotesCount[15] and ModeVotesCount[16] > ModeVotesCount[17] and ModeVotesCount[16] > ModeVotesCount[20] then
            set IncomeMode = 1
        elseif ModeVotesCount[20] > ModeVotesCount[15] and ModeVotesCount[20] > ModeVotesCount[16] and ModeVotesCount[20] > ModeVotesCount[17] then
            set IncomeMode = 3
        else
            set IncomeMode = 2	
        endif
    endfunction


    function CheckAbilityVotes takes nothing returns nothing
        //random
        if ModeVotesCount[7] > ModeVotesCount[6] and ModeVotesCount[7] > ModeVotesCount[19] then
            set AbilityMode = 0
    
            //pick
        elseif ModeVotesCount[6] > ModeVotesCount[7] and ModeVotesCount[6] > ModeVotesCount[19] then
            set AbilityMode = 1
    
            //draft
        elseif ModeVotesCount[19] > ModeVotesCount[6] and ModeVotesCount[19] > ModeVotesCount[7] then
            set AbilityMode = 2
    
            //if tie just do ap
        else
            set AbilityMode = 1
        endif
    endfunction


    function Trig_Dialog_Complete_Func010Func004A takes nothing returns nothing
        call DeleteUnit(GetEnumUnit())
    endfunction


    function Trig_Dialog_Complete_Func012C takes nothing returns boolean
        if(not(ModeVotesCount[14]> ModeVotesCount[13]))then
            return false
        endif
        return true
    endfunction


    function Trig_Dialog_Complete_Func014Func001Func003C takes nothing returns boolean
        if(not(ModeVotesCount[11]> ModeVotesCount[9]))then
            return false
        endif
        if(not(ModeVotesCount[11]> ModeVotesCount[10]))then
            return false
        endif
        return true
    endfunction


    function Trig_Dialog_Complete_Func014Func001C takes nothing returns boolean
        if((ElimModeEnabled==true))then
            return true
        endif
        if((InitialPlayerCount <= 2))then
            return true
        endif
        if(Trig_Dialog_Complete_Func014Func001Func003C())then
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


    function Trig_Dialog_Complete_Func014Func007Func011C takes nothing returns boolean
        if(not(ModeVotesCount[10]> ModeVotesCount[9]))then
            return false
        endif
        if(not(ModeVotesCount[10]> ModeVotesCount[11]))then
            return false
        endif
        return true
    endfunction


    function Trig_Dialog_Complete_Func014Func007C takes nothing returns boolean
        if(not Trig_Dialog_Complete_Func014Func007Func011C())then
            return false
        endif
        return true
    endfunction


    function Trig_Dialog_Complete_Func023001 takes nothing returns boolean
        return(udg_boolean16==false)
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
        call ConditionalTriggerExecute(udg_trigger79)
    endfunction


    function Trig_Dialog_Complete_Actions takes nothing returns nothing
        call DisableTrigger(GetTriggeringTrigger())
        set udg_strings02[0]= ""
        call ClearTextMessagesBJ(GetPlayersAll())
        set ElimModeEnabled = false
        set udg_boolean07 = false
        
        if(Trig_Dialog_Complete_Func008C())then
            if(Trig_Dialog_Complete_Func008Func002C())then
                call DisableTrigger(GetTriggeringTrigger())
                //call BJDebugMsg("25 lvls")
                set udg_boolean08 = true
            else
                call DisableTrigger(GetTriggeringTrigger())
                //call BJDebugMsg("50 lvls")
                set udg_boolean08 = false
            endif

            if Trig_Dialog_Complete_Func006Func004C() then
                set udg_strings02[1]= "Mode: Immortal|r"
            else
                set udg_strings02[1]= "Mode: Normal|r"
            endif
    
            //boolean08
            if(Trig_Dialog_Complete_Func008Func003C())then
                set udg_strings02[1] = udg_strings02[1] + " (25 Levels)|r"
                call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
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
                set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
                set udg_strings02[1]= "PvP: Every 5th Level|r"
                if(Trig_Dialog_Complete_Func008Func003Func012001())then
                    set udg_strings02[1]= "PvP: None|r"
                else
                    call DoNothing()
                endif
                call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
                call ForForce(GetPlayersMatching(Condition(function Trig_Dialog_Complete_Func008Func003Func014001001)),function Trig_Dialog_Complete_Func008Func003Func014A)
            else
                set BattleRoyalRound = 50
                set udg_strings02[1] = udg_strings02[1] + " (50 Levels)|r"
                call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
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
                set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
                set udg_strings02[1]= "PvP: Every 5th Level|r"
                if(Trig_Dialog_Complete_Func008Func003Func006001())then
                    set udg_strings02[1]= "PvP: None|r"
                else
                    call DoNothing()
                endif
                call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
                call ForForce(GetPlayersMatching(Condition(function Trig_Dialog_Complete_Func008Func003Func008001001)),function Trig_Dialog_Complete_Func008Func003Func008A)
            endif
        else
        endif
        call CheckIncomeVotes()
        if IncomeMode == 0 then
            set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
            set udg_strings02[1]= "Creep Upgrades: Enabled"
        elseif IncomeMode == 1 then
            set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
            set udg_strings02[1]= "Creep Upgrades: Individual"
        elseif IncomeMode == 3 then
            set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
            set udg_strings02[1]= "Creep Upgrades: Economy"
        else
            set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
            set udg_strings02[1]= "Creep Upgrades: Disabled"
        endif
        call CheckAbilityVotes()
        if AbilityMode == 0 then
            set ArNotLearningAbil = true
            set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
            set udg_strings02[1]= "Type: Random Abilities"
        elseif AbilityMode == 1 then
            set ArNotLearningAbil = false
            set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
            set udg_strings02[1]= "Type: Pick Abilities"
            call ForGroupBJ(GetUnitsOfTypeIdAll('n016'),function Trig_Dialog_Complete_Func010Func004A)
    
            //Draft mode
        elseif AbilityMode == 2 then
            set ArNotLearningAbil = false
            set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
            set udg_strings02[1]= "Type: Draft Abilities"
            call ForGroupBJ(GetUnitsOfTypeIdAll('n016'),function Trig_Dialog_Complete_Func010Func004A)
        endif
        if(Trig_Dialog_Complete_Func012C())then
            set udg_boolean16 = true
            set udg_strings02[1]=(udg_strings02[1]+ ", Random Hero|r")
            call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
        else
            set udg_boolean16 = false
            set udg_strings02[1]=(udg_strings02[1]+ ", Pick Hero|r")
            call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
        endif
        if(Trig_Dialog_Complete_Func014C())then
            set udg_boolean13 = false
            set udg_boolean14 = false
            set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
            set udg_strings02[1]= "Betting: Disabled|r"
            call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
        else
            if(Trig_Dialog_Complete_Func014Func007C())then
                set udg_boolean13 = true
                set udg_boolean14 = false
                set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
                set udg_strings02[1]= "Betting: Enabled (Hidden)|r"
                call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
            else
                set udg_boolean13 = true
                set udg_boolean14 = true
                set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
                set udg_strings02[1]= "Betting: Enabled (Show)|r"
                call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
            endif
        endif
        call PlaySoundBJ(udg_sound03)
        call ConditionalTriggerExecute(udg_trigger90)
        set udg_strings02[0]=(udg_strings02[0]+ udg_strings02[1])
        call QuestSetDescriptionBJ(GetLastCreatedQuestBJ(),udg_strings02[0])
        call QuestSetDiscoveredBJ(GetLastCreatedQuestBJ(),true)
        if(Trig_Dialog_Complete_Func023001())then
            return
        else
            call DoNothing()
        endif
        call TriggerSleepAction(0.00)
        call ForForce(GetPlayersMatching(Condition(function Trig_Dialog_Complete_Func025001001)),function Trig_Dialog_Complete_Func025A)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger77 = CreateTrigger()
        call TriggerAddCondition(udg_trigger77,Condition(function Trig_Dialog_Complete_Conditions))
        call TriggerAddAction(udg_trigger77,function Trig_Dialog_Complete_Actions)
    endfunction


endlibrary
