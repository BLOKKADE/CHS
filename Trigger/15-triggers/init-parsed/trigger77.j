library trigger77 initializer init requires RandomShit

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


    function Trig_Dialog_Complete_Func006Func009A takes nothing returns nothing
        call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_RESOURCE_FOOD_CAP,udg_integer31)
        call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_FOOD_CAP_CEILING,udg_integer31)
        call ResourseRefresh(GetEnumPlayer()) 
    endfunction


    function Trig_Dialog_Complete_Func006Func004Func006001001001001 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(8))
    endfunction


    function Trig_Dialog_Complete_Func006Func004Func006A takes nothing returns nothing
        call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_RESOURCE_FOOD_CAP,udg_integer31)
        call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_FOOD_CAP_CEILING,udg_integer31)
        call ResourseRefresh(GetEnumPlayer()) 
    endfunction


    function Trig_Dialog_Complete_Func008Func003Func014001001001001 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(8))
    endfunction


    function Trig_Dialog_Complete_Func008Func003Func014A takes nothing returns nothing
        call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_RESOURCE_FOOD_CAP,25)
        call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_FOOD_CAP_CEILING,25)
        call ResourseRefresh(GetEnumPlayer()) 
    endfunction


    function Trig_Dialog_Complete_Func008Func003Func008001001001001 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(8))
    endfunction


    function Trig_Dialog_Complete_Func008Func003Func008A takes nothing returns nothing
        call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_RESOURCE_FOOD_CAP,50)
        call SetPlayerStateBJ(GetEnumPlayer(),PLAYER_STATE_FOOD_CAP_CEILING,50)
        call ResourseRefresh(GetEnumPlayer()) 
    endfunction


    function Trig_Dialog_Complete_Func010Func004A takes nothing returns nothing
        call DeleteUnit(GetEnumUnit())
    endfunction


    function Trig_Dialog_Complete_Func010Func004A takes nothing returns nothing
        call DeleteUnit(GetEnumUnit())
    endfunction


    function Trig_Dialog_Complete_Func025001001001001 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(8))
    endfunction


    function Trig_Dialog_Complete_Func025A takes nothing returns nothing
        set udg_player02 = GetEnumPlayer()
        call ConditionalTriggerExecute(udg_trigger79)
    endfunction


    function Trig_Dialog_Complete_Actions takes nothing returns nothing
        call DisableTrigger(GetTriggeringTrigger())
        set udg_strings02[0]= ""
        call ClearTextMessagesBJ(GetPlayersAll())
        if(Trig_Dialog_Complete_Func006C())then
            call DisableTrigger(GetTriggeringTrigger())
            set udg_boolean04 = true
            set udg_integer31 =(udg_integer06 * 5)
            set udg_integer31 =(udg_integer31 - 5)
            if(Trig_Dialog_Complete_Func006Func008C())then
                set udg_strings02[1]= "Mode: Elimination (Hard)|r"
                call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
                set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
                set udg_strings02[1]= "PvP: Every 5th Level|r"
                if(Trig_Dialog_Complete_Func006Func008Func011001())then
                    set udg_strings02[1]= "PvP: None|r"
                else
                    call DoNothing()
                endif
                call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
            else
                set udg_strings02[1]= "Mode: Elimination (Normal)|r"
                call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
                set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
                set udg_strings02[1]= "PvP: Every 5th Level|r"
                if(Trig_Dialog_Complete_Func006Func008Func006001())then
                    set udg_strings02[1]= "PvP: None|r"
                else
                    call DoNothing()
                endif
                call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
            endif
            call DisplayTimedTextToForce(GetPlayersAll(),15,"|c00ff2c2cElimination mode will likely be removed in the future! Let us know on discord if you disagree.|r")
            call ForForce(GetPlayersMatching(Condition(function Trig_Dialog_Complete_Func006Func009001001)),function Trig_Dialog_Complete_Func006Func009A)
        else
            set udg_boolean04 = false
            if(Trig_Dialog_Complete_Func006Func004C())then
                call DisableTrigger(GetTriggeringTrigger())
                set udg_boolean07 = true
                if(Trig_Dialog_Complete_Func006Func004Func005C())then
                    set udg_strings02[1]= "Mode: Death Match (Hard)|r"
                    call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
                    set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
                    set udg_strings02[1]= "PvP: Every 5th Level|r"
                    if(Trig_Dialog_Complete_Func006Func004Func005Func020001())then
                        set udg_strings02[1]= "PvP: None|r"
                    else
                        call DoNothing()
                    endif
                    call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
                    if(Trig_Dialog_Complete_Func006Func004Func005Func022001())then
                        set udg_integer31 = 0
                    else
                        call DoNothing()
                    endif
                    if(Trig_Dialog_Complete_Func006Func004Func005Func023001())then
                        set udg_integer31 = 5
                    else
                        call DoNothing()
                    endif
                    if(Trig_Dialog_Complete_Func006Func004Func005Func024001())then
                        set udg_integer31 = 5
                    else
                        call DoNothing()
                    endif
                    if(Trig_Dialog_Complete_Func006Func004Func005Func025001())then
                        set udg_integer31 = 10
                    else
                        call DoNothing()
                    endif
                    if(Trig_Dialog_Complete_Func006Func004Func005Func026001())then
                        set udg_integer31 = 10
                    else
                        call DoNothing()
                    endif
                    if(Trig_Dialog_Complete_Func006Func004Func005Func027001())then
                        set udg_integer31 = 10
                    else
                        call DoNothing()
                    endif
                    if(Trig_Dialog_Complete_Func006Func004Func005Func028001())then
                        set udg_integer31 = 10
                    else
                        call DoNothing()
                    endif
                    if(Trig_Dialog_Complete_Func006Func004Func005Func029001())then
                        set udg_integer31 = 15
                    else
                        call DoNothing()
                    endif
                    set udg_boolean08 = true
                else
                    set udg_strings02[1]= "Mode: Death Match (Normal)|r"
                    call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
                    set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
                    set udg_strings02[1]= "PvP: Every 10th Level|r"
                    if(Trig_Dialog_Complete_Func006Func004Func005Func006001())then
                        set udg_strings02[1]= "PvP: None|r"
                    else
                        call DoNothing()
                    endif
                    call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
                    if(Trig_Dialog_Complete_Func006Func004Func005Func008001())then
                        set udg_integer31 = 0
                    else
                        call DoNothing()
                    endif
                    if(Trig_Dialog_Complete_Func006Func004Func005Func009001())then
                        set udg_integer31 = 10
                    else
                        call DoNothing()
                    endif
                    if(Trig_Dialog_Complete_Func006Func004Func005Func010001())then
                        set udg_integer31 = 10
                    else
                        call DoNothing()
                    endif
                    if(Trig_Dialog_Complete_Func006Func004Func005Func011001())then
                        set udg_integer31 = 20
                    else
                        call DoNothing()
                    endif
                    if(Trig_Dialog_Complete_Func006Func004Func005Func012001())then
                        set udg_integer31 = 20
                    else
                        call DoNothing()
                    endif
                    if(Trig_Dialog_Complete_Func006Func004Func005Func013001())then
                        set udg_integer31 = 20
                    else
                        call DoNothing()
                    endif
                    if(Trig_Dialog_Complete_Func006Func004Func005Func014001())then
                        set udg_integer31 = 20
                    else
                        call DoNothing()
                    endif
                    if(Trig_Dialog_Complete_Func006Func004Func005Func015001())then
                        set udg_integer31 = 30
                    else
                        call DoNothing()
                    endif
                    set udg_boolean08 = false
                endif
                call DisplayTimedTextToForce(GetPlayersAll(),15,"|c00ff2c2cDeath Match mode will likely be removed in the future! Let us know on discord if you disagree.|r")
                call ForForce(GetPlayersMatching(Condition(function Trig_Dialog_Complete_Func006Func004Func006001001)),function Trig_Dialog_Complete_Func006Func004Func006A)
            else
                set udg_boolean07 = false
            endif
        endif
        if(Trig_Dialog_Complete_Func008C())then
            if(Trig_Dialog_Complete_Func008Func002C())then
                call DisableTrigger(GetTriggeringTrigger())
                set udg_boolean08 = true
            else
                call DisableTrigger(GetTriggeringTrigger())
                set udg_boolean08 = false
            endif
    
            //boolean08
            if(Trig_Dialog_Complete_Func008Func003C())then
                set udg_strings02[1]= "Mode: Normal (25 Levels)|r"
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
                if(Trig_Dialog_Complete_Func008Func003Func012001())then
                    set udg_strings02[1]= "PvP: None|r"
                else
                    call DoNothing()
                endif
                call DisplayTimedTextToForce(GetPlayersAll(),udg_real04,("|c00F08000" + udg_strings02[1]))
                call ForForce(GetPlayersMatching(Condition(function Trig_Dialog_Complete_Func008Func003Func014001001)),function Trig_Dialog_Complete_Func008Func003Func014A)
            else
                set udg_strings02[1]= "Mode: Normal (50 Levels)|r"
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
        else
            set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
            set udg_strings02[1]= "Creep Upgrades: Disabled"
        endif
        call CheckAbilityVotes()
        if AbilityMode == 0 then
            set udg_boolean05 = true
            set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
            set udg_strings02[1]= "Type: Random Abilities"
        elseif AbilityMode == 1 then
            set udg_boolean05 = false
            set udg_strings02[0]=(udg_strings02[0]+(udg_strings02[1]+ "|n"))
            set udg_strings02[1]= "Type: Pick Abilities"
            call ForGroupBJ(GetUnitsOfTypeIdAll('n016'),function Trig_Dialog_Complete_Func010Func004A)
    
            //Draft mode
        elseif AbilityMode == 2 then
            set udg_boolean05 = false
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
