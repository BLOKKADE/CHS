library CreepDies initializer init requires RandomShit, CreepDeath

    private function CreepDiesConditions takes nothing returns boolean
        return GetOwningPlayer(GetTriggerUnit()) == Player(11) and GetOwningPlayer(GetKillingUnitBJ()) != Player(11) and (GetKillingUnit() != null)
    endfunction

    private function CreepDiesActions takes nothing returns nothing
        local unit deadCreep = GetTriggerUnit()

        call CreepDeath_Death(deadCreep, PlayerHeroes[GetPlayerId(GetOwningPlayer(GetKillingUnit()))])

        // What is the point of this?
        call TriggerSleepAction(0.00)

        call SetUnitOwner(deadCreep, Player(PLAYER_NEUTRAL_PASSIVE), false)

        // Cleanup
        set deadCreep = null
    endfunction

    private function init takes nothing returns nothing
        set CreepDiesTrigger = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(CreepDiesTrigger, EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(CreepDiesTrigger, Condition(function CreepDiesConditions))
        call TriggerAddAction(CreepDiesTrigger, function CreepDiesActions)
    endfunction

endlibrary
