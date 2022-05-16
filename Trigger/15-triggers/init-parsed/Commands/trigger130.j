library trigger130 initializer init requires RandomShit

    function Trig_Spacebar_Point_Func001001002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
    endfunction


    function Trig_Spacebar_Point_Func001A takes nothing returns nothing
        local location unitLocation = GetUnitLoc(GetEnumUnit())
        call SetCameraQuickPositionLocForPlayer(GetOwningPlayer(GetEnumUnit()),unitLocation)
        call RemoveLocation(unitLocation)
        set unitLocation = null
    endfunction


    function Trig_Spacebar_Point_Actions takes nothing returns nothing
        call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_Spacebar_Point_Func001001002)),function Trig_Spacebar_Point_Func001A)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger130 = CreateTrigger()
        call TriggerRegisterTimerEventPeriodic(udg_trigger130,4)
        call TriggerAddAction(udg_trigger130,function Trig_Spacebar_Point_Actions)
    endfunction


endlibrary
