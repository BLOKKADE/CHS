/*library trigger18 initializer init requires RandomShit

    function Trig_Inferno_Conditions takes nothing returns boolean
        if(not(GetUnitTypeId(GetTriggerUnit())=='n005'))then
            return false
        endif
        return true
    endfunction


    function Trig_Inferno_Actions takes nothing returns nothing
        call SetUnitAbilityLevelSwapped('ANpi',GetTriggerUnit(),GetUnitAbilityLevelSwapped('AUin',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
        call SetUnitAbilityLevelSwapped('A000',GetTriggerUnit(),(GetUnitAbilityLevelSwapped('AUin',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])))
        set bj_forLoopBIndex = 1
        set bj_forLoopBIndexEnd =(GetUnitAbilityLevelSwapped('AUin',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])* 2)
        loop
            exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
            call UnitAddItemByIdSwapped('I022',GetTriggerUnit())
            call UnitAddItemByIdSwapped('I022',GetTriggerUnit())
            set bj_forLoopBIndex = bj_forLoopBIndex + 1
        endloop
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger18 = CreateTrigger()
        call TriggerRegisterEnterRectSimple(udg_trigger18,GetPlayableMapRect())
        call TriggerAddCondition(udg_trigger18,Condition(function Trig_Inferno_Conditions))
        call TriggerAddAction(udg_trigger18,function Trig_Inferno_Actions)
    endfunction


endlibrary
*/