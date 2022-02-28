library trigger108 initializer init requires RandomShit, EconomyCreepBonus

    globals
        integer BattleRoyalRound = 50
    endglobals

    function Trig_Level_Completed_Func001C takes nothing returns boolean
        if(not(RoundFinishedCount >= PlayerCount))then
            return false
        endif
        return true
    endfunction

    function Trig_Level_Completed_Func001Func001001001 takes nothing returns boolean
        return(IsTriggerEnabled(udg_trigger119)!=true)
    endfunction
    
    function Trig_Level_Completed_Func001Func001001002001 takes nothing returns boolean
        return(udg_boolean11!=true)
    endfunction
    
    function Trig_Level_Completed_Func001Func001001002002001 takes nothing returns boolean
        return(IsTriggerEnabled(udg_trigger118)!=true)
    endfunction
    
    function Trig_Level_Completed_Func001Func001001002002002 takes nothing returns boolean
        return(InitialPlayerCount!=1)
    endfunction
    
    function Trig_Level_Completed_Func001Func001001002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Level_Completed_Func001Func001001002002001(),Trig_Level_Completed_Func001Func001001002002002())
    endfunction
    
    function Trig_Level_Completed_Func001Func001001002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Level_Completed_Func001Func001001002001(),Trig_Level_Completed_Func001Func001001002002())
    endfunction
    
    function Trig_Level_Completed_Func001Func001001 takes nothing returns boolean
        return GetBooleanOr(Trig_Level_Completed_Func001Func001001001(),Trig_Level_Completed_Func001Func001001002())
    endfunction


    function Trig_Level_Completed_Func001Func014C takes nothing returns boolean
        if(not(udg_boolean04==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Level_Completed_Func001Func014Func001Func001Func002C takes nothing returns boolean
        if((RoundNumber==5))then
            return true
        endif
        if((RoundNumber==10))then
            return true
        endif
        if((RoundNumber==15))then
            return true
        endif
        if((RoundNumber==20))then
            return true
        endif
        if((RoundNumber==25))then
            return true
        endif
        if((RoundNumber==30))then
            return true
        endif
        if((RoundNumber==35))then
            return true
        endif
        return false
    endfunction


    function Trig_Level_Completed_Func001Func014Func001Func001C takes nothing returns boolean
        if(not(PlayerCount > 1))then
            return false
        endif
        if(not Trig_Level_Completed_Func001Func014Func001Func001Func002C())then
            return false
        endif
        return true
    endfunction


    function Trig_Level_Completed_Func001Func014Func001C takes nothing returns boolean
        if(not Trig_Level_Completed_Func001Func014Func001Func001C())then
            return false
        endif
        return true
    endfunction


    function Trig_Level_Completed_Func001Func018C takes nothing returns boolean
        if(not(udg_boolean08==true))then
            return false
        endif
        if(not(udg_boolean04==false))then
            return false
        endif
        return true
    endfunction


    function Trig_Level_Completed_Func001Func018Func002Func004Func001C takes nothing returns boolean
        if((RoundNumber==5))then
            return true
        endif
        if((RoundNumber==10))then
            return true
        endif
        if((RoundNumber==15))then
            return true
        endif
        if((RoundNumber==20))then
            return true
        endif
        return false
    endfunction


    function Trig_Level_Completed_Func001Func018Func002Func004C takes nothing returns boolean
        if(not Trig_Level_Completed_Func001Func018Func002Func004Func001C())then
            return false
        endif
        if(not(PlayerCount > 1))then
            return false
        endif
        if(not(udg_boolean04==false))then
            return false
        endif
        return true
    endfunction


    function Trig_Level_Completed_Func001Func018Func002C takes nothing returns boolean
        if(not Trig_Level_Completed_Func001Func018Func002Func004C())then
            return false
        endif
        return true
    endfunction


    function Trig_Level_Completed_Func001Func018Func001Func004Func001C takes nothing returns boolean
    
        if MorePvp == 0 then
            if((RoundNumber==10))then
                return true
            endif
            if((RoundNumber==20))then
                return true
            endif
            if((RoundNumber==30))then
                return true
            endif
            if((RoundNumber==40))then
                return true
            endif
        else
    
            if((RoundNumber==5))then
                return true
            endif
            if((RoundNumber==10))then
                return true
            endif
            if((RoundNumber==15))then
                return true
            endif
            if((RoundNumber==20))then
                return true
            endif
            if((RoundNumber==25))then
                return true
            endif
            if((RoundNumber==30))then
                return true
            endif	
            if((RoundNumber==35))then
                return true
            endif	
            if((RoundNumber==40))then
                return true
            endif	
            if((RoundNumber==45))then
                return true
            endif	
    
    
        endif
    
    
        return false
    endfunction


    function Trig_Level_Completed_Func001Func018Func001Func004C takes nothing returns boolean
        if(not Trig_Level_Completed_Func001Func018Func001Func004Func001C())then
            return false
        endif
        if(not(PlayerCount > 1))then
            return false
        endif
        if(not(udg_boolean04==false))then
            return false
        endif
        return true
    endfunction


    function Trig_Level_Completed_Func001Func018Func001C takes nothing returns boolean
        if(not Trig_Level_Completed_Func001Func018Func001Func004C())then
            return false
        endif
        return true
    endfunction


    function Trig_Level_Completed_Func001Func023C takes nothing returns boolean
        if(not(udg_boolean08==true))then
            return false
        endif
        if(not(udg_boolean04==false))then
            return false
        endif
        return true
    endfunction


    function Trig_Level_Completed_Func001Func023Func002C takes nothing returns boolean
        if(not(RoundNumber==BattleRoyalRound))then
            return false
        endif
        if(not(udg_boolean04==false))then
            return false
        endif
        return true
    endfunction


    function Trig_Level_Completed_Func001Func023Func002Func003C takes nothing returns boolean
        if(not(PlayerCount==1))then
            return false
        endif
        return true
    endfunction


    function Trig_Level_Completed_Func001Func023Func001C takes nothing returns boolean
        if(not(RoundNumber==BattleRoyalRound))then
            return false
        endif
        if(not(udg_boolean04==false))then
            return false
        endif
        return true
    endfunction


    function Trig_Level_Completed_Func001Func023Func001Func003C takes nothing returns boolean
        if(not(PlayerCount==1))then
            return false
        endif
        return true
    endfunction


    function Trig_Level_Completed_Func001Func028C takes nothing returns boolean
        if(not(RoundNumber <= 3))then
            return false
        endif
        return true
    endfunction


    function Trig_Level_Completed_Actions takes nothing returns nothing
        local integer round = RoundNumber + 1
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
            
            set RoundFinishedCount = 0
            call PlaySoundBJ(udg_sound02)
            if(Trig_Level_Completed_Func001Func014C())then
                if(Trig_Level_Completed_Func001Func014Func001C())then
                    call ConditionalTriggerExecute(udg_trigger152)
                    return
                endif
            endif
            if(Trig_Level_Completed_Func001Func018C())then
                if(Trig_Level_Completed_Func001Func018Func002C())then
                    call GroupClear(DuelWinners)
                    call ConditionalTriggerExecute(udg_trigger134)
                    return
                endif
            else
                if(Trig_Level_Completed_Func001Func018Func001C())then
                    call GroupClear(DuelWinners)
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

            if IncomeMode == 3 then
                call SetEconomyCreepBonus()
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
