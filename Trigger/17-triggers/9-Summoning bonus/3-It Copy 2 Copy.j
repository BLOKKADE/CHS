function Trig_It_Copy_2_Copy_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I04M' ) ) then
        return false
    endif
    return true
endfunction

function Trig_It_Copy_2_Copy_Actions takes nothing returns nothing
    call SetPlayerTechResearchedSwap( 'R002', ( 1 + GetPlayerTechCountSimple('R002', GetOwningPlayer(GetTriggerUnit())) ), GetOwningPlayer(GetTriggerUnit()) )
endfunction

//===========================================================================
function InitTrig_It_Copy_2_Copy takes nothing returns nothing
    set gg_trg_It_Copy_2_Copy = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_It_Copy_2_Copy, EVENT_PLAYER_UNIT_PICKUP_ITEM )
    call TriggerAddCondition( gg_trg_It_Copy_2_Copy, Condition( function Trig_It_Copy_2_Copy_Conditions ) )
    call TriggerAddAction( gg_trg_It_Copy_2_Copy, function Trig_It_Copy_2_Copy_Actions )
endfunction

