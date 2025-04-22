library DisableAbilities initializer init requires RandomShit, DummySpell

    private function DisableAbilitiesActions takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local player p = GetTriggerPlayer()
        if (GetUnitAbilityLevel(u, ENTANGLING_ROOTS_BUFF_ID) > 0 and GetDummySpell(u, BLINK_STRIKE_ABILITY_ID) != 0) then
            call IssueImmediateOrder(u, "stop")
            call DisplayTimedTextToPlayer(p, 0, 0, 20, "|cffffcc00Caster movement has been disabled.|r")
            return
        endif

        if (not IsCastingAllowed(u)) or ((p != Player(8) and p != Player(11)) and CurrentlyFighting[GetPlayerId(p)] == false) then
            call IssueImmediateOrder(u, "stop")
            //call BJDebugMsg(GetUnitName(u) +  "disable abilities stop")
        endif

        set u = null
        set p = null
    endfunction

    private function init takes nothing returns nothing
        set DisableAbilitiesTrigger = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(DisableAbilitiesTrigger, EVENT_PLAYER_UNIT_SPELL_CAST)
        call TriggerAddAction(DisableAbilitiesTrigger, function DisableAbilitiesActions)
    endfunction

endlibrary
