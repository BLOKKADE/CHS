library trigger90 initializer init requires RandomShit

    function Trig_Melee_Initialization_Conditions takes nothing returns boolean
        if(not(IsTriggerEnabled(GetTriggeringTrigger())==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Melee_Initialization_Func010Func003001001001001 takes nothing returns boolean
        return(GetFilterPlayer()!=Player(8))
    endfunction


    function Trig_Melee_Initialization_Func010Func003A takes nothing returns nothing
        if(Trig_Melee_Initialization_Func010Func003Func001C())then
            set udg_player02 = GetEnumPlayer()
            call ConditionalTriggerExecute(udg_trigger79)
        else
        endif
    endfunction


    function Trig_Melee_Initialization_Actions takes nothing returns nothing
        call DisableTrigger(GetTriggeringTrigger())
        call TriggerSleepAction(0.50)
        if(Trig_Melee_Initialization_Func004C())then
            if(Trig_Melee_Initialization_Func004Func001001())then
                return
            else
                call DoNothing()
            endif
            call PlaySoundBJ(udg_sound14)
            call EnableTrigger(udg_trigger78)
            call MouseHoverInfo_ActivateMouseHover()
            call DisplayTimedTextToForce(GetPlayersAll(),8.00,"|cffffcc00Select your hero! (click again to confirm)|r")
            call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
            call CreateTimerDialogBJ(GetLastCreatedTimerBJ(),"Game starting in ...")
            call StartTimerBJ(GetLastCreatedTimerBJ(),false,30.00)
        else
        endif
        call TriggerSleepAction(24.50)
        set udg_location01 = OffsetLocation(GetRectCenter(GetPlayableMapRect()),- 40.00,- 50.00)
        set udg_integer19 = 5
        call ConditionalTriggerExecute(udg_trigger117)
        call TriggerSleepAction(5.00)
        if(Trig_Melee_Initialization_Func010C())then
            call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
            call PlaySoundBJ(udg_sound11)
            call ForForce(GetPlayersMatching(Condition(function Trig_Melee_Initialization_Func010Func003001001)),function Trig_Melee_Initialization_Func010Func003A)
        else
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger90 = CreateTrigger()
        call TriggerAddCondition(udg_trigger90,Condition(function Trig_Melee_Initialization_Conditions))
        call TriggerAddAction(udg_trigger90,function Trig_Melee_Initialization_Actions)
    endfunction


endlibrary
