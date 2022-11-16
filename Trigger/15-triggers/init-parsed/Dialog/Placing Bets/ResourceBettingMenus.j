library ResourceBettingMenus initializer init requires RandomShit

    private function ResourceBettingMenusConditions takes nothing returns boolean
        return BettingEnabled == true
    endfunction

    private function ResourceBettingMenusActions takes nothing returns nothing
        call DialogSetMessageBJ(Dialogs[2],"Betting Menu")
        call DialogAddButtonBJ(Dialogs[2],"Gold")
        set DialogButtons[4] = GetLastCreatedButtonBJ()
        call DialogAddButtonBJ(Dialogs[2],"Lumber")
        set DialogButtons[5] = GetLastCreatedButtonBJ()
        call DialogAddButtonBJ(Dialogs[2],"Gold & Lumber")
        set DialogButtons[6] = GetLastCreatedButtonBJ()
        call DialogAddButtonBJ(Dialogs[2],"Cancel")
        set DialogButtons[7] = GetLastCreatedButtonBJ()

        call DialogSetMessageBJ(Dialogs[3],"Betting Menu")
        call DialogAddButtonBJ(Dialogs[3],"25%")
        set DialogButtons[8] = GetLastCreatedButtonBJ()
        call DialogAddButtonBJ(Dialogs[3],"50%")
        set DialogButtons[9] = GetLastCreatedButtonBJ()
        call DialogAddButtonBJ(Dialogs[3],"100%")
        set DialogButtons[10] = GetLastCreatedButtonBJ()
        call DialogAddButtonBJ(Dialogs[3],"Cancel")
        set DialogButtons[11] = GetLastCreatedButtonBJ()
    endfunction

    private function init takes nothing returns nothing
        set ResourceBettingMenusTrigger = CreateTrigger()
        call TriggerRegisterTimerEventSingle(ResourceBettingMenusTrigger, 30.00)
        call TriggerAddCondition(ResourceBettingMenusTrigger, Condition(function ResourceBettingMenusConditions))
        call TriggerAddAction(ResourceBettingMenusTrigger, function ResourceBettingMenusActions)
    endfunction

endlibrary
