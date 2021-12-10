library trigger33 initializer init requires RandomShit

    function Trig_Time_Wizard_Cooldown_Conditions takes nothing returns boolean
        if(not(GetUnitTypeId(GetTriggerUnit())=='O007'))then
            return false
        endif
        return true
    endfunction


    function Trig_Time_Wizard_Cooldown_Actions takes nothing returns nothing
        //	call TriggerSleepAction(0.00)
        //	call UnitResetCooldown(GetTriggerUnit())
        //	call TriggerSleepAction(0.01)
        //	call UnitResetCooldown(GetTriggerUnit())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger33 = CreateTrigger()
        //call TriggerRegisterAnyUnitEventBJ(udg_trigger33,EVENT_PLAYER_UNIT_SPELL_CAST)
        //call TriggerRegisterAnyUnitEventBJ(udg_trigger33,EVENT_PLAYER_UNIT_SPELL_EFFECT)
        //call TriggerRegisterAnyUnitEventBJ(udg_trigger33,EVENT_PLAYER_UNIT_SPELL_FINISH)
        //call TriggerAddCondition(udg_trigger33,Condition(function Trig_Time_Wizard_Cooldown_Conditions))
        //call TriggerAddAction(udg_trigger33,function Trig_Time_Wizard_Cooldown_Actions)
    endfunction


endlibrary
