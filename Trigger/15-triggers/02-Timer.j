globals
    integer Glob_time = 0 
endglobals


function Trig_Timer_Actions takes nothing returns nothing
    set Glob_time = Glob_time + 1
endfunction

//===========================================================================
function InitTrig_Timer takes nothing returns nothing
    set gg_trg_Timer = CreateTrigger(  )
    call TriggerRegisterTimerEventPeriodic( gg_trg_Timer, 0.01 )
    call TriggerAddAction( gg_trg_Timer, function Trig_Timer_Actions )
endfunction

