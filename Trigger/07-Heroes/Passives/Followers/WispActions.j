library WispActions initializer init requires RandomShit

    private function WispFollowAction takes nothing returns nothing
        local unit wisp = GetEnumUnit()
        local player wispPlayer = GetOwningPlayer(wisp)
        local unit playerHero = PlayerHeroes[GetPlayerId(GetOwningPlayer(wisp)) + 1]
        local location unitLocation = GetUnitLoc(wisp)
        local location heroLocation = GetUnitLoc(playerHero)
        local real distance = DistanceBetweenPoints(unitLocation, heroLocation)

        if (wispPlayer == GetOwningPlayer(playerHero)) then
            if (distance >= 800.00) then
                call DestroyEffect(AddSpecialEffectLocBJ(unitLocation, "Abilities\\Spells\\NightElf\\FaerieDragonInvis\\FaerieDragon_Invis.mdl"))
                call SetUnitPositionLoc(wisp, heroLocation)
                call IssueImmediateOrder(wisp, "stop")
                call DestroyEffect(AddSpecialEffectTargetUnitBJ("origin", wisp, "Abilities\\Spells\\NightElf\\FaerieDragonInvis\\FaerieDragon_Invis.mdl"))
            elseif (distance <= 450.00) then
                call SetUnitAbilityLevelSwapped('A01H', wisp, (GetHeroLevel(playerHero) / 2))
                call IssueTargetOrder(wisp, "healingwave", playerHero)
            endif

            if (GetUnitState(wisp, UNIT_STATE_MANA) == GetUnitState(wisp, UNIT_STATE_MAX_MANA)) then
                call IssuePointOrderLoc(wisp, "move", OffsetLocation(heroLocation, GetRandomReal(-150.00, 150.00), GetRandomReal(-150.00, 150.00)))
                call SetUnitManaBJ(wisp, GetRandomReal(0, 1.00))
            elseif (distance >= 200.00) then
                call SetUnitMoveSpeed(wisp, (DistanceBetweenPoints(unitLocation,heroLocation)/ 2.00))
                call IssuePointOrderLoc(wisp, "move", OffsetLocation(heroLocation, GetRandomReal(-150.00, 150.00), GetRandomReal(-150.00, 150.00)))
                call SetUnitManaBJ(wisp, GetRandomReal(0, 1.00))
            else
                call SetUnitMoveSpeed(wisp, GetUnitDefaultMoveSpeed(wisp))
            endif
        endif

        // Cleanup
        call RemoveLocation(unitLocation)
        call RemoveLocation(heroLocation)
        set wispPlayer = null
        set unitLocation = null
        set heroLocation = null
        set playerHero = null
        set wisp = null
    endfunction

    private function WispFollowActions takes nothing returns nothing
        local group wispUnits = GetUnitsOfTypeIdAll('e003')

        call ForGroup(wispUnits, function WispFollowAction)

        // Cleanup
        call DestroyGroup(wispUnits)
        set wispUnits = null
    endfunction

    private function init takes nothing returns nothing
        set WispActionsTrigger = CreateTrigger()
        call TriggerRegisterTimerEventPeriodic(WispActionsTrigger, 1.00)
        call TriggerAddAction(WispActionsTrigger, function WispFollowActions)
    endfunction

endlibrary
