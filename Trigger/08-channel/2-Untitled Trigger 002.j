

function Trig_Untitled_Trigger_002_Actions takes nothing returns nothing

    call FreeInitChannel()
    

endfunction

//===========================================================================
function InitTrig_Untitled_Trigger_002 takes nothing returns nothing


    set gg_trg_Untitled_Trigger_002 = CreateTrigger(  )
    call TriggerRegisterTimerEventSingle( gg_trg_Untitled_Trigger_002, 0.00 )
    call TriggerAddAction( gg_trg_Untitled_Trigger_002, function Trig_Untitled_Trigger_002_Actions )
endfunction

