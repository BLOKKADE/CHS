library trigger62 initializer init requires RandomShit

    function Trig_Skip_Betting_Menu_Func001Func003Func002C takes nothing returns boolean
        if(not(ModeVotesCount[5]> ModeVotesCount[4]))then
            return false
        endif
        if(not(ModeVotesCount[5]> ModeVotesCount[8]))then
            return false
        endif
        if(not(udg_boolean15==false))then
            return false
        endif
        return true
    endfunction


    function Trig_Skip_Betting_Menu_Func001Func003C takes nothing returns boolean
        if((InitialPlayerCount <= 2))then
            return true
        endif
        if(Trig_Skip_Betting_Menu_Func001Func003Func002C())then
            return true
        endif
        return false
    endfunction


    function Trig_Skip_Betting_Menu_Func001C takes nothing returns boolean
        if(not Trig_Skip_Betting_Menu_Func001Func003C())then
            return false
        endif
        return true
    endfunction


    function Trig_Skip_Betting_Menu_Actions takes nothing returns nothing
        if(Trig_Skip_Betting_Menu_Func001C())then
            set udg_integer63 =(udg_integer63 + 1)
            call ConditionalTriggerExecute(udg_trigger77)
        else
            call DialogDisplayBJ(true,BettingModeDialog,GetTriggerPlayer())
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger62 = CreateTrigger()
        call TriggerAddAction(udg_trigger62,function Trig_Skip_Betting_Menu_Actions)
    endfunction


endlibrary
