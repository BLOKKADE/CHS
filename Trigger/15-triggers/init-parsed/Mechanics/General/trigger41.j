library trigger41 initializer init requires RandomShit

    function Trig_Remove_Dummies_Conditions takes nothing returns boolean
        if(not(GetUnitTypeId(GetTriggerUnit())=='n00V'))then
            return false
        endif
        if(not(GetUnitTypeId(GetTriggerUnit())!='h015'))then
            return false
        endif
        if(not(GetUnitTypeId(GetTriggerUnit())!='h014'))then
            return false
        endif
        if(not(IsUnitInGroup(GetTriggerUnit(),udg_group08)!=true))then
            return false
        endif
        return true
    endfunction


    function Trig_Remove_Dummies_Actions takes nothing returns nothing
        call DeleteUnit(GetTriggerUnit())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger41 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger41,EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(udg_trigger41,Condition(function Trig_Remove_Dummies_Conditions))
        call TriggerAddAction(udg_trigger41,function Trig_Remove_Dummies_Actions)
    endfunction


endlibrary
