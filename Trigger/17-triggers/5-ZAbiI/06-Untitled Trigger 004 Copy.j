function Trig_Untitled_Trigger_004_Copy_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'H01E' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Untitled_Trigger_004_Copy_Actions takes nothing returns nothing

call DisplayTextToPlayer(GetLocalPlayer(),0,0, OrderId2String(GetIssuedOrderId()))
endfunction

//===========================================================================
function InitTrig_Untitled_Trigger_004_Copy takes nothing returns nothing
    set gg_trg_Untitled_Trigger_004_Copy = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Untitled_Trigger_004_Copy, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Untitled_Trigger_004_Copy, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Untitled_Trigger_004_Copy, EVENT_PLAYER_UNIT_ISSUED_ORDER )
    call TriggerAddCondition( gg_trg_Untitled_Trigger_004_Copy, Condition( function Trig_Untitled_Trigger_004_Copy_Conditions ) )
    call TriggerAddAction( gg_trg_Untitled_Trigger_004_Copy, function Trig_Untitled_Trigger_004_Copy_Actions )
endfunction

