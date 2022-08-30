library EnergyShield initializer init requires RandomShit, CustomEvent

    private function checkShield takes nothing returns nothing endfunction
        local timer t = GetExpiredTimer()
        local unit u = LoadUnitHandle(HT, GetHandleId(t), 1)
        local effect e = LoadEffectHandle(HT, GetHandleId(t), 2)
        local integer alpha = 0

        call BlzSetSpecialEffectX(e, GetUnitX(u))
        call BlzSetSpecialEffectY(e, GetUnitY(u))
        call BlzSetSpecialEffectZ(e, BlzGetUnitZ(u))

        if IsUnitVisible(u, GetLocalPlayer()) then
            set alpha = 60
        endif
    
        call BlzSetSpecialEffectAlpha(e, alpha)

        set t = null
        set u = null
        set e = null
    endfunction 


    private function LearnAbility takes nothing returns boolean
        local customEvent e = GetTriggerCustomEvent(GetTriggeringTrigger())
        local effect eff = null
        local timer t = null

        if e.EventSpellId == ENERGY_SHIELD_ABILITY_ID and e.LearnedAbilityIsNew then
            set eff = AddSpecialEffect("war3mapImported\\Ubershield Azure.mdx", GetUnitX(e.EventUnit), GetUnitY(e.EventUnit))
            call SaveEffectHandle(HT, GetHandleId(e.EventUnit), ENERGY_SHIELD_ABILITY_ID, eff)
            set t = CreateTimer()
            call SaveUnitHandle(HT,GetHandleId(t), 1, e.EventUnit)
            call SaveEffectHandle(HT, GetHandleId(t), 2, eff)
            call SaveTimerHandle(HT,GetHandleId(e.EventUnit), ENERGY_SHIELD_ABILITY_ID, t)
            call TimerStart(t, 0.03, true, function checkShield)

            call BlzSetSpecialEffectAlpha(eff, 60)
            call BlzSetSpecialEffectZ(eff, 300)
            call BlzSetSpecialEffectMatrixScale(eff, 4.25, 4.25, 2)
        endif

        set eff = null
        set t = null
        return false
    endfunction

    private function UnlearnAbility takes nothing returns boolean
        local customEvent e = GetTriggerCustomEvent(GetTriggeringTrigger())
        local timer t = null

        if e.EventSpellId == ENERGY_SHIELD_ABILITY_ID then
            set t = LoadTimerHandle(HT, GetHandleId(e.EventUnit), ENERGY_SHIELD_ABILITY_ID)
            call DestroyEffect(LoadEffectHandle(HT, GetHandleId(t), 2))
            call FlushChildHashtable(HT,GetHandleId(t))
            call DestroyTimer(t)
        endif

        set t = null
        return false
    endfunction

    private function init takes nothing returns nothing
        call EventSubscriber(CUSTOM_EVENT_LEARN_ABILITY, function LearnAbility)
        call EventSubscriber(CUSTOM_EVENT_UNLEARN_ABILITY, function UnlearnAbility)
    endfunction
endlibrary