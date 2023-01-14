library PowerOfWater initializer init requires RandomShit, CustomGameEvent
    private function LearnAbility takes EventInfo eventInfo returns nothing
        if eventInfo.abilId == POWER_OF_WATER_ABILITY_ID then
            call SaveEffectHandle(HT, GetHandleId(eventInfo.hero), POWER_OF_WATER_ABILITY_ID, AddLocalizedSpecialEffectTarget("war3mapImported\\OrbWaterX.mdx", eventInfo.hero, "overhead"))
        endif
    endfunction

    private function UnlearnAbility takes EventInfo eventInfo returns nothing
        if eventInfo.abilId == POWER_OF_WATER_ABILITY_ID then
            call DestroyEffect(LoadEffectHandle(HT,GetHandleId(eventInfo.hero), POWER_OF_WATER_ABILITY_ID))
        endif
    endfunction

    private function init takes nothing returns nothing
        call CustomGameEvent_RegisterEventCode(EVENT_LEARN_ABILITY, CustomEvent.LearnAbility)
        call CustomGameEvent_RegisterEventCode(EVENT_UNLEARN_ABILITY, CustomEvent.UnlearnAbility)
    endfunction
endlibrary