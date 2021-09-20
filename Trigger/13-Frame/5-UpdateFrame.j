globals

	integer array NumPlayerLast 
    unit array selectedUnit
endglobals


function Trig_UpdateFrame_Actions takes nothing returns nothing
    local integer pid = GetPlayerId(GetTriggerPlayer())

//if udg_units01[ GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] != null then
   set NumPlayerLast[pid] =  GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
   set selectedUnit[pid] = GetTriggerUnit()
//endif
endfunction

//===========================================================================
function InitTrig_UpdateFrame takes nothing returns nothing
    set gg_trg_UpdateFrame = CreateTrigger(  )
    call TriggerRegisterPlayerSelectionEventBJ( gg_trg_UpdateFrame, Player(0), true )
    call TriggerRegisterPlayerSelectionEventBJ( gg_trg_UpdateFrame, Player(1), true )
    call TriggerRegisterPlayerSelectionEventBJ( gg_trg_UpdateFrame, Player(2), true )
    call TriggerRegisterPlayerSelectionEventBJ( gg_trg_UpdateFrame, Player(3), true )
    call TriggerRegisterPlayerSelectionEventBJ( gg_trg_UpdateFrame, Player(4), true )
    call TriggerRegisterPlayerSelectionEventBJ( gg_trg_UpdateFrame, Player(5), true )
    call TriggerRegisterPlayerSelectionEventBJ( gg_trg_UpdateFrame, Player(6), true )
    call TriggerRegisterPlayerSelectionEventBJ( gg_trg_UpdateFrame, Player(7), true )
    call TriggerAddAction( gg_trg_UpdateFrame, function Trig_UpdateFrame_Actions )
endfunction

