library FaerieDragonDies initializer init requires RandomShit

    private function FaerieDragonDiesConditions takes nothing returns boolean
        return GetUnitTypeId(GetTriggerUnit()) == 'e003'
    endfunction

    private function FaerieDragonDiesActions takes nothing returns nothing
        local unit currentUnit = GetTriggerUnit()
        local location unitLocation = GetUnitLoc(currentUnit)

        call CreateUnitAtLoc(GetOwningPlayer(currentUnit), GetUnitTypeId(currentUnit), unitLocation, GetUnitFacing(currentUnit))

        // Cleanup
        call RemoveLocation(unitLocation)
        set unitLocation = null
        set currentUnit = null
    endfunction

    private function init takes nothing returns nothing
        set FaerieDragonDiesTrigger = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(FaerieDragonDiesTrigger, EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(FaerieDragonDiesTrigger, Condition(function FaerieDragonDiesConditions))
        call TriggerAddAction(FaerieDragonDiesTrigger, function FaerieDragonDiesActions)
    endfunction

endlibrary
