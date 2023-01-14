library PvpSuddenDeathTimerWindow /*initializer init*/ requires TimerUtils
    globals
        private integer Duration = 30

        //how often damage is changed, damage is dealt, and when to start sudden death
        private integer damageUpdateInterval = R2I(1.25 * 32)
        private integer damageInterval = R2I(0.25 * 32)
        private integer damageStartTick = R2I(Duration * 32)
    endglobals

    /*
    //these can be used if we ever need to get sudden death for a player (for midas touch for example) ive disable dit for now
    globals
        Table PlayerSuddenDeath
        Table SuddenDeathStructs
    endglobals

    private function GetSuddenDeathStruct takes integer i returns SuddenDeath
        return SuddenDeathStructs[i]
    endfunction

    function IsPlayerInSudddenDeath takes player p returns boolean
        return GetSuddenDeathStruct(PlayerSuddenDeath[GetPlayerId(p)]).suddenDeath
    endfunction

    private function init takes nothing returns nothing
        set PlayerSuddenDeath = Table.create()
        set SuddenDeathStructs = Table.create()
    endfunction
    */

    struct SuddenDeath extends array
        private static SuddenDeath temp
        private integer startTick
        private integer nextDamageUpdate
        private integer nextDamage
        private integer damageStart

        boolean suddenDeath
        private real multiplier
        private boolean damageTeam1
        
        private DuelGame duelGame

        private timer suddenDeathTimer
        private timerdialog timerDialog

        //deal damage to players based on static temp and damage.team1 boolean
        private static method damagePlayer takes nothing returns nothing
            local SuddenDeath this = SuddenDeath.temp
            local integer pid = GetPlayerId(GetEnumPlayer())
            local real damage = 0
            local unit source
            local integer damageSourcePid

            if this.damageTeam1 then
                set damageSourcePid = GetPlayerId(ForcePickRandomPlayer(this.duelGame.team2))
            else
                set damageSourcePid = GetPlayerId(ForcePickRandomPlayer(this.duelGame.team1))
            endif

            if GetUnitTypeId(PlayerHeroes[pid]) == BANSHEE_UNIT_ID then
                set damage = GetUnitState(PlayerHeroes[pid], UNIT_STATE_MAX_MANA) * multiplier
            else
                set damage = GetUnitState(PlayerHeroes[pid], UNIT_STATE_MAX_LIFE) * multiplier
            endif
            
            set source = CreateUnit(Player(damageSourcePid), SUDDEN_DEATH_UNIT_ID, GetUnitX(PlayerHeroes[damageSourcePid]), GetUnitY(PlayerHeroes[damageSourcePid]), 0)
            call UnitApplyTimedLife(source, 'BTLF', 0.25)

            set udg_NextDamageAbilitySource = SUDDEN_DEATH_ABILITY_ID
            call Damage.apply(source, PlayerHeroes[pid], damage, false, false, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_WHOKNOWS)
            
            set source = null
        endmethod

        //setup temp and damageteam1
        private method damageDuelers takes nothing returns nothing
            set SuddenDeath.temp = this

            set this.damageTeam1 = true
            call ForForce(this.duelGame.team1, function SuddenDeath.damagePlayer)

            set this.damageTeam1 = false
            call ForForce(this.duelGame.team2, function SuddenDeath.damagePlayer)
        endmethod

        private method startSuddenDeath takes nothing returns nothing
            set this.nextDamageUpdate = T32_Tick + damageUpdateInterval
            set this.nextDamage = T32_Tick + damageInterval
            set this.suddenDeath = true
        endmethod

        private method updateMultiplier takes nothing returns nothing
            set this.multiplier = this.multiplier * 1.1
            call TimerDialogSetTitle(this.timerDialog, "Sudden Death: " + R2SW(this.multiplier * 100, 1, 1) + "%")
        endmethod

        private method periodic takes nothing returns nothing
            if not duelGame.isDuelOver then
                if not this.suddenDeath then
                    if T32_Tick > this.damageStart then
                        call this.startSuddenDeath()
                    endif
                else
                    if T32_Tick > this.nextDamage then
                        set this.nextDamage = T32_Tick + damageInterval
                        call this.damageDuelers()
                    endif
                    if T32_Tick > this.nextDamageUpdate then
                        set this.nextDamageUpdate = T32_Tick + damageUpdateInterval
                        call this.updateMultiplier()
                    endif
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
            call TimerDialogSetTitle(this.timerDialog, "Sudden Death")
            
            if SimultaneousDuelMode == 1 or BlzForceHasPlayer(this.duelGame.team1, GetLocalPlayer()) or BlzForceHasPlayer(this.duelGame.team2, GetLocalPlayer()) then
                call TimerDialogDisplay(this.timerDialog, true)
            endif
        endmethod

        method start takes nothing returns thistype
            set this.startTick = T32_Tick
            set this.damageStart = T32_Tick + damageStartTick
            call this.setupTimer()
            call this.startPeriodic()

            return this
        endmethod

        static method create takes DuelGame duelGame returns thistype
            local thistype this = thistype.setup()
            set this.multiplier = 0.01
            set this.suddenDeath = false
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