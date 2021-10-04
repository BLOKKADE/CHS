library SuddenDeathTimerWindow requires TimerUtils
    globals
        private timer SuddenDeathTimer = null
        private timerdialog SuddenDeathDialog = null
        private integer level
    endglobals

    function StopSuddenDeathTimer takes nothing returns nothing
        call ReleaseTimer(SuddenDeathTimer)
        set SuddenDeathTimer = null
        call TimerDialogDisplay(SuddenDeathDialog, false)
        call DestroyTimerDialog(SuddenDeathDialog)
        set SuddenDeathDialog = null
    endfunction

    function UpdateSuddenDeathTimer takes nothing returns nothing
        set level = level + 1
        set SuddenDeathEnabled = true
        call TimerDialogSetTitle(SuddenDeathDialog, "Creep enrage level " + I2S(level))
        if level == 2 then
            call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 10, "Sudden Death Level 1: Midas Touch disabled")
        elseif level == 3 then
            call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 10, "Sudden Death Level 2: Creeps get Critical Strike and max movespeed")
        elseif level == 4 then
            call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 10, "Sudden Death Level 3: Creeps get attack damage bonus")
        elseif level == 5 then
            call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 10, "Sudden Death Level 4: HP drain")
        endif
        call TimerStart(SuddenDeathTimer, 30, false, null)
    endfunction

    function StartSuddenDeathTimer takes nothing returns nothing
        if SuddenDeathTimer == null then
            set SuddenDeathEnabled = false
            set SuddenDeathTimer = NewTimer()
            call TimerStart(SuddenDeathTimer, 30, false, null)
            set level = 1
            set SuddenDeathDialog = CreateTimerDialog(SuddenDeathTimer)
            call TimerDialogSetTitle(SuddenDeathDialog, "Creep enrage level " + I2S(level))
            call TimerDialogDisplay(SuddenDeathDialog, true)
        endif
    endfunction
endlibrary