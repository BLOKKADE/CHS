library trigger108 initializer init requires RandomShit

    function Trig_Level_Completed_Actions takes nothing returns nothing
        local integer round = udg_integer02 + 1
        if(Trig_Level_Completed_Func001C())then
            if(Trig_Level_Completed_Func001Func001001())then
                return
            else
                call DoNothing()
            endif
            call DisableTrigger(udg_trigger110)
            call StopSuddenDeathTimer()
            call DisableTrigger(udg_trigger116)
            call ConditionalTriggerExecute(udg_trigger122)
            call ConditionalTriggerExecute(udg_trigger119)
            set udg_boolean01 = true
            set udg_integer08 = 0
            call PlaySoundBJ(udg_sound02)
            if(Trig_Level_Completed_Func001Func014C())then
                if(Trig_Level_Completed_Func001Func014Func001C())then
                    call ConditionalTriggerExecute(udg_trigger152)
                    return
                endif
            endif
            if(Trig_Level_Completed_Func001Func018C())then
                if(Trig_Level_Completed_Func001Func018Func002C())then
                    call GroupClear(udg_group03)
                    call ConditionalTriggerExecute(udg_trigger134)
                    return
                endif
            else
                if(Trig_Level_Completed_Func001Func018Func001C())then
                    call GroupClear(udg_group03)
                    call ConditionalTriggerExecute(udg_trigger134)
                    return
                endif
            endif
            if(Trig_Level_Completed_Func001Func023C())then
                if(Trig_Level_Completed_Func001Func023Func002C())then
                    if(Trig_Level_Completed_Func001Func023Func002Func003C())then
                        call ConditionalTriggerExecute(udg_trigger119)
                    else
                        call ConditionalTriggerExecute(udg_trigger42)
                    endif
                    return
                endif
            else
                if(Trig_Level_Completed_Func001Func023Func001C())then
                    if(Trig_Level_Completed_Func001Func023Func001Func003C())then
                        call ConditionalTriggerExecute(udg_trigger119)
                    else
                        call ConditionalTriggerExecute(udg_trigger42)
                    endif
                    return
                endif
            endif
            call ConditionalTriggerExecute(udg_trigger103)
            call CreateTimerDialogBJ(GetLastCreatedTimerBJ(),"Next Level ...")
            set NextRound[round] = true
            if(Trig_Level_Completed_Func001Func028C())then
                call StartTimerBJ(GetLastCreatedTimerBJ(),false, RoundTime)
                call TriggerSleepAction(RoundTime)
            else
                call StartTimerBJ(GetLastCreatedTimerBJ(),false,RoundTime * 0.75)
                call TriggerSleepAction(RoundTime * 0.75)
            endif
    
            if NextRound[round] then
                call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
                call TriggerExecute(udg_trigger109)
            endif
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger108 = CreateTrigger()
        call TriggerAddAction(udg_trigger108,function Trig_Level_Completed_Actions)
    endfunction


endlibrary
