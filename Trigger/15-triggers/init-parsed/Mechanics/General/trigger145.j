library trigger145 initializer init requires RandomShit

    function Trig_Remove_Units_From_Center_Func001C takes nothing returns boolean
        if(not(GetUnitTypeId(GetTriggerUnit())!='n00V'))then
            return false
        endif
        if(not(GetUnitTypeId(GetTriggerUnit())!='h015'))then
            return false
        endif
        if(not(GetUnitTypeId(GetTriggerUnit())!='h014'))then
            return false
        endif
        if(not(GetUnitTypeId(GetTriggerUnit())!='n00E'))then
            return false
        endif
        if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_STRUCTURE)!=true))then
            return false
        endif
        if(not(IsUnitIdType(GetUnitTypeId(GetTriggerUnit()),UNIT_TYPE_HERO)!=true))then
            return false
        endif
        /*if(not(GetUnitTypeId(GetTriggerUnit())!='e001'))then
            return false
        endif*/
        if(not(GetUnitTypeId(GetTriggerUnit())!='e003'))then
            return false
        endif
        return true
    endfunction


    function Trig_Remove_Units_From_Center_Conditions takes nothing returns boolean
        if(not Trig_Remove_Units_From_Center_Func001C())then
            return false
        endif
        return true
    endfunction


    function Trig_Remove_Units_From_Center_Func003001 takes nothing returns boolean
        return(GetUnitTypeId(GetTriggerUnit())=='hphx')
    endfunction


    function Trig_Remove_Units_From_Center_Actions takes nothing returns nothing
        call TriggerSleepAction(0.00)
        if(Trig_Remove_Units_From_Center_Func003001())then
            call DeleteUnit(GetTriggerUnit())
        else
            call DoNothing()
        endif
        call KillUnit(GetTriggerUnit())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger145 = CreateTrigger()
        call TriggerRegisterEnterRectSimple(udg_trigger145,udg_rect09)
        call TriggerAddCondition(udg_trigger145,Condition(function Trig_Remove_Units_From_Center_Conditions))
        call TriggerAddAction(udg_trigger145,function Trig_Remove_Units_From_Center_Actions)
    endfunction


endlibrary
