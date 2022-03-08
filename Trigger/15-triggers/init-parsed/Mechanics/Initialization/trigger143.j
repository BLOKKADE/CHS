library trigger143 initializer init requires RandomShit, MouseHoverInfo

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
        if GetUnitTypeId(GetEnumUnit()) == 'n02L' and IncomeMode > 0 then
            if IncomeMode != 3 then
                if IncomeMode == 1 then
                    call ReplaceUnitBJ(GetEnumUnit(),'n035',bj_UNIT_STATE_METHOD_RELATIVE)
                elseif IncomeMode == 2 then
                    call ReplaceUnitBJ(GetEnumUnit(),'n034',bj_UNIT_STATE_METHOD_RELATIVE)		
                endif
            else
                call ReplaceUnitBJ(GetEnumUnit(),'n005',bj_UNIT_STATE_METHOD_RELATIVE)
            endif
        else
            call ShowUnitShow(GetEnumUnit())
        endif
    endfunction


    function Trig_Enter_Shop_Mode_Func039A takes nothing returns nothing
        call DeleteUnit(GetEnumUnit())
    endfunction


    function Trig_Enter_Shop_Mode_Actions takes nothing returns nothing
        call DisableTrigger(GetTriggeringTrigger())
        call DisableTrigger(udg_trigger78)
        call MouseHoverInfo_DisableMouseHover()
        call DeleteUnit(udg_unit33)
        call DeleteUnit(udg_unit25)
        call DeleteUnit(udg_unit24)
        call DeleteUnit(udg_unit23)
        call DeleteUnit(udg_unit22)
        call DeleteUnit(udg_unit34)
        call DeleteUnit(udg_unit26)
        call DeleteUnit(udg_unit08)
        call DeleteUnit(udg_unit09)
        call DeleteUnit(udg_unit10)
        call DeleteUnit(udg_unit21)
        call DeleteUnit(udg_unit31)
        call DeleteUnit(udg_unit27)
        call DeleteUnit(udg_unit07)
        call DeleteUnit(udg_unit06)
        call DeleteUnit(udg_unit11)
        call DeleteUnit(udg_unit20)
        call DeleteUnit(udg_unit32)
        call DeleteUnit(udg_unit28)
        call DeleteUnit(udg_unit14)
        call DeleteUnit(udg_unit13)
        call DeleteUnit(udg_unit12)
        call DeleteUnit(udg_unit19)
        call DeleteUnit(udg_unit29)
        call DeleteUnit(udg_unit15)
        call DeleteUnit(udg_unit16)
        call DeleteUnit(udg_unit17)
        call DeleteUnit(udg_unit18)
        call DeleteUnit(udg_unit30)
        call DeleteUnit( CicrleUnit[0])
        call DeleteUnit( CicrleUnit[1])
        call DeleteUnit( CicrleUnit[2])
        call DeleteUnit( CicrleUnit[3])
        call DeleteUnit( CicrleUnit[4])
        call DeleteUnit( CicrleUnit[5])
        call DeleteUnit( CicrleUnit[6])
        call DeleteUnit( CicrleUnit[7])
        call DeleteUnit( CicrleUnit[8])
        call DeleteUnit( CicrleUnit[9])
        call DeleteUnit( CicrleUnit[10])
        call DeleteUnit( CicrleUnit[11])
        call DeleteUnit( CicrleUnit[12])
        call DeleteUnit( CicrleUnit[13])
        call DeleteUnit( CicrleUnit[14])
        call DeleteUnit( CicrleUnit[15])
        call DeleteUnit( CicrleUnit[16])
        call DeleteUnit( CicrleUnit[17])
        call DeleteUnit( CicrleUnit[18])
        call DeleteUnit( CicrleUnit[19])
        call DeleteUnit( CicrleUnit[20])
        call ForGroupBJ(GetUnitsOfPlayerMatching(Player(PLAYER_NEUTRAL_PASSIVE),Condition(function Trig_Enter_Shop_Mode_Func036001002)),function Trig_Enter_Shop_Mode_Func036A)
        call TriggerSleepAction(0.00)
        call ForGroupBJ(GetUnitsOfPlayerAll(Player(8)),function Trig_Enter_Shop_Mode_Func039A)
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
