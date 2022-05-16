library trigger34 initializer init requires RandomShit

    function Trig_Ward_Location_Func002C takes nothing returns boolean
        if((GetUnitTypeId(GetTriggerUnit())=='ohwd'))then
            return true
        endif
        if((GetUnitTypeId(GetTriggerUnit())=='osp1'))then
            return true
        endif
        if((GetUnitTypeId(GetTriggerUnit())=='osp2'))then
            return true
        endif
        if((GetUnitTypeId(GetTriggerUnit())=='osp3'))then
            return true
        endif
        if((GetUnitTypeId(GetTriggerUnit())=='osp4'))then
            return true
        endif
        return false
    endfunction


    function Trig_Ward_Location_Conditions takes nothing returns boolean
        if(not Trig_Ward_Location_Func002C())then
            return false
        endif
        return true
    endfunction


    function Trig_Ward_Location_Func001Func003C takes nothing returns boolean
        if((RectContainsUnit(PlayerArenaRects[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetTriggerUnit())==true))then
            return true
        endif
        if((RectContainsUnit(udg_rect09,GetTriggerUnit())==true))then
            return true
        endif
        return false
    endfunction


    function Trig_Ward_Location_Func001C takes nothing returns boolean
        if(not Trig_Ward_Location_Func001Func003C())then
            return false
        endif
        return true
    endfunction


    function Trig_Ward_Location_Func001Func002Func003Func001001001002001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_Ward_Location_Func001Func002Func003Func001001001002002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
    endfunction
    
    function Trig_Ward_Location_Func001Func002Func003Func001001001002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Ward_Location_Func001Func002Func003Func001001001002001(),Trig_Ward_Location_Func001Func002Func003Func001001001002002())
    endfunction


    function Trig_Ward_Location_Func001Func002Func003C takes nothing returns boolean
        if(not(CountUnitsInGroup(GetUnitsInRectMatching(PlayerArenaRects[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],Condition(function Trig_Ward_Location_Func001Func002Func003Func001001001002)))==0))then
            return false
        endif
        return true
    endfunction


    function Trig_Ward_Location_Func001Func002C takes nothing returns boolean
        if(not Trig_Ward_Location_Func001Func002Func003C())then
            return false
        endif
        return true
    endfunction


    function Trig_Ward_Location_Actions takes nothing returns nothing
        local location unitLocation
        local location arenaLocation

        if(Trig_Ward_Location_Func001C())then
            call DoNothing()
        else
            if(Trig_Ward_Location_Func001Func002C())then
                call DoNothing()
            else
                set unitLocation = GetUnitLoc(GetTriggerUnit())
                set arenaLocation = GetRectCenter(PlayerArenaRects[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])
                call SetUnitPositionLoc(GetTriggerUnit(),PolarProjectionBJ(arenaLocation,525.00,AngleBetweenPoints(arenaLocation,unitLocation)))
                call RemoveLocation(unitLocation)
                call RemoveLocation(arenaLocation)
                set unitLocation = null
                set arenaLocation = null
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
