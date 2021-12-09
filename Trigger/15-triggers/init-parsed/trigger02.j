library trigger02 initializer init requires RandomShit

    function Trig_Black_Arrow_Conditions takes nothing returns boolean
        if(not(GetUnitTypeId(GetTriggerUnit())=='n015'))then
            return false
        endif
        return true
    endfunction


    function Trig_Black_Arrow_Actions takes nothing returns nothing
        set udg_real02 =(I2R(GetUnitAbilityLevelSwapped('ANba',udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))* 1.50)
        call SetUnitScalePercent(GetTriggerUnit(),(100.00 + udg_real02),(100.00 + udg_real02),(100.00 + udg_real02))
        call SetUnitVertexColorBJ(GetTriggerUnit(),100,(100.00 - udg_real02),(100.00 - udg_real02),0)
        call SetUnitAbilityLevelSwapped('A000',GetTriggerUnit(),(GetUnitAbilityLevelSwapped('ANba',udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])/ 1))
        set bj_forLoopBIndex = 1
        set bj_forLoopBIndexEnd =(GetUnitAbilityLevelSwapped('ANba',udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])- 1)
        loop
            exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
            call UnitAddItemByIdSwapped('I02L',GetTriggerUnit())
            set bj_forLoopBIndex = bj_forLoopBIndex + 1
        endloop
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger02 = CreateTrigger()
        call TriggerRegisterEnterRectSimple(udg_trigger02,GetPlayableMapRect())
        call TriggerAddCondition(udg_trigger02,Condition(function Trig_Black_Arrow_Conditions))
        call TriggerAddAction(udg_trigger02,function Trig_Black_Arrow_Actions)
    endfunction


endlibrary
