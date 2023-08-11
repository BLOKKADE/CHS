library Rings initializer init requires Table, CustomGameEvent, UnitItems, CustomState
    globals
        Table RingTable
    endglobals

    private function RingBlockReset takes EventInfo eventInfo returns nothing
        call AddUnitCustomState(eventInfo.hero, BONUS_BLOCK, RingTable[GetHandleId(eventInfo.hero)])
    endfunction

    private function RingBlockLoss takes EventInfo eventInfo returns nothing
        local integer blockLoss = (GetUnitItemTypeCount(eventInfo.hero, 'I0AF') * 30) + (GetUnitItemTypeCount(eventInfo.hero, 'I071') * 20) + (GetUnitItemTypeCount(eventInfo.hero, 'I072') * 20) + (GetUnitItemTypeCount(eventInfo.hero, 'I073') * 20)
        set RingTable[GetHandleId(eventInfo.hero)] = blockLoss
        call AddUnitCustomState(eventInfo.hero, BONUS_BLOCK,0 - blockLoss)
    endfunction

    private function init takes nothing returns nothing
        set RingTable = Table.create()
        call CustomGameEvent_RegisterEventCode(EVENT_GAME_ROUND_START, CustomEvent.RingBlockLoss)
        call CustomGameEvent_RegisterEventCode(EVENT_GAME_ROUND_END, CustomEvent.RingBlockReset)
    endfunction 
endlibrary