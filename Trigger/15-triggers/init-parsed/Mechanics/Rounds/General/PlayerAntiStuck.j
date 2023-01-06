library PlayerAntiStuck initializer init requires RandomShit

    private function PlayerAntiStuckConditions takes nothing returns boolean
        return (IsTriggerEnabled(GetTriggeringTrigger()) == true)
    endfunction

    private function CreepUnitFilter takes nothing returns boolean
        local unit currentUnit = GetFilterUnit()
        local boolean isValid = (GetOwningPlayer(currentUnit) == Player(11)) and (UnitAlive(currentUnit) == true) and (GetUnitAbilityLevel(currentUnit, 'Aloc') == 0)

        // Cleanup
        set currentUnit = null

        return isValid
    endfunction

    private function PlayerAntiStuckActions takes nothing returns nothing
        local integer currentPlayerId = 0
        local group playerArenaUnits
        local player currentPlayer

        loop
            exitwhen currentPlayerId == 8

            set currentPlayer = Player(currentPlayerId)
            set playerArenaUnits = GetUnitsInRectMatching(PlayerArenaRects[currentPlayerId], Condition(function CreepUnitFilter))

            // There are creeps in the player's arena, but the player's hero isn't there
            if (RectContainsUnit(RectMidArena, PlayerHeroes[currentPlayerId + 1]) and CountUnitsInGroup(playerArenaUnits) != 0) then
                call RemoveUnitsInRectCreeps(PlayerArenaRects[currentPlayerId])
            endif
    
            // Player hero exists, arena has creeps, player isn't defeated, and has not completed the round yet
            if ((PlayerHeroes[currentPlayerId + 1] != null) and (CountUnitsInGroup(playerArenaUnits) == 0) and (not IsPlayerInForce(currentPlayer, DefeatedPlayers)) and (not IsPlayerInForce(currentPlayer, RoundPlayersCompleted))) then
                call CreateNUnitsAtLoc(1, 'n00T', Player(11), PlayerArenaRectCenters[currentPlayerId], bj_UNIT_FACING)
                call SuspendHeroXPBJ(false, PlayerHeroes[currentPlayerId + 1])
                call UnitDamageTargetBJ(PlayerHeroes[currentPlayerId + 1], GetLastCreatedUnit(), 500, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL)
                call SuspendHeroXPBJ(true, PlayerHeroes[currentPlayerId + 1])
            endif
    
            // Cleanup
            call DestroyGroup(playerArenaUnits)
            set playerArenaUnits = null
            set currentPlayer = null

            set currentPlayerId = currentPlayerId + 1
        endloop
    endfunction

    private function init takes nothing returns nothing
        set PlayerAntiStuckTrigger = CreateTrigger()
        call DisableTrigger(PlayerAntiStuckTrigger)
        call TriggerRegisterTimerEventPeriodic(PlayerAntiStuckTrigger, 0.50)
        call TriggerAddCondition(PlayerAntiStuckTrigger, Condition(function PlayerAntiStuckConditions))
        call TriggerAddAction(PlayerAntiStuckTrigger, function PlayerAntiStuckActions)
    endfunction

endlibrary
