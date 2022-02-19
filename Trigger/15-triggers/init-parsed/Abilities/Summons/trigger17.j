/*library trigger17 initializer init requires RandomShit

    function Trig_Healing_Ward_Conditions takes nothing returns boolean
        if(not(GetUnitTypeId(GetTriggerUnit())=='ohwd'))then
            return false
        endif
        return true
    endfunction


    function Trig_Healing_Ward_Actions takes nothing returns nothing
        call SetUnitAbilityLevelSwapped('Aoar',GetTriggerUnit(),GetUnitAbilityLevelSwapped('Ahwd',udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]))
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger17 = CreateTrigger()
        call TriggerRegisterEnterRectSimple(udg_trigger17,GetPlayableMapRect())
        call TriggerAddCondition(udg_trigger17,Condition(function Trig_Healing_Ward_Conditions))
        call TriggerAddAction(udg_trigger17,function Trig_Healing_Ward_Actions)
    endfunction


endlibrary
*/