library trigger56 initializer init requires RandomShit

    function Trig_Voting_Rights_Initialization_Func003C takes nothing returns boolean
        if(not(udg_integer13==1))then
            return false
        endif
        return true
    endfunction


    function Trig_Voting_Rights_Initialization_Func007Func001C takes nothing returns boolean
        if(not(GetPlayerController(ConvertedPlayer(GetForLoopIndexA()))==MAP_CONTROL_USER))then
            return false
        endif
        if(not(GetPlayerSlotState(ConvertedPlayer(GetForLoopIndexA()))==PLAYER_SLOT_STATE_PLAYING))then
            return false
        endif
        return true
    endfunction


    function Trig_Voting_Rights_Initialization_Func016C takes nothing returns boolean
        if(not(IsTriggerEnabled(udg_trigger55)!=true))then
            return false
        endif
        return true
    endfunction


    function Trig_Voting_Rights_Initialization_Actions takes nothing returns nothing
        call ConditionalTriggerExecute(udg_trigger131)
        if(Trig_Voting_Rights_Initialization_Func003C())then
            call TriggerExecute(udg_trigger57)
            return
        else
        endif
        call DialogSetMessageBJ(udg_dialog06,"Voting Rights")
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 8
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            if(Trig_Voting_Rights_Initialization_Func007Func001C())then
                call DialogAddButtonBJ(udg_dialog06,GetPlayerNameColour(ConvertedPlayer(GetForLoopIndexA())))
                set udg_buttons04[GetForLoopIndexA()]= GetLastCreatedButtonBJ()
                exitwhen true
            else
            endif
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
        call DialogAddButtonBJ(udg_dialog06,"Everyone")
        set udg_buttons04[0]= GetLastCreatedButtonBJ()
        call DialogDisplayBJ(true,udg_dialog06,udg_player03)
        call CreateTimerDialogBJ(GetLastCreatedTimerBJ(),"Please wait!")
        call StartTimerBJ(GetLastCreatedTimerBJ(),false,5.00)
        call TriggerSleepAction(5.00)
        if(Trig_Voting_Rights_Initialization_Func016C())then
            call DialogDisplayBJ(false,udg_dialog06,udg_player03)
            call TriggerExecute(udg_trigger58)
        else
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger56 = CreateTrigger()
        call TriggerRegisterTimerEventSingle(udg_trigger56,0.00)
        call TriggerAddAction(udg_trigger56,function Trig_Voting_Rights_Initialization_Actions)
    endfunction


endlibrary
