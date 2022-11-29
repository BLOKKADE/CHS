library trigger133 initializer init requires RandomShit

    function Trig_Player_Selection_Camera_Func001001 takes nothing returns boolean
        return(udg_boolean12==true)
    endfunction


    function Trig_Player_Selection_Camera_Func002001001 takes nothing returns boolean
        return(IsPlayerInForce(GetFilterPlayer(),udg_PlayersWithHero)!=true)
    endfunction


    function Trig_Player_Selection_Camera_Func002A takes nothing returns nothing
        // call CameraSetupApplyForPlayer(true,udg_camerasetup01,GetEnumPlayer(),0.00)
    endfunction


    function Trig_Player_Selection_Camera_Actions takes nothing returns nothing
        if(Trig_Player_Selection_Camera_Func001001())then
            call DisableTrigger(GetTriggeringTrigger())
        else
            call DoNothing()
        endif
        call ForForce(GetPlayersMatching(Condition(function Trig_Player_Selection_Camera_Func002001001)),function Trig_Player_Selection_Camera_Func002A)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger133 = CreateTrigger()
        call TriggerRegisterTimerEventPeriodic(udg_trigger133,0.02)
        call TriggerAddAction(udg_trigger133,function Trig_Player_Selection_Camera_Actions)
    endfunction


endlibrary
