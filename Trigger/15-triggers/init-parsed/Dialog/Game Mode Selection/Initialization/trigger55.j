library trigger55 initializer init requires RandomShit, VotingScreen

    function Trig_Dialog_Initialization_Func047A takes nothing returns nothing
        if(InitialPlayerCount > 1)then
            if(udg_boolean15==true)then // If everyone should vote
                if GetLocalPlayer() == GetEnumPlayer() then
                    call BlzFrameSetVisible(MainVotingFrameHandle, true)
                endif
            else
                if GetLocalPlayer() == udg_player03 then
                    call BlzFrameSetVisible(MainVotingFrameHandle, true)
                endif
            endif
        else
            if GetLocalPlayer() == GetEnumPlayer() then
                call BlzFrameSetVisible(MainVotingFrameHandle, true)
            endif
        endif
    endfunction


    function Trig_Dialog_Initialization_Func049001 takes nothing returns boolean
        return(IsTriggerEnabled(udg_trigger77)!=true)
    endfunction


    function Trig_Dialog_Initialization_Func054001 takes nothing returns boolean
        return(IsTriggerEnabled(udg_trigger77)!=true)
    endfunction

    function Trig_Dialog_Initialization_Func056C takes nothing returns boolean
        if(not(IsTriggerEnabled(udg_trigger77)==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Dialog_Initialization_Actions takes nothing returns nothing
        call EnableTrigger(GetTriggeringTrigger())

    
        call ForForce(GetPlayersAll(),function Trig_Dialog_Initialization_Func047A)
        if(Trig_Dialog_Initialization_Func049001())then
            return
        endif

        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call CreateTimerDialogBJ(GetLastCreatedTimerBJ(),"Mode Selection")
        call StartTimerBJ(GetLastCreatedTimerBJ(),false,25.00)
        call TriggerSleepAction(25.00)
        if(Trig_Dialog_Initialization_Func054001())then
            return
        endif

        call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
        call BlzFrameSetVisible(MainVotingFrameHandle, false)

        if(Trig_Dialog_Initialization_Func056C())then
            call TriggerExecute(udg_trigger77)
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger55 = CreateTrigger()
        call DisableTrigger(udg_trigger55)
        call TriggerAddAction(udg_trigger55,function Trig_Dialog_Initialization_Actions)
    endfunction


endlibrary
