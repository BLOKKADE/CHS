library AncientTeaching initializer init requires Cooldown, StableSpells, ToggleSpell

    private function ResetAbility_A05U takes unit u,integer abilId returns nothing
        if BlzGetUnitAbilityCooldownRemaining(u, ANCIENT_TEACHING_ABILITY_ID) <= 0.001 and GetUnitAbilityLevel(u, ANCIENT_TEACHING_ABILITY_ID) > 0 and IsSpellResettable(abilId) then
            call AbilStartCD(u, ANCIENT_TEACHING_ABILITY_ID, BlzGetUnitAbilityCooldownRemaining(u, abilId) * (4 - 0.1 * I2R(GetUnitAbilityLevel(u, ANCIENT_TEACHING_ABILITY_ID)))) 
            call BlzEndUnitAbilityCooldown(u, abilId)
            call BlzEndUnitAbilityCooldown(u, GetDummySpell(u, abilId))
        endif
    endfunction

    //public because its used by an ExecuteFunc, maybe refactor some time
    function ResetAbilit_Ec takes nothing returns nothing
        call ResetAbility_A05U(Global_u, Global_i)
    endfunction

    private function A05U_Reset_Timer takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit u = LoadUnitHandle(HT, GetHandleId(t), 2)
        local integer abilId = LoadInteger(HT, GetHandleId(t), 1)

        call ResetAbility_A05U(u, abilId)

        call FlushChildHashtable(HT, GetHandleId(t))
        call ReleaseTimer(t)
        set t = null
        set u = null
    endfunction

    private function AncientTeachingActions takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local integer abilId = GetSpellAbilityId()
        local timer t = null

        if abilId != RESET_TIME_ABILITY_ID then
            if GetUnitAbilityLevel(u, ANCIENT_TEACHING_ABILITY_ID) > 0 and BlzGetUnitAbilityCooldownRemaining(u, ANCIENT_TEACHING_ABILITY_ID) <= 0.001 then
                set t = NewTimer()
                call SaveInteger(HT, GetHandleId(t), 1, abilId)
                call SaveUnitHandle(HT, GetHandleId(t), 2, u)
                call TimerStart(t, 0, false, function A05U_Reset_Timer)
            endif
        endif

        // Cleanup
        set u = null
        set t = null
    endfunction

    private function init takes nothing returns nothing
        local trigger ancientTeachingTrigger = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(ancientTeachingTrigger, EVENT_PLAYER_UNIT_SPELL_EFFECT)
        call TriggerAddAction(ancientTeachingTrigger, function AncientTeachingActions)
        set ancientTeachingTrigger = null
    endfunction

endlibrary