library PlayerDiesInBattleRoyale initializer init requires BattleRoyaleHelper, Scoreboard

    globals
        private constant integer PLAYER_BR_SHADE_TIMED_LIFE = 5
    endglobals

    private function PlayerDiesInBattleRoyaleConditions takes nothing returns boolean
        return BrStarted == true and IsPlayerHero(GetTriggerUnit())
    endfunction

    private function KillPlayerUnit takes nothing returns nothing
        local unit currentUnit = GetEnumUnit()

        if not IsUnitExcluded(currentUnit) then
            call KillUnit(currentUnit)
        endif

        // Cleanup
        set currentUnit = null
    endfunction

    private function PlayerDiesInBattleRoyaleActions takes nothing returns nothing
        local unit deadHero = GetTriggerUnit()
        local player deadPlayer = GetOwningPlayer(deadHero)
        local integer deadPlayerId = GetPlayerId(deadPlayer)
        local PlayerStats ps = PlayerStats.forPlayer(GetOwningPlayer(GetKillingUnit()))
        local group deadPlayerUnits
        local unit shadeUnit

        if deadPlayer == GetOwningPlayer(GetKillingUnit()) then
            call DisplayTimedTextToForce(GetPlayersAll(), 5.00, "|cffffcc00" + GetPlayerNameColour(deadPlayer) + " was defeated by themselves!")
        else
            call DisplayTimedTextToForce(GetPlayersAll(), 5.00, "|cffffcc00" + GetPlayerNameColour(deadPlayer) + " was defeated by |r" + GetPlayerNameColour(GetOwningPlayer(GetKillingUnit())) + "!")
        endif
        
        set deadPlayerUnits = GetUnitsOfPlayerAll(deadPlayer)
        call ForGroup(deadPlayerUnits, function KillPlayerUnit)

        // Try to revive the hero if there are BR lives
        if (BRLivesMode == 2) then
            // Increment the player deaths
            set PlayerBRDeaths[deadPlayerId] = PlayerBRDeaths[deadPlayerId] + 1
            call UpdateLivesForPlayer(deadPlayer, IMaxBJ(MaxBRDeathCount - PlayerBRDeaths[deadPlayerId], 0), true)

            // Don't revive the hero if they died too many times
            if (PlayerBRDeaths[deadPlayerId] > MaxBRDeathCount) then

                // Allow these stats to go up for fun BR rounds, won't be allowed to save them though. TODO Possibly show fun kills/wins separately from save code stats?
                call ps.addBRPVPKill()
                call ps.addPlayerKill()

                // Set the status of their death in the BR
                call UpdateScoreboardPlayerDies(deadPlayer, RoundNumber)

                call DisplayTimedTextToForce(GetPlayersAll(), 5.00, "|cffffcc00" + GetPlayerNameColour(deadPlayer) + " has no lives left and will not respawn.|r")
                // Set the status of their death in the BR
                call StopRectLeaveDetection(GetHandleId(deadHero))
                call UpdateScoreboardPlayerDies(deadPlayer, RoundNumber)
                set PlayerCount = PlayerCount - 1

                call SetUnitX(deadHero, GetRectCenterX(PlayerArenaRects[deadPlayerId]))
                call SetUnitY(deadHero, GetRectCenterY(PlayerArenaRects[deadPlayerId]))

                // Cleanup
                call DestroyGroup(deadPlayerUnits)
                set deadPlayerUnits = null
                set deadHero = null
                set deadPlayer = null

                // Try to end the game
                call ConditionalTriggerExecute(EndGameTrigger)
            else
                call DisplayTimedTextToForce(GetPlayersAll(), 5.00, "|cffffcc00" + GetPlayerNameColour(deadPlayer) + " has |r" + I2S(MaxBRDeathCount - PlayerBRDeaths[deadPlayerId]) + " |cffffcc00lives remaining! Respawning in 5 seconds.|r")
                
                // Create an invlunerable/invisible unit for the dead player
                set shadeUnit = CreateUnit(deadPlayer, SHADE_BR_RESPAWN_UNIT_ID, GetUnitX(deadHero), GetUnitY(deadHero), 270)
                call UnitApplyTimedLife(shadeUnit, 'BTLF', PLAYER_BR_SHADE_TIMED_LIFE)
                call SelectUnitForPlayerSingle(shadeUnit, deadPlayer)
                call CustomGameEvent_FireEvent(EVENT_PLAYER_ROUND_COMPLETE, EventInfo.createAll(deadPlayer, 0, RoundNumber, true))

                // Track how many shades there are to prevent 
                set ShadeCount = ShadeCount + 1

                // Cleanup
                set shadeUnit = null
                set deadHero = null
                set deadPlayer = null
            endif

            return
        endif

        // Allow these stats to go up for fun BR rounds, won't be allowed to save them though. TODO Possibly show fun kills/wins separately from save code stats?
        call ps.addBRPVPKill()
        call ps.addPlayerKill()

        // Set the status of their death in the BR
        call StopRectLeaveDetection(GetHandleId(deadHero))
        call UpdateScoreboardPlayerDies(deadPlayer, RoundNumber)
        call ShowDiscordFrames(deadPlayer, true)
        set PlayerCount = PlayerCount - 1

        // Cleanup
        set deadHero = null
        set deadPlayer = null

        // Try to end the game
        call ConditionalTriggerExecute(EndGameTrigger)
    endfunction

    private function init takes nothing returns nothing
        set PlayerDiesInBattleRoyaleTrigger = CreateTrigger()
        call DisableTrigger(PlayerDiesInBattleRoyaleTrigger)
        call TriggerRegisterAnyUnitEventBJ(PlayerDiesInBattleRoyaleTrigger, EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(PlayerDiesInBattleRoyaleTrigger, Condition(function PlayerDiesInBattleRoyaleConditions))
        call TriggerAddAction(PlayerDiesInBattleRoyaleTrigger, function PlayerDiesInBattleRoyaleActions)
    endfunction

endlibrary
