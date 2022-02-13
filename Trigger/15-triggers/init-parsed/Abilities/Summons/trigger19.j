/*library trigger19 initializer init requires RandomShit

    function Trig_Mountain_Giant_Conditions takes nothing returns boolean
        if(not(GetUnitTypeId(GetTriggerUnit())=='e002'))then
            return false
        endif
        return true
    endfunction


    function Trig_Mountain_Giant_Actions takes nothing returns nothing
        call SetUnitAbilityLevelSwapped('ANpi',GetTriggerUnit(),GetUnitAbilityLevelSwapped('AEsv',udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
        call SetUnitAbilityLevelSwapped('A000',GetTriggerUnit(),(GetUnitAbilityLevelSwapped('AEsv',udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])* 1))
        set bj_forLoopBIndex = 1
        set bj_forLoopBIndexEnd =(GetUnitAbilityLevelSwapped('AEsv',udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])* 6)
        loop
            exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
            call UnitAddItemByIdSwapped('I02K',GetTriggerUnit())
            call UnitAddItemByIdSwapped('I02K',GetTriggerUnit())
            set bj_forLoopBIndex = bj_forLoopBIndex + 1
        endloop
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger19 = CreateTrigger()
        call TriggerRegisterEnterRectSimple(udg_trigger19,GetPlayableMapRect())
        call TriggerAddCondition(udg_trigger19,Condition(function Trig_Mountain_Giant_Conditions))
        call TriggerAddAction(udg_trigger19,function Trig_Mountain_Giant_Actions)
    endfunction


endlibrary
*/