library trigger147 initializer init requires RandomShit

    function Trig_Hide_Shops_Func002001002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)==true)
    endfunction

    //removes preplaced shops, couldve really also just hid them I think
    function Trig_Hide_Shops_Func002A takes nothing returns nothing
        set HideShopsCount =(HideShopsCount + 1)
        set udg_locations01[HideShopsCount]= GetUnitLoc(GetEnumUnit())
        set ShopIds[HideShopsCount]= GetUnitTypeId(GetEnumUnit())
        call SetUnitPositionLoc(GetEnumUnit(),OffsetLocation(GetRectCenter(GetEntireMapRect()),0,1000000000.00))
        call DeleteUnit(GetEnumUnit())
    endfunction


    function Trig_Hide_Shops_Actions takes nothing returns nothing
        set HideShopsCount = 0
        call ForGroupBJ(GetUnitsInRectMatching(GetPlayableMapRect(),Condition(function Trig_Hide_Shops_Func002001002)),function Trig_Hide_Shops_Func002A)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger147 = CreateTrigger()
        call TriggerAddAction(udg_trigger147,function Trig_Hide_Shops_Actions)
    endfunction


endlibrary
