library DeathDialogInitialization initializer init requires RandomShit

    private function DeathDialogInitializationActions takes nothing returns nothing
        call DialogClear(udg_dialog04)
        call DialogSetMessage(udg_dialog04, "Defeat!")
        call DialogAddButtonBJ(udg_dialog04, "Spectate")
        set udg_buttons03[1] = GetLastCreatedButtonBJ()
        call DialogAddButtonBJ(udg_dialog04, "Leave")
        set udg_buttons03[2] = GetLastCreatedButtonBJ()
    endfunction

    private function init takes nothing returns nothing
        set DeathDialogInitializationTrigger = CreateTrigger()
        call TriggerRegisterTimerEventSingle(DeathDialogInitializationTrigger, 0.00)
        call TriggerAddAction(DeathDialogInitializationTrigger, function DeathDialogInitializationActions)
    endfunction

endlibrary
