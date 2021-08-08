function Trig_E_Actions takes nothing returns nothing


if BlzFrameGetEnable(SpellUP[0]) then  
call DisplayTextToPlayer(GetLocalPlayer(),0,0,"yea")
endif



endfunction

//===========================================================================
function InitTrig_E takes nothing returns nothing
    set gg_trg_E = CreateTrigger(  )
    call TriggerRegisterTimerEventPeriodic( gg_trg_E, 0.01 )
    call TriggerAddAction( gg_trg_E, function Trig_E_Actions )
endfunction

