library DivineSource initializer init requires RandomShit

    private function DivineSourceConditions takes nothing returns boolean
        return GetItemTypeId(GetManipulatedItem()) == 'I043'
    endfunction

    private function DivineSourceActions takes nothing returns nothing
        local unit currentUnit = GetTriggerUnit()
        local location unitLocation = GetUnitLoc(currentUnit)
        local unit dummyUnit = CreateUnitAtLoc(GetOwningPlayer(currentUnit), PRIEST_1_UNIT_ID, unitLocation, bj_UNIT_FACING)

        call UnitApplyTimedLife(dummyUnit, 'BTLF', 2.00)
        call UnitRemoveAbility(currentUnit, 'Bena')
        call UnitRemoveAbility(currentUnit, 'Bens')
        call UnitRemoveAbility(currentUnit, 'Beng')
        call UnitRemoveAbility(currentUnit, 'Bliq')
        call UnitRemoveAbility(currentUnit, 'Bpoi')
        call UnitRemoveAbility(currentUnit, 'Bpsd')
        call UnitAddAbility(dummyUnit, 'Aadm')
        call IssueTargetOrder(dummyUnit, "autodispel", currentUnit)

        // Cleanup
        call RemoveLocation(unitLocation)
        set unitLocation = null
        set currentUnit = null
        set dummyUnit = null
    endfunction

    private function init takes nothing returns nothing
        set DivineSourceTrigger = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(DivineSourceTrigger, EVENT_PLAYER_UNIT_USE_ITEM)
        call TriggerAddCondition(DivineSourceTrigger, Condition(function DivineSourceConditions))
        call TriggerAddAction(DivineSourceTrigger, function DivineSourceActions)
    endfunction

endlibrary
