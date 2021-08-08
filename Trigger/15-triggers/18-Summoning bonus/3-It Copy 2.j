function Trig_It_Copy_2_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I04M' ) ) then
        return false
    endif
    return true
endfunction

function Trig_It_Copy_2_Actions takes nothing returns nothing
    call SetPlayerTechResearchedSwap( 'R002', ( 1 + GetPlayerTechCountSimple('R002', GetOwningPlayer(GetTriggerUnit())) ), GetOwningPlayer(GetTriggerUnit()) )
endfunction

//===========================================================================
function InitTrig_It_Copy_2 takes nothing returns nothing
    set gg_trg_It_Copy_2 = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_It_Copy_2, EVENT_PLAYER_UNIT_PICKUP_ITEM )
    call TriggerAddCondition( gg_trg_It_Copy_2, Condition( function Trig_It_Copy_2_Conditions ) )
    call TriggerAddAction( gg_trg_It_Copy_2, function Trig_It_Copy_2_Actions )
endfunction

