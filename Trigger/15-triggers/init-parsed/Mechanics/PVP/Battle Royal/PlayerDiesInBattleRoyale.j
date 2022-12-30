library PlayerDiesInBattleRoyale initializer init requires RandomShit, UnitFilteringUtility, Scoreboard

    private function PlayerDiesInBattleRoyaleConditions takes nothing returns boolean
        return BrStarted == true and IsPlayerHero(GetTriggerUnit())
    endfunction

    private function KillPlayerUnit takes nothing returns nothing
        local unit u = GetEnumUnit()
    
        if (IsUnitType(u, UNIT_TYPE_HERO)) then
            call RemoveItem(UnitItemInSlot(u, 0))
            call RemoveItem(UnitItemInSlot(u, 1))
            call RemoveItem(UnitItemInSlot(u, 2))
            call RemoveItem(UnitItemInSlot(u, 3))
            call RemoveItem(UnitItemInSlot(u, 4))
            call RemoveItem(UnitItemInSlot(u, 5))
    
            call RemoveHeroAbilities(u)
        endif
    
        call KillUnit(u)

        // Cleanup
        set u = null
    endfunction

    private function PlayerDiesInBattleRoyaleActions takes nothing returns nothing
        local player deadPlayer = GetOwningPlayer(GetTriggerUnit())
        local group deadPlayerUnits = GetUnitsOfPlayerAll(deadPlayer)

        // Set the wave the player left
        call UpdateScoreboardPlayerDies(deadPlayer, RoundNumber)

        // Cleanup everything regarding to the dead player
        call ForceAddPlayerSimple(deadPlayer, DefeatedPlayers)
        call ForGroupBJ(deadPlayerUnits, function KillPlayerUnit)
        call ShowDiscordFrames(deadPlayer, true)
        set PlayerCount = PlayerCount - 1

        call DisplayTimedTextToForce(GetPlayersAll(), 5.00, "|cffffcc00" + GetPlayerNameColour(deadPlayer) + " was defeated by |r" + GetPlayerNameColour(GetOwningPlayer(GetKillingUnit())))

        // Cleanup
        call DestroyGroup(deadPlayerUnits)
        set deadPlayerUnits = null
        set deadPlayer = null

        // Try to end the game
        call ConditionalTriggerExecute(EndGameTrigger)
    endfunction

    private function init takes nothing returns nothing
        set PlayerDiesInBattleRoyaleTrigger = CreateTrigger()
        call DisableTrigger(PlayerDiesInBattleRoyaleTrigger)
        call TriggerRegisterAnyUnitEventBJ(PlayerDiesInBattleRoyaleTrigger,EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(PlayerDiesInBattleRoyaleTrigger, Condition(function PlayerDiesInBattleRoyaleConditions))
        call TriggerAddAction(PlayerDiesInBattleRoyaleTrigger, function PlayerDiesInBattleRoyaleActions)
    endfunction

endlibrary
