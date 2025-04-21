library Murloc initializer init requires CustomGameEvent
    private function ResetMurlocStats takes EventInfo eventInfo returns nothing
        local integer hid = GetHandleId(eventInfo.hero)
        local integer i1 = LoadInteger(HT, hid, 54021)

        if i1 != 0 then 
            call AddUnitBonus(eventInfo.hero, BONUS_STRENGTH, 0 - i1)
            call AddUnitBonus(eventInfo.hero, BONUS_AGILITY, 0 - i1)
            call AddUnitBonus(eventInfo.hero, BONUS_INTELLIGENCE, 0 - i1)
            call SaveInteger(HT, hid, 54021, 0)
        endif
    endfunction

    private function init takes nothing returns nothing
        call CustomGameEvent_RegisterEventCode(EVENT_GAME_ROUND_START, CustomEvent.ResetMurlocStats)
        call CustomGameEvent_RegisterEventCode(EVENT_PLAYER_ROUND_COMPLETE, CustomEvent.ResetMurlocStats)
    endfunction 
endlibrary
