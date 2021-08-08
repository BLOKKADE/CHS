globals
    integer Glob_time = 0 
endglobals


function Trig_Timer_Copy_Actions takes nothing returns nothing
    set Glob_time = Glob_time + 1
endfunction

//===========================================================================
function InitTrig_Timer_Copy takes nothing returns nothing
    set gg_trg_Timer_Copy = CreateTrigger(  )
    call TriggerRegisterTimerEventPeriodic( gg_trg_Timer_Copy, 0.01 )
    call TriggerAddAction( gg_trg_Timer_Copy, function Trig_Timer_Copy_Actions )
endfunction

