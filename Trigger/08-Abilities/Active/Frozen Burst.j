library FrozenBurst initializer Init requires Cooldown, GetObjectElement

    globals
        // ===================== CONFIG =====================
        private constant real    COOLDOWN          = 9.
        private constant real    BURST_RADIUS      = 450.
        private constant real    BASE_DMG_PER_LVL  = 500.
        private constant real    COLD_BONUS        = 0.33   // +33% damage per Element_Cold (additive)
        private constant real    SLOW_DURATION     = 3.5    // 100% slow = movement speed 0

        // Frost Nova ground burst. Its native radius is roughly 200, so 450 / 200 = ~2.25 scale.
        // Adjust FX_SCALE if it looks too small or too big against the 450 area.
        private constant string  SFX_BURST         = "Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl"
        private constant real    FX_SCALE          = 2.25

        // Small frost hit effect on every unit caught
        private constant string  SFX_HIT           = "Abilities\\Spells\\Undead\\FrostArmor\\FrostArmorDamage.mdl"

        private constant boolean DEBUG_MODE = false
        // ====================================================

        private hashtable SlowTimerHash = InitHashtable() // timer -> SlowInstance
        private hashtable SlowUnitHash  = InitHashtable() // unit id -> {0: active slow count, 0 (real): original speed}
    endglobals

    //==================================================================
    private function DebugMsg takes string s returns nothing
        if DEBUG_MODE then
            call BJDebugMsg(s)
        endif
    endfunction

    private function IsValidEnemy takes unit u, player owner returns boolean
        return GetWidgetLife(u) > 0.405 and IsUnitEnemy(u, owner) and (not IsUnitType(u, UNIT_TYPE_DEAD))
    endfunction

    //==================================================================
    // 100% slow for a duration. Stacking-safe: the original move speed is
    // stored once, and only restored when the LAST active slow on the unit
    // expires, so a second Frozen Burst can't lock in speed 0 permanently.
    //==================================================================
    private struct SlowInstance
        unit u
        timer tmr

        static method create takes unit target, real duration returns thistype
            local thistype this = thistype.allocate()
            local integer uid = GetHandleId(target)
            local integer count = LoadInteger(SlowUnitHash, uid, 0)

            set .u   = target
            set .tmr = CreateTimer()

            if count == 0 then
                call SaveReal(SlowUnitHash, uid, 1, GetUnitMoveSpeed(target))
                call SetUnitMoveSpeed(target, 0.)
            endif
            call SaveInteger(SlowUnitHash, uid, 0, count + 1)

            call SaveInteger(SlowTimerHash, GetHandleId(.tmr), 0, this)
            call TimerStart(.tmr, duration, false, function SlowInstance.onExpireCallback)
            return this
        endmethod

        method onExpire takes nothing returns nothing
            local integer uid = GetHandleId(.u)
            local integer count = LoadInteger(SlowUnitHash, uid, 0) - 1

            if count <= 0 then
                if GetWidgetLife(.u) > 0.405 then
                    call SetUnitMoveSpeed(.u, LoadReal(SlowUnitHash, uid, 1))
                endif
                call FlushChildHashtable(SlowUnitHash, uid)
            else
                call SaveInteger(SlowUnitHash, uid, 0, count)
            endif

            call FlushChildHashtable(SlowTimerHash, GetHandleId(.tmr))
            call PauseTimer(.tmr)
            call DestroyTimer(.tmr)
            set .u = null
            call .destroy()
        endmethod

        static method onExpireCallback takes nothing returns nothing
            local timer t = GetExpiredTimer()
            local thistype this = LoadInteger(SlowTimerHash, GetHandleId(t), 0)
            call this.onExpire()
            set t = null
        endmethod
    endstruct

    //==================================================================
    // Public entry point - no target needed, bursts from the hero.
    //==================================================================
    function CastFrozenBurst takes unit caster, integer lvl returns nothing
        local player owner = GetOwningPlayer(caster)
        local real cx = GetUnitX(caster)
        local real cy = GetUnitY(caster)
        local integer cold = GetUnitElementCount(caster, Element_Cold)
        local real dmg = BASE_DMG_PER_LVL * I2R(lvl) * (1. + COLD_BONUS * I2R(cold))
        local group g = CreateGroup()
        local unit u
        local effect fx

        call AbilStartCD(caster, FROZEN_BURST_ABILITY_ID, COOLDOWN)

        call DebugMsg("Frozen Burst: cold=" + I2S(cold) + " dmg=" + R2S(dmg))

        // Burst visual, scaled to match the 450 radius
        set fx = AddSpecialEffect(SFX_BURST, cx, cy)
        call BlzSetSpecialEffectScale(fx, FX_SCALE)
        call DestroyEffect(fx)
        set fx = null

        call GroupEnumUnitsInRange(g, cx, cy, BURST_RADIUS, null)
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            call GroupRemoveUnit(g, u)

            if IsValidEnemy(u, owner) then
                call UnitDamageTarget(caster, u, dmg, false, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                call DestroyEffect(AddSpecialEffectTarget(SFX_HIT, u, "chest"))
                call SlowInstance.create(u, SLOW_DURATION)
            endif
        endloop

        call DestroyGroup(g)
        set g = null
        set owner = null
    endfunction

    private function Init takes nothing returns nothing
    endfunction

endlibrary