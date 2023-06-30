library ShiningRunestone initializer init requires RandomShit, CustomGameEvent, RuneInit, UnitItems

    private function OnRoundStart takes EventInfo eventInfo returns nothing
        local integer i = 0
        local integer count = GetUnitItemTypeCount(eventInfo.hero, SHINING_RUNESTONE_ITEM_ID)

         if count > 0 then
             loop 
                 exitwhen i >= count
                 call CreateRandomRune(0, GetRandomReal(- 100, 100) + GetUnitX(eventInfo.hero), GetRandomReal(-100, 100) + GetUnitY(eventInfo.hero), eventInfo.hero)
                 set i = i + 1
             endloop
         endif
    endfunction

    private function init takes nothing returns nothing
        call CustomGameEvent_RegisterEventCode(EVENT_PLAYER_ROUND_START, CustomEvent.OnRoundStart)
    endfunction 
endlibrary
