library trigger108 initializer init requires RandomShit, EconomyCreepBonus, VotingResults

    globals
        integer BattleRoyalRound = 50
    endglobals

    function Trig_Level_Completed_Func001Func001001 takes nothing returns boolean
        return (IsTriggerEnabled(udg_trigger119)!=true) or (udg_boolean11!=true and IsTriggerEnabled(udg_trigger118)!=true and InitialPlayerCount!=1)
    endfunction

    function Trig_Level_Completed_Func001Func018Func002C takes nothing returns boolean
        return (PlayerCount > 1) and (ElimModeEnabled==false) and (RoundNumber==5 or RoundNumber==10 or RoundNumber==15 or RoundNumber==20)
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

    function Trig_Level_Completed_Func001Func018Func001C takes nothing returns boolean
        return Trig_Level_Completed_Func001Func018Func001Func004Func001C() and (PlayerCount > 1) and (ElimModeEnabled==false)
    endfunction

    function Trig_Level_Completed_Actions takes nothing returns nothing
        local integer round = RoundNumber + 1
        if(RoundFinishedCount >= PlayerCount)then
            if(Trig_Level_Completed_Func001Func001001())then
                return
            endif
            call DisableTrigger(udg_trigger110)
            call StopSuddenDeathTimer()
            call DisableTrigger(udg_trigger116)
            call ConditionalTriggerExecute(EndGameTrigger)
            call ConditionalTriggerExecute(udg_trigger119)
            
            set RoundFinishedCount = 0
            call PlaySoundBJ(udg_sound02)
            if(GameModeShort==true and ElimModeEnabled==false)then
                if(Trig_Level_Completed_Func001Func018Func002C())then
                    call ConditionalTriggerExecute(InitializePvpTrigger)
                    return
                endif
            else
                if(Trig_Level_Completed_Func001Func018Func001C())then
                    call ConditionalTriggerExecute(InitializePvpTrigger)
                    return
                endif
            endif

            if(GameModeShort==true and ElimModeEnabled==false)then
                if(RoundNumber==BattleRoyalRound and ElimModeEnabled==false)then
                    if(PlayerCount==1)then
                        //end game
                        call ConditionalTriggerExecute(udg_trigger119)
                    else
                        //battle royal
                        call ConditionalTriggerExecute(udg_trigger42)
                    endif
                    return
                endif
            else
                if(RoundNumber==BattleRoyalRound and ElimModeEnabled==false)then
                    if(PlayerCount==1)then
                        //end game
                        call ConditionalTriggerExecute(udg_trigger119)
                    else
                        //battle royal
                        call ConditionalTriggerExecute(udg_trigger42)
                    endif
                    return
                endif
            endif
            call ConditionalTriggerExecute(udg_trigger103)
            call CreateTimerDialogBJ(GetLastCreatedTimerBJ(),"Next Level ...")
            set NextRound[round] = true
            if(RoundNumber <= 3)then
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
