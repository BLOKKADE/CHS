library trigger98 initializer init requires RandomShit

    function Trig_Attack_Move_Func001Func001001002001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_Attack_Move_Func001Func001001002002 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())==Player(11))
    endfunction
    
    function Trig_Attack_Move_Func001Func001001002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Attack_Move_Func001Func001001002001(),Trig_Attack_Move_Func001Func001001002002())
    endfunction


    function Trig_Attack_Move_Func001Func001A takes nothing returns nothing
        call IssuePointOrderLocBJ(GetEnumUnit(),"patrol",GetRandomLocInRect(PlayerArenaRects[udg_integer43]))
    endfunction


    function Trig_Attack_Move_Actions takes nothing returns nothing
        set udg_integer43 = 1
        loop
            exitwhen udg_integer43 > 8
            call ForGroupBJ(GetUnitsInRectMatching(PlayerArenaRects[udg_integer43],Condition(function Trig_Attack_Move_Func001Func001001002)),function Trig_Attack_Move_Func001Func001A)
            set udg_integer43 = udg_integer43 + 1
        endloop
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger98 = CreateTrigger()
        call TriggerRegisterTimerEventPeriodic(udg_trigger98,6.00)
        call TriggerAddAction(udg_trigger98,function Trig_Attack_Move_Actions)
    endfunction


endlibrary
