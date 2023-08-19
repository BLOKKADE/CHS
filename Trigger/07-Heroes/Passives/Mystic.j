library Mystic initializer init requires HideEffects, CustomGameEvent
    private function OnRoundStart takes EventInfo eventInfo returns nothing
        local real x = 0
        local real y = 0

        if GetUnitTypeId(eventInfo.hero) == MYSTIC_UNIT_ID then
            set x = GetUnitX(eventInfo.hero) + 40 * CosBJ(- 30 + GetUnitFacing(eventInfo.hero))
            set y = GetUnitY(eventInfo.hero) + 40 * SinBJ(- 30 + GetUnitFacing(eventInfo.hero))
            call DestroyEffect(AddLocalizedSpecialEffect(FX_BLINK, x, y))
            call CreateUnit(GetOwningPlayer(eventInfo.hero), FAERIE_DRAGON_UNIT_ID, x, y, GetUnitFacing(eventInfo.hero))
        endif
    endfunction

    private function init takes nothing returns nothing
        call CustomGameEvent_RegisterEventCode(EVENT_PLAYER_ROUND_START, CustomEvent.OnRoundStart)
    endfunction 
endlibrary
