library PickingPhase initializer init requires HeroSelector, HeroInfo

    globals
        trigger PickingPhaseTrigger
    endglobals

    function Trig_Picking_Phase_Copy_Func005Func002Func003Func003001001002 takes nothing returns boolean
        return ( IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true )
    endfunction

    function Trig_Picking_Phase_Copy_Func005Func002Func003C takes nothing returns boolean
        if ( not ( GroupPickRandomUnit(GetUnitsOfPlayerMatching(GetEnumPlayer(), Condition(function Trig_Picking_Phase_Copy_Func005Func002Func003Func003001001002))) == null ) ) then
            return false
        endif
        return true
    endfunction

    function Trig_Picking_Phase_Copy_Func005Func002A takes nothing returns nothing
        set bj_wantDestroyGroup = true
        // This one has a hero?
        if ( GetEnumPlayer() != Player(8) and GetEnumPlayer() != Player(11) and Trig_Picking_Phase_Copy_Func005Func002Func003C() ) then
            // No, force a Pick for him
            call HeroSelectorForcePickPlayer(GetEnumPlayer())
        endif
    endfunction

    function Trig_Picking_Phase_Copy_Actions takes nothing returns nothing
        set Count = ( 25 - GetTriggerExecCount(GetTriggeringTrigger()) )
        call HeroSelectorSetTitleText( GetLocalizedString("DEFAULTTIMERDIALOGTEXT")+": " +I2S( Count))

        if ( Count <= 5 and Count > 0 ) then
            // call PlaySoundBJ( gg_snd_BattleNetTick )
        endif

        // The Time run up?
        if ( Count <= 0 ) then
            // Pick everyone
            call ForForce( GetPlayersAll(), function Trig_Picking_Phase_Copy_Func005Func002A )
            call DisableTrigger( GetTriggeringTrigger() )
            call HeroSelectorDestroy()
            call HeroInfoDestroy()
        endif
    endfunction

    private function init takes nothing returns nothing
        set PickingPhaseTrigger = CreateTrigger(  )
        call DisableTrigger( PickingPhaseTrigger )
        call TriggerRegisterTimerEventPeriodic( PickingPhaseTrigger, 1.00 )
        call TriggerAddAction( PickingPhaseTrigger, function Trig_Picking_Phase_Copy_Actions )
    endfunction

endlibrary