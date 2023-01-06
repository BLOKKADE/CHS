library SuddenDeathTimerWindow requires TimerUtils, Utility

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

    function PlayerText takes string s returns nothing
        local integer i = 0

        loop
            if HasPlayerFinishedLevel(PlayerHeroes[i], Player(i)) == false then
                call DisplayTimedTextToPlayer(Player(i), 0, 0, 10, s)
            endif
            set i = i + 1
            exitwhen i > 7
        endloop
    endfunction

    function UpdateSuddenDeathTimer takes nothing returns nothing
        local real duration = 30
        set level = level + 1
        set SuddenDeathEnabled = true
        
        call TimerDialogSetTitle(SuddenDeathDialog, "Creep enrage level " + I2S(level))
        
        if level == 2 then
            call PlayerText("|cffffee00Sudden Death Level 1|r: Midas Touch disabled")
            set duration = 15
        elseif level == 3 then
            call PlayerText("|cffff9900Sudden Death Level 2|r: Creeps get Critical Strike and max movespeed")
            set duration = 15
        elseif level == 4 then
            call PlayerText("|cffff6600Sudden Death Level 3|r: Creeps get attack damage bonus")
            set duration = 15
        elseif level == 5 then
            call PlayerText("|cffff0000Sudden Death Level 4|r: 20% current hit point drain every 0.25 seconds.")
            return
        endif

        call TimerStart(SuddenDeathTimer, duration, false, null)
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