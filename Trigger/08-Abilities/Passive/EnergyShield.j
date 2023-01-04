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


    function LearnAbility takes EventInfo eventInfo returns nothing
        local effect fx = null
        local timer t = null
        call BJDebugMsg("learn event")
        if eventInfo.abilId == ENERGY_SHIELD_ABILITY_ID then
            set fx = AddLocalizedSpecialEffect("war3mapImported\\Ubershield Azure.mdx", GetUnitX(eventInfo.hero), GetUnitY(eventInfo.hero))
            call SaveEffectHandle(HT, GetHandleId(eventInfo.hero), ENERGY_SHIELD_ABILITY_ID, fx)
            set t = NewTimer()
            call SaveUnitHandle(HT,GetHandleId(t), 1, eventInfo.hero)
            call SaveEffectHandle(HT, GetHandleId(t), 2, fx)
            call SaveTimerHandle(HT,GetHandleId(eventInfo.hero), ENERGY_SHIELD_ABILITY_ID, t)
            call TimerStart(t, 0.03, true, function checkShield)

            call BlzSetSpecialEffectAlpha(fx, 60)
            call BlzSetSpecialEffectZ(fx, 300)
            call BlzSetSpecialEffectMatrixScale(fx, 4.25, 4.25, 2)
        endif

        set fx = null
        set t = null
    endfunction

    function UnlearnAbility takes EventInfo eventInfo returns nothing
        local timer t = null

        if eventInfo.abilId == ENERGY_SHIELD_ABILITY_ID then
            set t = LoadTimerHandle(HT, GetHandleId(eventInfo.hero), ENERGY_SHIELD_ABILITY_ID)
            call DestroyEffect(LoadEffectHandle(HT, GetHandleId(t), 2))
            call FlushChildHashtable(HT,GetHandleId(t))
            call DestroyTimer(t)
        endif

        set t = null
    endfunction

    private function init takes nothing returns nothing
        call CustomGameEvent_RegisterEventCode(EVENT_LEARN_ABILITY, CustomEvent.LearnAbility)
        call CustomGameEvent_RegisterEventCode(EVENT_UNLEARN_ABILITY, CustomEvent.UnlearnAbility)
    endfunction
endlibrary