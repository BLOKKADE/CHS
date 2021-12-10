library trigger10 initializer init requires RandomShit

    function Trig_Death_Pact_Conditions takes nothing returns boolean
        if(not(GetSpellAbilityId()=='A00M'))then
            return false
        endif
        return true
    endfunction


    function Trig_Death_Pact_Actions takes nothing returns nothing
        set udg_real02 =(I2R(GetUnitAbilityLevelSwapped(GetSpellAbilityId(),GetTriggerUnit()))* GetUnitStateSwap(UNIT_STATE_LIFE,GetSpellTargetUnit()))
        call KillUnit(GetSpellTargetUnit())
        call TriggerSleepAction(0.00)
        call SetUnitLifeBJ(GetTriggerUnit(),(GetUnitStateSwap(UNIT_STATE_LIFE,GetTriggerUnit())+ udg_real02))
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger10 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger10,EVENT_PLAYER_UNIT_SPELL_EFFECT)
        call TriggerAddCondition(udg_trigger10,Condition(function Trig_Death_Pact_Conditions))
        call TriggerAddAction(udg_trigger10,function Trig_Death_Pact_Actions)
    endfunction


endlibrary
