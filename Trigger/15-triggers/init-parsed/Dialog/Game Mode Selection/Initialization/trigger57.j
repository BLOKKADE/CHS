library trigger57 initializer init requires RandomShit

    function Trig_Game_Master_Selects_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()!=udg_buttons04[0]))then
            return false
        endif
        return true
    endfunction


    function Trig_Game_Master_Selects_Func001Func001C takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons04[GetForLoopIndexA()]))then
            return false
        endif
        return true
    endfunction

    function Trig_Game_Master_Selects_Func007001001 takes nothing returns boolean
        return(GetFilterPlayer()!=udg_player03)
    endfunction


    function Trig_Game_Master_Selects_Actions takes nothing returns nothing
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 8
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            if(Trig_Game_Master_Selects_Func001Func001C())then
                set udg_player03 = ConvertedPlayer(GetForLoopIndexA())
                exitwhen true
            endif
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop

        // Only the admin player votes
        set udg_boolean15 = false
        call ConditionalTriggerExecute(udg_trigger55)

        // Don't show the message if there is only 1 person in the game
        if(InitialPlayerCount==1)then
            return
        endif

        // Show the message to everyone except the admin player
        call DisplayTimedTextToForce(GetPlayersMatching(Condition(function Trig_Game_Master_Selects_Func007001001)),8.00,"|cffffcc00Please wait! The host is choosing a game mode.")
        call PlaySoundBJ(udg_sound25)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger57 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger57,udg_dialog06)
        call TriggerAddCondition(udg_trigger57,Condition(function Trig_Game_Master_Selects_Conditions))
        call TriggerAddAction(udg_trigger57,function Trig_Game_Master_Selects_Actions)
    endfunction


endlibrary
