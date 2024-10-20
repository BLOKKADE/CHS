library PvpSuddenDraw /*initializer init*/ requires TimerUtils, PvpEnd
    globals
        private integer Duration = 45
    endglobals

    struct SuddenDraw extends array
        private static SuddenDraw temp
        private integer endTick

        private DuelGame duelGame

        private timer suddenDeathTimer
        private timerdialog timerDialog

        private boolean suddenDrawActive

        private method periodic takes nothing returns nothing
            if (not duelGame.isDuelOver) and this.suddenDrawActive then
                if T32_Tick > this.endTick then
                    set this.suddenDrawActive = false

                    set PvpEndDuelGame = this.duelGame
                    call ConditionalTriggerExecute(DuelDrawTrigger)
                endif
            else
                call this.destroy()
            endif
        endmethod 

        private method setupTimer takes nothing returns nothing
            set suddenDeathTimer = NewTimer()
            call TimerStart(this.suddenDeathTimer, Duration, false, null)
            set this.timerDialog = CreateTimerDialog(this.suddenDeathTimer)
            call TimerDialogDisplay(this.timerDialog, false)
            call TimerDialogSetTitle(this.timerDialog, "Duel draws in:")
            
            if SimultaneousDuelMode == 1 or BlzForceHasPlayer(this.duelGame.team1, GetLocalPlayer()) or BlzForceHasPlayer(this.duelGame.team2, GetLocalPlayer()) then
                call TimerDialogDisplay(this.timerDialog, true)
            endif
        endmethod

        method start takes nothing returns thistype
            call this.setupTimer()
            set this.endTick = T32_Tick + (Duration * 32)
            set this.suddenDrawActive = true

            call this.startPeriodic()
            return this
        endmethod

        static method create takes DuelGame duelGame returns thistype
            local thistype this = thistype.setup()
            set this.duelGame = duelGame
            
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            call this.stopPeriodic()
            call ReleaseTimer(this.suddenDeathTimer)
            set this.suddenDeathTimer = null
            call TimerDialogDisplay(this.timerDialog, false)
            call DestroyTimerDialog(this.timerDialog)
            set this.timerDialog = null
            call this.recycle()
        endmethod
    
        implement T32x
        implement Recycle
    endstruct
endlibrary