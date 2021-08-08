function Trig_It_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I04K' ) ) then
        return false
    endif
    return true
endfunction

function Trig_It_Actions takes nothing returns nothing
    call SetPlayerTechResearchedSwap( 'R000', ( 1 + GetPlayerTechCountSimple('R000', GetOwningPlayer(GetTriggerUnit())) ), GetOwningPlayer(GetTriggerUnit()) )
endfunction

//===========================================================================
function InitTrig_It takes nothing returns nothing
    set gg_trg_It = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_It, EVENT_PLAYER_UNIT_PICKUP_ITEM )
    call TriggerAddCondition( gg_trg_It, Condition( function Trig_It_Conditions ) )
    call TriggerAddAction( gg_trg_It, function Trig_It_Actions )
endfunction

