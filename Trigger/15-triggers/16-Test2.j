function Trig_Test2_Actions takes nothing returns nothing

call DisplayTextToPlayer(GetLocalPlayer(),0,0, BlzFrameGetText(BlzGetFrameByName("SimpleNameValue", 0))  )


endfunction

//===========================================================================
function InitTrig_Test2 takes nothing returns nothing
    set gg_trg_Test2 = CreateTrigger(  )
    call TriggerRegisterPlayerEventEndCinematic( gg_trg_Test2, Player(0) )
    call TriggerRegisterPlayerEventEndCinematic( gg_trg_Test2, Player(1) )
    call TriggerAddAction( gg_trg_Test2, function Trig_Test2_Actions )
endfunction

