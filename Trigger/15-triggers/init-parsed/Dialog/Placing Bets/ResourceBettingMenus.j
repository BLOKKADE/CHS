library ResourceBettingMenus initializer init requires RandomShit, InitializeBettingDialogs

    private function ResourceBettingMenusConditions takes nothing returns boolean
        return BettingEnabled == true
    endfunction

    private function ResourceBettingMenusActions takes nothing returns nothing
        call DialogSetMessage(BettingDialogs[2], "Betting Menu")
        call DialogAddButtonBJ(BettingDialogs[2], "Gold")
        set BettingDialogButtons[4] = GetLastCreatedButtonBJ()
        call DialogAddButtonBJ(BettingDialogs[2], "Cancel")
        set BettingDialogButtons[7] = GetLastCreatedButtonBJ()

        call DialogSetMessage(BettingDialogs[3], "Betting Menu")
        call DialogAddButtonBJ(BettingDialogs[3], "25%")
        set BettingDialogButtons[8] = GetLastCreatedButtonBJ()
        call DialogAddButtonBJ(BettingDialogs[3], "50%")
        set BettingDialogButtons[9] = GetLastCreatedButtonBJ()
        call DialogAddButtonBJ(BettingDialogs[3], "100%")
        set BettingDialogButtons[10] = GetLastCreatedButtonBJ()
        call DialogAddButtonBJ(BettingDialogs[3], "Cancel")
        set BettingDialogButtons[11] = GetLastCreatedButtonBJ()
    endfunction

    private function init takes nothing returns nothing
        set ResourceBettingMenusTrigger = CreateTrigger()
        call TriggerRegisterTimerEventSingle(ResourceBettingMenusTrigger, 30.00)
        call TriggerAddCondition(ResourceBettingMenusTrigger, Condition(function ResourceBettingMenusConditions))
        call TriggerAddAction(ResourceBettingMenusTrigger, function ResourceBettingMenusActions)
    endfunction

endlibrary
