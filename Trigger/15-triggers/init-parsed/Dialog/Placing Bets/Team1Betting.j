library Team1Betting initializer init requires RandomShit

    private function Team1BettingConditions takes nothing returns boolean
        return GetClickedButton() == DialogButtons[1]
    endfunction

    private function Team1BettingActions takes nothing returns nothing
        call DialogSetMessageBJ(Dialogs[2], "Betting Menu")
        call DialogDisplayBJ(true, Dialogs[2], GetTriggerPlayer())
        call ForceAddPlayerSimple(GetTriggerPlayer(), Team1BettingForce)
    endfunction

    private function init takes nothing returns nothing
        set Team1BettingTrigger = CreateTrigger()
        call TriggerRegisterDialogEventBJ(Team1BettingTrigger, Dialogs[1])
        call TriggerAddCondition(Team1BettingTrigger, Condition(function Team1BettingConditions))
        call TriggerAddAction(Team1BettingTrigger, function Team1BettingActions)
    endfunction

endlibrary
