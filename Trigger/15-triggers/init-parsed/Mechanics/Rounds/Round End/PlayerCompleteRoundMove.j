library PlayerCompleteRoundMove initializer init requires RandomShit, Functions

    private function PlayerCompleteRoundMoveConditions takes nothing returns boolean
        return IsUnitInGroup(GetTriggerUnit(), GroupEmptyArenaCheck) == true
    endfunction

    private function PlayerCompleteRoundMoveActions takes nothing returns nothing
        local player currentPlayer = GetOwningPlayer(GetTriggerUnit())
        local integer currentPlayerId = GetPlayerId(currentPlayer)
        local PlayerStats ps = PlayerStats.forPlayer(currentPlayer)

        if (IsPlayerInForce(currentPlayer, DefeatedPlayers) != true) then
            call RemoveUnitBuffs(PlayerHeroes[currentPlayerId], BUFFTYPE_BOTH, true)
            call SetUnitPositionLoc(PlayerHeroes[currentPlayerId], RectMidArenaCenter)

            if (ps.getPet() != null) then
                call SetUnitPositionLoc(ps.getPet(), RectMidArenaCenter)
            endif

            if (not CamMoveDisabled[currentPlayerId]) then
                call PanCameraToTimedLocForPlayer(currentPlayer, RectMidArenaCenter, 0.20)
            endif
        endif

        if (ElimModeEnabled == true or GameModeShort == true) then
            if (RoundNumber <= 1) then
                set LumberGained[currentPlayerId] = 21 * RoundNumber * 30
                call AdjustPlayerStateBJ((21 * RoundNumber * 30), currentPlayer, PLAYER_STATE_RESOURCE_GOLD)
                //call DisplayTimedTextToPlayer(currentPlayer, 0, 0, 20, "|cff00aa0e+" + I2S(21*RoundNumber) + " lumber|r")
                call ResourseRefresh(currentPlayer)
            else
                if (RoundNumber < 4) then
                    set LumberGained[currentPlayerId] = 11 * RoundNumber * 30
                    call AdjustPlayerStateBJ((11 * RoundNumber * 30), currentPlayer, PLAYER_STATE_RESOURCE_GOLD)
                    call ResourseRefresh(currentPlayer)
                else
                    set LumberGained[currentPlayerId] = R2I((I2R(RoundNumber) / 2.00)) * 6 * 30
                    call AdjustPlayerStateBJ((R2I((I2R(RoundNumber) / 2.00)) * 6 * 30), currentPlayer, PLAYER_STATE_RESOURCE_GOLD)
                    call ResourseRefresh(currentPlayer)
                endif
            endif
        else
            if (RoundNumber <= 1) then
                set LumberGained[currentPlayerId] = 10 * RoundNumber * 30
                call AdjustPlayerStateBJ((10 * RoundNumber * 30), currentPlayer, PLAYER_STATE_RESOURCE_GOLD)
                //call DisplayTimedTextToPlayer(currentPlayer, 0, 0, 20, "|cff00aa0e+" + I2S(10*RoundNumber) + " lumber|r")
                call ResourseRefresh(currentPlayer)
            else
                if (RoundNumber < 8) then
                    set LumberGained[currentPlayerId] = 6 * RoundNumber * 30
                    call AdjustPlayerStateBJ((6 * RoundNumber * 30), currentPlayer, PLAYER_STATE_RESOURCE_GOLD)
                    //call DisplayTimedTextToPlayer(currentPlayer, 0, 0, 20, "|cff00aa0e+" + I2S(6*RoundNumber) + " lumber|r")
                    call ResourseRefresh(currentPlayer)
                else
                    set LumberGained[currentPlayerId] = R2I((I2R(RoundNumber)/ 4.00)) * 6 * 30
                    call AdjustPlayerStateBJ((R2I((I2R(RoundNumber) / 4.00)) * 6 * 30), currentPlayer, PLAYER_STATE_RESOURCE_GOLD)
                    //call DisplayTimedTextToPlayer(currentPlayer, 0, 0, 20, "|cff00aa0e+" + I2S((R2I((I2R(RoundNumber)/4.00))*6)) + " lumber|r")
                    call ResourseRefresh(currentPlayer)
                endif
            endif
        endif

        call DisplayTimedTextToPlayer(currentPlayer, 0, 0, 10, "|cffffcc00Level Completed!|r")
        call Func_completeLevel(PlayerHeroes[currentPlayerId])

        // Remove end round dummy
        call DeleteUnit(GetTriggerUnit())

        // Cleanup
        set currentPlayer = null
        
        call ConditionalTriggerExecute(AllPlayersCompletedRoundTrigger)
    endfunction

    private function init takes nothing returns nothing
        set PlayerCompleteRoundMoveTrigger = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(PlayerCompleteRoundMoveTrigger,EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(PlayerCompleteRoundMoveTrigger, Condition(function PlayerCompleteRoundMoveConditions))
        call TriggerAddAction(PlayerCompleteRoundMoveTrigger, function PlayerCompleteRoundMoveActions)
    endfunction

endlibrary
