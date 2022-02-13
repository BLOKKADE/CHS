/*library trigger25 initializer init requires RandomShit

    function Trig_Pocket_Factory_Conditions takes nothing returns boolean
        if(not(GetUnitTypeId(GetTriggerUnit())=='n010'))then
            return false
        endif
        return true
    endfunction


    function Trig_Pocket_Factory_Actions takes nothing returns nothing
        set udg_real02 =(I2R(GetUnitAbilityLevelSwapped('ANsy',udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))* 1.0)
        call SetUnitScalePercent(GetTriggerUnit(),(90.00 + udg_real02),(90.00 + udg_real02),(90.00 + udg_real02))
        set bj_forLoopBIndex = 1
        set bj_forLoopBIndexEnd =(GetUnitAbilityLevelSwapped('ANsy',udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
        loop
            exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
            call UnitAddItemByIdSwapped('I02L',GetTriggerUnit())
            set bj_forLoopBIndex = bj_forLoopBIndex + 1
        endloop
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger25 = CreateTrigger()
        call TriggerRegisterEnterRectSimple(udg_trigger25,GetPlayableMapRect())
        call TriggerAddCondition(udg_trigger25,Condition(function Trig_Pocket_Factory_Conditions))
        call TriggerAddAction(udg_trigger25,function Trig_Pocket_Factory_Actions)
    endfunction


endlibrary
*/