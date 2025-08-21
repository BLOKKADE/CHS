library Mystic initializer init requires HideEffects, CustomGameEvent
    private function OnRoundStart takes EventInfo eventInfo returns nothing
        local real x = 0
        local real y = 0
        local integer heroLevel = GetHeroLevel(eventInfo.hero)
        local integer faerieCount = 1 //+ (heroLevel / 35) // Base 1 Faerie + 1 extra per 35 levels
        local integer i = 0
        local real angleOffset = 0

        if GetUnitTypeId(eventInfo.hero) == MYSTIC_UNIT_ID then
            loop
                exitwhen i >= faerieCount
                set angleOffset = 30.0 * i // Spread Faeries in a circle
                set x = GetUnitX(eventInfo.hero) + 40 * CosBJ(-30.0 + GetUnitFacing(eventInfo.hero) + angleOffset)
                set y = GetUnitY(eventInfo.hero) + 40 * SinBJ(-30.0 + GetUnitFacing(eventInfo.hero) + angleOffset)
                call DestroyEffect(AddLocalizedSpecialEffect(FX_BLINK, x, y))
                call CreateUnit(GetOwningPlayer(eventInfo.hero), FAERIE_DRAGON_UNIT_ID, x, y, GetUnitFacing(eventInfo.hero))
                set i = i + 1
            endloop
        endif
    endfunction

    private function init takes nothing returns nothing
        call CustomGameEvent_RegisterEventCode(EVENT_PLAYER_ROUND_START, CustomEvent.OnRoundStart)
    endfunction
endlibrary
