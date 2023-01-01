library DeathDialogLeave initializer init requires RandomShit

    private function DeathDialogLeaveConditions takes nothing returns boolean
        return GetClickedButton() == udg_buttons03[2]
    endfunction

    private function DeathDialogLeaveActions takes nothing returns nothing
        call CustomDefeatBJ(GetTriggerPlayer(), "Defeat!")
    endfunction

    private function init takes nothing returns nothing
        set DeathDialogLeaveTrigger = CreateTrigger()
        call TriggerRegisterDialogEventBJ(DeathDialogLeaveTrigger, udg_dialog04)
        call TriggerAddCondition(DeathDialogLeaveTrigger, Condition(function DeathDialogLeaveConditions))
        call TriggerAddAction(DeathDialogLeaveTrigger, function DeathDialogLeaveActions)
    endfunction

endlibrary
