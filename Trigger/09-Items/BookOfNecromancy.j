library BookOfNecromancy initializer init requires RandomShit, CustomGameEvent, UnitItems, Stomp

    private function OnRoundStart takes EventInfo eventInfo returns nothing
        local integer count = GetUnitItemTypeCount(eventInfo.hero, BOOK_OF_NECROMANCY_ITEM_ID)
        local integer pid = GetPlayerId(eventInfo.p)
        local integer i = 0
        local integer loops = 1

        if GameModeShort and SuddenDeathEnabled == false then
            set loops = 2
        endif

        if count > 0 and SuddenDeathEnabled == false then
            loop
                exitwhen i >= loops
                call ElemFuncStart(eventInfo.hero, BOOK_OF_NECROMANCY_ITEM_ID)
                set SummonDamage[pid] = SummonDamage[pid] + count
                call DisplayTimedTextToPlayer(Player(pid), 0, 0, 2, "Summon Attack Bonus - [|cffffcc00Level " + I2S(SummonDamage[pid]) + "|r] - (|cff89ff52+" + I2S(SummonDamage[pid] * 20) + ")|r")
                set SummonArmor[pid] = SummonArmor[pid] + count
                call DisplayTimedTextToPlayer(Player(pid), 0, 0, 2, "Summon Armor Bonus - [|cffffcc00Level " + I2S(SummonArmor[pid]) + "|r] - (|cff89ff52+" + I2S(SummonArmor[pid] * 2) + ")|r")
                set SummonHitPoints[pid] = SummonHitPoints[pid] + count  
                call DisplayTimedTextToPlayer(Player(pid), 0, 0, 2, "Summon HP Bonus - [|cffffcc00Level " + I2S(SummonHitPoints[pid]) + "|r] - (|cff89ff52+" + I2S(SummonHitPoints[pid] * 200) + ")|r") 
                call AddStompStats(eventInfo.hero)
                set i = i + 1
            endloop
        endif 
    endfunction

    private function init takes nothing returns nothing
        call CustomGameEvent_RegisterEventCode(EVENT_PLAYER_ROUND_START, CustomEvent.OnRoundStart)
    endfunction 

endlibrary
