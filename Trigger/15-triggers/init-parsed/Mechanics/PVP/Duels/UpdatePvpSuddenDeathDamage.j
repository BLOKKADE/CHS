library UpdatePvpSuddenDeathDamage initializer init requires RandomShit

    private function UpdatePvpSuddenDeathDamageConditions takes nothing returns boolean
        return (IsTriggerEnabled(ApplyPvpSuddenDeathDamageTrigger) == true) and SuddenDeathTick >= 120
    endfunction

    private function UpdatePvpSuddenDeathDamageActions takes nothing returns nothing
        set SuddenDeathDamageMultiplier = SuddenDeathDamageMultiplier * 1.1
        call PvpUpdateDeathTimerDisplay(SuddenDeathDamageMultiplier)
    endfunction

    private function init takes nothing returns nothing
        set UpdatePvpSuddenDeathDamageTrigger = CreateTrigger()
        call DisableTrigger(UpdatePvpSuddenDeathDamageTrigger)
        call TriggerRegisterTimerEventPeriodic(UpdatePvpSuddenDeathDamageTrigger, 1.25)
        call TriggerAddCondition(UpdatePvpSuddenDeathDamageTrigger, Condition(function UpdatePvpSuddenDeathDamageConditions))
        call TriggerAddAction(UpdatePvpSuddenDeathDamageTrigger, function UpdatePvpSuddenDeathDamageActions)
    endfunction

endlibrary
