library FullRestore initializer init
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
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trg, EVENT_PLAYER_UNIT_USE_ITEM )
        call TriggerAddCondition( trg, Condition( function Trig_Full_Restore_Conditions ) )
        call TriggerAddAction( trg, function Trig_Full_Restore_Actions )
        set trg = null
    endfunction
endlibrary