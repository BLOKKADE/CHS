library PowerOfWater initializer init requires RandomShit, CustomEvent




    private function LearnAbility takes nothing returns boolean
        local customEvent e = GetTriggerCustomEvent(GetTriggeringTrigger())
        if e.EventSpellId == POWER_OF_WATER_ABILITY_ID and e.LearnedAbilityIsNew then
            call SaveEffectHandle(HT, GetHandleId(e.EventUnit), POWER_OF_WATER_ABILITY_ID, AddSpecialEffectTargetUnitBJ("overhead", e.EventUnit, "war3mapImported\\OrbWaterX.mdx"))
        endif

        return false
    endfunction

    private function UnlearnAbility takes nothing returns boolean
        local customEvent e = GetTriggerCustomEvent(GetTriggeringTrigger())
        if e.EventSpellId == POWER_OF_WATER_ABILITY_ID then
            call DestroyEffect(LoadEffectHandle(HT,GetHandleId(e.EventUnit), POWER_OF_WATER_ABILITY_ID))
        endif

        return false
    endfunction

    private function init takes nothing returns nothing
        call EventSubscriber(CUSTOM_EVENT_LEARN_ABILITY, function LearnAbility)
        call EventSubscriber(CUSTOM_EVENT_UNLEARN_ABILITY, function UnlearnAbility)
    endfunction
endlibrary