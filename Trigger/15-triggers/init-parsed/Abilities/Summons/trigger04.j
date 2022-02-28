/*library trigger04 initializer init requires RandomShit

    function Trig_Clockwerk_Goblin_Conditions takes nothing returns boolean
        if(not(GetUnitTypeId(GetTriggerUnit())=='n011'))then
            return false
        endif
        return true
    endfunction


    function Trig_Clockwerk_Goblin_Actions takes nothing returns nothing
        set udg_real02 =(I2R(GetUnitAbilityLevelSwapped('ANsy',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))* 1.50)
        call SetUnitScalePercent(GetTriggerUnit(),(100.00 + udg_real02),(100.00 + udg_real02),(100.00 + udg_real02))
        call SetUnitAbilityLevelSwapped('A00P',GetTriggerUnit(),GetUnitAbilityLevelSwapped('ANsy',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
        call SetUnitAbilityLevelSwapped('A000',GetTriggerUnit(),(GetUnitAbilityLevelSwapped('ANsy',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])/ 1))
        set bj_forLoopBIndex = 1
        set bj_forLoopBIndexEnd =(GetUnitAbilityLevelSwapped('ANsy',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])/ 1)
        loop
            exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
            call UnitAddItemByIdSwapped('I02L',GetTriggerUnit())
            set bj_forLoopBIndex = bj_forLoopBIndex + 1
        endloop
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger04 = CreateTrigger()
        call TriggerRegisterEnterRectSimple(udg_trigger04,GetPlayableMapRect())
        call TriggerAddCondition(udg_trigger04,Condition(function Trig_Clockwerk_Goblin_Conditions))
        call TriggerAddAction(udg_trigger04,function Trig_Clockwerk_Goblin_Actions)
    endfunction


endlibrary
*/