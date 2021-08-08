globals
	hashtable HT = InitHashtable()
endglobals

function Trig_InitHash_Copy_Actions takes nothing returns nothing
call InitLState() 
endfunction

//===========================================================================
function InitTrig_InitHash_Copy takes nothing returns nothing
    set gg_trg_InitHash_Copy = CreateTrigger(  )
    call TriggerRegisterTimerEventSingle( gg_trg_InitHash_Copy, 0.00 )
    call TriggerAddAction( gg_trg_InitHash_Copy, function Trig_InitHash_Copy_Actions )
endfunction

