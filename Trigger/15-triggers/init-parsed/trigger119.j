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
