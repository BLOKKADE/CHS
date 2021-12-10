library trigger28 initializer init requires RandomShit

    function Trig_Raise_Dead_Func001C takes nothing returns boolean
        if((GetUnitTypeId(GetTriggerUnit())=='uske'))then
            return true
        endif
        if((GetUnitTypeId(GetTriggerUnit())=='uskm'))then
            return true
        endif
        return false
    endfunction


    function Trig_Raise_Dead_Conditions takes nothing returns boolean
        if(not Trig_Raise_Dead_Func001C())then
            return false
        endif
        return true
    endfunction


    function Trig_Raise_Dead_Actions takes nothing returns nothing
        set udg_real02 =(I2R(GetUnitAbilityLevelSwapped('Arai',udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))* 1.50)
        call SetUnitScalePercent(GetTriggerUnit(),(100.00 + udg_real02),(100.00 + udg_real02),(100.00 + udg_real02))
        call SetUnitVertexColorBJ(GetTriggerUnit(),100,(100.00 - udg_real02),(100.00 - udg_real02),0)
        call SetUnitAbilityLevelSwapped('A000',GetTriggerUnit(),(GetUnitAbilityLevelSwapped('Arai',udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])/ 3))
        set bj_forLoopBIndex = 1
        set bj_forLoopBIndexEnd =(GetUnitAbilityLevelSwapped('Arai',udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])- 1)
        loop
            exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
            call UnitAddItemByIdSwapped('I02L',GetTriggerUnit())
            set bj_forLoopBIndex = bj_forLoopBIndex + 1
        endloop
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger28 = CreateTrigger()
        call TriggerRegisterEnterRectSimple(udg_trigger28,GetPlayableMapRect())
        call TriggerAddCondition(udg_trigger28,Condition(function Trig_Raise_Dead_Conditions))
        call TriggerAddAction(udg_trigger28,function Trig_Raise_Dead_Actions)
    endfunction


endlibrary
