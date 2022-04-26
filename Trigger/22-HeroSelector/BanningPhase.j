library BanningPhase initializer init requires PickingPhase

    globals
        trigger BanningPhaseTrigger
    endglobals
    
    function Trig_BaningPhase_Copy_Actions takes nothing returns nothing
        // Show Remaining Counts in the Titel
        set Count = ( 25 - GetTriggerExecCount(GetTriggeringTrigger()) )
        call HeroSelectorSetTitleText( GetLocalizedString("CHAT_ACTION_BAN")+": " + I2S(Count))
        if ( Count > 0 and Count <= 5 ) then
            // call PlaySoundBJ( gg_snd_BattleNetTick )
        endif
        // Time Run up?
        if ( Count <= 0 ) then
            // Enable Picking
            call HeroSelectorEnablePick(true)
            // Swap Active Trigger (Phase)
            call DisableTrigger( GetTriggeringTrigger() )
            call EnableTrigger( PickingPhaseTrigger )
            // Update Titel Right Now
            call HeroSelectorUpdate()
            call HeroSelectorSetTitleText( "Picking: ")
        else
        endif
    endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
        set BanningPhaseTrigger = CreateTrigger(  )
        call DisableTrigger( BanningPhaseTrigger )
        call TriggerRegisterTimerEventPeriodic( BanningPhaseTrigger, 1.00 )
        call TriggerAddAction( BanningPhaseTrigger, function Trig_BaningPhase_Copy_Actions )
    endfunction
    
endlibrary