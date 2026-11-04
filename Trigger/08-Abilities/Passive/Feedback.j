library Feedback initializer Init requires AbilityCooldown

    globals
        // ===================== CONFIG =====================
        private constant real    COOLDOWN        = 1.
        private constant real    MANA_PCT        = 0.04    // 4% of the target's CURRENT mana
        private constant real    TICK            = 1.
        private constant integer TICKS           = 3
        private constant real    BLAST_RADIUS    = 350.

        // The debuff buff the dummy cast applies. It must last at least 3s.
        private constant integer DEBUFF_SPELL_ID = 'fBBb'
        private constant integer DEBUFF_BUFF_ID  = 'BfbB'

        // Unverified paths (War Stomp is confirmed in your map)
        private constant string  SFX_BURN        = "Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBoltImpact.mdl"
        private constant string  SFX_COMBUST     = "Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl"
        // ====================================================

        private hashtable TimerHash = InitHashtable()
        private group     Grp       = CreateGroup()
    endglobals

    //==================================================================
    // One combustion package. Every hit creates its own, so they stack.
    // A package only deals damage while the target still has the debuff.
    //==================================================================
    private struct Combustion
        unit source
        unit target
        player owner
        real dmg
        integer left
        timer tmr

        static method create takes unit source, unit target, real dmg returns thistype
            local thistype this = thistype.allocate()

            set .source = source
            set .target = target
            set .owner  = GetOwningPlayer(source)
            set .dmg    = dmg
            set .left   = TICKS
            set .tmr    = CreateTimer()

            call SaveInteger(TimerHash, GetHandleId(.tmr), 0, this)
            call TimerStart(.tmr, TICK, true, function thistype.onTickCallback)
            return this
        endmethod

        method onTick takes nothing returns nothing
            local unit u
            local real x
            local real y

            if GetWidgetLife(.target) < 0.405 or GetUnitAbilityLevel(.target, DEBUFF_BUFF_ID) == 0 then
                call .destroy()
                return
            endif

            set x = GetUnitX(.target)
            set y = GetUnitY(.target)
            call DestroyEffect(AddSpecialEffect(SFX_COMBUST, x, y))

            call GroupEnumUnitsInRange(Grp, x, y, BLAST_RADIUS, null)
            loop
                set u = FirstOfGroup(Grp)
                exitwhen u == null
                call GroupRemoveUnit(Grp, u)
                if GetWidgetLife(u) > 0.405 and IsUnitEnemy(u, .owner) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and GetUnitAbilityLevel(u, 'Aloc') == 0 then
                    call UnitDamageTarget(.source, u, .dmg, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                endif
            endloop
            set u = null

            set .left = .left - 1
            if .left <= 0 then
                call .destroy()
            endif
        endmethod

        method onDestroy takes nothing returns nothing
            call FlushChildHashtable(TimerHash, GetHandleId(.tmr))
            call PauseTimer(.tmr)
            call DestroyTimer(.tmr)
            set .source = null
            set .target = null
        endmethod

        static method onTickCallback takes nothing returns nothing
            local timer t = GetExpiredTimer()
            local thistype this = LoadInteger(TimerHash, GetHandleId(t), 0)
            call this.onTick()
            set t = null
        endmethod
    endstruct

    //==================================================================
    // Step 1: cooldown check, mana removal, cooldown start.
    // Returns the mana removed, or 0 if Feedback did not trigger.
    //==================================================================
    function FeedbackPrepare takes unit source, unit target returns real
        local real mana = GetUnitState(target, UNIT_STATE_MANA)
        local real lost = mana * MANA_PCT

        if BlzGetUnitAbilityCooldownRemaining(source, FEEDBACK_ABILITY_ID) > 0. then
            return 0.
        endif
        if lost < 1. then
            return 0.
        endif

        call AbilStartCD(source, FEEDBACK_ABILITY_ID, COOLDOWN)
        call SetUnitState(target, UNIT_STATE_MANA, mana - lost)
        call DestroyEffect(AddSpecialEffectTarget(SFX_BURN, target, "origin"))
        return lost
    endfunction

    // Step 2: call after the debuff has been applied to the target.
    function FeedbackStart takes unit source, unit target, real lost returns nothing
        call Combustion.create(source, target, lost)
    endfunction

    private function Init takes nothing returns nothing
    endfunction

endlibrary




