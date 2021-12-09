library trigger87 initializer init requires RandomShit

    function Trig_Display_Hint_Func001Func003001001001 takes nothing returns boolean
        return(IsPlayerInForce(GetFilterPlayer(),udg_force06)!=true)
    endfunction


    function Trig_Display_Hint_Func001Func001Func002001001001 takes nothing returns boolean
        return(IsPlayerInForce(GetFilterPlayer(),udg_force06)!=true)
    endfunction


    function Trig_Display_Hint_Func001Func001Func001001001001 takes nothing returns boolean
        return(IsPlayerInForce(GetFilterPlayer(),udg_force06)!=true)
    endfunction


    function Trig_Display_Hint_Actions takes nothing returns nothing
        if(Trig_Display_Hint_Func001C())then
            call DisplayTimedTextToForce(GetPlayersMatching(Condition(function Trig_Display_Hint_Func001Func003001001)),5.00,("|cff0080FFHint: " +(udg_strings01[GetRandomInt(1,udg_integers12[1])]+ "|r")))
        else
            if(Trig_Display_Hint_Func001Func001C())then
                call DisplayTimedTextToForce(GetPlayersMatching(Condition(function Trig_Display_Hint_Func001Func001Func002001001)),5.00,("|cff0080FFHint: " +(udg_strings01[GetRandomInt(1,udg_integers12[2])]+ "|r")))
            else
                call DisplayTimedTextToForce(GetPlayersMatching(Condition(function Trig_Display_Hint_Func001Func001Func001001001)),5.00,("|cff0080FFHint: " +(udg_strings01[GetRandomInt(1,udg_integers12[3])]+ "|r")))
            endif
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger87 = CreateTrigger()
        call DisableTrigger(udg_trigger87)
        call TriggerRegisterTimerEventPeriodic(udg_trigger87,60.00)
        call TriggerAddAction(udg_trigger87,function Trig_Display_Hint_Actions)
    endfunction


endlibrary
