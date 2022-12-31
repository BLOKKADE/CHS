library DisableAbilities initializer init requires RandomShit, DummyActiveSpell

    private function DisableAbilitiesActions takes nothing returns nothing
        if (GetUnitAbilityLevel(GetTriggerUnit(), 'BEer') > 0 and GetAssociatedSpell(GetTriggerUnit(), BLINK_STRIKE_ABILITY_ID) != 0) then
            call IssueImmediateOrder(GetTriggerUnit(), "stop")
            call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 20, "|cffffcc00Caster movement has been disabled.|r")
            return
        endif

        if CheckIfCastAllowed(GetTriggerUnit()) then
            call IssueImmediateOrder(GetTriggerUnit(), "stop")
            //call BJDebugMsg(GetUnitName(GetTriggerUnit()) +  "disable abilities stop")
        else
            //call ConditionalTriggerExecute(udg_trigger37)
        endif
    endfunction

    private function init takes nothing returns nothing
        set DisableAbilitiesTrigger = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(DisableAbilitiesTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
        call TriggerAddAction(DisableAbilitiesTrigger, function DisableAbilitiesActions)
    endfunction

endlibrary
