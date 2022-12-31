library PandarenDies initializer init requires RandomShit, PetDeath

    private function PandarenDiesConditions takes nothing returns boolean
        local unit currentUnit = GetTriggerUnit()
        local boolean isValid = (not UnitAlive(currentUnit)) and (not IsUnitIllusion(currentUnit)) and (GetUnitTypeId(currentUnit) == HUNTRESS_UNIT_ID)

        // Cleanup
        set currentUnit = null

        return isValid
    endfunction

    private function PandarenDiesActions takes nothing returns nothing
        call ConditionalTriggerExecute(PandarenDeathSoundsTrigger)
        call PlaySoundOnUnitBJ(udg_sounds01[GetPlayerId(GetOwningPlayer(GetTriggerUnit())) + 1], 100, GetTriggerUnit())
    endfunction

    private function init takes nothing returns nothing
        set PandarenDiesTrigger = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(PandarenDiesTrigger, EVENT_PLAYER_UNIT_DEATH)
        call TriggerRegisterAnyUnitEventBJ(PandarenDiesTrigger, EVENT_PLAYER_UNIT_DROP_ITEM)
        call TriggerAddCondition(PandarenDiesTrigger, Condition(function PandarenDiesConditions))
        call TriggerAddAction(PandarenDiesTrigger, function PandarenDiesActions)
    endfunction

endlibrary
