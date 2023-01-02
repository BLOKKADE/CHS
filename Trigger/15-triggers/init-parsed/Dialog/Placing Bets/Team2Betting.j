library Team2Betting initializer init requires RandomShit, InitializeBettingDialogs

    private function Team2BettingConditions takes nothing returns boolean
        return GetClickedButton() == BettingDialogButtons[2]
    endfunction

    private function Team2BettingActions takes nothing returns nothing
        call DialogSetMessage(BettingDialogs[2], "Betting Menu")
        call DialogDisplayBJ(true, BettingDialogs[2], GetTriggerPlayer())
        call ForceAddPlayerSimple(GetTriggerPlayer(), Team2BettingForce)
    endfunction

    private function init takes nothing returns nothing
        set Team2BettingTrigger = CreateTrigger()
        call TriggerRegisterDialogEventBJ(Team2BettingTrigger, BettingDialogs[1])
        call TriggerAddCondition(Team2BettingTrigger, Condition(function Team2BettingConditions))
        call TriggerAddAction(Team2BettingTrigger, function Team2BettingActions)
    endfunction


endlibrary
