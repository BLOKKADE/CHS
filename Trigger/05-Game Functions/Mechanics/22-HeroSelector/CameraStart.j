library SetupHeroCamera initializer init requires HeroSelector

    globals
        private trigger ForceHeroSelectionTrigger
    endglobals

    public function DisableHeroSelectionForcedCamera takes nothing returns nothing
        call DisableTrigger(ForceHeroSelectionTrigger)
    endfunction

    private function ApplyHeroCamera takes nothing returns nothing
        if (not IsPlayerInForce(GetEnumPlayer(), udg_PlayersWithHero)) then
            call CameraSetupApplyForPlayer(true, gg_cam_HeroSelectCamera, GetEnumPlayer(), 0)
        endif
    endfunction

    private function ApplyHeroCameraToPlayers takes nothing returns nothing
        call ForForce(GetPlayersAll(), function ApplyHeroCamera)
    endfunction
    
    private function init takes nothing returns nothing
        set ForceHeroSelectionTrigger = CreateTrigger()
        call TriggerRegisterTimerEventPeriodic(ForceHeroSelectionTrigger,0.02)
        call TriggerAddAction(ForceHeroSelectionTrigger, function ApplyHeroCameraToPlayers)
    endfunction

endlibrary