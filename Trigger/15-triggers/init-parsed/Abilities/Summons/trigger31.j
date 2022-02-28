/*library trigger31 initializer init requires RandomShit

    function Trig_Summon_Hawk_Conditions takes nothing returns boolean
        if(not(GetUnitTypeId(GetTriggerUnit())=='nwe3'))then
            return false
        endif
        return true
    endfunction


    function Trig_Summon_Hawk_Actions takes nothing returns nothing
        set udg_real02 =(I2R(GetUnitAbilityLevelSwapped('ANsw',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))* 1)
        call SetUnitScalePercent(GetTriggerUnit(),(100.00 + udg_real02),(100.00 + udg_real02),(100.00 + udg_real02))
        call SetUnitVertexColorBJ(GetTriggerUnit(),100,(100.00 - udg_real02),(100.00 - udg_real02),0)
        call SetUnitAbilityLevelSwapped('A000',GetTriggerUnit(),(GetUnitAbilityLevelSwapped('ANsw',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])/ 4))
        set bj_forLoopBIndex = 1
        set bj_forLoopBIndexEnd =(GetUnitAbilityLevelSwapped('ANsw',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])/ 2)
        loop
            exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
            call UnitAddItemByIdSwapped('I02L',GetTriggerUnit())
            set bj_forLoopBIndex = bj_forLoopBIndex + 1
        endloop
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger31 = CreateTrigger()
        call TriggerRegisterEnterRectSimple(udg_trigger31,GetPlayableMapRect())
        call TriggerAddCondition(udg_trigger31,Condition(function Trig_Summon_Hawk_Conditions))
        call TriggerAddAction(udg_trigger31,function Trig_Summon_Hawk_Actions)
    endfunction


endlibrary
*/