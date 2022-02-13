/*library trigger03 initializer init requires RandomShit

    function Trig_Carrion_Beetles_Conditions takes nothing returns boolean
        if(not(GetUnitTypeId(GetTriggerUnit())=='u001'))then
            return false
        endif
        return true
    endfunction


    function Trig_Carrion_Beetles_Actions takes nothing returns nothing
        set udg_real02 =(I2R(GetUnitAbilityLevelSwapped('AUcb',udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))* 1.50)
        call SetUnitScalePercent(GetTriggerUnit(),(100.00 + udg_real02),(100.00 + udg_real02),(100.00 + udg_real02))
        call SetUnitVertexColorBJ(GetTriggerUnit(),100,(100.00 - udg_real02),(100.00 - udg_real02),0)
        call SetUnitAbilityLevelSwapped('A000',GetTriggerUnit(),(GetUnitAbilityLevelSwapped('AUcb',udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])/ 2))
        set bj_forLoopBIndex = 1
        set bj_forLoopBIndexEnd =(GetUnitAbilityLevelSwapped('AUcb',udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])- 1)
        loop
            exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
            call UnitAddItemByIdSwapped('I01B',GetTriggerUnit())
            set bj_forLoopBIndex = bj_forLoopBIndex + 1
        endloop
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger03 = CreateTrigger()
        call TriggerRegisterEnterRectSimple(udg_trigger03,GetPlayableMapRect())
        call TriggerAddCondition(udg_trigger03,Condition(function Trig_Carrion_Beetles_Conditions))
        call TriggerAddAction(udg_trigger03,function Trig_Carrion_Beetles_Actions)
    endfunction


endlibrary
*/