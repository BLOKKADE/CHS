library PlayerShadeDeath initializer init requires IdLibrary, GameInit

    private function PlayerShadeDeathConditions takes nothing returns boolean
        return BrStarted == true and (GetUnitTypeId(GetTriggerUnit()) == SHADE_BR_RESPAWN_UNIT_ID)
    endfunction

    private function PlayerShadeDeathActions takes nothing returns nothing
        local unit deadShade = GetTriggerUnit()
        local player deadPlayer = GetOwningPlayer(deadShade)
        local unit playerHero = PlayerHeroes[GetPlayerId(deadPlayer)]
        local location respawnLocation = GetUnitLoc(deadShade)

        // Respawn the hero
        call ReviveHeroLoc(playerHero, respawnLocation, true)
        call SelectUnitForPlayerSingle(playerHero, deadPlayer)
        call PanCameraToTimedLocForPlayer(deadPlayer, respawnLocation, 0.50)

        set TempUnit = playerHero // Used in HeroRefreshTrigger
        call ConditionalTriggerExecute(HeroRefreshTrigger)

        // Cleanup
        call RemoveLocation(respawnLocation)
        set respawnLocation = null
        set deadShade = null
        set deadPlayer = null
        set playerHero = null
    endfunction

    private function init takes nothing returns nothing
        local trigger playerShadeDeathTrigger = CreateTrigger()
        call DisableTrigger(playerShadeDeathTrigger)
        call TriggerRegisterAnyUnitEventBJ(playerShadeDeathTrigger, EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(playerShadeDeathTrigger, Condition(function PlayerShadeDeathConditions))
        call TriggerAddAction(playerShadeDeathTrigger, function PlayerShadeDeathActions)
    endfunction

endlibrary
