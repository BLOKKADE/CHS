function Trig_It_Copy_3_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I04K' ) ) then
        return false
    endif
    return true
endfunction

function Trig_It_Copy_3_Actions takes nothing returns nothing
    call SetPlayerTechResearchedSwap( 'R000', ( 1 + GetPlayerTechCountSimple('R000', GetOwningPlayer(GetTriggerUnit())) ), GetOwningPlayer(GetTriggerUnit()) )
endfunction

//===========================================================================
function InitTrig_It_Copy_3 takes nothing returns nothing
    set gg_trg_It_Copy_3 = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_It_Copy_3, EVENT_PLAYER_UNIT_PICKUP_ITEM )
    call TriggerAddCondition( gg_trg_It_Copy_3, Condition( function Trig_It_Copy_3_Conditions ) )
    call TriggerAddAction( gg_trg_It_Copy_3, function Trig_It_Copy_3_Actions )
endfunction

