globals
	hashtable HT = InitHashtable()
endglobals

function Trig_InitHash_Actions takes nothing returns nothing
call InitLState() 
endfunction

//===========================================================================
function InitTrig_InitHash takes nothing returns nothing
    set gg_trg_InitHash = CreateTrigger(  )
    call TriggerRegisterTimerEventSingle( gg_trg_InitHash, 0.00 )
    call TriggerAddAction( gg_trg_InitHash, function Trig_InitHash_Actions )
endfunction

