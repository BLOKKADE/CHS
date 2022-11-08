library BanningPhase initializer init requires PickingPhase, VotingResults

    globals
        trigger BanningPhaseTrigger
    endglobals
    
    private function AfterBanningActions takes nothing returns nothing
        // Hero mode settings
        if HeroMode == 2 then // Random hero
            call HeroSelectorShow(false)
            call HeroSelectorForceRandom()
            call HeroSelectorDestroy()
            call HeroInfoDestroy()
        elseif HeroMode == 1 then // Pick hero
            call EnableTrigger(PickingPhaseTrigger)
            call HeroSelectorShow(true)
            call HeroSelectorEnablePick(true)
        elseif HeroMode == 3 then // Draft hero
            call ApplyDraftSelectionForPlayers()
            call HeroSelectorUpdate()
            call EnableTrigger(PickingPhaseTrigger)
            call HeroSelectorShow(true)
            call HeroSelectorEnablePick(true)
        elseif HeroMode == 4 then // Same-Draft hero
            call ApplySameDraftSelectionForPlayers()
            call HeroSelectorUpdate()
            call EnableTrigger(PickingPhaseTrigger)
            call HeroSelectorShow(true)
            call HeroSelectorEnablePick(true)
        endif
    endfunction

    private function BanningPhaseActions takes nothing returns nothing
        // Show Remaining Counts in the Title
        set Count = 25 - GetTriggerExecCount(GetTriggeringTrigger())
        call HeroSelectorSetTitleText( GetLocalizedString("CHAT_ACTION_BAN")+": " + I2S(Count))
        
        if ( Count > 0 and Count <= 5 ) then
            // call PlaySoundBJ( gg_snd_BattleNetTick )
        endif

        // Time Run up or everyone has banned
        if ( Count <= 0 or PlayerBanCount >= PlayerCount) then
            call DisableTrigger( GetTriggeringTrigger() )

            call AfterBanningActions()

            // Update Title Right Now
            call HeroSelectorUpdate()
            call HeroSelectorSetTitleText( "Picking: ")
        endif
    endfunction
    
    public function TryEnablingBanningPhase takes nothing returns nothing
        // Check if we should even ban
        if (HeroBanningMode == 1) then
            call AfterBanningActions()
            return
        endif

        call HeroSelectorShow(true)
        call HeroSelectorEnableBan(true)
        call EnableTrigger(BanningPhaseTrigger)
    endfunction

    private function init takes nothing returns nothing
        set BanningPhaseTrigger = CreateTrigger(  )
        call DisableTrigger( BanningPhaseTrigger )
        call TriggerRegisterTimerEventPeriodic( BanningPhaseTrigger, 1.00 )
        call TriggerAddAction( BanningPhaseTrigger, function BanningPhaseActions )
    endfunction
    
endlibrary