library Murloc initializer init requires CustomGameEvent
    private function ResetMurlocStats takes EventInfo eventInfo returns nothing
        local integer hid = GetHandleId(eventInfo.hero)
        local integer i1 = LoadInteger(HT, hid, 54021)

        if i1 != 0 then 
            call SetHeroStr(eventInfo.hero, GetHeroStr(eventInfo.hero, false) - i1, false)
            call SetHeroAgi(eventInfo.hero, GetHeroAgi(eventInfo.hero, false) - i1, false)
            call SetHeroInt(eventInfo.hero, GetHeroInt(eventInfo.hero, false) - i1, false)
            call SaveInteger(HT, hid, 54021, 0)
        endif
    endfunction

    private function init takes nothing returns nothing
        call CustomGameEvent_RegisterEventCode(EVENT_GAME_ROUND_START, CustomEvent.ResetMurlocStats)
        call CustomGameEvent_RegisterEventCode(EVENT_PLAYER_ROUND_COMPLETE, CustomEvent.ResetMurlocStats)
    endfunction 
endlibrary
