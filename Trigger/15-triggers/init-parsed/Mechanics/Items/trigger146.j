library trigger146 initializer init requires RandomShit

    function Trig_Update_Items_Func001Func001C takes nothing returns boolean
        if((ElimModeEnabled==true))then
            return true
        endif
        if((udg_boolean08==true))then
            return true
        endif
        return false
    endfunction


    function Trig_Update_Items_Func001C takes nothing returns boolean
        if(not Trig_Update_Items_Func001Func001C())then
            return false
        endif
        return true
    endfunction


    function Trig_Update_Items_Func001Func002Func001C takes nothing returns boolean
        if(not(RoundNumber==10))then
            return false
        endif
        return true
    endfunction


    function Trig_Update_Items_Func001Func002Func001Func001A takes nothing returns nothing
        call ReplaceUnitBJ(GetEnumUnit(),'n017',bj_UNIT_STATE_METHOD_RELATIVE)
    endfunction


    function Trig_Update_Items_Func001Func003Func001C takes nothing returns boolean
        if(not(RoundNumber==20))then
            return false
        endif
        return true
    endfunction


    function Trig_Update_Items_Func001Func003Func001Func001A takes nothing returns nothing
        call ReplaceUnitBJ(GetEnumUnit(),'n017',bj_UNIT_STATE_METHOD_RELATIVE)
    endfunction


    function Trig_Update_Items_Actions takes nothing returns nothing
        if(Trig_Update_Items_Func001C())then
            if(Trig_Update_Items_Func001Func002Func001C())then
                call ForGroupBJ(GetUnitsOfTypeIdAll('n004'),function Trig_Update_Items_Func001Func002Func001Func001A)
            endif
        else
            if(Trig_Update_Items_Func001Func003Func001C())then
                call ForGroupBJ(GetUnitsOfTypeIdAll('n004'),function Trig_Update_Items_Func001Func003Func001Func001A)
            endif
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger146 = CreateTrigger()
        call TriggerAddAction(udg_trigger146,function Trig_Update_Items_Actions)
    endfunction


endlibrary
