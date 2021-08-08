function Trig_test_Actions takes nothing returns nothing
   // call DisplayTextToPlayer(GetLocalPlayer(),0,0,I2S(GetHandleId(ConvertAbilityRealField(1))) )
    
endfunction

//===========================================================================
function InitTrig_test takes nothing returns nothing
    set gg_trg_test = CreateTrigger(  )
    call TriggerRegisterPlayerEventEndCinematic( gg_trg_test, Player(0) )
    call TriggerAddAction( gg_trg_test, function Trig_test_Actions )
endfunction

