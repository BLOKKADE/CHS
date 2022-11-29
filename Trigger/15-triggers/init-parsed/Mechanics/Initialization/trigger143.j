library trigger143 initializer init requires RandomShit

    function Trig_Enter_Shop_Mode_Conditions takes nothing returns boolean
        if(not(IsTriggerEnabled(GetTriggeringTrigger())==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Enter_Shop_Mode_Func036001002001 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_STRUCTURE)==true)
    endfunction
    
    function Trig_Enter_Shop_Mode_Func036001002002 takes nothing returns boolean
        return(GetUnitTypeId(GetFilterUnit())!='ncop')
    endfunction
    
    function Trig_Enter_Shop_Mode_Func036001002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Enter_Shop_Mode_Func036001002001(),Trig_Enter_Shop_Mode_Func036001002002())
    endfunction


    function Trig_Enter_Shop_Mode_Func036A takes nothing returns nothing
        if GetUnitTypeId(GetEnumUnit()) == 'n02L' then
            if IncomeMode == 1 then
                call ReplaceUnitBJ(GetEnumUnit(),'n035',bj_UNIT_STATE_METHOD_RELATIVE)
            elseif IncomeMode == 2 then
                call ReplaceUnitBJ(GetEnumUnit(),'n034',bj_UNIT_STATE_METHOD_RELATIVE)		
            elseif IncomeMode == 3 then
                call ReplaceUnitBJ(GetEnumUnit(),'n005',bj_UNIT_STATE_METHOD_RELATIVE)
            endif
        else
            call ShowUnitShow(GetEnumUnit())
        endif
    endfunction

    function Trig_Enter_Shop_Mode_Actions takes nothing returns nothing
        call DisableTrigger(GetTriggeringTrigger())
        // call DisableTrigger(udg_trigger78)
        
        call ForGroupBJ(GetUnitsOfPlayerMatching(Player(PLAYER_NEUTRAL_PASSIVE),Condition(function Trig_Enter_Shop_Mode_Func036001002)),function Trig_Enter_Shop_Mode_Func036A)
        call TriggerSleepAction(0.00)
        call EnableTrigger(udg_trigger123)
        call EnableTrigger(udg_trigger127)
        call EnableTrigger(udg_trigger132)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger143 = CreateTrigger()
        call TriggerAddCondition(udg_trigger143,Condition(function Trig_Enter_Shop_Mode_Conditions))
        call TriggerAddAction(udg_trigger143,function Trig_Enter_Shop_Mode_Actions)
    endfunction


endlibrary
