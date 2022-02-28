/*library trigger21 initializer init requires RandomShit

    function Trig_Phoenix_Conditions takes nothing returns boolean
        if(not(GetUnitTypeId(GetTriggerUnit())=='hphx'))then
            return false
        endif
        return true
    endfunction


    function Trig_Phoenix_Actions takes nothing returns nothing
        call SetUnitAbilityLevelSwapped('A000',GetTriggerUnit(),(GetUnitAbilityLevelSwapped('AHpx',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])* 1))
        set bj_forLoopBIndex = 1
        set bj_forLoopBIndexEnd =(GetUnitAbilityLevelSwapped('AHpx',PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])* 2)
        loop
            exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
            call UnitAddItemByIdSwapped('I022',GetTriggerUnit())
            set bj_forLoopBIndex = bj_forLoopBIndex + 1
        endloop
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger21 = CreateTrigger()
        call TriggerRegisterEnterRectSimple(udg_trigger21,GetPlayableMapRect())
        call TriggerAddCondition(udg_trigger21,Condition(function Trig_Phoenix_Conditions))
        call TriggerAddAction(udg_trigger21,function Trig_Phoenix_Actions)
    endfunction


endlibrary
*/