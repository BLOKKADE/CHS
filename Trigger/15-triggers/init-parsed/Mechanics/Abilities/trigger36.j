library trigger36 initializer init requires RandomShit, DummyActiveSpell

    function Trig_Disable_Abilities_Actions takes nothing returns nothing
        if (GetUnitAbilityLevel(GetTriggerUnit(), 'BEer') > 0 and GetAssociatedSpell(GetTriggerUnit(), BLINK_STRIKE_ABILITY_ID) != 0) then
            call IssueImmediateOrderBJ(GetTriggerUnit(),"stop")
            call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 20, "|cffffcc00Caster movement has been disabled.|r")
            return
        endif
        if(Trig_Disable_Abilities_Func001C(GetTriggerUnit())) then
            call IssueImmediateOrderBJ(GetTriggerUnit(),"stop")
            //call BJDebugMsg(GetUnitName(GetTriggerUnit()) +  "disable abilities stop")
        else
            //call ConditionalTriggerExecute(udg_trigger37)
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger36 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger36,EVENT_PLAYER_UNIT_SPELL_CAST)
        call TriggerAddAction(udg_trigger36,function Trig_Disable_Abilities_Actions)
    endfunction


endlibrary
