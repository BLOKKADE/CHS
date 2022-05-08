/*library trigger149 initializer init requires RandomShit

    function Trig_Passive_Spells_II_Conditions takes nothing returns boolean
        if(not(IsUnitAliveBJ(GetTriggerUnit())==true))then
            return false
        endif
        if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
            return false
        endif
        if(not(IsUnitInGroup(GetTriggerUnit(),udg_group09)!=true))then
            return false
        endif
        if(not(IsUnitHiddenBJ(udg_unit04)!=true))then
            return false
        endif
        if(not(IsUnitVisible(udg_unit04,GetOwningPlayer(GetTriggerUnit()))==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Passive_Spells_II_Func001001003 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
    endfunction


    function Trig_Passive_Spells_II_Func001A takes nothing returns nothing
        call GroupAddUnitSimple(GetEnumUnit(),udg_group09)
    endfunction


    function Trig_Passive_Spells_II_Actions takes nothing returns nothing
        call BJDebugMsg("hell0o?")
        call ForGroupBJ(GetUnitsInRangeOfLocMatching(512,GetUnitLoc(udg_unit04),Condition(function Trig_Passive_Spells_II_Func001001003)),function Trig_Passive_Spells_II_Func001A)
        call DisableTrigger(GetTriggeringTrigger())
        call CreateNUnitsAtLoc(1,'n00E',GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(udg_unit04),bj_UNIT_FACING)
        call UnitApplyTimedLifeBJ(4.00,'BTLF',GetLastCreatedUnit())
        call SetUnitFlyHeightBJ(GetLastCreatedUnit(),400.00,0.00)
        call SetUnitFlyHeightBJ(GetLastCreatedUnit(),200.00,400.00)
        set udg_unit03 = GetLastCreatedUnit()
        call TriggerSleepAction(6.00)
        call EnableTrigger(GetTriggeringTrigger())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger149 = CreateTrigger()
        call TriggerAddCondition(udg_trigger149,Condition(function Trig_Passive_Spells_II_Conditions))
        call TriggerAddAction(udg_trigger149,function Trig_Passive_Spells_II_Actions)
    endfunction


endlibrary
*/