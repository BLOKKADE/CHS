library trigger131 initializer init requires RandomShit

    function Trig_Select_Game_Master_Func001Func001C takes nothing returns boolean
        if(not(GetPlayerController(ConvertedPlayer(GetForLoopIndexA()))==MAP_CONTROL_USER))then
            return false
        endif
        if(not(GetPlayerSlotState(ConvertedPlayer(GetForLoopIndexA()))==PLAYER_SLOT_STATE_PLAYING))then
            return false
        endif
        return true
    endfunction


    function Trig_Select_Game_Master_Actions takes nothing returns nothing
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 8
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            if(Trig_Select_Game_Master_Func001Func001C())then
                set udg_player03 = ConvertedPlayer(GetForLoopIndexA())
                exitwhen true
            else
            endif
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger131 = CreateTrigger()
        call TriggerAddAction(udg_trigger131,function Trig_Select_Game_Master_Actions)/*
    endfunction


endlibrary
