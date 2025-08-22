library Murloc initializer init requires CustomGameEvent

    private function ResetMurlocStats takes EventInfo eventInfo returns nothing
    local unit hero = eventInfo.hero
    local integer hid = GetHandleId(hero)
    local integer strBonus = LoadInteger(HT, hid, 54021)
    local integer agiBonus = LoadInteger(HT, hid, 54022)
    local integer intBonus = LoadInteger(HT, hid, 54023)

        // Reset scale factor to default FIRST
        call SetUnitScale(hero, 1.0, 1.0, 1.0)

        // Remove bonuses if any were applied
        if strBonus != 0 or agiBonus != 0 or intBonus != 0 then
            call AddUnitBonus(hero, BONUS_STRENGTH, -strBonus)
            call AddUnitBonus(hero, BONUS_AGILITY, -agiBonus)
            call AddUnitBonus(hero, BONUS_INTELLIGENCE, -intBonus)

            // Prevent hero death from zero Strength
            if GetHeroStr(hero, true) <= 1 then
                call SetHeroStr(hero, 2, true)
            endif

            // Reset saved bonuses
            call SaveInteger(HT, hid, 54021, 0)
            call SaveInteger(HT, hid, 54022, 0)
            call SaveInteger(HT, hid, 54023, 0)
        endif
    endfunction

    private function init takes nothing returns nothing
        call CustomGameEvent_RegisterEventCode(EVENT_GAME_ROUND_START, CustomEvent.ResetMurlocStats)
        call CustomGameEvent_RegisterEventCode(EVENT_PLAYER_ROUND_COMPLETE, CustomEvent.ResetMurlocStats)
    endfunction

endlibrary


