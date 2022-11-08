library trigger137 initializer init requires RandomShit

    function Trig_PvP_No_Player_Func001Func001001002 takes nothing returns boolean
        return (IsUnitAliveBJ(GetFilterUnit())==true) and (IsUnitInGroup(GetFilterUnit(),DuelingHeroGroup)==true) and ((GetPlayerSlotState(GetOwningPlayer(GetFilterUnit()))!=PLAYER_SLOT_STATE_PLAYING)) or (GetPlayerController(GetOwningPlayer(GetFilterUnit()))==MAP_CONTROL_COMPUTER)
    endfunction

    function Trig_PvP_No_Player_Func001Func001A takes nothing returns nothing
        if(RectContainsUnit(PlayerArenaRects[udg_integer45],GetEnumUnit())==true)then
            call IssuePointOrderLocBJ(GetEnumUnit(),"attack",GetRandomLocInRect(PlayerArenaRects[udg_integer45]))
        endif
    endfunction

    function Trig_PvP_No_Player_Actions takes nothing returns nothing
        set udg_integer45 = 1
        loop
            exitwhen udg_integer45 > 8
            call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_PvP_No_Player_Func001Func001001002)),function Trig_PvP_No_Player_Func001Func001A)
            set udg_integer45 = udg_integer45 + 1
        endloop
    endfunction

    private function init takes nothing returns nothing
        set udg_trigger137 = CreateTrigger()
        call TriggerRegisterTimerEventPeriodic(udg_trigger137,6.00)
        call TriggerAddAction(udg_trigger137,function Trig_PvP_No_Player_Actions)
    endfunction

endlibrary
