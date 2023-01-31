library DeathDialogInitialization initializer init requires RandomShit

    private function DeathDialogInitializationActions takes nothing returns nothing
        call DialogClear(DeathDialog)
        call DialogSetMessage(DeathDialog, "Defeat!")
        call DialogAddButtonBJ(DeathDialog, "Spectate")
        set DeathDialogButtons[1] = GetLastCreatedButtonBJ()
        call DialogAddButtonBJ(DeathDialog, "Leave")
        set DeathDialogButtons[2] = GetLastCreatedButtonBJ()
    endfunction

    private function init takes nothing returns nothing
        call TimerStart(CreateTimer(), 1, false, function DeathDialogInitializationActions)
    endfunction

endlibrary
