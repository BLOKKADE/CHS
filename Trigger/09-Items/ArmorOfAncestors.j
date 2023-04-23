library ArmorOfAncestors initializer init requires CustomState, CustomGameEvent, RandomShit

    globals
        Table ArmorOfAncestorsBonus
    endglobals

    private function OnRoundEnd takes EventInfo eventInfo returns nothing
        local integer bonus = ArmorOfAncestorsBonus[GetHandleId(eventInfo.hero)]

        if bonus != 0 then
            set ArmorOfAncestorsBonus[GetHandleId(eventInfo.hero)] = 0
            call BlzSetUnitArmor(eventInfo.hero, BlzGetUnitArmor(eventInfo.hero) - bonus)
            call AddUnitCustomState(eventInfo.hero, BONUS_BLOCK, - bonus)
        endif
    endfunction

    private function OnRoundStart takes EventInfo eventInfo returns nothing
        local integer itemCount = 0

        if not eventInfo.isPvp then
            set itemCount = GetUnitItemTypeCount(eventInfo.hero, 'I07G')
            if itemCount > 0 then
                call ElemFuncStart(eventInfo.hero, 'I07G')
                call BlzSetUnitArmor(eventInfo.hero, BlzGetUnitArmor(eventInfo.hero) + itemCount * 20 * RoundCreepNumber)
                call AddUnitCustomState(eventInfo.hero, BONUS_BLOCK, itemCount * 20 * RoundCreepNumber)
                set ArmorOfAncestorsBonus[GetHandleId(eventInfo.hero)] = ArmorOfAncestorsBonus[GetHandleId(eventInfo.hero)] + itemCount * 20 * RoundCreepNumber
            endif
        endif
    endfunction

    private function init takes nothing returns nothing
        set ArmorOfAncestorsBonus = Table.create()
        call CustomGameEvent_RegisterEventCode(EVENT_PLAYER_ROUND_START, CustomEvent.OnRoundStart)
        call CustomGameEvent_RegisterEventCode(EVENT_PLAYER_ROUND_COMPLETE, CustomEvent.OnRoundEnd)
    endfunction
endlibrary
