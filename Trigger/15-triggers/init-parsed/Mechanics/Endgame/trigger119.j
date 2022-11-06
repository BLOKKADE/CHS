library trigger119 initializer init requires RandomShit

    function Trig_End_Game_Conditions takes nothing returns boolean
        if(not(udg_boolean11==true))then
            return false
        endif
        if(not(IsTriggerEnabled(GetTriggeringTrigger())==true))then
            return false
        endif
        return true
    endfunction


    function Trig_End_Game_Func003Func007Func001C takes nothing returns boolean
        if((udg_boolean07==true))then
            return true
        endif
        if((ElimModeEnabled==true))then
            return true
        endif
        return false
    endfunction


    function Trig_End_Game_Func003Func007Func002C takes nothing returns boolean
        if(not(GameModeShort==true))then
            return false
        endif
        if(not(RoundNumber==25))then
            return false
        endif
        if(not(ElimModeEnabled==false))then
            return false
        endif
        return true
    endfunction


    function Trig_End_Game_Func003Func007Func003C takes nothing returns boolean
        if(not(GameModeShort==false))then
            return false
        endif
        if(not(RoundNumber==50))then
            return false
        endif
        if(not(ElimModeEnabled==false))then
            return false
        endif
        return true
    endfunction


    function Trig_End_Game_Func003Func007C takes nothing returns boolean
        if(Trig_End_Game_Func003Func007Func001C())then
            return true
        endif
        if(Trig_End_Game_Func003Func007Func002C())then
            return true
        endif
        if(Trig_End_Game_Func003Func007Func003C())then
            return true
        endif
        return false
    endfunction


    function Trig_End_Game_Func003C takes nothing returns boolean
        if(not Trig_End_Game_Func003Func007C())then
            return false
        endif
        return true
    endfunction


    function Trig_End_Game_Actions takes nothing returns nothing
        if(Trig_End_Game_Func003C())then
            call DisableTrigger(GetTriggeringTrigger())
            set udg_boolean09 = true
            call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
            call TriggerSleepAction(8.00)
            call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 120, "The game has finished, you can leave whenever you want.")
        else
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger119 = CreateTrigger()
        call TriggerAddCondition(udg_trigger119,Condition(function Trig_End_Game_Conditions))
        call TriggerAddAction(udg_trigger119,function Trig_End_Game_Actions)
    endfunction


endlibrary
