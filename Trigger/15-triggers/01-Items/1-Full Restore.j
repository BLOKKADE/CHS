library FullRestore initializer InitTrig_Full_Restore

function Trig_Full_Restore_Conditions takes nothing returns boolean
    return GetItemTypeId(GetManipulatedItem()) == 'I04G'
endfunction

function Trig_Full_Restore_Actions takes nothing returns nothing
    local unit u = GetManipulatingUnit()
    call SetUnitState(u, UNIT_STATE_LIFE, GetUnitState(u, UNIT_STATE_MAX_LIFE))
    call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MAX_MANA))
    set u = null
endfunction

//===========================================================================
function InitTrig_Full_Restore takes nothing returns nothing
    set gg_trg_Full_Restore = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Full_Restore, EVENT_PLAYER_UNIT_USE_ITEM )
    call TriggerAddCondition( gg_trg_Full_Restore, Condition( function Trig_Full_Restore_Conditions ) )
    call TriggerAddAction( gg_trg_Full_Restore, function Trig_Full_Restore_Actions )
endfunction

endlibrary