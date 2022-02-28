/*library trigger20 initializer init requires RandomShit

    function Trig_Parasite_Conditions takes nothing returns boolean
        if(not(GetUnitTypeId(GetTriggerUnit())=='ncfs'))then
            return false
        endif
        return true
    endfunction


    function Trig_Parasite_Actions takes nothing returns nothing
        set udg_real02 =(I2R(GetUnitAbilityLevelSwapped('ANpa',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))* 1.50)
        call SetUnitScalePercent(GetTriggerUnit(),(100.00 + udg_real02),(100.00 + udg_real02),(100.00 + udg_real02))
        call SetUnitVertexColorBJ(GetTriggerUnit(),100,(100.00 - udg_real02),(100.00 - udg_real02),0)
        call SetUnitAbilityLevelSwapped('A000',GetTriggerUnit(),(GetUnitAbilityLevelSwapped('ANpa',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])- 2))
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger20 = CreateTrigger()
        call TriggerRegisterEnterRectSimple(udg_trigger20,GetPlayableMapRect())
        call TriggerAddCondition(udg_trigger20,Condition(function Trig_Parasite_Conditions))
        call TriggerAddAction(udg_trigger20,function Trig_Parasite_Actions)
    endfunction


endlibrary
*/