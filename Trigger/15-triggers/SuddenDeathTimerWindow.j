library SuddenDeathTimerWindow requires TimerUtils
    globals
        private timer SuddenDeathTimer = null
        private timerdialog SuddenDeathDialog = null
        private integer level
        private integer LevelUp = 60
    endglobals

    function StopSuddenDeathTimer takes nothing returns nothing
        call ReleaseTimer(SuddenDeathTimer)
        set SuddenDeathTimer = null
        call TimerDialogDisplay(SuddenDeathDialog, false)
        call DestroyTimerDialog(SuddenDeathDialog)
        set SuddenDeathDialog = null
    endfunction

    function UpdateSuddenDeathTimer takes nothing returns nothing
        local real remaining = TimerGetRemaining(SuddenDeathTimer)
        if remaining <= 5 then
            set level = level + 1
            set SuddenDeathEnabled = true
            call TimerDialogSetTitle(SuddenDeathDialog, "Creep enrage level " + I2S(level))
            if level == 2 then
                call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 10, "The creeps are pissed off! They won't let you use Midas Touch!")
            elseif level == 3 then
                call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 10, "The creeps are pretty angry!")
            elseif level == 4 then
                call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 10, "The creeps are extremely agitated!")
            endif
            call TimerStart(SuddenDeathTimer, 60, false, null)
        endif
    endfunction

    function StartSuddenDeathTimer takes nothing returns nothing
        if SuddenDeathTimer == null then
            set SuddenDeathEnabled = false
            set SuddenDeathTimer = NewTimer()
            call TimerStart(SuddenDeathTimer, LevelUp, false, null)
            set level = 1
            set SuddenDeathDialog = CreateTimerDialog(SuddenDeathTimer)
            call TimerDialogSetTitle(SuddenDeathDialog, "Creep enrage level " + I2S(level))
            call TimerDialogDisplay(SuddenDeathDialog, true)
        endif
    endfunction
endlibrary