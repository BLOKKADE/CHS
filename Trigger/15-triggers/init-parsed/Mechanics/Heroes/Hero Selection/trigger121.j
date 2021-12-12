library trigger121 initializer init requires RandomShit

    function Trig_Remove_Selection_Circles_Func001A takes nothing returns nothing
        call DeleteUnit(GetEnumUnit())
    endfunction


    function Trig_Remove_Selection_Circles_Func002001002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
    endfunction


    function Trig_Remove_Selection_Circles_Func002A takes nothing returns nothing
        call DeleteUnit(GetEnumUnit())
    endfunction


    function Trig_Remove_Selection_Circles_Actions takes nothing returns nothing
        call ForGroupBJ(GetUnitsOfTypeIdAll('ncop'),function Trig_Remove_Selection_Circles_Func001A)
        call ForGroupBJ(GetUnitsOfPlayerMatching(Player(8),Condition(function Trig_Remove_Selection_Circles_Func002001002)),function Trig_Remove_Selection_Circles_Func002A)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger121 = CreateTrigger()
        call DisableTrigger(udg_trigger121)
        call TriggerAddAction(udg_trigger121,function Trig_Remove_Selection_Circles_Actions)
    endfunction


endlibrary
