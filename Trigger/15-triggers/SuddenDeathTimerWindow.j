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
            call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 10, "The creeps are pissed off! They won't let you use Midas Touch or the Magic Necklace!")
        elseif level == 3 then
            call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 10, "The creeps are pretty angry! They have Crit and max movespeed!")
        elseif level == 4 then
            call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 10, "The creeps are extremely agitated! Their damage will start to increase!")
        elseif level == 5 then
            call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 10, "The creeps are going crazy!!! You start losing hp every second!")
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