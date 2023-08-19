library IsGameFinished initializer init requires RandomShit

    private function IsGameFinishedConditions takes nothing returns boolean
        return (GameComplete == true) and (IsTriggerEnabled(GetTriggeringTrigger()) == true)
    endfunction

    private function IsEliminationGameMode takes nothing returns boolean
        return ElimModeEnabled == true
    endfunction

    private function IsShortGameMode takes nothing returns boolean
        return (GameModeShort == true) and (RoundNumber == 25) and (ElimModeEnabled == false)
    endfunction

    private function IsLongGameMode takes nothing returns boolean
        return (GameModeShort == false) and (RoundNumber == 50) and (ElimModeEnabled == false)
    endfunction

    private function IsGameFinishedActions takes nothing returns nothing
        if (IsEliminationGameMode() or IsShortGameMode() or IsLongGameMode()) then
            call DisableTrigger(GetTriggeringTrigger())
            set udg_boolean09 = true
            call DestroyTimerDialogBJ(GetLastCreatedTimerDialogBJ())
            call TriggerSleepAction(8.00)
            // call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 120, "The game has finished, you can leave whenever you want.")
        endif
    endfunction

    private function init takes nothing returns nothing
        set IsGameFinishedTrigger = CreateTrigger()
        call TriggerAddCondition(IsGameFinishedTrigger, Condition(function IsGameFinishedConditions))
        call TriggerAddAction(IsGameFinishedTrigger, function IsGameFinishedActions)
    endfunction

endlibrary
