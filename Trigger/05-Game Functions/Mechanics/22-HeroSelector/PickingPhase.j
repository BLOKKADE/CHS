library PickingPhase initializer init requires HeroSelector, HeroInfo

    globals
        trigger PickingPhaseTrigger
    endglobals

    private function PlayerHeroFilter takes nothing returns boolean
        return (IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true)
    endfunction

    private function DoesPlayerNotHaveHero takes nothing returns boolean
        local group playerHeroes = GetUnitsOfPlayerMatching(GetEnumPlayer(), Condition(function PlayerHeroFilter))
        local boolean playerHasNoHero = GroupPickRandomUnit(playerHeroes) == null

        // Cleanup
        call DestroyGroup(playerHeroes)
        set playerHeroes = null

        return playerHasNoHero
    endfunction

    private function ForcePickRandomHeroForPlayer takes nothing returns nothing
        set bj_wantDestroyGroup = true
        // This one has a hero?
        if (GetEnumPlayer() != Player(20) and GetEnumPlayer() != Player(21)and DoesPlayerNotHaveHero()) then
            // No, force a Pick for him
            call HeroSelectorForcePickPlayer(GetEnumPlayer())
        endif
    endfunction

    private function DestroyHeroSelector takes nothing returns nothing
        local timer t = GetExpiredTimer()
        call HeroSelectorDestroy()
        call HeroInfoDestroy()
        call ReleaseTimer(t)
        set t = null
    endfunction

    private function PickingPhaseActions takes nothing returns nothing
        set Count = (25 - GetTriggerExecCount(GetTriggeringTrigger()))
        call HeroSelectorSetTitleText(GetLocalizedString("DEFAULTTIMERDIALOGTEXT")+": " +I2S(Count))

        if (Count <= 5 and Count > 0) then
            // call PlaySoundBJ(gg_snd_BattleNetTick)
        endif

        // The Time run up?
        if (Count <= 0) then
            // Pick everyone
            call ForForce(GetPlayersAll(), function ForcePickRandomHeroForPlayer)
            call DisableTrigger(GetTriggeringTrigger())
            call HeroSelectorShow(false)
            call TimerStart(NewTimer(), 1, false, function DestroyHeroSelector)
        endif
    endfunction

    private function init takes nothing returns nothing
        set PickingPhaseTrigger = CreateTrigger()
        call DisableTrigger(PickingPhaseTrigger)
        call TriggerRegisterTimerEventPeriodic(PickingPhaseTrigger, 1.00)
        call TriggerAddAction(PickingPhaseTrigger, function PickingPhaseActions)
    endfunction

endlibrary