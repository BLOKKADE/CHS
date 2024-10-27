library PvpSuddenDraw /*initializer init*/ requires TimerUtils, PvpEnd
    globals
        private integer Duration = 75
        private integer CountdownDuration = 10 // cannnot be biger than Duration
    endglobals

    struct SuddenDraw extends array
        private static SuddenDraw temp
        private integer endTick

        private integer startCountdown
        private boolean countdownActive

        private DuelGame duelGame

        private timer suddenDeathTimer
        private timerdialog timerDialog

        private boolean suddenDrawActive

        private method Countdown takes nothing returns nothing
            local string message = "|cffebca48Duel draws |r in |cff61e9d7" + I2S(CountdownDuration) + "|r seconds!"
            set this.countdownActive = true
            call DisplayTimedTextToForce(duelGame.team1, 5, message)
            call DisplayTimedTextToForce(duelGame.team2, 5, message)
            call duelGame.startCountdown(CountdownDuration)
        endmethod

        private method periodic takes nothing returns nothing
            if (not duelGame.isDuelOver) and this.suddenDrawActive then
                if (not this.countdownActive) and T32_Tick >= this.startCountdown then
                    call this.Countdown()
                endif
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
            set this.startCountdown = this.endTick - (CountdownDuration * 32)
            set this.countdownActive = false

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