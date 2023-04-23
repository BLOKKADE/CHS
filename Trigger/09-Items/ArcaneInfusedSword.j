library ArcaneInfusedSword initializer init requires CustomState, CustomGameEvent, Utility

    globals
        Table ArcaneInfusedSwordBonus
    endglobals

    private function OnRoundEnd takes EventInfo eventInfo returns nothing
        local integer bonus = ArcaneInfusedSwordBonus[GetHandleId(eventInfo.hero)]

        if bonus != 0 then
            set ArcaneInfusedSwordBonus[GetHandleId(eventInfo.hero)] = 0
            call AddUnitBonus(eventInfo.hero, BONUS_DAMAGE, 0 - bonus)
        endif
    endfunction

    private function OnRoundStart takes EventInfo eventInfo returns nothing
        local integer itemCount = 0
        local integer bonus = 0

        if not eventInfo.isPvp then
            set itemCount = GetUnitItemTypeCount(eventInfo.hero, ARCANE_INFUSED_SWORD_ITEM_ID)
            if itemCount > 0 then
                set bonus = ArcaneInfusedSwordBonus[GetHandleId(eventInfo.hero)] + R2I(GetUnitDamage(eventInfo.hero, 0) * 0.05 * RoundCreepNumber * itemCount)
                call AddUnitBonus(eventInfo.hero, BONUS_DAMAGE, bonus)
                set ArcaneInfusedSwordBonus[GetHandleId(eventInfo.hero)] = bonus
            endif
        endif
    endfunction

    private function init takes nothing returns nothing
        set ArcaneInfusedSwordBonus = Table.create()
        call CustomGameEvent_RegisterEventCode(EVENT_PLAYER_ROUND_START, CustomEvent.OnRoundStart)
        call CustomGameEvent_RegisterEventCode(EVENT_PLAYER_ROUND_COMPLETE, CustomEvent.OnRoundEnd)
    endfunction
endlibrary
