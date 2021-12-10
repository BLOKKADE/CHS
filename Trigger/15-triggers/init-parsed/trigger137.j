library trigger137 initializer init requires RandomShit

    function Trig_PvP_No_Player_Func001Func001001002001001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction


    function Trig_PvP_No_Player_Func001Func001Func001C takes nothing returns boolean
        if(not(RectContainsUnit(udg_rects01[udg_integer45],GetEnumUnit())==true))then
            return false
        endif
        return true
    endfunction


    function Trig_PvP_No_Player_Func001Func001A takes nothing returns nothing
        if(Trig_PvP_No_Player_Func001Func001Func001C())then
            call IssuePointOrderLocBJ(GetEnumUnit(),"attack",GetRandomLocInRect(udg_rects01[udg_integer45]))
        else
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
