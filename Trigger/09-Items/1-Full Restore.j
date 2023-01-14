library FullRestore initializer init

    private function FullRestoreConditions takes nothing returns boolean
        return GetItemTypeId(GetManipulatedItem()) == 'I04G'
    endfunction

    private function FullRestoreActions takes nothing returns nothing
        local unit u = GetManipulatingUnit()
        call SetUnitState(u, UNIT_STATE_LIFE, GetUnitState(u, UNIT_STATE_MAX_LIFE))
        call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MAX_MANA))
        set u = null
    endfunction

    private function init takes nothing returns nothing
        local trigger fullRestoreTrigger = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(fullRestoreTrigger, EVENT_PLAYER_UNIT_USE_ITEM)
        call TriggerAddCondition(fullRestoreTrigger, Condition(function FullRestoreConditions))
        call TriggerAddAction(fullRestoreTrigger, function FullRestoreActions)
        set fullRestoreTrigger = null
    endfunction

endlibrary