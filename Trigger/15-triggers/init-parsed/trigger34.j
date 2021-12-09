library trigger34 initializer init requires RandomShit

    function Trig_Ward_Location_Conditions takes nothing returns boolean
        if(not Trig_Ward_Location_Func002C())then
            return false
        endif
        return true
    endfunction


    function Trig_Ward_Location_Actions takes nothing returns nothing
        if(Trig_Ward_Location_Func001C())then
            call DoNothing()
        else
            if(Trig_Ward_Location_Func001Func002C())then
                call DoNothing()
            else
                call SetUnitPositionLoc(GetTriggerUnit(),PolarProjectionBJ(GetRectCenter(udg_rects01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]),525.00,AngleBetweenPoints(GetRectCenter(udg_rects01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]),GetUnitLoc(GetTriggerUnit()))))
            endif
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger34 = CreateTrigger()
        call TriggerRegisterEnterRectSimple(udg_trigger34,GetPlayableMapRect())
        call TriggerAddCondition(udg_trigger34,Condition(function Trig_Ward_Location_Conditions))
        call TriggerAddAction(udg_trigger34,function Trig_Ward_Location_Actions)
    endfunction


endlibrary
