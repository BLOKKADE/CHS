library PvpSuddenDeathTimerWindow requires TimerUtils
    globals
        private timer SuddenDeathTimer = null
        private timerdialog SuddenDeathDialog = null
        private integer Duration = 30
    endglobals

    function PvpUpdateDeathTimerDisplay takes real value returns nothing
        set SuddenDeathEnabled = true
        call TimerDialogSetTitle(SuddenDeathDialog, "Sudden Death: " + R2SW(value * 5, 1, 1) + " + " + R2SW(value * 50, 1, 1) + "%")
    endfunction

    function PvpStopSuddenDeathTimer takes nothing returns nothing
        call ReleaseTimer(SuddenDeathTimer)
        set SuddenDeathTimer = null
        call TimerDialogDisplay(SuddenDeathDialog, false)
        call DestroyTimerDialog(SuddenDeathDialog)
        set SuddenDeathDialog = null
    endfunction

    function PvpStartSuddenDeathTimer takes nothing returns nothing
        if SuddenDeathTimer == null then
            set SuddenDeathEnabled = false
            set SuddenDeathTimer = NewTimer()
            call TimerStart(SuddenDeathTimer, 30, false, null)
            set SuddenDeathDialog = CreateTimerDialog(SuddenDeathTimer)
            call TimerDialogSetTitle(SuddenDeathDialog, "Sudden Death")
            call TimerDialogDisplay(SuddenDeathDialog, true)
        endif
    endfunction
endlibrary