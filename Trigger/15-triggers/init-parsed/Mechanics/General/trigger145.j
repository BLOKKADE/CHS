library trigger145 initializer init requires RandomShit, IdLibrary

    /*
    function Trig_Remove_Units_From_Center_Func001C takes nothing returns boolean
        if(not(GetUnitTypeId(GetTriggerUnit())!=SUDDEN_DEATH_UNIT_ID))then
            return false
        endif
        if(not(GetUnitTypeId(GetTriggerUnit())!=PRIEST_1_UNIT_ID))then
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
        if(not(GetUnitTypeId(GetTriggerUnit())!=PET_BASE_UNIT_ID))then
            return false
        endif
        if(not(GetUnitTypeId(GetTriggerUnit())!=SELL_ITEM_DUMMY))then
            return false
        endif
        if(not(GetUnitTypeId(GetTriggerUnit())!=HERO_PREVIEW_UNIT_ID))then
            return false
        endif
        
        return true
    endfunction
    */

    function Trig_Remove_Units_From_Center_Conditions takes nothing returns boolean
        local unit u = GetTriggerUnit()

        if not IsUnitExcluded(u) then
            call DeleteUnit(u)
        endif

        set u = null
        return false
    endfunction

    private function init takes nothing returns nothing
        set udg_trigger145 = CreateTrigger()
        call TriggerRegisterEnterRectSimple(udg_trigger145,RectMidArena)
        call TriggerAddCondition(udg_trigger145,Condition(function Trig_Remove_Units_From_Center_Conditions))
    endfunction
endlibrary
