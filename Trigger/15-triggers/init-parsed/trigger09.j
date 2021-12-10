library trigger09 initializer init requires RandomShit

    function Trig_Dark_Ritual_Conditions takes nothing returns boolean
        if(not(GetSpellAbilityId()=='A00N'))then
            return false
        endif
        return true
    endfunction


    function Trig_Dark_Ritual_Actions takes nothing returns nothing
        set udg_real02 =((0.33 * I2R(GetUnitAbilityLevelSwapped(GetSpellAbilityId(),GetTriggerUnit())))* GetUnitStateSwap(UNIT_STATE_LIFE,GetSpellTargetUnit()))
        call KillUnit(GetSpellTargetUnit())
        call TriggerSleepAction(0.00)
        call SetUnitManaBJ(GetTriggerUnit(),(GetUnitStateSwap(UNIT_STATE_MANA,GetTriggerUnit())+ udg_real02))
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger09 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger09,EVENT_PLAYER_UNIT_SPELL_EFFECT)
        call TriggerAddCondition(udg_trigger09,Condition(function Trig_Dark_Ritual_Conditions))
        call TriggerAddAction(udg_trigger09,function Trig_Dark_Ritual_Actions)
    endfunction


endlibrary
